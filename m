From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Some ideas for StGIT
Date: Sat, 4 Aug 2007 17:35:49 -0400
Message-ID: <20070804213549.GA1967@filer.fsl.cs.sunysb.edu>
References: <1186163410.26110.55.camel@dv> <20070804063858.GA13758@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 04 23:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHRIH-0001Zx-Ia
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 23:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763552AbXHDVgP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 17:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762478AbXHDVgO
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 17:36:14 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:47844 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762240AbXHDVgO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 17:36:14 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l74LZn2k005827;
	Sat, 4 Aug 2007 17:35:49 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l74LZnGD005825;
	Sat, 4 Aug 2007 17:35:49 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <20070804063858.GA13758@thunk.org>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54911>

On Sat, Aug 04, 2007 at 02:38:58AM -0400, Theodore Tso wrote:
> On Fri, Aug 03, 2007 at 01:50:10PM -0400, Pavel Roskin wrote:
> > Hello!
> > 
> > I was recently disappointed to learn that one of the Linux drivers
> > (bcm43xx_mac80211, to be precise) switched from git to quilt.  I asked
> > whether StGIT was considered, a discussion followed, and I think the key
> > points need to be shared with StGIT developers.  I'll add some of my
> > ideas to the mix.
> 
> You might also ask them if they considered "guilt", which uses
> text-based patches.  It's a lot easier to use, and if they really want
> quilt-like functionality, "guilt" will provide it.
 
I guess I should chime in.

The goal behind guilt is to be very simple yet powerful enough to do what is
necessary to maintain a piece of kernel code (read: to scratch my own itch).

> And because it's so stupid simple, it's much rarer that something goes
> seriously wrong that requires me to use a recovery procedure in the
> first place.

Thanks! :)

> Editing patch headers are also a lot easier with guilt; you can just
> go ahead and edit them all, and then you can fresh them in git by
> doing a "guilt pop -a; guilt push -a".  Since it's not using a
> git-based storage, it doesn't have to rewrite the whole patch stack
> when you modify a single patch header; you can edit a whole bunch of
> text headers and then refresh the git commit series just once.

FYI: v0.27 allows you to edit the patch headers with: guilt header -e

Pavel, if you have any questions, you know where to ask :)

Josef 'Jeff' Sipek.

-- 
Don't drink and derive. Alcohol and algebra don't mix.
