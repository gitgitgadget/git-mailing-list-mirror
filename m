From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Wed, 23 Feb 2011 19:14:21 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102231908340.26358@xanadu.home>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie> <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie> <20110222155637.GC27178@sigill.intra.peff.net>
 <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
 <20110223045143.GA11846@sigill.intra.peff.net>
 <7vlj16aeih.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102231213280.26358@xanadu.home>
 <1298502543.28664.19.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Feb 24 01:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsOqi-0003Op-6c
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017Ab1BXAOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 19:14:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29354 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab1BXAOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 19:14:22 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LH300G1NHZ87E60@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 23 Feb 2011 19:13:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1298502543.28664.19.camel@drew-northup.unet.maine.edu>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167753>

On Wed, 23 Feb 2011, Drew Northup wrote:

> 
> On Wed, 2011-02-23 at 12:18 -0500, Nicolas Pitre wrote:
> > On Wed, 23 Feb 2011, Junio C Hamano wrote:
> > 
> > > Jeff King <peff@peff.net> writes:
> > > 
> > > > On Tue, Feb 22, 2011 at 11:30:41AM -0800, Junio C Hamano wrote:
> > > >
> > > >> > Speaking of Makefiles, one downside to all of this directory
> > > >> > segmentation is that you can't run "make" from the subdirectories.
> > > >> 
> > > >> I had an impression that "make -C lib/" would be one of the goals, iow,
> > > >> when we split the directory structure, the next step would be to split the
> > > >> top-level Makefile so that each directory is covered by its own Makefile,
> > > >> just like Documentation/ is already usable that way.
> > > >
> > > > Ugh. I am not thrilled at the prospect of more recursive make.
> > > 
> > > Likewise. Notice that I have consistently been unthrilled when people
> > > started talking about splitting the source code tree?
> > 
> > Maybe that would be wiser to consider an initial set of patches as those 
> > which were proposed to only do the simple file move first, then wait for 
> > the dust to settle before doing more changes.  Doing too much in one go 
> > is inevitably going to bounce against the human tendency to resist any 
> > kind of change, good or bad.
> 
> > Nicolas
> 
> Nicolas,
> They are doing it this way because change is not the objective. A
> possible better way of managing the codebase is.

Incidentally I know that (guess whom this proposal came from initially).  ;-)

> Perhaps it isn't the
> right way to go--and we won't know that until we've explored all of the
> side-effects, advantages, disadvantages, etc.
> 
> Besides, if we move anything around into a deeper directory structure we
> are inevitably going to have to deal with more recursive make problems.
> We can't just commit to master a tree that has everything moved about
> and get around to dealing with the Makefiles later.

The initial set of patches simply moved files into subdirectories and 
made the corresponding renames within the Makefile.

Reorganizing the Makefile into a better Makefile or sub-makefiles can be 
done subsequently.  That's my point.


Nicolas
