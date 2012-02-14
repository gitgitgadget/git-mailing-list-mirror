From: Jeff King <peff@peff.net>
Subject: Re: Git documentation at kernel.org
Date: Tue, 14 Feb 2012 17:15:25 -0500
Message-ID: <20120214221525.GD24802@sigill.intra.peff.net>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki>
 <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
 <20120210200401.GB5504@sigill.intra.peff.net>
 <vpqehtz909k.fsf@bauges.imag.fr>
 <20120212222508.GA25619@sigill.intra.peff.net>
 <CAP2yMa+2E6101fe3Z2WTCfuGnq17WT7nDUQr7PVH6_YKRnNifw@mail.gmail.com>
 <20120213003024.GA25794@sigill.intra.peff.net>
 <7vmx8nju1k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:15:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQes-0002KI-GB
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761296Ab2BNWPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:15:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35975
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757338Ab2BNWP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:15:29 -0500
Received: (qmail 12782 invoked by uid 107); 14 Feb 2012 22:22:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 17:22:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 17:15:25 -0500
Content-Disposition: inline
In-Reply-To: <7vmx8nju1k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190776>

On Sun, Feb 12, 2012 at 07:23:19PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That sounds great to me. I'd like to be link-compatible with the old
> > kernel.org docs section (even if through redirects) so that old links
> > work (assuming kernel.org gives us a wholesale redirect).  Which means
> > importing all of the docs for released versions. I don't know if the old
> > kernel.org doc tree was saved anywhere, but if I understand correctly,
> > they are identical to what's in the "git-htmldocs" repository (which I
> > _thought_ Junio wasn't going to keep updating, but it seems pretty up to
> > date).
> [...]
> But the contents of htmldocs does _not_ match what used to be at k.org in
> that its git.html does not have links to documentation pages for older
> releases, iow, formatted without "stalenotes" defined.

Ah, that makes sense. We might have to just rebuild the old versions
with stalenotes, then (our doc toolchain is so finicky that I worry
about minor incompatibilities in building old versions with a newer
toolchain, but it is probably good enough).

-Peff
