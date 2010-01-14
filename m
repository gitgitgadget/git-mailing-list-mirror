From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] strbuf_expand: convert "%%" to "%"
Date: Thu, 14 Jan 2010 09:32:55 -0500
Message-ID: <20100114143255.GA15792@sigill.intra.peff.net>
References: <20100113173408.GA16652@coredump.intra.peff.net>
 <20100113173531.GA16786@coredump.intra.peff.net>
 <CABC23EF-410F-461C-936F-7BE72E9822BC@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Adam Megacz <adam@megacz.com>,
	git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 15:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVQkz-0002B6-EC
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 15:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab0ANOdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 09:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990Ab0ANOdA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 09:33:00 -0500
Received: from peff.net ([208.65.91.99]:54005 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621Ab0ANOdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 09:33:00 -0500
Received: (qmail 10456 invoked by uid 107); 14 Jan 2010 14:37:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 14 Jan 2010 09:37:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2010 09:32:56 -0500
Content-Disposition: inline
In-Reply-To: <CABC23EF-410F-461C-936F-7BE72E9822BC@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136995>

On Thu, Jan 14, 2010 at 05:47:09AM -0600, Chris Johnsen wrote:

> On 2010 Jan 13, at 11:35, Jeff King wrote:
> >Signed-off-by: Jeff King <peff@coredump.intra.peff.net>
> 
> The patches of the v2 of this series (well, except "4/3") all use
> this surprising, "extended" hostname in their Signed-off-by lines. I
> suppose you unset user.email while testing the series and sent these
> out before restoring your normal configuration.

Heh. Yes, thank you for noticing. That is exactly what happened. Perhaps
the next series should be a huge nag about implicit ident for S-o-b
lines. ;)

Junio, can you please fix up s/coredump.intra.// in your copies before
pushing out?

-Peff
