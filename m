X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 01:10:59 -0800
Message-ID: <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
References: <86y7p57y05.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
	<86r6uw9azn.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181625140.18171@xanadu.home>
	<86hcvs984c.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
	<8664c896xv.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612181906450.18171@xanadu.home>
	<20061219051108.GA29405@thunk.org>
	<Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
	<Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 09:11:33 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 19 Dec 2006 09:32:36 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34804>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gwb06-0001Fy-PM for gcvg-git@gmane.org; Tue, 19 Dec
 2006 10:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932701AbWLSJLB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 04:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWLSJLB
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 04:11:01 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:33409 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932701AbWLSJLA (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 04:11:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219091100.UDRU97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 04:11:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0ZBB1W00R1kojtg0000000; Tue, 19 Dec 2006
 04:11:12 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> in a very unscientific test, without your patch local cloning of the 
> LilyPond repo takes 1m33s (user), and with your patch (pread() instead of 
> mmap()) it takes 1m13s (user). The real times are somewhat bogus, but 
> still in favour of pread(), but only by 8 seconds instead of 20.
>
> This is on Linux 2.4.32.

Interesting.  Anybody have numbers from 2.6?
 
