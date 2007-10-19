From: Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 17:17:55 -0400
Message-ID: <20071019211755.GC751@thunk.org>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com> <20071019113822.GB16726@thunk.org> <20071019143844.GB23765@diana.vm.bytemark.co.uk> <alpine.LFD.0.9999.0710191058570.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 23:18:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IizEg-0004HD-Gv
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 23:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966602AbXJSVSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 17:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966665AbXJSVSM
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 17:18:12 -0400
Received: from THUNK.ORG ([69.25.196.29]:41046 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966602AbXJSVSK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 17:18:10 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IizO8-0002xI-FH; Fri, 19 Oct 2007 17:28:12 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IizEB-0003A7-Ny; Fri, 19 Oct 2007 17:17:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710191058570.19446@xanadu.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61765>

On Fri, Oct 19, 2007 at 11:03:00AM -0400, Nicolas Pitre wrote:
> Well, the important thing is that the _content_ is moving from the 
> remote repository to the local one.  That's how the arrow should be 
> interpreted conceptually.  The fact that technically we end up assigning 
> the local ref with the remote value is a technical issue.

If the _content_ is moving from the remote repository to the local
one, I would think the arrow should be pointing from the remote
repoistory to the local one, i.e.:

  * 895be02..2fe5433   next <- spearce/next

But right now we are proposing:

  * 895be02..2fe5433   next -> spearce/next

I would think the former makes more sense is the content is going
*from* spearce/next into the local next branch.

This isn't a huge deal, but these tiny things make a large amount of
difference in usability for the novice who just getting started with
git....

						- Ted
