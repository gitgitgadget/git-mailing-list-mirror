From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diffcore-pickaxe: unify setup and teardown code
 between log -S/-G
Date: Fri, 5 Apr 2013 01:45:24 -0400
Message-ID: <20130405054524.GB12705@sigill.intra.peff.net>
References: <7v1uapfuyp.fsf@alter.siamese.dyndns.org>
 <1365137126-21659-1-git-send-email-gitster@pobox.com>
 <1365137126-21659-3-git-send-email-gitster@pobox.com>
 <20130405052810.GA29815@sigill.intra.peff.net>
 <7vk3ohedn1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 07:46:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNzTM-0006Ai-Jq
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 07:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab3DEFpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 01:45:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56848 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab3DEFpb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 01:45:31 -0400
Received: (qmail 11160 invoked by uid 107); 5 Apr 2013 05:47:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 01:47:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 01:45:24 -0400
Content-Disposition: inline
In-Reply-To: <7vk3ohedn1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220148>

On Thu, Apr 04, 2013 at 10:43:14PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I notice that you are stuck factoring out not just the setup, but also
> > the cleanup, and I wondered if things could be made even simpler by just
> > encapsulating the checking logic in a callback; then the setup and
> > cleanup flow more naturally, as they are in a single function wrapper.
> >
> > Like this, which ends up saving 20 lines rather than adding 7:
> 
> Oh, this is one of those many times I am reminded why I love having
> you in the reviewer/contributor pool ;-)

I didn't actually test that patch beyond compilation (but it's
_obviously_ correct, right?), and I'm about to go to bed. Do you want to
take care of adapting your commit message to it?

-Peff
