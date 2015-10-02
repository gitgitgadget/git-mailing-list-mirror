From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Fri, 2 Oct 2015 11:33:47 -0400
Message-ID: <20151002153346.GA31378@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210736.GL30946@sigill.intra.peff.net>
 <CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
 <20150930002347.GA23406@sigill.intra.peff.net>
 <xmqqh9mb7k3r.fsf@gitster.mtv.corp.google.com>
 <20151001025119.GA31565@sigill.intra.peff.net>
 <560E1D78.1040805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 02 17:34:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi2LY-0000cf-5e
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 17:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbbJBPdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Oct 2015 11:33:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:38836 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752116AbbJBPdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 11:33:49 -0400
Received: (qmail 6685 invoked by uid 102); 2 Oct 2015 15:33:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Oct 2015 10:33:49 -0500
Received: (qmail 25931 invoked by uid 107); 2 Oct 2015 15:34:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Oct 2015 11:34:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Oct 2015 11:33:47 -0400
Content-Disposition: inline
In-Reply-To: <560E1D78.1040805@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278923>

On Fri, Oct 02, 2015 at 08:00:24AM +0200, Torsten B=C3=B6gershausen wro=
te:

> Peff, are you planing a re-roll ?
> Or. Junio, do you plan to fix it ?
> Or should I send a patch on top of pu ?

I am on vacation, so I am hoping that somebody on OS X can confirm that
the patch that I sent earlier does indeed fix it, and that Junio
can squash it in.

Makefile hack similar to what you posted, but I cannot actually on Linu=
x
that the code does what it should).

> The compilation can be tested under Linux like this:

Yeah, I did something similar to see that it at least compiled, but I
don't have an easy way to actually run t3910.

-Peff
