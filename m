From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-update-ref: add --no-deref option for overwriting/detaching
 ref
Date: Wed, 9 May 2007 18:07:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091806070.4167@racer.site>
References: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org>
 <7vk5viuim5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 18:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hloh5-0005Fj-Ch
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbXEIQHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754259AbXEIQHG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:07:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:56200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754218AbXEIQHE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:07:04 -0400
Received: (qmail invoked by alias); 09 May 2007 16:07:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 09 May 2007 18:07:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qviJFiC2qPl5jghsIHz2fYc9NW2GEQSi/m8sppY
	cmxkPZs6ZUQXIh
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5viuim5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46735>

Hi,

On Wed, 9 May 2007, Junio C Hamano wrote:

> Sven Verdoolaege <skimo@kotnet.org> writes:
> 
> > git-checkout is also adapted to make use of this new option
> > instead of the handcrafted command sequence.
> >
> > Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
> > ---
> > All tests pass, except the recently added cvsserver tests,
> > but they fail without this patch too.
> 
> Can you retry after installing libdbi and libdbd-sqlite-perl?

We have quite a few tests which are ignored when the prerequisites are not 
installed. I wonder if we could do the same with t9400...

Ciao,
Dscho
