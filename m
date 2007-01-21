From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sun, 21 Jan 2007 02:39:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701210234350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701210137.41219.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1794508947-1169343599=:22628"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 02:40:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Rgv-0005jA-Ay
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 02:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbXAUBkD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 20:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbXAUBkD
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 20:40:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:38623 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751062AbXAUBkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 20:40:01 -0500
Received: (qmail invoked by alias); 21 Jan 2007 01:39:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 21 Jan 2007 02:39:59 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
In-Reply-To: <200701210137.41219.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37302>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1794508947-1169343599=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 21 Jan 2007, Robin Rosenberg wrote:

> lördag 20 januari 2007 23:04 skrev Johannes Schindelin:
> > +--reverse::
> > +
> > +	Output the commits in reverse order.
> > +
> 
> The --reverse is really bad naming since the default *is* to list 
> commits in reverse order.

Easy. In my worldview it is _not_ the reverse order. It is the most 
useful order, and thus straight-forward.

> Name it "--chronological" or something to indicate that you do not want 
> the default reverse order.

But it is not chronological. Take for example "git log --topo-order 
--reverse". See? Not chronological. Not even reverse chronological.

> Some suggestions:
> 	--chronological
> 	--forward
> 	--noreverse
> 	--commit-order

All of these have a high "Huh?" effect on me. "forward" is wrong, 
"noreverse" is confusing at best, and commit-order is anything but 
obvious. IOW those names don't solve a problem.

Ciao,
Dscho

---1148973799-1794508947-1169343599=:22628--
