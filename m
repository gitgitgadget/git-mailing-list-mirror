From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] allow mangling short options which take integer
 arguments
Date: Fri, 2 Oct 2009 10:41:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910021040260.18640@intel-tinevez-2-302>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost> <20091001202301.GB12175@localhost> <alpine.DEB.1.00.0910012354080.4985@pacific.mpi-cbg.de> <20091002074317.GB9444@localhost> <20091002075012.GB27664@coredump.intra.peff.net>
 <20091002082633.GA21168@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Oct 02 10:43:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtdhY-0005Pq-Gi
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 10:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbZJBIlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 04:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbZJBIlJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 04:41:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:46027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755592AbZJBIlI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 04:41:08 -0400
Received: (qmail invoked by alias); 02 Oct 2009 08:41:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp049) with SMTP; 02 Oct 2009 10:41:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19q+A1BPXFq2Dw4qReT57oJlKq4KH5pQcG9vB5gc2
	F9gwhEG/e8rRsM
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20091002082633.GA21168@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129433>

Hi,

On Fri, 2 Oct 2009, Clemens Buchacher wrote:

> On Fri, Oct 02, 2009 at 03:50:12AM -0400, Jeff King wrote:
> > On Fri, Oct 02, 2009 at 09:43:17AM +0200, Clemens Buchacher wrote:
> > 
> > > On Thu, Oct 01, 2009 at 11:55:03PM +0200, Johannes Schindelin wrote:
> > > 
> > > > And this patch looks even more straight-forward than 1/2, _but_... what 
> > > > about cases where there are short options that are digits?
> > > 
> > > Could you point me to one of those? I did not find any during my
> > > non-exhaustive search. We should be able to handle them easily by adding
> > > PARSE_OPT_MANY.
> > 
> > The one that comes readily to mind is "git log -1", but that is actually
> > parsed by the revision options parser, which doesn't use parseopt. But
> > there are a few done by parseopt:
> 
> Oh, I mistakenly thought Dscho was asking about options with 
> single-digit arguments. Thanks for clearing this up.

I was actually thinking both of "git log -11" as well as out-of-tree users 
of parse-options.

Ciao,
Dscho
