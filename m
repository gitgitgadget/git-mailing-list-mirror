From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] do not mangle short options which take arguments
Date: Fri, 2 Oct 2009 11:04:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910021104060.18640@intel-tinevez-2-302>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost> <20091002061159.GA24892@coredump.intra.peff.net> <20091002073628.GA9444@localhost> <alpine.DEB.1.00.0910021042110.18640@intel-tinevez-2-302>
 <20091002084359.GA8878@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 02 11:04:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mte47-0005sZ-Bz
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 11:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbZJBJE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 05:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753518AbZJBJE0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 05:04:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:43243 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753439AbZJBJEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 05:04:25 -0400
Received: (qmail invoked by alias); 02 Oct 2009 09:04:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp056) with SMTP; 02 Oct 2009 11:04:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18O1w1Qq/UOh8lC00zMlcAGC7+jb7MD3EdrcHCdiJ
	fSld8sk1xJu+Pz
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20091002084359.GA8878@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129437>

Hi,

On Fri, 2 Oct 2009, Jeff King wrote:

> On Fri, Oct 02, 2009 at 10:42:36AM +0200, Johannes Schindelin wrote:
> 
> > > Yes, we deliberately allow users to shoot themselves in the foot. But 
> > > they should have to use at least a long option to do it.
> > 
> > Something like this?
> > [...]
> > +		} else if (!strcmp(cmd, "--shoot-me-in-the-foot")) {
> > +			warning ("Bang, bang!");
> 
> Doh! Now I have to come up with a new joke patch for the GitTogether!

Don't make me envious :-(

Ciao,
Dscho
