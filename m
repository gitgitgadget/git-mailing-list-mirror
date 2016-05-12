From: Jeff King <peff@peff.net>
Subject: Re: t5551 hangs ?
Date: Thu, 12 May 2016 03:29:39 -0400
Message-ID: <20160512072939.GA10922@sigill.intra.peff.net>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
 <cover.1462863934.git.johannes.schindelin@gmx.de>
 <ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
 <db56fae5-799a-29af-3a0f-a7b5c671063a@web.de>
 <20160511173130.GA29731@sigill.intra.peff.net>
 <5f285a5f-f66a-ed35-ecf9-0fece19ee5ca@web.de>
 <20160512031628.GA2741@sigill.intra.peff.net>
 <c0f2ae7b-0a67-af75-86ca-258a58b053bd@web.de>
 <20160512064038.GA32271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 12 09:29:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0l47-0004ml-2u
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 09:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbcELH3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 03:29:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:38412 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751975AbcELH3m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 03:29:42 -0400
Received: (qmail 2471 invoked by uid 102); 12 May 2016 07:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 03:29:42 -0400
Received: (qmail 7427 invoked by uid 107); 12 May 2016 07:29:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 03:29:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2016 03:29:39 -0400
Content-Disposition: inline
In-Reply-To: <20160512064038.GA32271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294396>

On Thu, May 12, 2016 at 02:40:39AM -0400, Jeff King wrote:

> Hmm. Switching to "pu" seems to make things slow on my machine, too, and
> the time all goes to fetch. So perhaps there is some recent regression
> there. It should be bisectable.

It's 66d33af21bd1e398973414435af43d06f2e2099c. I don't think it's
hanging, but it is _really_ slow. I'll reply to that patch separately
with a report.

-Peff
