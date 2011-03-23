From: Jeff King <peff@peff.net>
Subject: Re: gsoc - Better git log --follow support
Date: Wed, 23 Mar 2011 14:22:49 -0400
Message-ID: <20110323182249.GA17490@sigill.intra.peff.net>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
 <20110321122407.GH16334@sigill.intra.peff.net>
 <AANLkTi=woLeveur6gKnSXTRzmS8nB0o4M9HegJ+GNUCa@mail.gmail.com>
 <20110323162023.GC30337@sigill.intra.peff.net>
 <7v8vw5g4f0.fsf@alter.siamese.dyndns.org>
 <20110323170655.GA4392@sigill.intra.peff.net>
 <7vk4fpemei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Micha=C5=82_=C5=81owicki?= <mlowicki@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:22:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Sht-0007zW-8K
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 19:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803Ab1CWSWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 14:22:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42370
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635Ab1CWSWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 14:22:51 -0400
Received: (qmail 8545 invoked by uid 107); 23 Mar 2011 18:23:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Mar 2011 14:23:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2011 14:22:49 -0400
Content-Disposition: inline
In-Reply-To: <7vk4fpemei.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169868>

On Wed, Mar 23, 2011 at 11:12:37AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Obviously a solution that always provides an exact right answer is
> > preferable to "pretty good results", but we'd have to keep in mind the
> > performance difference.
> 
> And that is why the current --follow hack was declared to be good enough
> to give "pretty good results" by its inventor, no?

Absolutely. I just think we can make "pretty good" slightly better with
just a little more effort.

> I still agree with it personally, and if we _were_ to improve it out of
> "hack" status, we should aim to do the right thing (provided if there is a
> "right thing" exists).

Right. The problem is that I'm not sure we want to pay the performance
penalty to take it out of "hack" status. But that doesn't mean we can't
make it as good a hack as possible. :)

Actually, I think the non-hack version of it is not really --follow at
all, but more like Bo's line-level browser. But I think that still
leaves room for a solution like --follow that is perhaps a bit faster
and provides a pretty good answer.

-Peff
