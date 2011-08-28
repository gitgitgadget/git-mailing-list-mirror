From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: branch practice in my project
Date: Sun, 28 Aug 2011 17:23:06 +0800
Message-ID: <CAPgpnMQmLUcxfNBDO53=s1SfigJtq2zk4H+npZeX0B_Vf0FAuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 11:23:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxbaJ-0006z8-GX
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 11:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab1H1JXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Aug 2011 05:23:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42316 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab1H1JXH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 05:23:07 -0400
Received: by vws1 with SMTP id 1so3960362vws.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=7+LXCIDp9fSuMPZVp09+Y5BhnfAVFg7rPwbJpxE9yOg=;
        b=VCvL4aIZ5XY0nJnBwki/C6kBPW5D80BNBZ8rtqXXJIGb6LikpdNoWwj/2WFzzsFW5U
         3Nu863Veg0e8FBtSlF7r61M725djtt9375hJph9ngnyHAeCsUZV5D9wridTx/EMtTJUs
         M8PYq8XTodtklfsR+fCcTY4kAP4iYIiQploio=
Received: by 10.220.9.199 with SMTP id m7mr874250vcm.278.1314523386244; Sun,
 28 Aug 2011 02:23:06 -0700 (PDT)
Received: by 10.52.157.41 with HTTP; Sun, 28 Aug 2011 02:23:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180263>

Hi git experts,
     currently our project use git to manage source code,we only have
master branch to support development and release.However when we goes
into regression phase,code freeze will be runnning on master branch
and it will hold lots of patch in developers.

I want to use a new branch strategy  to resolve code freeeze issue


master   branch    ----1----2----3-----4-----5-----6-----7------8--->
                                     |                               |
 release                         3=91----4=92---5=91                  7=
'----8'

our release sprint  cycle is 3 weeks per sprint. when we start  a new
sprint,we can create a release branch and get the data back to master
branch after the sprint is over

how to get the data back to master branch?   I  suggest we can merge
release branch back, and others are afraid that merge conflict will be
a big deal for us so they suggest we can double commit into master and
release branch

what's your thoughts? Could you give me some suggestions?

Thanks in advance

Lynn
