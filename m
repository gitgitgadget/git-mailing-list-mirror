From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix warning about bitfield in struct ref
Date: Wed, 21 Nov 2007 11:59:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211158450.27959@racer.site>
References: <20071118093137.GA2196@spearce.org>
 <Pine.LNX.4.64.0711200058270.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <20071121065155.GT14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 13:00:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuoFi-0008Fs-Jo
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 13:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbXKUMAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 07:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756200AbXKUMAB
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 07:00:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:36533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752303AbXKUMAA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 07:00:00 -0500
Received: (qmail invoked by alias); 21 Nov 2007 11:59:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 21 Nov 2007 12:59:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MJeFjgPpMFVw7IYji215d/7ak5RW79SceZnBHuH
	BF+EwClZrMOgim
X-X-Sender: gene099@racer.site
In-Reply-To: <20071121065155.GT14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65634>

Hi,

On Wed, 21 Nov 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 18 Nov 2007, Shawn O. Pearce wrote:
> > 
> > > +	unsigned int force:1,
> > 
> > Isn't this "unsigned force:1" everywhere else in git's source?
> 
> That may be true but Junio already applied it as "unsigned int"
> as I wrote it.

Yes, I saw that _after_ I wrote this mail.

> Anyway "unsigned int" and "unsigned" will give the same result here; I 
> just typed 4 characters more than I needed to.

No big problem.

Ciao,
Dscho
