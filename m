From: Robert Buck <buck.robert.j@gmail.com>
Subject: how do I create a branch and push it so several developers can share work?
Date: Wed, 8 Sep 2010 18:31:30 -0400
Message-ID: <AANLkTinO9TVyg6EBS1ZuQPS+VWxzODmLan0sDGzFw8eh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 09 00:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtTB3-0000Qm-Cz
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 00:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434Ab0IHWbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 18:31:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52590 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267Ab0IHWbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 18:31:31 -0400
Received: by eyb6 with SMTP id 6so506145eyb.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 15:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=TKZZyNFwWc5lG9kG6o0z6JAygcXwYZm5ZSrVpvSLvcQ=;
        b=cvrE9aWOgum+1DGeHl9OsNR1QuwzKHwSg/BVpx3JfWfwe89746Jr51LjU1uMPaHxbM
         S4e/ssoGYDg392EXOYzxmFT6iTJvIzt7my2x0n7k4eVAUPKxb+7wh53xvcf+fiwxy0R2
         m90AtyL2x8Viu5UCClPxM+BEmHKRAPovvskk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=V2BqsLkM6uFKc7guAMPdicobmVAN3356nqXu4sKucuFEhzkBAL+8NnEQqlBInleS0F
         pVZB8+qVwO4b8bNPMQR6XI2fLi5y7Z/GXWhq2qB3zjo+dley5Iy2rcXdKkcH5h96JQt5
         fVp0577HQA+YqCKQ4eBWlOEwiqvlXGY9TOyZ8=
Received: by 10.14.45.9 with SMTP id o9mr133490eeb.29.1283985090237; Wed, 08
 Sep 2010 15:31:30 -0700 (PDT)
Received: by 10.14.4.11 with HTTP; Wed, 8 Sep 2010 15:31:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155818>

We just switched over to git and also use gitolite.

To create a new branch and push it so a team of developers can
collaborate on that branch I performed the following commands:

Listed available tags:
git fetch --tags

Listed available branches, which for me only showed one, master:
git branch

Created the branch off the tag:
git branch fullers tagduvel

Checked out the branch to verify the contents:
git checkout fullers
...

Push the branch to the remote repository:
git push origin fullers

Now, when I clone the repository and list the branches I only see
'master'. If I list the branches with the -a option I see something I
did not anticipate:
git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/duvel
  remotes/origin/fullers
  remotes/origin/master

What I had expected was a fullers branch.

So apparently I did something very wrong here. What did I do wrong?

Thanks,

Bob
