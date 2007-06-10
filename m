From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/4] Introduce optional "keywords" on tag objects
Date: Sun, 10 Jun 2007 21:04:48 +0200
Message-ID: <200706102104.48440.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706101350.00271.johan@herland.net>
 <Pine.LNX.4.64.0706101937250.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 21:04:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxSig-00086H-No
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 21:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbXFJTE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 15:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbXFJTE5
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 15:04:57 -0400
Received: from smtp.getmail.no ([84.208.20.33]:44437 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755536AbXFJTE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 15:04:57 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00L0PP07MF00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 21:04:55 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00E5HP000X90@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 21:04:49 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00J32P003M40@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 21:04:48 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706101937250.4059@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49757>

On Sunday 10 June 2007, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 10 Jun 2007, Johan Herland wrote:
> 
> > +	/* Verify the keywords: disallow ctrl chars, spaces and double commas */
> 
> What about Junio's suggestion, making it really strict at first, and only 
> loosening it if we need to? IIRC it was alnum + '_', maybe even '-'.

For now, I couldn't find a good reason why the set of allowed characters
for keywords should be smaller than for the tag name.
Feel free to tighten the set of characters before this makes it into a
release. However, if you do, the same tightening should be considered
for the tag name as well, I guess. Can't see any good reasons for why
one should be tighter than the other.

> And please accept my apologies for my language. Reading some of it, I have 
> to admit that it sounded as harsh as Junio suggested it to be. My only 
> excuse is that I had an unplanned stay at the Paris airport for more than 
> 9 hours (after a night in the plane where I could hardly sleep), so I 
> should really have stayed away from writing emails. But since you 
> addressed your emails to me, I wanted to reply to you as soon as I had the 
> chance to.

Apology accepted. I'm sorry my patch-series-from-hell came at such an
inconvenient time for you. 


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
