From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "http: don't always prompt for password"
Date: Tue, 13 Dec 2011 18:18:00 -0500
Message-ID: <20111213231800.GC12432@sigill.intra.peff.net>
References: <20111213201704.GA12072@sigill.intra.peff.net>
 <20111213202508.GA12187@sigill.intra.peff.net>
 <7vaa6wuqjt.fsf@alter.siamese.dyndns.org>
 <CA+e6NDTQNEJB6Y17ow+yuLp2Bc799wsyQdnS8immMDYdCEyCGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Eric Advincula <eric.advincula@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 00:18:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rabbt-0008R1-4C
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 00:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756054Ab1LMXSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 18:18:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49829
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639Ab1LMXSD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 18:18:03 -0500
Received: (qmail 25176 invoked by uid 107); 13 Dec 2011 23:24:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 18:24:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 18:18:00 -0500
Content-Disposition: inline
In-Reply-To: <CA+e6NDTQNEJB6Y17ow+yuLp2Bc799wsyQdnS8immMDYdCEyCGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187074>

On Tue, Dec 13, 2011 at 02:22:12PM -0700, Eric Advincula wrote:

> Is there an alternative to using git on windows?  I used windows, apache,
> dav for git.
> If there is a better solution please let me know.

I don't know the status of running the smart-http backend on Windows,
but that would be a preferable solution. It's way more efficient, and
the client half of the code is better maintained.

See "git help http-backend" for documentation.

-Peff
