From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] config includes 3: revenge of the killer includes
Date: Mon, 6 Feb 2012 04:53:06 -0500
Message-ID: <20120206095306.GA2404@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 10:53:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuLG9-0001zr-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 10:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab2BFJxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 04:53:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58728
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab2BFJxM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 04:53:12 -0500
Received: (qmail 26191 invoked by uid 107); 6 Feb 2012 10:00:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 05:00:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 04:53:06 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190056>

So here's a third version of the config include patches that I think are
sane. For those of you who missed episode 2, our heroes decided to drop
the include-from-ref bits from the series, but otherwise incorporated
all suggestions. There was a surprise cliffhanger ending in which it was
discovered that suppressing duplicate include files was actually the
villain!

This version keeps a simple depth counter to stop cycles from causing
infinite loops, but otherwise allows multiple inclusion of files.

And now, the exciting conclusion...

  [1/2]: docs: add a basic description of the config API
  [2/2]: config: add include directive

-Peff
