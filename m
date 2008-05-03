From: skillzero@gmail.com
Subject: Best way to optimize a git repository?
Date: Fri, 2 May 2008 17:34:02 -0700
Message-ID: <2729632a0805021734h72196639x8789a00ce9be4059@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 02:34:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js5iI-0000LG-8i
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 02:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbYECAeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 20:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759052AbYECAeE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 20:34:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:10614 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbYECAeC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 20:34:02 -0400
Received: by wa-out-1112.google.com with SMTP id j37so610157waf.23
        for <git@vger.kernel.org>; Fri, 02 May 2008 17:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Zw0F91kZzLOuwFw7cDVXaYWFR466bNK9RGxgX+/EAqA=;
        b=Q8BB3KStCHMXhCiJwTF/3IbhA3eizxJoeXSMVtSzZQ/v8KMc5i2vm3XJx8EMAdcxOEhPlfGQEOwQq5TUtfwSVBJcd4Xto2QnJ2PvxOXaQgSblFz9A+Fmqo3Wef/Ia3lLIzg5TyGmgzs+8kinbKYvCSy3cVn1NIJq50DxPHpYDKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rkJ+CSk88mQQ7eZ5eQp45CGY30IYQgOff1WciBnn73+lgDeCDM2lKI/K1Ok5rrjrCK3Gwp+8DbKZQJKo5J9J7Cx5UHZlS6QQWvfcgrTa9qBzfppgrkllBpmnGJf/7Lmb8XYUIOmVnBOKw2haX4C8pGNn3sNILyNP/hb1h28XMJ4=
Received: by 10.114.150.1 with SMTP id x1mr3572087wad.46.1209774842080;
        Fri, 02 May 2008 17:34:02 -0700 (PDT)
Received: by 10.114.193.9 with HTTP; Fri, 2 May 2008 17:34:02 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81054>

I want to periodically optimize my repositories even if it takes a
long time to run the command. Should I do 'git gc --aggressive', 'git
repack -a -d', 'git prune', or some combination? The documentation
implies that things like git gc will use git repack, but I'm sort of
looking for the definitive answer of what I should run to fully
optimize my repositories. These are relatively new repositories, all
created with git 1.5.5.1.

I also read somewhere (but can't find now) that some of these commands
shouldn't be run while other people might be accessing the repository.
I want to run these commands on a server that multiple people clone
and pull from and push to. Is that safe to do? I'm okay if clone,
pull, or push fail during this time (although I'd prefer if they
didn't fail), I just don't want to corrupt the repository.
