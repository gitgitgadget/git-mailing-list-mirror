From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Sat, 20 Oct 2007 01:00:19 -0400
Message-ID: <20071020050019.GA27282@coredump.intra.peff.net>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com> <20071019113822.GB16726@thunk.org> <4718A3AB.7090301@viscovery.net> <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Theodore Tso <tytso@thunk.org>,
	Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 07:00:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij6Ru-0006eB-E2
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 07:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbXJTFAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 01:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbXJTFAW
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 01:00:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2706 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbXJTFAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 01:00:21 -0400
Received: (qmail 18632 invoked by uid 111); 20 Oct 2007 05:00:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Oct 2007 01:00:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Oct 2007 01:00:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61784>

On Fri, Oct 19, 2007 at 10:14:59AM -0400, Nicolas Pitre wrote:

> > ==> git://repo.or.cz/git/spearce.git
> >  * (new)              gitk -> spearce/gitk
> >  * 1aa3d01..e7187e4   maint -> spearce/maint
> >  * de61e42..7840ce6   master -> spearce/master
> >  * 895be02..2fe5433   next -> spearce/next
> >  + 89fa332...1e4c517  pu -> spearce/pu
> >  * (new)              todo -> spearce/todo
> 
> Actually I think this is the best format so far: one line per branch, no 
> terminal width issue (long branch names are simply wrapped), the 
> old..new info is there also with the single character marker to quickly 
> notice the type of update.

Technically speaking, the hash IDs can be up to 80 characters long,
since they are meant to be unique abbreviations. But in practice, I
think leaving enough space for 10 + '...' + 10 should accomodate just
about any project (IIRC, the kernel's longest non-unique is around 9).

-Peff
