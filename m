From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Change softrefs file format from text (82 bytes per
 entry) to binary (40 bytes per entry)
Date: Sun, 10 Jun 2007 09:02:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100900420.4059@racer.site>
References: <200706040251.05286.johan@herland.net> <200706092019.13185.johan@herland.net>
 <200706092025.30156.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:05:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIQU-0000X1-BJ
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762392AbXFJIF2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762366AbXFJIF1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:05:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:50463 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762351AbXFJIFY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:05:24 -0400
Received: (qmail invoked by alias); 10 Jun 2007 08:05:22 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp050) with SMTP; 10 Jun 2007 10:05:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wgRQ8CZmw1STeS161klKHdngHgjrvVBqFual9AT
	sD/WySrb8MJRE6
X-X-Sender: gene099@racer.site
In-Reply-To: <200706092025.30156.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49669>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> The text-based softrefs file format uses 82 bytes per entry (40 bytes 
> from_sha1 in hex, 1 byte SP, 40 bytes to_sha1 in hex, 1 byte LF).
> 
> The binary softrefs file format uses 40 bytes per entry (20 bytes 
> from_sha1, 20 bytes to_sha1).
> 
> Moving to a binary format increases performance slightly, but sacrifices 
> easy readability of the softrefs files.

It is bad style to introduce one type, and then change it to another in a 
backwards-incompatible way. Either you make it backwards compatible, or 
you start with the second format, never even mentioning that you had 
another format.

Ciao,
Dscho
