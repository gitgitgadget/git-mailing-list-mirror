From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 9 Jul 2007 12:57:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707091256430.5546@racer.site>
References: <11839118073186-git-send-email-skimo@liacs.nl> 
 <1183911808787-git-send-email-skimo@liacs.nl>  <Pine.LNX.4.64.0707081729040.4248@racer.site>
 <46912726.5080807@midwinter.com>  <Pine.LNX.4.64.0707081920410.4248@racer.site>
 <20070708211034.GO1528MdfPADPa@greensroom.kotnet.org> <4691F96E.D869DF97@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 14:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7rzS-0007Wb-MQ
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 14:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbXGIMFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 08:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbXGIMFO
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 08:05:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:48520 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751691AbXGIMFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 08:05:13 -0400
Received: (qmail invoked by alias); 09 Jul 2007 12:05:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 09 Jul 2007 14:05:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186KfRlAlQ6LWIx8OjAeBIC4ruKoyFUuj15UVFfgr
	o2CqukVziwGzEI
X-X-Sender: gene099@racer.site
In-Reply-To: <4691F96E.D869DF97@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51985>

Hi,

On Mon, 9 Jul 2007, Johannes Sixt wrote:

> Sven Verdoolaege wrote:
> > I guess the major thing that is missing is --subdirectory-filter.
> > Anything else?
> 
> Yes, how about this:
> 
>   $ git rewrite-commits --index-map '
>          testresult=$($HOME/bin/expensive-test);
>          [ $testresult = t ] && $HOME/bin/tweak-index ' \
>      --commit-map '
>          [ $testresult = t ] && $HOME/bin/tweak-commit '

As skimo almost hinted: this will not work.  Once the index "map" exits, 
testresult is forgotten.

Ciao,
Dscho
