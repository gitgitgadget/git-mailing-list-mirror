From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 1/6] Add set to IntList
Date: Mon, 4 May 2009 17:10:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905041709100.5553@intel-tinevez-2-302>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org> <1241230127-28279-2-git-send-email-spearce@spearce.org> <200905030907.02287.robin.rosenberg.lists@dewire.com> <20090504142231.GS23604@spearce.org> <alpine.DEB.1.00.0905041649570.5553@intel-tinevez-2-302>
 <20090504145506.GV23604@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 04 17:10:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0zoA-0005PH-FO
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 17:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbZEDPKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 11:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbZEDPKE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 11:10:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:44555 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751567AbZEDPKC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 11:10:02 -0400
Received: (qmail invoked by alias); 04 May 2009 15:10:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp001) with SMTP; 04 May 2009 17:10:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZVHNKfIDZVExnFaa59kzPs0XXoTVCZcZMpf93Tq
	/fZIb9o+F0sXNt
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090504145506.GV23604@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118247>

Hi,

On Mon, 4 May 2009, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 4 May 2009, Shawn O. Pearce wrote:
> > 
> > > Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > > > l?rdag 02 maj 2009 04:08:42 skrev "Shawn O. Pearce" 
> > > > <spearce@spearce.org>:
> > > > > Some applications may wish to modify an int list.
> > > 
> > > OK, as it turns out, this is used by code which Dscho wrote but I 
> > > haven't packaged up as patches yet.  And I don't think that even uses 
> > > the weird set(size(), ...) expands the list rules I implemented. So drop 
> > > this patch for now from the series and I'll respin it at a later date.
> > 
> > Indeed, my code only needs add(int i), which should expand the array on 
> > demand (i.e. after a clear(), it should _not_ blindly resize the array).
> 
> Really?  When I was starting to bring your code in and moved from 
> IntArray to IntList I had compile errors on set calls, so I added it to 
> IntList.

Well, in the code you have, that might be true, but as I promised, I 
picked up work on it again.  And my new version only needs add() ;-)

> Huh.  Well, add(int) is already there, and clear() resets the size
> to 0 but doesn't resize the internal array, so future adds up to
> the prior capacity are free.

Exactly as it should be!

Thanks,
Dscho
