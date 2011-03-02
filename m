From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Wed, 2 Mar 2011 16:28:24 -0500
Message-ID: <20110302212824.GF20400@sigill.intra.peff.net>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org>
 <AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
 <7v7hckje4n.fsf@alter.siamese.dyndns.org>
 <20110301205424.GA18793@sigill.intra.peff.net>
 <7vwrkiccy6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:28:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Putb2-0005S2-1M
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804Ab1CBV21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:28:27 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34448 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756074Ab1CBV20 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:28:26 -0500
Received: (qmail 20626 invoked by uid 111); 2 Mar 2011 21:28:26 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 21:28:26 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 16:28:24 -0500
Content-Disposition: inline
In-Reply-To: <7vwrkiccy6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168347>

On Tue, Mar 01, 2011 at 09:24:01PM -0800, Junio C Hamano wrote:

> >   - Nit: you nicely use "%d commit%s" to handle the single/plural case
> >     in the warning message, but then you "them" later on. It needs
> >     (1 < lost) ? "them" : "it".
> 
> I actually don't like playing games like that, especially when i18n topic
> is in flight.  Among the languages I know rules reasonably well, two has
> the rule that a countable noun is spelled differently depending on the
> number of that thing is one or more, and one spells the noun the same way
> regardless of the number.  Who knows if git needs to be translated into a
> language whose noun changes its shape three-way, depending on the number
> being one, two, or more?

OK, I am showing my English-centric ignorance then, I think. :) I will
leave that topic for the i18n people to deal with.

-Peff
