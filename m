From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 20:17:31 +0200
Message-ID: <200706132017.31379.Josef.Weidendorfer@gmx.de>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org> <200706131854.59605.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0706131804080.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:25:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1HyXX8-0004bt-LO
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759281AbXFMSSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759231AbXFMSSK
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:18:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:58836 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757918AbXFMSSI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 14:18:08 -0400
Received: (qmail invoked by alias); 13 Jun 2007 18:18:04 -0000
Received: from atbode100.lrr.in.tum.de (EHLO localhost) [131.159.32.72]
  by mail.gmx.net (mp052) with SMTP; 13 Jun 2007 20:18:04 +0200
X-Authenticated: #352111
X-Provags-ID: V01U2FsdGVkX1+XmptAaxeXqtcfNJ9x8CSAhimBfpw1JVtm6R1/6h
	T1n1YjZmsCMFDq
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0706131804080.4059@racer.site>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50109>

On Wednesday 13 June 2007, Johannes Schindelin wrote:
> So, I should have realized earlier that "git-log -z" _without_ anything in 
> the way of "-p", "--stat" or friends does not make sense at all.

But it does make sense: it separates commits using '\0'.

Josef
