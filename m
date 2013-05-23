From: Andreas Krey <a.krey@gmx.de>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 11:06:57 +0200
Message-ID: <20130523090657.GB23933@inner.h.apk.li>
References: <20130522115042.GA20649@inner.h.apk.li> <7v4ndukhx0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 11:07:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfRUN-0001SM-QL
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 11:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757592Ab3EWJHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 05:07:05 -0400
Received: from continuum.iocl.org ([217.140.74.2]:38715 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415Ab3EWJHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 05:07:03 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4N96vS30796;
	Thu, 23 May 2013 11:06:57 +0200
Content-Disposition: inline
In-Reply-To: <7v4ndukhx0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225226>

On Wed, 22 May 2013 11:07:07 +0000, Junio C Hamano wrote:
...
> If you have a four-commit segment in your commit ancestry graph

I never had yet. :-(

> (time flows from left to right; turn your head 90-degrees to the
> right if you want a gitk representation):
> 
>     ---A--X
>         \/
>         /\
>     ---B--Y
> 
> where X and Y are both merges between A and B, having A as their
> first parent, how would you express such a graph with first-parent
> chain going a straight line?

Of course there are multiple possible straight lines and how it looks
depends on the order I use the existing heads to fish them out. (That
is, when the straight lines join, I need to bend one of them.) Assuming
I take the one where X is on, I expect a look like

-----A-------X-----
      \      |
       +- Y--------
          |  |
-----B----+--+

Branch heads that are reachable from other head are picked after those
that aren't reachable.

The point is to get the feature branches being displayed on separate
lanes (and thus visibly sticking out) and not being intermingled with
the longer-living branches.

...
> Don't do that, then.

:-) Problem is, in this case 'I' expands to about
    1<<7 people I need to educate on this.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
