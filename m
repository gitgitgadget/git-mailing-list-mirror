From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Reference for git.git release process
Date: Thu, 26 Mar 2009 10:03:26 -0700
Message-ID: <20090326170326.GE23521@spearce.org>
References: <49CA78BF.2020101@fastmail.fm> <7viqlxz9go.fsf@gitster.siamese.dyndns.org> <20090326022757.GC5835@coredump.intra.peff.net> <7v3ad1ufcb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Raman Gupta <rocketraman@fastmail.fm>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 18:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmt1f-0000Eg-S8
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 18:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759296AbZCZRDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 13:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759662AbZCZRD3
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 13:03:29 -0400
Received: from george.spearce.org ([209.20.77.23]:47828 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759815AbZCZRD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 13:03:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CAC4C38211; Thu, 26 Mar 2009 17:03:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v3ad1ufcb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114805>

jUNio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
> > On Wed, Mar 25, 2009 at 12:30:31PM -0700, Junio C Hamano wrote:
> >
> >> I do not answer "generally" part, but in git.git, I do not publish heads
> >> of individual topic branches.  I could, but simply I don't, because that
> >> has been the way I've operated so far, and I am too lazy to change my
> >> configuration.
> >
> > I don't think it is a big problem in practice.
> 
> Both times Shawn took over the maintainership from me in October for the
> past few years (and I will ask him to this year, too, although I do not
> know if he is willing to take it again yet), it would have made his life
> (and possibly everybody who had his topic in flight) much easier if they
> were public.  Last year I sent him for-each-ref output offline before I
> took off to make it a bit easier on him (my disappearance two years ago
> was unscheduled and I couldn't do that).

So yes, I'd be happy to fill in while you are offline again.

But back to Jeff's point, the bigger issue when you dropped off
all of a sudden wasn't extracting the refs from the `pu` branch
(that was fairly easy, just scan through the merge commits, copy
and paste the branch name, copy and paste the 2nd parent), it was
figuring out what the state of each branch was, and what your final
thoughts on that branch had been before you left.

The newer "what's in" tools in your Meta project make this easier,
along with having the messages archived.  The first year I had to
go pull the what's in email from the list archives, and just scan
through the code and form my own opinion in a few cases.

-- 
Shawn.
