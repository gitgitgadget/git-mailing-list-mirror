From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all
 untracked files
Date: Wed, 22 Jun 2011 11:00:15 -0400
Message-ID: <20110622150015.GB9266@sigill.intra.peff.net>
References: <1308612986-26593-1-git-send-email-david@porkrind.org>
 <20110621003852.GB2050@sigill.intra.peff.net>
 <4DFFF5AA.4030401@porkrind.org>
 <4E002762.3050803@sohovfx.com>
 <4E003A0F.5080601@viscovery.net>
 <20110621141843.GA18700@sigill.intra.peff.net>
 <4E00C2BD.6000903@esperanto.de>
 <buotybi2tqg.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Ebermann <Paul.Ebermann@esperanto.de>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Andrew Wong <andrew.w@sohovfx.com>,
	David Caldwell <david@porkrind.org>,
	Junio C Hamano <gitster@pobox.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 22 17:00:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZOun-00026v-DZ
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 17:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180Ab1FVPAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 11:00:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44301
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755582Ab1FVPAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 11:00:17 -0400
Received: (qmail 13792 invoked by uid 107); 22 Jun 2011 15:00:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Jun 2011 11:00:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jun 2011 11:00:15 -0400
Content-Disposition: inline
In-Reply-To: <buotybi2tqg.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176239>

On Wed, Jun 22, 2011 at 04:47:03PM +0900, Miles Bader wrote:

> Paul Ebermann <Paul.Ebermann@esperanto.de> writes:
> >>   $ git stash --untracked-too --ignored-too
> >> 
> >> is fairly clear, but somehow strikes me as unnecessarily ugly and
> >> verbose.
> >
> > I think `--also-untracked` sounds better. It is even longer, though.
> 
> "--include-untracked" sounds a bit smoother to my ears.

Me too. It's long, but it fits with other git commands.

-Peff
