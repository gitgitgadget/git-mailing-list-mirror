From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: resurrect the traditional empty "diff --git"
 behaviour
Date: Fri, 31 Aug 2007 22:30:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708312229270.28586@racer.site>
References: <20070830072748.GF16312@mellanox.co.il> <7vmyw85uml.fsf@gitster.siamese.dyndns.org>
 <20070831080651.GA17637@mellanox.co.il> <7vabs82kcq.fsf@gitster.siamese.dyndns.org>
 <20070831081517.GB17637@mellanox.co.il> <7v4pig2j91.fsf@gitster.siamese.dyndns.org>
 <20070831152120.GC17637@mellanox.co.il> <7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
 <20070831160335.GA17761@coredump.intra.peff.net> <7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
 <20070831203250.GA19340@coredump.intra.peff.net> <Pine.LNX.4.64.0708312154530.28586@racer.site>
 <7vhcmfxv4n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:30:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRE4I-0004bM-UE
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965600AbXHaVaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965586AbXHaVaN
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:30:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:58352 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965426AbXHaVaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:30:10 -0400
Received: (qmail invoked by alias); 31 Aug 2007 21:30:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 31 Aug 2007 23:30:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gYVB8dNCg2Z5o+8AQK//pM1JDTi064U385V+bJJ
	d9/Tiy8+cWXKpv
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcmfxv4n.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57218>

Hi,

On Fri, 31 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 31 Aug 2007, Jeff King wrote:
> >
> >> On Fri, Aug 31, 2007 at 01:13:42PM -0700, Junio C Hamano wrote:
> >> 
> >> > If you set diff.autorefreshindex configuration variable, it
> >> > squelches the empty "diff --git" output, and at the end of the
> >> > command, it automatically runs "update-index --refresh" without
> >> > even bothering the user.  In other words, with the configuration
> >> > variable set, people who do not care about the cache-dirtyness
> >> > do not even have to see the warning.
> >> 
> >> Nice. This is much more sane behavior, IMHO, and I think it should make 
> >> everyone happy.
> >
> > I could even imagine that this will eventually become the standard 
> > behaviour.
> 
> You sound as if you _like_ that behaviour...

Heh.  Almost.  I'd like to believe that these complaints would stop.

Ciao,
Dscho
