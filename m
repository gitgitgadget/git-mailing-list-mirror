From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 17 Feb 2008 13:22:08 -0500
Message-ID: <20080217182208.GB4818@coredump.intra.peff.net>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org> <7vmyq9gk94.fsf@gitster.siamese.dyndns.org> <7vk5la4oxq.fsf@gitster.siamese.dyndns.org> <7vejbc44hu.fsf@gitster.siamese.dyndns.org> <1203263316.6601.3.camel@futex> <7v7ih31mj9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthias Kestenholz <mk@spinlock.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:22:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQoA2-0001KH-MR
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbYBQSWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbYBQSWL
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:22:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1756 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbYBQSWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:22:11 -0500
Received: (qmail 3168 invoked by uid 111); 17 Feb 2008 18:22:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 17 Feb 2008 13:22:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Feb 2008 13:22:08 -0500
Content-Disposition: inline
In-Reply-To: <7v7ih31mj9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74153>

On Sun, Feb 17, 2008 at 10:10:50AM -0800, Junio C Hamano wrote:

> > What about color.ui? I am still interested in a single central
> > configuration variable to enable colored output from git. I know that I
> > sent a proposal patch at a bad time.
> 
> Yeah, I liked the general idea, and was about to forget.  I
> vaguely recall there was a design disagreement between you and
> Jeff King (perhaps others as well)?

IIRC, my objection was that the original implementation didn't correctly
preserve the existing split color types, but that the latest version of
the patch dealt with it.

> I appreciate a reminder like your message, but I do not want to
> be in the business of fishing for old patches that may or may
> not { apply to | work well with } the updated base anymore for
> everybody.  I wish I had the mental bandwidth to do so, but it
> simply becomes infeasible in the longer run.
> 
> Could you (and anybody who has "sent but about to be or
> suspected to be forgotten" changes) respin, retest and resend
> please?

Speaking as a reviewer, I second this. It is much easier to review
patches if they are up to date, and doubly so if the new cover letter
material gives a hint as to what happened the last time (e.g., "this
looked good, but we were in rc freeze", "somebody objected to X, and I
have fixed it", or even just "nobody said anything and it got
overlooked").

-Peff
