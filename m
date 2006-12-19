X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 09:32:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
 <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org>
 <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 08:32:53 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34798>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwaOy-0003mb-1o for gcvg-git@gmane.org; Tue, 19 Dec
 2006 09:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932661AbWLSIck (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 03:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWLSIck
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 03:32:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:40698 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932662AbWLSIck
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 03:32:40 -0500
Received: (qmail invoked by alias); 19 Dec 2006 08:32:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp047) with SMTP; 19 Dec 2006 09:32:38 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

in a very unscientific test, without your patch local cloning of the 
LilyPond repo takes 1m33s (user), and with your patch (pread() instead of 
mmap()) it takes 1m13s (user). The real times are somewhat bogus, but 
still in favour of pread(), but only by 8 seconds instead of 20.

This is on Linux 2.4.32.

Ciao,
Dscho

