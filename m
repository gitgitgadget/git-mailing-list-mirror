From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] create_symref: use existing ref-lock code
Date: Tue, 29 Dec 2015 00:41:16 -0500
Message-ID: <20151229054116.GA14551@sigill.intra.peff.net>
References: <20151220072637.GA22102@sigill.intra.peff.net>
 <20151220073414.GD30662@sigill.intra.peff.net>
 <568104AF.102@alum.mit.edu>
 <20151229050230.GA13253@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 29 06:41:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDn2D-0008Ma-Ac
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 06:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbbL2FlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 00:41:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:46487 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750977AbbL2FlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 00:41:19 -0500
Received: (qmail 13292 invoked by uid 102); 29 Dec 2015 05:41:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Dec 2015 23:41:19 -0600
Received: (qmail 18276 invoked by uid 107); 29 Dec 2015 05:41:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:41:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 00:41:16 -0500
Content-Disposition: inline
In-Reply-To: <20151229050230.GA13253@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283066>

On Tue, Dec 29, 2015 at 12:02:30AM -0500, Jeff King wrote:

> Given that using symlinks is only
> triggered by an undocumented (!) option that presumably very few people
> use, I'm inclined to leave it as-is.

Sorry, I am wrong here. We do document core.preferSymlinkRefs. I missed
it because my grep was case-sensitive. :-/

-Peff
