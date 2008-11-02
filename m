From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Sat, 1 Nov 2008 23:42:24 -0400
Message-ID: <20081102034224.GA5261@coredump.intra.peff.net>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <alpine.DEB.1.00.0810311745030.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 02 04:43:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwTsO-00014G-25
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 04:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbYKBDm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 23:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbYKBDm1
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 23:42:27 -0400
Received: from peff.net ([208.65.91.99]:3295 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbYKBDm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 23:42:26 -0400
Received: (qmail 22203 invoked by uid 111); 2 Nov 2008 03:42:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Nov 2008 23:42:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Nov 2008 23:42:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810311745030.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99803>

On Fri, Oct 31, 2008 at 05:46:35PM +0100, Johannes Schindelin wrote:

> > > +  * 'git branch --switch' : alternative to checkout
> > 
> > Blech. I think switching branches is the one thing that checkout does 
> > unconfusedly. And this is much more typing. Not to mention that So I 
> > would rather see "git switch" if checkout is somehow unpalatable.
> 
> You know, I asked for this because a _user_ told me "Guess how long it 
> took me to find out how to check out a branch!".
> 
> I think if you are not confused by CVS/SVN, the name "checkout" is utterly 
> unintuitive.

OK. I am not opposed to such a change as long as:

 - this is not just _a_ user, but a _common_ user confusion. IOW, I
   don't recall this complaint coming up a lot (or at least not nearly
   as often as other ones do). But maybe you have more data.

 - it is done consistently.

   My initial "blech" was a little premature, as I was thinking "instead
   of checkout", though it does clearly say "alternative" there.

   However, (and somebody else in the thread very cleverly came up with
   this analysis, not me), this is basically going from "verb the noun"
   to "noun --verb". And that's reasonable, if users think in terms of
   nouns. But we should be consistent in applying that transformation,
   and make it available for other nouns that match that verb. In other
   words, "git tag --switch". And however one might manipulate remote
   tracking branches ("git branch -r --switch", I guess).

   Personally I find it somewhat backwards, but I think CVS rotted my
   brain long ago.

-Peff
