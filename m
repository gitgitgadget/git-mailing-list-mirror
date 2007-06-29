From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git add: respect core.filemode even with unmerged entries
 in the index
Date: Fri, 29 Jun 2007 11:06:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706291103470.4438@racer.site>
References: <20070625064017.GA2839@mellanox.co.il> <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
 <20070625071752.GB15343@mellanox.co.il> <Pine.LNX.4.64.0706250846200.4059@racer.site>
 <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>
 <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com>
 <Pine.LNX.4.64.0706281506390.4438@racer.site> <4683C5D2.FDF4ED02@eudaptics.com>
 <4683CA7A.7F8070D7@eudaptics.com> <Pine.LNX.4.64.0706281653260.4438@racer.site>
 <7vir97f98o.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 12:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4DSU-0006Mp-LJ
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 12:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbXF2KMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 06:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754971AbXF2KMI
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 06:12:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:40878 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754616AbXF2KMF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 06:12:05 -0400
Received: (qmail invoked by alias); 29 Jun 2007 10:12:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 29 Jun 2007 12:12:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/i4PlfYybi/KNhduTInBAxD3Rboe53zOX5l2G9VV
	yIY1mx/2w4gZxp
X-X-Sender: gene099@racer.site
In-Reply-To: <7vir97f98o.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51168>

Hi,

On Fri, 29 Jun 2007, Junio C Hamano wrote:

> Hmph.
> 
>  * Are you sure about (1-pos)?
> 
>  * I _think_ we would want to favor our stage (i.e. #2)

Hmph back.

I _thought_ that our stage is #1, not even bothering to check the 
documentation. But it seems that you are right.

So your code looks fine to me, except that I would move the whole 
get_index_entry_for_file_even_if_the_entry_is_unmerged(name, namelen) 
code into its own function.

Want me to prepare a patch? If so, I'll do it tonight, since I will be 
occupied the rest of the (working) day.

Ciao,
Dscho
