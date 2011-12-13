From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "http: don't always prompt for password"
Date: Tue, 13 Dec 2011 18:19:09 -0500
Message-ID: <20111213231909.GD12432@sigill.intra.peff.net>
References: <20111213201704.GA12072@sigill.intra.peff.net>
 <20111213202508.GA12187@sigill.intra.peff.net>
 <7vaa6wuqjt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 00:19:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rabcy-0000TN-De
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 00:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab1LMXTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 18:19:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49837
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471Ab1LMXTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 18:19:12 -0500
Received: (qmail 25211 invoked by uid 107); 13 Dec 2011 23:25:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 18:25:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 18:19:09 -0500
Content-Disposition: inline
In-Reply-To: <7vaa6wuqjt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187075>

On Tue, Dec 13, 2011 at 01:09:42PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Doing (3) is obviously the easiest thing. And given the complexity of
> > the other two solutions, I think it makes sense to revert 986bbc08
> > (i.e., apply this patch), ship a working v1.7.8.1, and then look at
> > doing one of the other two solutions for v1.7.9.
> 
> Or just let the "dumb HTTP" die.
> 
> I thought push over DAV has long been dead; is anybody using it for real?

For the record, I have no problem whatsoever with letting it die. I just
think we probably shouldn't do it accidentally during a release. ;)

-Peff
