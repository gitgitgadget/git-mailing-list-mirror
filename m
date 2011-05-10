From: Francis Moreau <francis.moro@gmail.com>
Subject: Why sometime git-rebase doesn't preserve merge
Date: Tue, 10 May 2011 14:51:49 +0200
Message-ID: <BANLkTinV1hJ4CaV_X1ospOFzH0k17aYWYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 14:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJmPs-0002Mc-54
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 14:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab1EJMvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 08:51:50 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35515 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab1EJMvt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 08:51:49 -0400
Received: by pvg12 with SMTP id 12so2805950pvg.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=mpUBuMh291Rd8SYwBVyzROkRjwkTb47CZD1pymAjmzY=;
        b=ULMqMeGndb8wepX0CjWJfwsrEgQpRf+d9Bh4F5wItq86lbZ6IFWStwq+swMmPFRvjq
         uFm5YYfGwZiPqnecEktOgiVuNdHvU8VmsyXzXHxIzyHOLQrjfi3BiGf22sLOZquwEWiO
         +a4aw516HQ5s7shqX3OcJ4KQBDjFu+IVCLmvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=uQdebd3ufSeMLXelNhtOQbU7nKXC81Cq/+FKdX2bcrUGxETE35ob30Ei5edr+BmhDe
         /uCEyE60XFwrWxYUOT4llKrMuw9HA1skxlqIjNSbD3WOVVGX0pVYKLj+wmhBs/ZC6e4B
         3JBZe89wu60zjzjm5uwgEhr/iMzcZD+FrSbqc=
Received: by 10.143.21.34 with SMTP id y34mr4183847wfi.395.1305031909033; Tue,
 10 May 2011 05:51:49 -0700 (PDT)
Received: by 10.142.77.4 with HTTP; Tue, 10 May 2011 05:51:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173332>

Hello,

I'm using "git rebase -p" to rebase (not a suprise here) my devel
branch onto the master one.

In my devel branch, I've merged some remote branches.

Some merges are recreated, since I passed the -p switch,  but some are
not and all commits from the remote branch are inlined in my devel
branch.

Could anybody tell me why this happen and how I can avoid this behaviour ?

Shouldn't git-rebase fail if -p is passed ?

Thanks
-- 
Francis
