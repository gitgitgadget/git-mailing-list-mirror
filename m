From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 1/6] Add set to IntList
Date: Mon, 4 May 2009 16:50:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905041649570.5553@intel-tinevez-2-302>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org> <1241230127-28279-2-git-send-email-spearce@spearce.org> <200905030907.02287.robin.rosenberg.lists@dewire.com> <20090504142231.GS23604@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 04 16:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0zVN-0004V9-Fn
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 16:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443AbZEDOuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 10:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbZEDOuo
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 10:50:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:55764 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752115AbZEDOun (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 10:50:43 -0400
Received: (qmail invoked by alias); 04 May 2009 14:50:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp050) with SMTP; 04 May 2009 16:50:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ys6o9CSmYmw55ZZypKnGUyJvX6OO37Muqn080cl
	PHB3G5LMh7rTAR
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090504142231.GS23604@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118244>

Hi,

On Mon, 4 May 2009, Shawn O. Pearce wrote:

> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > l?rdag 02 maj 2009 04:08:42 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > > Some applications may wish to modify an int list.
> 
> OK, as it turns out, this is used by code which Dscho wrote but I 
> haven't packaged up as patches yet.  And I don't think that even uses 
> the weird set(size(), ...) expands the list rules I implemented. So drop 
> this patch for now from the series and I'll respin it at a later date.

Indeed, my code only needs add(int i), which should expand the array on 
demand (i.e. after a clear(), it should _not_ blindly resize the array).

Ciao,
Dscho
