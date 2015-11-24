From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 2/2] Add Travis CI support
Date: Tue, 24 Nov 2015 15:40:05 -0500
Message-ID: <20151124204004.GC7174@sigill.intra.peff.net>
References: <1448267108-55652-1-git-send-email-larsxschneider@gmail.com>
 <1448267108-55652-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 24 21:40:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1KNn-00078C-03
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 21:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbbKXUkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 15:40:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:33393 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754302AbbKXUkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 15:40:07 -0500
Received: (qmail 21359 invoked by uid 102); 24 Nov 2015 20:40:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 14:40:07 -0600
Received: (qmail 18029 invoked by uid 107); 24 Nov 2015 20:40:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 15:40:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 15:40:05 -0500
Content-Disposition: inline
In-Reply-To: <1448267108-55652-3-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281626>

On Mon, Nov 23, 2015 at 09:25:08AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
> 64 bit" and on "OS X Mavericks" using gcc and clang.
> 
> Perforce and Git-LFS are installed and therefore available for the
> respective tests.

Thanks, I find this one a little easier to digest.

I'm iffy on the NO_GETTEXT change from patch 1. I had hoped we could
just build out of the box everywhere, but I think the "do we have
libintl" decision is a hard one. Most people _do_ have it and want it,
but it sounds like the Travis environment does not. So maybe it is a
place where it is worth doing the tweak inside travis.yml and leaving
the stock build alone.

-Peff
