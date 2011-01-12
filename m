From: JT Olds <jtolds@xnet5.com>
Subject: Git Rebase blows away GIT_AUTHOR_NAME
Date: Wed, 12 Jan 2011 09:15:41 -0700
Message-ID: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 12 17:15:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd3MS-0000dk-QZ
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 17:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab1ALQPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 11:15:44 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34250 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1ALQPn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 11:15:43 -0500
Received: by ewy5 with SMTP id 5so327556ewy.19
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=6P6jTVmGn9hgNNLjsOLcRHPOipOT2eDa1I5SfjSTShw=;
        b=rx2iDKxRnFBKXuNqX83nwhejL9xMcl/7UK5xDrGa2TVECmRxogHO24LmJH7bn9T7Xu
         YmnpvzkEwljo+JOCMOhJF/UOyYNB4PFqjBHNXO6dvE1CKgckL9XfvQEqVd05Ip3huIh3
         p4sGjVBWFrou1YE9tf5ppWjUSNO7A4FL/NTng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=XKTuQGImTkasWPaUc/BKjUk5MdyEeLjRSNxQMb2A9lr1C3KugCpAGRA4RVxP61PC3V
         WPLULGTeEp0ge/qa44wnGherJwxynPWnPTdjuUJjp8IGXYuVebggUjfiRwFqy9isBZa4
         fr2THlOyjGP5TfuqPXYiwAE40NhDD8c7Hahh0=
Received: by 10.216.183.145 with SMTP id q17mr1011665wem.5.1294848941873; Wed,
 12 Jan 2011 08:15:41 -0800 (PST)
Received: by 10.216.2.194 with HTTP; Wed, 12 Jan 2011 08:15:41 -0800 (PST)
X-Google-Sender-Auth: NRepTTy_StnYQXiCicVW0Ka6DQ0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165018>

I asked this in #git on freenode, and I've also spent a while
searching the internet for anyone with any similar issues, but I can't
seem to find anyone or anything that knows what's going on.

On every fresh install of Ubuntu that I have used (by default, I use
ecryptfs for my home directory, which of course has its own set of
silly Git errors right now), when I clone from a remote repository,
have changes local to me, and changes on the remote repository, do
'git pull --rebase', occasionally my GIT_AUTHOR_NAME gets set to my
GIT_AUTHOR_EMAIL on my changes that get applied on top of the remote
changes.

This is incredibly frustrating, so much so that my workflow now
includes running an alias to git filter-branch that fixes this.

Notable things: so far I have only had a remote server hosted by
Gerrit, but I can't imagine how changes on the remote git server could
possibly affect my local changes. Like I said, I'm using ecryptfs, and
I'm using vanilla Git from the latest stable Ubuntu, though I've had
this problem on Ubuntus for a few releases now.

Anyone have any idea why this might happen?

-JT
