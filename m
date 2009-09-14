From: Thiago Farina <tfransosi@gmail.com>
Subject: Tracking remote branches
Date: Sun, 13 Sep 2009 21:37:26 -0300
Message-ID: <a4c8a6d00909131737v35d7c63dsea669f47456f5acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 02:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmzcU-0004z1-TT
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 02:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbZINAhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 20:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbZINAhY
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 20:37:24 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:52040 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbZINAhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 20:37:24 -0400
Received: by yxe29 with SMTP id 29so3259177yxe.16
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=tca1bbzBv7V4mM81KPhxoBUk9Ea3oMW+4vJL7v4CndI=;
        b=DDR/OEPhYBCjIgmrzyrTe+VgZvNOd1qjDJXKFsTM4gFLmJwJHmUG2CeYsm6QFOde4D
         pOhDVIgVbGA/FXCxuYCA2MDCtaA76XO8YT7M82oJs60REWUwlik2Hlzns2MDg9WoVQDJ
         7dactVp57j5wx8/LqGJfVALmloBBUD5pCMTwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=g4YXU5U2ROfKz0wcDuK19sLjkUV4imtH3y5pVmhiP2bvBiHmeHbXmY2yJSFX8F9wiI
         GHbajRw2nBRMJedMDpYJEqhRSrAp7gQqvFqRCTmPtAGXfJ9jJFUFQ+fxu/Ue1eIlLBtt
         a0RYCHoaRUOMFASyMfGxtVRFFB3psTV6XG4K0=
Received: by 10.101.59.5 with SMTP id m5mr5618231ank.67.1252888647122; Sun, 13 
	Sep 2009 17:37:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128432>

Hi,

I'm not understanding what is happening here. I tried to track a
remote branch, origin/maint from git. So I did:
$ git branch --track maint origin/maint
$ git checkout maint

I know that I could do simply, instead of above:
$ git checkout --track -b maint origin/maint

OK, now I switched to maint branch. And then I did:
$ git status

# On branch maint
# Changes to be committed
#    (use "git reset HEAD <file>..." to unstage)
#
#          new file:    git-remote-curl
#          new file:    git-replace
#

What happened here? What I have to do now?
