From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/21] Copy the remaining differences from verify_tag()
 to parse_tag_buffer_internal()
Date: Sun, 10 Jun 2007 09:22:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100917290.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090215.31731.johan@herland.net> <81b0412b0706091431h3a786aaew342693a667938d9@mail.gmail.com>
 <200706092339.12821.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:25:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIk3-0002ra-Kq
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761345AbXFJIZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761421AbXFJIZm
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:25:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:35711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761056AbXFJIZl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:25:41 -0400
Received: (qmail invoked by alias); 10 Jun 2007 08:25:40 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp048) with SMTP; 10 Jun 2007 10:25:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sCytUM27sK6F+AbBAsbNVlXKeI/JaFvU4+1hFDW
	+NSt6De4Ul43zc
X-X-Sender: gene099@racer.site
In-Reply-To: <200706092339.12821.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49674>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> I'm probably splitting this up into too small pieces, since I keep 
> getting comments that fail to see the overall picture of what I'm trying 
> to do, [...]

Maybe I said that your patch was too large. But then, I said something 
much more important: hard-to-review.

These small patches, split in a manner making it even more difficult to 
understand what you want to accomplish, do not help.

Yes, you should make small patches. Even small patch series. But in such a 
fashion that a reviewer can see that it is a good patch[*1*]. Just lean 
back, look at your patches, and ask yourself how you would have reacted if 
you had reviewed them.

Ciao,
Dscho

*1* A good patch follows the immortal words of Saint Exupery: A designer 
knows he has achieved perfection not when there is nothing left to add, 
but when there is nothing left to take away.
