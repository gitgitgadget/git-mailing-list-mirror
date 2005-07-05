From: Wolfgang Denk <wd@denx.de>
Subject: Re: cvsimport: rewritten in Perl
Date: Wed, 06 Jul 2005 01:02:26 +0200
Message-ID: <20050705230226.0F9F4353A69@atlas.denx.de>
References: <pan.2005.07.03.13.44.46.995524@smurf.noris.de>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 01:09:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpwX6-0004n0-CT
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 01:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVGEXI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 19:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVGEXI2
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 19:08:28 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:10699 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262000AbVGEXGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2005 19:06:37 -0400
Received: from fwd28.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1DpwT6-0004X7-00; Wed, 06 Jul 2005 01:04:44 +0200
Received: from denx.de (rCj2ImZSge2AmuQ-NuIAB9KSoWYLwdwGcAZuUhB4ibMf+z2v-j1ocs@[84.150.101.32]) by fwd28.sul.t-online.de
	with esmtp id 1DpwT0-0nmx280; Wed, 6 Jul 2005 01:04:38 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 81EDD42F4E; Wed,  6 Jul 2005 01:04:37 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 0F9F4353A69;
	Wed,  6 Jul 2005 01:02:26 +0200 (MEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
In-reply-to: <pan.2005.07.03.13.44.46.995524@smurf.noris.de> 
Comments: In-reply-to Matthias Urlichs <smurf@smurf.noris.de>
   message dated "Sun, 03 Jul 2005 15:44:47 +0200."
X-ID: rCj2ImZSge2AmuQ-NuIAB9KSoWYLwdwGcAZuUhB4ibMf+z2v-j1ocs@t-dialin.net
X-TOI-MSGID: c9da4410-b4ac-4a75-a560-8d7b09f1d877
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <pan.2005.07.03.13.44.46.995524@smurf.noris.de> you wrote:
> 
> Linus: Please grab http://netz.smurf.noris.de/git/git.git/#cvs2git.

I tested this on the U-Boot CVS repository (available at
http://cvs.sourceforge.net/cvstarballs/u-boot-cvsroot.tar.bz2).

I got:

-> ~/test/git-cvsimport-script -d ~/git/u-boot-SF/u-boot -C u-boot u-boot
cvs_direct initialized to CVSROOT /home/wd/git/u-boot-SF/u-boot
cvs rlog: Logging u-boot
cvs rlog: Logging u-boot/board
...
cvs rlog: Logging u-boot/tools/scripts
cvs rlog: Logging u-boot/tools/updater
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    include/configs/svm_sc8xx.h:1.3=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 816, Tag LABEL_2003_12_08_MKR:
    include/configs/rmu.h:1.4=after, CHANGELOG:1.171=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    include/configs/TQM823M.h:1.3=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    include/configs/TQM823L.h:1.9=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 816, Tag LABEL_2003_12_08_MKR:
    include/configs/IceCube.h:1.16=after, CHANGELOG:1.171=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, CHANGELOG:1.165=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/RRvision/RRvision.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/atc/atc.c:1.6=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/c2mon/c2mon.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/etx094/etx094.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/evb64260/flash.c:1.5=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/rmu/rmu.c:1.3=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/tqm8260/tqm8260.c:1.4=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/tqm8xx/tqm8xx.c:1.4=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, include/version.h:1.20=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, lib_arm/board.c:1.19=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    cpu/mpc8xx/lcd.c:1.14=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 817, Tag LABEL_2003_12_08_MKR:
    common/cmd_bootm.c:1.31=after, CHANGELOG:1.172=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    board/tqm8xx/tqm8xx.c:1.5=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    README:1.60=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    Makefile:1.65=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 816, Tag LABEL_2003_12_08_MKR:
    include/configs/IceCube.h:1.16=after, CHANGELOG:1.171=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    include/configs/TQM823M.h:1.3=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    include/configs/svm_sc8xx.h:1.3=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 817, Tag LABEL_2003_12_08_MKR:
    common/cmd_bootm.c:1.31=after, CHANGELOG:1.172=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    cpu/mpc8xx/lcd.c:1.14=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, CHANGELOG:1.165=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/RRvision/RRvision.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/atc/atc.c:1.6=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/c2mon/c2mon.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/etx094/etx094.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/evb64260/flash.c:1.5=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/rmu/rmu.c:1.3=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/tqm8260/tqm8260.c:1.4=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, board/tqm8xx/tqm8xx.c:1.4=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, include/version.h:1.20=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_12_08_MKR:
    fs/fat/fat.c:1.5=after, lib_arm/board.c:1.19=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    include/configs/TQM823L.h:1.9=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    board/tqm8xx/tqm8xx.c:1.5=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    Makefile:1.65=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 816, Tag LABEL_2003_12_08_MKR:
    include/configs/rmu.h:1.4=after, CHANGELOG:1.171=before. Treated as 'before'
WARNING: Invalid PatchSet 815, Tag LABEL_2003_12_08_MKR:
    README:1.60=after, CHANGELOG:1.170=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, CHANGELOG:1.165=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/RRvision/RRvision.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/atc/atc.c:1.6=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/c2mon/c2mon.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/etx094/etx094.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/evb64260/flash.c:1.5=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/rmu/rmu.c:1.3=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/tqm8260/tqm8260.c:1.4=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/tqm8xx/tqm8xx.c:1.4=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, include/version.h:1.20=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, lib_arm/board.c:1.19=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, CHANGELOG:1.165=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/RRvision/RRvision.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/atc/atc.c:1.6=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/c2mon/c2mon.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/etx094/etx094.c:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/evb64260/flash.c:1.5=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/rmu/rmu.c:1.3=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/tqm8260/tqm8260.c:1.4=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, board/tqm8xx/tqm8xx.c:1.4=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, include/version.h:1.20=before. Treated as 'before'
WARNING: Invalid PatchSet 810, Tag LABEL_2003_11_26_MKR:
    fs/fat/fat.c:1.5=after, lib_arm/board.c:1.19=before. Treated as 'before'
Committing initial tree 2183da96d548c02bd4f99b05e673395f81212878
Cannot create object: Too many open files
-> ulimit -n
1024

Any ideas?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"It is easier to port a shell than a shell script."      - Larry Wall
