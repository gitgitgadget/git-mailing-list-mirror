From: Jeff King <peff@peff.net>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 8 Mar 2011 16:03:12 -0500
Message-ID: <20110308210312.GA4594@sigill.intra.peff.net>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com>
 <4D75ED72.8030203@drmicha.warpmail.net>
 <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
 <AANLkTikK8Uc8=wKROYWWxZ_6OtQtqBmFCZN760M1LO+c@mail.gmail.com>
 <4D75FB7B.70403@drmicha.warpmail.net>
 <AANLkTim_h6vbvnmy7oUNYmV82vCzLLfWKq=3_UY9kPYw@mail.gmail.com>
 <20110308171251.GA1823@sigill.intra.peff.net>
 <m2r5ahqvjs.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:03:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px43v-0006OO-LA
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607Ab1CHVDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 16:03:17 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52419
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756532Ab1CHVDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:03:14 -0500
Received: (qmail 4212 invoked by uid 107); 8 Mar 2011 21:03:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Mar 2011 16:03:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2011 16:03:12 -0500
Content-Disposition: inline
In-Reply-To: <m2r5ahqvjs.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168693>

On Tue, Mar 08, 2011 at 08:08:55PM +0100, Andreas Schwab wrote:

> > Isn't the merge the first commit in bar that is not in foo? IOW:
> >
> >   git rev-list foo..bar | tail -n 1
> 
> That would show the commit marked b1 above, wouldn't it?  ^foo cuts only
> x and its parents, but not the other parent of m.

Yes, just me being dumb. See the other subthread.

-Peff
