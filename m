From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-curl: don't pass back fake refs
Date: Mon, 19 Dec 2011 16:12:03 -0500
Message-ID: <20111219211203.GA18396@sigill.intra.peff.net>
References: <20111217104539.GA23844@sigill.intra.peff.net>
 <20111219171055.GA21227@sigill.intra.peff.net>
 <7vty4wmkdt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 22:12:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RckVI-0000tX-KG
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 22:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244Ab1LSVMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 16:12:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45989
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab1LSVMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 16:12:06 -0500
Received: (qmail 2527 invoked by uid 107); 19 Dec 2011 21:18:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Dec 2011 16:18:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2011 16:12:03 -0500
Content-Disposition: inline
In-Reply-To: <7vty4wmkdt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187473>

On Mon, Dec 19, 2011 at 11:28:14AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Perhaps we should squash in the test below, which demonstrates the
> > breakage. I also wonder if this is maint-worthy.
> 
> Thanks for a thorough analysis. I agree that this should go to maint even
> more so, as it fixes a case to push to a non-empty repository.

Do you want to squash in those tests, or should I re-send with a commit
message more fully explaining the situation?

-Peff
