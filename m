From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 11:22:08 +0100
Message-ID: <17846BF5-1215-4C28-8BBC-2C745A053156@wincent.com>
References: <478E1FED.5010801@web.de> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org> <46a038f90801162051s5ce40abcm623599269943a24@mail.gmail.com> <ACDB98F4-178C-43C3-99C4-A1D03DD6A8F5@sb.org> <A915BECA-A486-477B-A07D-D1033E44DCBD@adacore.com> <AD012876-3B4A-41EE-8CCB-F60D5C812903@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mitch Tishmack <mitcht.git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 11:22:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFRtS-00064H-6H
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 11:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbYAQKWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 05:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbYAQKWN
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 05:22:13 -0500
Received: from wincent.com ([72.3.236.74]:35443 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955AbYAQKWM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 05:22:12 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0HAM9YC018304;
	Thu, 17 Jan 2008 04:22:10 -0600
In-Reply-To: <AD012876-3B4A-41EE-8CCB-F60D5C812903@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70841>

El 17/1/2008, a las 8:11, Mitch Tishmack escribi=F3:

> I was going to post this earlier, but wanted to search the archives =20
> first. Here are the commands assuming you don't want to or can't =20
> partition a drive and format as ufs (I don't care for HFS+ much). I =20
> can't believe I didn't find the command in the git list archives, so =
=20
> voil=E0:
>
> $ hdiutil create -size 300m -fs UFS foo.dmg
> .....................................................................=
=2E.........
> created: /Users/mitch/foo.dmg
> $ hdiutil attach foo.dmg
> /dev/disk2          	GUID_partition_scheme          =09
> /dev/disk2s1        	Apple_UFS                      	/Volumes/untitle=
d
> $ cd /Volumes/untitled && git clone git://git.kernel.org/pub/scm/git/=
=20
> git.git
> ... snipped ...
> $ cd git && git status
> # On branch master
> nothing to commit (working directory clean)
>
> After git clone in HFS+ land...
> $ git status
> # On branch master
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #	gitweb/test/Ma=CC=88rchen
> nothing added to commit but untracked files present (use "git add" =20
> to track)
>
> Should I just add this to the wiki?

Definitely.

> Then we can all go back to ignoring the insane filesystems.

While it's a nice workaround, it really is just that (a workaround) =20
because performance will be suboptimal in a repository running on a =20
disk image (and many of switched to Git because of its speed).

Cheers,
Wincent
