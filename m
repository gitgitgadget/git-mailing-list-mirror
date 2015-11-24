From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: treat config options sslCAPath and sslCAInfo as
 paths
Date: Tue, 24 Nov 2015 18:53:17 -0500
Message-ID: <20151124235316.GD13872@sigill.intra.peff.net>
References: <1448280160-113572-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Nov 25 00:53:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1NOm-0001gn-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 00:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbbKXXxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 18:53:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:33582 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932485AbbKXXxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 18:53:19 -0500
Received: (qmail 31454 invoked by uid 102); 24 Nov 2015 23:53:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:53:19 -0600
Received: (qmail 20202 invoked by uid 107); 24 Nov 2015 23:53:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 18:53:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 18:53:17 -0500
Content-Disposition: inline
In-Reply-To: <1448280160-113572-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281654>

On Mon, Nov 23, 2015 at 12:02:40PM +0000, charles@hashpling.org wrote:

> From: Charles Bailey <cbailey32@bloomberg.net>
> 
> This enables ~ and ~user expansion for these config options.

Thanks, this seems like the obviously correct thing to do.

> In the only place that we (optionally) test https specifically, we also
> turn off SSL verification so I couldn't see a sensible way to add an
> automated test.
> 
> The change is fairly simple and I've tested manually and the effects are
> as I expected - I can point to a certificate bundle or directory in my
> home directory using a ~/ prefix in my .gitconfig.

Yeah, I agree that testing such a trivial feature is not worth the
infrastructure it would require adding to the test suite.

-Peff
