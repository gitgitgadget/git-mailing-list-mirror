From: Phil Miller <mille121@illinois.edu>
Subject: Name/documentation on git-log --full-diff is insufficient
Date: Thu, 19 Nov 2009 17:26:33 -0600
Message-ID: <81f018ac0911191526o1cfa8e56r79f8db33256a4e9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 20 00:27:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBGP2-0004WE-VQ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 00:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbZKSX0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 18:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbZKSX0t
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 18:26:49 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:39684 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbZKSX0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 18:26:49 -0500
Received: by fxm21 with SMTP id 21so3036213fxm.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 15:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=oWIkgAtNABtwkbZV6ATFrrI/qZL4bf8Ph/zymJkCbRs=;
        b=VTvpGPRygxzHnZHbljap5jgjWl5++2FPIyE256+6s+EtWoKf171J1BwLS6ffWzvDkW
         K/tBeo0AMi8VUcBatF6fzqj5EQlHQPB12prWkRvT1wWj9DlGBEMSC8sOqj8U1VAHCd23
         AxoeggXpPOJAfsQKwZSTjzrvD5idydzMvCKAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=FUsuhN+iUG4hgBv9wStmLAfQ62PrlmLBPEi4ahTaDrjVJFKS7CqmUe0u98/ausJQhD
         t6Zd+CAPBocqPnrk6RZFbyNk5tYQeLFNdHYSK2mf2dAC/u/2aXU898JRwT7a1rYlJv/b
         zSYdpAczbebN0lh2QTgMJyS7AmL4rY8WG1ido=
Received: by 10.216.85.213 with SMTP id u63mr206273wee.15.1258673214153; Thu, 
	19 Nov 2009 15:26:54 -0800 (PST)
X-Google-Sender-Auth: bf96c54dbe76fd9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133267>

I've been trying for a few days to figure out how to see all the files
touched in all the commits that changed a particular path. I just
discovered that that 'git log --full-diff --stat path' gives me the
complete list of files changed in the displayed commits, and not just
the files matching path. Reading the documentation, I figured that it
either only applied when running 'git log -p' or that it implied the
'-p', neither of which was desirable.

Thus, I'd suggest a couple potential improvements:
1. Expand the manual text to clarify that --full-diff really means
'tell me about all of the files in the commits that I see' regardless
of what information (a list of files, a diffstat, or a full diff) is
being printed about those files
2. Add a synonym with a more general name. Something like --all-files
would be close to the mark, though there are probably other more
suitable names.

Phil

PS: I sent in a patch for git-cvsserver a week ago, and have seen no
response or action on it. Is there something I should have done
differently?
http://article.gmane.org/gmane.comp.version-control.git/132789
