From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-curl: don't pass back fake refs
Date: Mon, 19 Dec 2011 16:29:32 -0500
Message-ID: <20111219212932.GA18743@sigill.intra.peff.net>
References: <20111217104539.GA23844@sigill.intra.peff.net>
 <20111219171055.GA21227@sigill.intra.peff.net>
 <7vty4wmkdt.fsf@alter.siamese.dyndns.org>
 <20111219211203.GA18396@sigill.intra.peff.net>
 <7v39cgmety.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 22:30:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rckmc-0000Bh-R8
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 22:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab1LSV3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 16:29:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45998
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592Ab1LSV3e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 16:29:34 -0500
Received: (qmail 2725 invoked by uid 107); 19 Dec 2011 21:36:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Dec 2011 16:36:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2011 16:29:32 -0500
Content-Disposition: inline
In-Reply-To: <7v39cgmety.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187475>

On Mon, Dec 19, 2011 at 01:28:09PM -0800, Junio C Hamano wrote:

> > Do you want to squash in those tests, or should I re-send with a commit
> > message more fully explaining the situation?
> 
> I was lazy and added these three lines at the end:
> 
>     This also fixes pushing with --mirror to a smart-http remote that uses
>     alternates. The fake ".have" refs the server gives to avoid unnecessary
>     network transfer has a similar bad interactions with the machinery.
> 
> but it may warrant a more thorough write-up there.

I think that's probably enough. I could restructure the whole text to
talk less about capabilities^{} and more about generically preventing
fake refs, but I really don't think there's much point.

-Peff
