From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: using the same repo with different OS
Date: Wed, 28 Feb 2007 13:12:51 -0500
Message-ID: <20070228181251.GG5924@spearce.org>
References: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com> <Pine.LNX.4.63.0702251829530.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v3b4ut7yq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702251929170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vy7mmrspw.fsf@assigned-by-dhcp.cox.net> <906f26060702281006l794173e8uea0f7174dd712e32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Stefano Spinucci <virgo977virgo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 19:13:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMTIQ-0006jQ-BW
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbXB1SM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbXB1SM4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:12:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58648 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbXB1SM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:12:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMTIE-00037v-4Z; Wed, 28 Feb 2007 13:12:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 223B620FBAE; Wed, 28 Feb 2007 13:12:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <906f26060702281006l794173e8uea0f7174dd712e32@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40983>

Stefano Spinucci <virgo977virgo@gmail.com> wrote:
> I noticed today that my notes about compiling Git on cygwin to work
> with FAT32 (export NO_MMAP=1) on the Wiki page WindowsInstall were
> removed.

That was me.  NO_MMAP=1 is now the default on Cygwin.
 
> Than I'm asking how you'd setup repos to work on some linux/windows
> machines, transferring data only with an USB disk.

Just create a bare repository on the USB stick and push/fetch to it.
It won't have a checkout directory or an index, the two sticking
points with mmap() on Windows and with a FAT32 filesystem being
accessed through Git by both Linux and Windows.

-- 
Shawn.
