From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: Re: [PATCH] git grep: Add "-Z/--null" option as in GNU's grep.
Date: Wed, 1 Oct 2008 15:23:51 +0200
Message-ID: <20081001132351.GA20659@rdrz.de>
References: <1222816390-9141-1-git-send-email-killekulla@rdrz.de> <20080930231619.GR21310@spearce.org> <20080930234157.GA1453@rdrz.de> <alpine.DEB.1.00.0810011514530.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 15:25:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl1hV-0001T7-4D
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 15:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbYJANXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 09:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbYJANXy
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 09:23:54 -0400
Received: from rdrz.de ([217.160.107.209]:49613 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752943AbYJANXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 09:23:53 -0400
Received: (qmail 19511 invoked by uid 1009); 1 Oct 2008 13:23:51 -0000
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810011514530.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97221>

On Wed, Oct 01, 2008 at 03:15:34PM +0200, Johannes Schindelin wrote:
> On Wed, 1 Oct 2008, Raphael Zimmerer wrote:
> > On Tue, Sep 30, 2008 at 04:16:19PM -0700, Shawn O. Pearce wrote:
> > > Elsewhere in Git we call this "-z", like "git ls-tree -z", "git log 
> > > -z".  Should we match grep or git convention here?
> > 
> > I'd tend to grep's convention, as most options of git-grep mimic those 
> > of grep. grep uses "-z" for \0 on _input_, so that would be very 
> > confusing for grep users...
> 
> I tend to disagree.  Git is _already_ perceived as too heterogenous, and 
> we should not add to that pile.

How about discarding "-Z" from my patch, and only leave in "--null"?
That removes ambiguity _and_ is compatible to GNU grep.

- Raphael
