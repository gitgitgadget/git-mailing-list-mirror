From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to replace a single corrupt, packed object?
Date: Fri, 8 Aug 2008 16:50:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081647580.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080808143918.GB9152@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, nico@cam.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 16:46:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRTEa-0007iq-MZ
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbYHHOp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 10:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbYHHOp1
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:45:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:51246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751827AbYHHOp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:45:26 -0400
Received: (qmail invoked by alias); 08 Aug 2008 14:45:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 08 Aug 2008 16:45:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VC6J3aOOVPzAa80wHUXy7Z4kHMV0STR8pL43qs0
	pixd05cgJbm6hR
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080808143918.GB9152@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91675>

Hi,

On Fri, 8 Aug 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > my auto gc kicked in, and shows this:
> > 
> > fatal: corrupt packed object for 2c1e128aa51e3a64bd61556c0cd488628b423ccf
> > error: failed to run repack
> > 
> > Fortunately, I have the uncorrupted object somewhere else.  So I copy the 
> > single object as a loose one, and all is fine.  Right?
> > 
> > Wrong.
> > 
> > Repack still picks up the corrupt object instead of the good one.  What's 
> > the best way out?
> 
> Use a 1.6.0 rc?  Nico I thought fixed this in 1.6 to automatically
> try and find another copy of an object if the first copy considered
> for inclusion into the pack was corrupt.

Thanks for the quick reply, but no joy (You should know me better than 
that ;-) :

$ git --version
git version 1.6.0.rc1.112.gebbe4

Ciao,
Dscho
