From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] remote: support --all for the prune-subcommand
Date: Tue, 4 Oct 2011 03:13:32 -0400
Message-ID: <20111004071332.GA7308@sigill.intra.peff.net>
References: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
 <20111004070006.GA6824@sigill.intra.peff.net>
 <CABPQNSZrfxhyA3em8TN2=d7pAHopZMgRg47baKnDT9h14=rxkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:13:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAzC7-0004Li-Cy
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 09:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab1JDHNf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 03:13:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51991
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027Ab1JDHNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 03:13:34 -0400
Received: (qmail 4124 invoked by uid 107); 4 Oct 2011 07:18:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 03:18:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 03:13:32 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSZrfxhyA3em8TN2=d7pAHopZMgRg47baKnDT9h14=rxkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182732>

On Tue, Oct 04, 2011 at 09:10:40AM +0200, Erik Faye-Lund wrote:

> > =C2=A0git fetch --all --prune
> >
> I wasn't aware that fetch could prune, but yeah, that seems much
> better to me. Perhaps a mention of this in the "git remote prune"
> documentation could steer other users in the right direction?

Yeah, that makes sense.

There is one slight difference: I think "git remote prune" will _just_
prune, and not fetch into existing refs at all. I'm not sure exactly
why you would want that, though. Presumably you run "prune" after you
just fetched, anyway. Combining the two steps saves an extra network
connection.

-Peff
