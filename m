From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] post-strbuf_getline cleanups
Date: Sun, 31 Jan 2016 06:22:16 -0500
Message-ID: <20160131112215.GA4589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 12:23:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPq5n-0000Ys-36
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 12:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291AbcAaLWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 06:22:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:35040 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757273AbcAaLWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 06:22:19 -0500
Received: (qmail 7071 invoked by uid 102); 31 Jan 2016 11:22:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:22:19 -0500
Received: (qmail 15569 invoked by uid 107); 31 Jan 2016 11:22:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:22:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2016 06:22:16 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285134>

As promised, here are the "how about this on top" patches that came out
of the discussion for the "strbuf_getline" series in:

  http://thread.gmane.org/gmane.comp.version-control.msysgit/21773/focus=284001

As I looked further at some of the option-parsing cleanups, I realized
that some of them are more than cleanups; we're actually fixing bizarre
behavior and segfaults.

  [1/6]: give "nbuf" strbuf a more meaningful name
  [2/6]: checkout-index: simplify "-z" option parsing
  [3/6]: checkout-index: handle "--no-prefix" option
  [4/6]: checkout-index: handle "--no-index" option
  [5/6]: checkout-index: disallow "--no-stage" option
  [6/6]: apply, ls-files: simplify "-z" parsing

-Peff
