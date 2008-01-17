From: Andrew Heybey <ath@niksun.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: 17 Jan 2008 09:02:39 -0500
Message-ID: <85zlv435z4.fsf@stiegl.mj.niksun.com>
References: <478E1FED.5010801@web.de>
	<1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
	<alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
	<7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
	<alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
	<B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
	<alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
	<8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
	<alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
	<4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org>
	<46a038f90801162051s5ce40abcm623599269943a24@mail.gmail.com>
	<ACDB98F4-178C-43C3-99C4-A1D03DD6A8F5@sb.org>
	<A915BECA-A486-477B-A07D-D1033E44DCBD@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kevin Ballard <kevin@sb.org>Martin Langhoff" 
	<martin.langhoff@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mark Junker" <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 09:12:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFmL8-0002XE-Bn
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 09:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbYARIL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 03:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbYARIL4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 03:11:56 -0500
Received: from gwnew.niksun.com ([65.115.46.162]:55364 "EHLO
	anuket.mj.niksun.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752439AbYARILz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 03:11:55 -0500
X-Greylist: delayed 65315 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jan 2008 03:11:54 EST
Received: from stiegl.mj.niksun.com (stiegl [10.70.0.231])
	by anuket.mj.niksun.com (8.13.6/8.13.6) with ESMTP id m0HE2dsb056879;
	Thu, 17 Jan 2008 09:02:39 -0500 (EST)
	(envelope-from ath@stiegl.mj.niksun.com)
Received: by stiegl.mj.niksun.com (Postfix, from userid 1002)
	id 784915CE3; Thu, 17 Jan 2008 09:02:39 -0500 (EST)
In-Reply-To: <A915BECA-A486-477B-A07D-D1033E44DCBD@adacore.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
X-Virus-Scanned: ClamAV 0.92/5490/Thu Jan 17 05:39:33 2008 on anuket.mj.niksun.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70973>

Geert Bosch <bosch@adacore.com> writes:

> For those on Mac OS X: it is possible to create a case-sensitive HFS+
> partition and
> use it with git. You even can just create a disk image and mount it.
> However,
> I wouldn't quite try to use it as startup filesystem...

This is starting to stray far afield, but the first thing I did when I
got a Macbook was to reinstall it with case-sensitive HFS as the boot
file system.  Works fine, including with git.  The only problem I have
had is that FileVault does not work.  There are rumored to be some
third-part apps that do not work but I do not use that many of those
anyway.

andrew
