From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 09:17:51 -0800
Message-ID: <20090210171751.GQ30949@spearce.org>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de> <20090210164430.GN30949@spearce.org> <alpine.DEB.1.00.0902101808310.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, gitster@pobox.com, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 18:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWwGV-0003pc-Sf
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 18:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbZBJRRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 12:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754195AbZBJRRw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 12:17:52 -0500
Received: from george.spearce.org ([209.20.77.23]:36100 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbZBJRRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 12:17:52 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 736DB38210; Tue, 10 Feb 2009 17:17:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902101808310.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109278>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 10 Feb 2009, Shawn O. Pearce wrote:
> 
> > For the "git database" thing above, I've been contemplating the
> > idea of an index stored external from the Git object database.
> 
> The whole point of my exercise was to reuse as much as possible of Git's 
> framework.  After all, if you store an index external from Git's object 
> database, you go back to reimplementing the whole infrastructure for 
> fetching/merging just for that index.

Yea, I know.

It might just be easier to abandon everything in Git and start
from scratch for the "git database" thing.  But we'd lose the
ability to at least piggyback onto the existing Git transport.
And it doesn't help the "git notes" feature we're talking about.

Maybe I was viewing the external index as like the working tree,
where you can't really access the data until the external indexes
are current, just like you can't really (easily anyway) access the
working tree files until you bring the working tree current.  But
yea, it doesn't really use any of the existing machinary.

-- 
Shawn.
