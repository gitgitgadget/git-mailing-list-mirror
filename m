From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Mon, 9 May 2016 12:51:39 -0400
Message-ID: <20160509165139.GA10048@sigill.intra.peff.net>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
 <cover.1462774709.git.johannes.schindelin@gmx.de>
 <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
 <20160509080315.GA14383@sigill.intra.peff.net>
 <alpine.DEB.2.20.1605091557050.4092@virtualbox>
 <20160509142711.GA9552@sigill.intra.peff.net>
 <alpine.DEB.2.20.1605091710310.4092@virtualbox>
 <xmqqwpn3w5c7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 18:52:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azoPL-0002HA-BW
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbcEIQvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:51:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:36409 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752789AbcEIQvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:51:42 -0400
Received: (qmail 21136 invoked by uid 102); 9 May 2016 16:51:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 12:51:41 -0400
Received: (qmail 21105 invoked by uid 107); 9 May 2016 16:51:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 12:51:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 12:51:39 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpn3w5c7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294016>

On Mon, May 09, 2016 at 09:42:32AM -0700, Junio C Hamano wrote:

> > Hopefully your patch to remove the -c ... sanitizing makes it to `master`
> > soon, then I can submit my next iteration.
> 
> Or we can just merge that "do not sanitize" branch in, and then
> queue the "next iteration" which I'd assume would only be the test
> addition?

I think we'd also want the change to the test script to make sure that
it fails with only a single header (Dscho's patch 2).

-Peff
