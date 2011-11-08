From: Jeff King <peff@peff.net>
Subject: Re: pretty placeholders for reflog entries
Date: Tue, 8 Nov 2011 00:47:45 -0500
Message-ID: <20111108054745.GD29643@sigill.intra.peff.net>
References: <CAMYxyaWPWVGUHz0qQOnARb9wexHCx73a04Bu_UhrJR=xrinX7g@mail.gmail.com>
 <20111107211325.GB7380@sigill.intra.peff.net>
 <CAMYxyaWJO7e8Lg__8N9BhL16mwfQtd-GBuLpBSCYmLMZ3gsMPA@mail.gmail.com>
 <20111107224556.GA28188@sigill.intra.peff.net>
 <7v8vnr1oww.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jack Nagel <jacknagel@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 06:47:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNeXI-0003EM-7K
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 06:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab1KHFrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 00:47:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36084
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab1KHFrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 00:47:47 -0500
Received: (qmail 1176 invoked by uid 107); 8 Nov 2011 05:47:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 00:47:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 00:47:45 -0500
Content-Disposition: inline
In-Reply-To: <7v8vnr1oww.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185074>

On Mon, Nov 07, 2011 at 03:41:19PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It would be a little nicer to provide explicit date placeholders, but we
> > can't quite make them match the author-date specifiers, because "gd" is
> > taken.  We could add %gt, %gr, etc. But in the long run, I'd like to
> > move to considering most of %ar, %at, etc to be historical, and have
> > something like "%ad(short)" be the official way of picking different
> > date formats[1]. And then the reflog placeholders could learn
> > "%gt(short)". So making more reflog placeholders right now just feels
> > like cluttering a namespace I'd like to get changed eventually.
> 
> I tend to agree with the direction.
> 
> As we are not adding anything new before the 1.7.8 final, I'd rather ask
> you to hold onto this and other changes in your footnote, instead of
> having me to carry them in 'pu', which is an integration branch even less
> official than it would otherwise be during the freeze period.

Sure. I'll re-send the patch once the release is out. That will also
give Jack and any other interested parties time to comment and test.

-Peff
