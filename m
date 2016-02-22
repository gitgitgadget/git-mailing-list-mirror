From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Correct conditions to free textconv result data
Date: Mon, 22 Feb 2016 13:12:24 -0500
Message-ID: <20160222181224.GA4917@sigill.intra.peff.net>
References: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
 <1456145545-5374-3-git-send-email-pclouds@gmail.com>
 <20160222180645.GB4587@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:12:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXuyF-00076J-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 19:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbcBVSM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 13:12:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:46869 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752134AbcBVSM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 13:12:27 -0500
Received: (qmail 9725 invoked by uid 102); 22 Feb 2016 18:12:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 13:12:26 -0500
Received: (qmail 20608 invoked by uid 107); 22 Feb 2016 18:12:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 13:12:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 13:12:24 -0500
Content-Disposition: inline
In-Reply-To: <20160222180645.GB4587@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286940>

On Mon, Feb 22, 2016 at 01:06:46PM -0500, Jeff King wrote:

> Is there a case I'm missing here where we actually leak memory or try to
> free non-allocated memory? I didn't see it.

By the way, I saw only patches 2/3 and 3/3 on the list. So maybe there
is something interesting going on in 1/3, or in a cover letter that
didn't make it. :)

-Peff
