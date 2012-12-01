From: =?ISO-8859-1?Q?Dan_Ros=E9n?= <danr@student.chalmers.se>
Subject: Inconsistency in messages about --set-upstream from git pull and git branch
Date: Sat, 1 Dec 2012 16:36:06 +0100
Message-ID: <CAN2DD_Hc4ZoQZefUirSZF=PZY5654yqrQfk5g1VzBLixEC=T-g@mail.gmail.com>
Reply-To: danr@student.chalmers.se
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 17:04:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TepYl-0002fr-Lk
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 17:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab2LAQEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 11:04:40 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:60327 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab2LAQEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 11:04:39 -0500
X-Greylist: delayed 1236 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Dec 2012 11:04:39 EST
Received: by mail-ie0-f171.google.com with SMTP id 17so2675898iea.16
        for <git@vger.kernel.org>; Sat, 01 Dec 2012 08:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:sender:from:date:x-google-sender-auth
         :message-id:subject:to:content-type;
        bh=ZsL1WsMdYb14A49fjNYlK08k4S1pkCIdlDmBDqqk4C8=;
        b=R/BReZEc16DItbDv631+5lfHPwgzT2QXBB9Uy8biPnE7jbl4Kf651augyjuAR4v5WF
         YFkPrpNDZtoiGHjuUz2Ceu914OB2HZusbC6hidoJqOnUmBHsKe49pdamj4i6myLKhozQ
         LsFqaFRoLP7n5y/Bb89DTwX1yzPk/MjF/SIIKZxHqLWmJ0GhKB/Kj/uCJHs5sSL/4WRg
         WxewNmeMIKk4GhQ6RKSrvwN6oH/E4h6nmvN/qT5xjSFrVjERwe7osi+3jazLo5ii+mgb
         sYigW8HcLH2wQ7g859vwPP/OnahIW9k6t/8OpMWKRhnNo2jXYhY+iDIf8Pumfy1wkDMk
         nFTQ==
Received: by 10.50.77.230 with SMTP id v6mr1587938igw.11.1354376187136; Sat,
 01 Dec 2012 07:36:27 -0800 (PST)
Received: by 10.64.37.225 with HTTP; Sat, 1 Dec 2012 07:36:06 -0800 (PST)
X-Google-Sender-Auth: iF_AZxh96bl0q0N-AdQZggQDV98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210976>

I added a new origin to a repository and did git pull and got this message:

 * [new branch]      master     -> origin/master
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details

    git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

    git branch --set-upstream master origin/<branch>


I followed the instructions:
$ git branch --set-upstream master origin/master
The --set-upstream flag is deprecated and will be removed. Consider
using --track or --set-upstream-to
Branch master set up to track remote branch master from origin.

I was using git version 1.8.0 precompiled for Arch Linux.

I tried to find an issue tracker but perhaps it is appropriate to
report this inconsistency to this mailing list.

Best,
Dan
