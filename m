From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Mon, 6 Feb 2012 15:12:45 -0500
Message-ID: <20120206201245.GA30776@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <20120206081342.GB3966@sigill.intra.peff.net>
 <7vk4408ir6.fsf@alter.siamese.dyndns.org>
 <7vfweo8ikq.fsf@alter.siamese.dyndns.org>
 <20120206083832.GA9425@sigill.intra.peff.net>
 <7vty337rug.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 21:12:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuUvl-0006JE-E5
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 21:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab2BFUMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 15:12:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58921
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755454Ab2BFUMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 15:12:47 -0500
Received: (qmail 30607 invoked by uid 107); 6 Feb 2012 20:19:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 15:19:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 15:12:45 -0500
Content-Disposition: inline
In-Reply-To: <7vty337rug.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190094>

On Mon, Feb 06, 2012 at 10:13:27AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > OK, that's easy enough to do. Should we show lightweight tags to commits
> > for backwards compatibility (and just drop the parse_signature junk in
> > that case)? The showing of blobs or trees is the really bad thing, I
> > think.
> 
> For now, dropping 3/3 and queuing this instead...
> 
> ---
> Subject: tag: do not show non-tag contents with "-n"

Looks perfect. Thanks.

-Peff
