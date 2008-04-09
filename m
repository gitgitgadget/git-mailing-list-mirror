From: Jeff King <peff@peff.net>
Subject: Re: git annoyances
Date: Wed, 9 Apr 2008 17:45:04 -0400
Message-ID: <20080409214504.GA11110@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 23:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jji76-0004jo-B4
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 23:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbYDIVpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 17:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbYDIVpI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 17:45:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3359 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbYDIVpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 17:45:07 -0400
Received: (qmail 14918 invoked by uid 111); 9 Apr 2008 21:45:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 09 Apr 2008 17:45:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Apr 2008 17:45:04 -0400
Content-Disposition: inline
In-Reply-To: <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79141>

On Wed, Apr 09, 2008 at 02:04:33PM -0700, Junio C Hamano wrote:

> The introductory documents may need to be updated to teach explicit "git
> pull $repo $branch" form first, and if they are short documents, end in
> introductory phase and leave the remainder to "further reading", they
> should probably be fixed not talk about the shorthand form "git pull
> $nick" and "git pull" without parameters at all.  That may help fixing
> this mental-model breakdown.

For me personally, I think this bottom-up approach makes the most sense
to learning (this may look familiar from the commit message to a patch I
sent earlier):

  1. here is what "git pull $repo $branch" means
  2. here is a way to shorten it to "git pull $repo" (set up remote
     $repo)
  3. here is a way to shorten it to "git pull" (default to origin)

But I think there are people who will get to the list and say "why
didn't you just tell me 'git pull' in the first place?" That is, the
complaints we have seen in the past reveal _too many_ low level details
too quickly.

Maybe we have stepped too far towards "top down workflow
descriptions" and need to go back. I dunno.

Another way of thinking about it is that we need two sets of
documentation with the same information (heresy, I know!): one bottom-up
and one top-down. I think the manpages tend to be "bottom up"
references. Bruce's user manual is more "top down" describing workflows.
I wonder which one(s) Ingo read, and which helped the most.

-Peff
