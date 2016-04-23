From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Fri, 22 Apr 2016 23:39:23 -0400
Message-ID: <20160423033922.GA15994@sigill.intra.peff.net>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 23 05:39:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atoPq-0005QD-8M
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 05:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbcDWDj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 23:39:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:54711 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751742AbcDWDj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 23:39:26 -0400
Received: (qmail 16469 invoked by uid 102); 23 Apr 2016 03:39:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 23:39:25 -0400
Received: (qmail 14453 invoked by uid 107); 23 Apr 2016 03:39:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 23:39:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Apr 2016 23:39:23 -0400
Content-Disposition: inline
In-Reply-To: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292297>

On Fri, Apr 22, 2016 at 10:34:02AM +0200, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Run "make doc" to check if all documentation can be build without errors.
> Since the documentation is the same on every platform/compiler, the check
> is only performed as part of the Linux/GCC build job to maintain a fast
> CI process.

This does slow down the normal test results for linux/gcc, though. I
don't know very much about Travis, but is it possible to break out the
documentation build into its own test, with a separate build status from
the other runs?

-Peff
