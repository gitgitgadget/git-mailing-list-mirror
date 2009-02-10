From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 18:09:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101808310.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
 <20090210164430.GN30949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, gitster@pobox.com, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 18:10:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWw8A-0000DC-Sc
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 18:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155AbZBJRJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 12:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755112AbZBJRJL
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 12:09:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:58686 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754949AbZBJRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 12:09:10 -0500
Received: (qmail invoked by alias); 10 Feb 2009 17:09:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 10 Feb 2009 18:09:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jY6pYbl4jZ5OzN+9JuoHfTxK/y6A8ZkHxcaXBOO
	mL9nS5/IyKKc00
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090210164430.GN30949@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109276>

Hi,

On Tue, 10 Feb 2009, Shawn O. Pearce wrote:

> For the "git database" thing above, I've been contemplating the
> idea of an index stored external from the Git object database.

The whole point of my exercise was to reuse as much as possible of Git's 
framework.  After all, if you store an index external from Git's object 
database, you go back to reimplementing the whole infrastructure for 
fetching/merging just for that index.

Ciao,
Dscho
