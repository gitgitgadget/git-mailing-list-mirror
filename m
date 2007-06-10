From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Change softrefs file format from text (82 bytes per entry)
 to binary (40 bytes per entry)
Date: Sun, 10 Jun 2007 16:03:42 +0200
Message-ID: <200706101603.43027.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092025.30156.johan@herland.net>
 <Pine.LNX.4.64.0706100900420.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 16:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxO1K-00066e-Co
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 16:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbXFJODx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 10:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754415AbXFJODx
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 10:03:53 -0400
Received: from smtp.getmail.no ([84.208.20.33]:38412 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbXFJODw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 10:03:52 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00J0LB2FT700@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:03:51 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00ENGB270X10@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:03:43 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00COXB27ZXA0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:03:43 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706100900420.4059@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49735>

On Sunday 10 June 2007, Johannes Schindelin wrote:
> On Sat, 9 Jun 2007, Johan Herland wrote:
> > The text-based softrefs file format uses 82 bytes per entry (40 bytes 
> > from_sha1 in hex, 1 byte SP, 40 bytes to_sha1 in hex, 1 byte LF).
> > 
> > The binary softrefs file format uses 40 bytes per entry (20 bytes 
> > from_sha1, 20 bytes to_sha1).
> > 
> > Moving to a binary format increases performance slightly, but sacrifices 
> > easy readability of the softrefs files.
> 
> It is bad style to introduce one type, and then change it to another in a 
> backwards-incompatible way. Either you make it backwards compatible, or 
> you start with the second format, never even mentioning that you had 
> another format.

As Junio correctly pointed out, this patch is only here to demonstrate an
alternative solution. Whether or not this patch should be used should be
determined _long_ before (even thinking about) putting this into a release.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
