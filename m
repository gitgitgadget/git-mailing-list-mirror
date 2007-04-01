From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Rename warn() to warning() to fix symbol conflicts on BSD and Mac OS
Date: Sun, 1 Apr 2007 12:25:54 +0200
Message-ID: <20070401102554.GA20579@steel.home>
References: <11752960251394-git-send-email-tytso@mit.edu> <7vejn5ygkc.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 12:26:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXxG4-0006bT-8t
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 12:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbXDAKZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 06:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbXDAKZ5
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 06:25:57 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:62157 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbXDAKZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 06:25:56 -0400
Received: from tigra.home (Fc969.f.strato-dslnet.de [195.4.201.105])
	by post.webmailer.de (mrclete mo25) (RZmta 5.5)
	with ESMTP id D0188aj318ilD4 ; Sun, 1 Apr 2007 12:25:55 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B564A277B6;
	Sun,  1 Apr 2007 12:25:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 309F6D150; Sun,  1 Apr 2007 12:25:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vejn5ygkc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzATso3c=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43587>

Junio C Hamano, Sat, Mar 31, 2007 10:15:31 +0200:
> >>I finally tracked down all the (albeit inconsequential) errors I was getting
> >>on both OpenBSD and OSX.  It's the warn() function in usage.c.  There's
> >>warn(3) in BSD-style distros.  It'd take a "great rename" to change it, but if
> >>someone with better C skills than I have could do that, my linker and I would
> >>appreciate it.
> >
> > It was annoying to me, too, when I was doing some mergetool testing on
> > Mac OS X, so here's a fix.
> 
> I'd take this for now, but I wonder where we should stop. 

Glibc also has warn(3) - see err.h for example.
(why is it part of libc, I wonder...)
