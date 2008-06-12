From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: To graft or not to graft... (Re: Recovering from repository corruption)
Date: Thu, 12 Jun 2008 14:20:16 +0200
Message-ID: <20080612122016.GA25926@cuci.nl>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com> <200806120914.22083.johan@herland.net> <20080612074752.GA507@sigill.intra.peff.net> <200806121221.02287.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Denis Bueno <dbueno@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 14:21:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6lnm-0005fg-5t
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 14:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760440AbYFLMUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 08:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760426AbYFLMUU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 08:20:20 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43118 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760410AbYFLMUS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 08:20:18 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id CB4CC545E; Thu, 12 Jun 2008 14:20:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200806121221.02287.johan@herland.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84751>

Johan Herland wrote:
>I can only draw the conclusion that with current versions of Git, repos 
>with grafts should _never_ be made public.

Correct.

I still prefer my original suggestion, i.e. allow repos with grafts to
be cloned, yet disregard the grafts during the cloning process.
The trouble is that with your suggestion, it becomes a bit convoluted
when grafts are being used and when not.  It already is complicated as
it is, so I suggest we try and keep git honest so that it does exactly
what one would expect (instead of documenting awkward behaviour).

As soon as time permits, I'll submit appropriate patches to implement
this, as well as some other sanity check patches which I've been
contemplating to help the grafter detect "bad" grafts as early as
possible.
-- 
Sincerely,
           Stephen R. van den Berg.

"Always look on the bright side of life!"
