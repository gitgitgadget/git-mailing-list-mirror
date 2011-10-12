From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http_init: accept separate URL parameter
Date: Wed, 12 Oct 2011 18:46:25 -0400
Message-ID: <20111012224625.GA11408@sigill.intra.peff.net>
References: <4E95FDC8.5030009@drmicha.warpmail.net>
 <20111012214316.GA4393@sigill.intra.peff.net>
 <20111012214610.GA4578@sigill.intra.peff.net>
 <7vk4897s4c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 00:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE7ZI-0003ia-Nq
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 00:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab1JLWq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 18:46:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58984
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510Ab1JLWq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 18:46:27 -0400
Received: (qmail 20142 invoked by uid 107); 12 Oct 2011 22:46:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 18:46:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 18:46:25 -0400
Content-Disposition: inline
In-Reply-To: <7vk4897s4c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183428>

On Wed, Oct 12, 2011 at 03:38:27PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Oct 12, 2011 at 05:43:16PM -0400, Jeff King wrote:
> > ...
> >> Instead, let's just add a separate URL parameter to
> >> http_init, and all three callsites can pass in the
> >> appropriate information.
> >> 
> >> Signed-off-by: Jeff King <peff@peff.net>
> >
> > Sorry, I forgot to mention: this is meant to go on top of the
> > http-auth-keyring topic.
> 
> Hmm, of course the patch was written to help http-auth-keyring topic, but
> wouldn't this be an improvement that is general enough?  I.e. it could
> even go to the bottom of the topic, no?

Yes, it could, and probably should. I suspect it might need some
rebasing to do that.

I'm going to float some other possible designs for the topic as soon as
I put enough polish on them. So I'll try to move this down when I
re-roll.  In the meantime, if you want to throw it on top, great. If you
want to ignore it until then, no problem. :)

-Peff
