From: Jeff King <peff@peff.net>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2
Date: Wed, 14 May 2014 06:14:40 -0400
Message-ID: <20140514101440.GA10173@sigill.intra.peff.net>
References: <536A8FF8.7080909@fabiodalfonso.com>
 <xmqqeh056z6q.fsf@gitster.dls.corp.google.com>
 <20140508041423.GC26630@sigill.intra.peff.net>
 <536B1DF4.5080109@fabiodalfonso.com>
 <20140509155945.GG18197@sigill.intra.peff.net>
 <xmqqy4yavewk.fsf@gitster.dls.corp.google.com>
 <20140510140259.GA6836@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 12:14:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkWD6-0008Oc-M3
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 12:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbaENKOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 06:14:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:51308 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753808AbaENKOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 06:14:45 -0400
Received: (qmail 13234 invoked by uid 102); 14 May 2014 10:14:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 May 2014 05:14:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 May 2014 06:14:40 -0400
Content-Disposition: inline
In-Reply-To: <20140510140259.GA6836@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248907>

On Sat, May 10, 2014 at 10:02:59AM -0400, Jeff King wrote:

> On Fri, May 09, 2014 at 02:08:27PM -0700, Junio C Hamano wrote:
> 
> > >   3. Just disable the http tests when run as root.
> > >
> > > I think I'd favor 3. But I'd like to be sure that being root is the
> > > problem.
> > 
> > I agree with both the conclusion and the precondition.
> 
> Here's the patch.
> 
> The problem starts in v1.9.2, not in v2.0.0, so it's not technically a
> regression in this cycle. And we are awfully late in the -rc period. But
> it is just a change in the test script, and one that seems rather
> unlikely to produce unexpected side effects. I'll leave it you whether
> you want to queue it for v2.0.0, or for the next maint release.

Hrm, sorry, I was wrong about this. I had thought the
auto-network-testing had gone into v1.9.2, but it didn't. So this _is_ a
potential regression in v2.0.0. It's still relatively minor, affecting
only the test suite, so it can probably wait for post-v2.0.0 if you
don't want to do another -rc.

-Peff
