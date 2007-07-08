From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: sometimes, d/f conflict is not an issue
Date: Sun, 8 Jul 2007 13:53:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081351330.4248@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131354250.4059@racer.site>
 <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131543140.4059@racer.site>
 <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0707080148370.4093@racer.site> <7vabu765r0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707080248320.4093@racer.site> <7v644v5tr3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	=?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Vanicat <vanicat@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 15:00:39 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7WNQ-00072I-Oo
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 15:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbXGHNAe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 09:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbXGHNAd
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 09:00:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:38380 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753625AbXGHNAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 09:00:32 -0400
Received: (qmail invoked by alias); 08 Jul 2007 13:00:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 08 Jul 2007 15:00:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bZ+J/JUMbR1EfKyHUplx+1EjUo15EAstpYpeipp
	nNqTRcqv5yYGtV
X-X-Sender: gene099@racer.site
In-Reply-To: <7v644v5tr3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51880>

Hi,

On Sat, 7 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> IOW, don't make unpack-trees to make policy decisions on final 
> >> resolution, unless it is operating under aggressive rule (where the 
> >> caller explicitly allows it to make more than the "trivial" decisions).  
> >> The caller (in this case, merge-recursive) should see A at stage #2 with 
> >> A/B at stages #1 and #3 and decide what to do.
> >
> > Okay, so you're saying that merge-recursive should use the aggressive 
> > strategy?
> 
> I do not think so.

Yes, I realized that by running the tests with it.  A rename A->B in one, 
and A->C in the other branch will go undetected.

I should have written this into my mail posting the WIP patch, but 
frankly, I was too tired.

Ciao,
Dscho
