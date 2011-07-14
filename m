From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 15:46:38 -0400
Message-ID: <20110714194638.GE8453@thunk.org>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
 <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <CA+55aFzvib7QF-J3fBj2brcQifXGqoeK1t7vfx6pcJmJAEO0dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:46:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRs3-0000dm-Iv
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab1GNTqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 15:46:47 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:48520 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969Ab1GNTqq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 15:46:46 -0400
Received: from root (helo=tytso-glaptop)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1QhRrr-0000DQ-Bd; Thu, 14 Jul 2011 19:46:39 +0000
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1QhRrq-0007Pc-Eh; Thu, 14 Jul 2011 15:46:38 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzvib7QF-J3fBj2brcQifXGqoeK1t7vfx6pcJmJAEO0dw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177166>

On Thu, Jul 14, 2011 at 11:55:39AM -0700, Linus Torvalds wrote:
> On Thu, Jul 14, 2011 at 11:47 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Also, I suspect that the cache could easily be done as a *small* and
> > *incomplete* cache, ie you don't need to cache all commits, it would
> > be sufficient to cache a few hundred spread-out commits, and just know
> > that "from any commit, the cached commit will be quickly reachable".
> 
> Put another way: we could do the cache not as a real dynamic entity,
> but as something that gets generated at "git clone" time or when
> re-packing.

Would it be considered evil if we put the generation number in the
pack, but not consider it part of the formal object (i.e., it would be
just a cache, but one that wouldn't change once the pack was created)?

       	      	      	   	    	   	- Ted
