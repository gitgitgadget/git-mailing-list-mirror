From: Jeff King <peff@peff.net>
Subject: Re: Bug: pull --rebase with =?utf-8?B?w6kg?= =?utf-8?Q?in?= name
Date: Tue, 6 Mar 2012 04:02:18 -0500
Message-ID: <20120306090218.GG21199@sigill.intra.peff.net>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
 <20120305102657.GB29061@sigill.intra.peff.net>
 <87399nqqog.fsf@thomas.inf.ethz.ch>
 <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
 <20120305115815.GA4550@sigill.intra.peff.net>
 <0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de>
 <87ipijkxlm.fsf@thomas.inf.ethz.ch>
 <20120305132913.GA15004@sigill.intra.peff.net>
 <7v8vjf2c8o.fsf@alter.siamese.dyndns.org>
 <87399mazxs.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Haber <rene@habr.de>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 10:02:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qHs-0006tG-7r
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 10:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122Ab2CFJCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 04:02:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38293
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964952Ab2CFJCU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 04:02:20 -0500
Received: (qmail 5874 invoked by uid 107); 6 Mar 2012 09:02:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 04:02:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 04:02:18 -0500
Content-Disposition: inline
In-Reply-To: <87399mazxs.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192321>

On Tue, Mar 06, 2012 at 09:36:31AM +0100, Thomas Rast wrote:

> > You guys seem to have been having a lot of fun overnight. Perhaps I
> > should live on European time?
>=20
> IIUC Peff just got up at an unreasonably early time to have fun with =
us
> Europeans?

Er...got up? Yeeeeeah, that's what happened. I would never stay up unti=
l
6am local time hacking on git. ;)

> This is the second "victim" of this broken install of sed, however.  =
I
> wonder where Ren=C3=A9 and Will got it from?  Perhaps this is "the" c=
ommon
> way of getting GNU sed on OS X, and thus more widespread than we migh=
t
> think.

That's worth looking into, but the answer may still be "this common sed
is broken, and we should tell the people who are packaging it to unbrea=
k
it". I'm worried that there really isn't a workaround (we are already
trying LC_ALL and LANG; is there something else we can do short of not
using sed at all?).

-Peff
