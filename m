From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Some git performance measurements..
Date: Fri, 7 Dec 2007 13:49:56 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712071348100.27959@racer.site>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
  <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org> 
 <alpine.LFD.0.99999.0711282244190.9605@xanadu.home> 
 <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org> 
 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>  <finmvm$da8$1@ger.gmane.org>
  <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org> 
 <alpine.LFD.0.99999.0711292131350.9605@xanadu.home> 
 <B161871F-E812-44B4-A699-44341B5783D3@zib.de>
 <e2b179460712070535x2eb10710s75a581664139e0cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 14:51:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0dbR-0001iY-FC
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 14:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbXLGNuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 08:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbXLGNub
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 08:50:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:40323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751740AbXLGNub (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 08:50:31 -0500
Received: (qmail invoked by alias); 07 Dec 2007 13:50:29 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 07 Dec 2007 14:50:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183R5deiKM3E3HRrHtsgo+Bo5r/7g+Jhg2aIGs/SS
	ob0lNNdsM7GyuS
X-X-Sender: gene099@racer.site
In-Reply-To: <e2b179460712070535x2eb10710s75a581664139e0cf@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67425>

Hi,

On Fri, 7 Dec 2007, Mike Ralphson wrote:

> I benchmarked 3 alternative qsorts, qsortG [2] was the fastest on my 
> system but has funky licensing, the NetBSD qsort was middle-range and 
> the glibc one the slowest of the three (but that could be due to it 
> being tuned for a "Sun 4/260"). All of them show over 100x speed 
> improvements on a git-status of my main repo (104s -> ~0.7s)

How is "You may use it in anything you like;" funky licensing?  It is 
effectively public domain.

BTW if you need a starting point (easing on your time constraints):
http://repo.or.cz/w/git/mingw/4msysgit.git?a=commitdiff;h=bba554dd0114dc436cfdd3f17edc836bbaf3d95f

Ciao,
Dscho
