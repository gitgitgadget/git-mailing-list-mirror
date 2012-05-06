From: Jon Seymour <jon.seymour@gmail.com>
Subject: git-svn: --ignore-paths appears to be ignored
Date: Mon, 7 May 2012 04:12:55 +0530
Message-ID: <CAH3Anrrz3OB2CofKAnRn2yR3DQRvHyQQSp6=GG-jqvYyD79b9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 07 00:43:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRAAy-0001I7-Qy
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 00:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab2EFWm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 18:42:57 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37864 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab2EFWm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 18:42:57 -0400
Received: by wgbdr13 with SMTP id dr13so4306458wgb.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=sD0LvRHG5dp4FgdIiZIwY/Gb5fqCmRe4NprW9vp/TAU=;
        b=HSOA2tPJIVbWzyPLo4iyy4CfCFoBgbUPVeISeA2TRvT8hfCsSjoktfocBcRay79j6p
         mYAvaQzkA6jybY9U9cLNmpsMcdkSle4xCSck2Q2pU0r+wz6St5BDkw8aHKb3h8vD64Pc
         UmMlbq9BY0+AUUjXVZcTox0F/gya+BIiJ/IB5rRiYyhK2UnL8NYcSo0QWdvc0L4Jp1b3
         gbZECSoaWppOazB+Xixm3EABLULg9YkiZkFxbmLBVrsnZ/CCelSGQIK2CkLoQg25lOWB
         kiQ1V1rv7a9QdTy6dRWC2aAoU6JloG14loclkU4+f6GpngwbgpW4uXL4NKzIIqIx/1Vs
         Gs/w==
Received: by 10.216.134.27 with SMTP id r27mr8464308wei.107.1336344175997;
 Sun, 06 May 2012 15:42:55 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Sun, 6 May 2012 15:42:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197219>

I configured ignore-paths as follows:

    svn-remote.svn.ignore-paths=^DB.*

I expected this would exclude paths of this kind on the initial fetch:

    DB/.project

but when I run git svn fetch, paths of this kind actually do get pulled.

I have also tried:

    svn-remote.svn.ignore-paths=^DB

with the same result.

I am using git version 1.7.9.264

What am I doing wrong?

jon.
