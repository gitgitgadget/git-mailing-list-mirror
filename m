From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow hooks to ignore their standard input stream
Date: Fri, 13 Nov 2015 01:18:48 -0500
Message-ID: <20151113061847.GD32157@sigill.intra.peff.net>
References: <20151111143920.GA30409@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, junio@pobox.com
To: Clemens Buchacher <clemens.buchacher@intel.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 07:18:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx7hH-0007dC-7x
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 07:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbbKMGSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 01:18:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:56975 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751547AbbKMGSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 01:18:50 -0500
Received: (qmail 17263 invoked by uid 102); 13 Nov 2015 06:18:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 00:18:50 -0600
Received: (qmail 21985 invoked by uid 107); 13 Nov 2015 06:19:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 01:19:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 01:18:48 -0500
Content-Disposition: inline
In-Reply-To: <20151111143920.GA30409@musxeris015.imu.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281242>

On Wed, Nov 11, 2015 at 03:39:20PM +0100, Clemens Buchacher wrote:

> Since ec7dbd145 (receive-pack: allow hooks to ignore its standard input
> stream) the pre-receive and post-receive hooks ignore SIGPIPE. Do the
> same for the remaining hooks pre-push and post-rewrite, which read from
> standard input. The same arguments for ignoring SIGPIPE apply.

The reasoning and the patch itself look good to me. I posted some
thoughts on tests in response to your other message.

-Peff
