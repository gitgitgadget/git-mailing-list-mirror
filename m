From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] bump rename limit defaults (again)
Date: Sun, 20 Feb 2011 05:12:47 -0500
Message-ID: <20110220101247.GD988@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
 <20110219102128.GB22508@sigill.intra.peff.net>
 <AANLkTi=aWC_sXK1VBspsiVAwhkC4pP8Z+uq7QceLMopS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 11:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr6He-0004fE-Pu
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 11:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab1BTKMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 05:12:50 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44527 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643Ab1BTKMt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 05:12:49 -0500
Received: (qmail 16679 invoked by uid 111); 20 Feb 2011 10:12:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 20 Feb 2011 10:12:49 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Feb 2011 05:12:47 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=aWC_sXK1VBspsiVAwhkC4pP8Z+uq7QceLMopS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167413>

On Sat, Feb 19, 2011 at 09:12:49PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Sat, Feb 19, 2011 at 11:21, Jeff King <peff@peff.net> wrote:
>=20
> > Let's bump the diff/merge default limits from 200/500 to
> > 400/1000. Those are 2 seconds and 10 seconds respectively on
> > my modern hardware.
>=20
> This is somewhat outside the scope of your patch, but rather than
> making these decisions for the user and compiling them into Git
> wouldn't it be better to expose it somehow?

What do you mean by expose it? We already have config options; this is
just for the defaults.

Or do you mean allowing setting merge.renamelimits to "30s" and cutting
off detection after 30 seconds? I think that would be a reasonable idea=
,
though part of me doesn't like non-deterministic answers based on how
loaded the system is.

> E.g. when you do a git-merge show a progress bar (similar to
> git-clone) showing that we're trying to do rename detection, show tha=
t
> we stopped, and when we fail point out that the user could run
> git-merge with some switch that would make Git try harder.

Er, isn't that exactly what patches 1/4 and 4/4 in my series do?

-Peff
