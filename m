From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all
 entries
Date: Thu, 11 Jan 2007 09:14:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701110913140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com> 
 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> 
 <7v8xgileza.fsf@assigned-by-dhcp.cox.net>  <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
  <20070107163112.GA9336@steel.home>  <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
 <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
 <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 09:14:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4v5A-0003y3-No
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 09:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbXAKIOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 03:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbXAKIOi
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 03:14:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:32829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030220AbXAKIOh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 03:14:37 -0500
Received: (qmail invoked by alias); 11 Jan 2007 08:14:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 11 Jan 2007 09:14:25 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36553>

Hi,

On Wed, 10 Jan 2007, Linus Torvalds wrote:

> On Thu, 11 Jan 2007, Alex Riesen wrote:
> > 
> > Yep. Tried the monster merge on it: 1m15sec on that small laptop.
> 
> Is that supposed to be good? That still sounds really slow to me. What 
> kind of nasty project are you doing? Is this the 44k file project, and 
> under cygwin? Or is it that bad even under Linux?

This _is_ cygwin. And 1m15sec is actually very, very good, if you happen 
to know that it took more than 10 minutes(!) when we started our quest of 
inbuilding recursive merge.

Ciao,
Dscho
