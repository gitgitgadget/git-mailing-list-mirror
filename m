From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 2/3] t5551: make the test for extra HTTP headers more
 robust
Date: Mon, 9 May 2016 04:20:24 -0400
Message-ID: <20160509082024.GA14299@sigill.intra.peff.net>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
 <cover.1462774709.git.johannes.schindelin@gmx.de>
 <f29dac327aeac23677aec955f5b46a7a4702abfe.1462774709.git.johannes.schindelin@gmx.de>
 <20160509080544.GB14383@sigill.intra.peff.net>
 <alpine.DEB.2.20.1605091011420.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 10:20:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azgQZ-00081W-Tv
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 10:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbcEIIU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 04:20:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:36162 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750864AbcEIIU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 04:20:27 -0400
Received: (qmail 23495 invoked by uid 102); 9 May 2016 08:20:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 04:20:27 -0400
Received: (qmail 17126 invoked by uid 107); 9 May 2016 08:20:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 04:20:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 04:20:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1605091011420.4092@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293993>

On Mon, May 09, 2016 at 10:13:51AM +0200, Johannes Schindelin wrote:

> do you sleep at all?

Actually, I just woke up. Nothing like some Git ML to get the blood
pumping in the morning.

> Yeah, a faulty Apache config will unfortunately *skip* the entire test, as
> httpd refuses to start.

If you care about this, you can set GIT_TEST_HTTPD=true. The default is
"auto", which will skip whenever apache setup fails. But with "true", it
will show a hard error (so at least your "make test" will report the
failure).

-Peff
