From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Ensure SHELL_PATH is the hash bang for test suite
 askpass helper script.
Date: Mon, 29 Sep 2014 13:30:34 -0400
Message-ID: <20140929173034.GA3845@peff.net>
References: <20140928231428.GA9061@peff.net>
 <1411974127-5258-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 19:31:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYemp-0008Ga-Ts
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 19:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbaI2Rak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 13:30:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:52789 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754646AbaI2Rah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 13:30:37 -0400
Received: (qmail 7649 invoked by uid 102); 29 Sep 2014 17:30:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Sep 2014 12:30:36 -0500
Received: (qmail 10690 invoked by uid 107); 29 Sep 2014 17:30:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Sep 2014 13:30:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Sep 2014 13:30:34 -0400
Content-Disposition: inline
In-Reply-To: <1411974127-5258-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257631>

On Mon, Sep 29, 2014 at 08:02:07AM +0100, Ben Walton wrote:

> The askpass script that is created for use by the test suite should
> use SHELL_PATH for its hash bang instead of /bin/sh. Commit 5a4352024
> introduced the use of idioms not supported in some legacy /bin/sh
> implementations.
> 
> Use write_script to ensure this happens automatically. This lets us
> remove the chmod step as well, since write_script handles that.
> 
> Signed-off-by: Ben Walton <bdwalton@gmail.com>

Thanks, this looks good to me.

-Peff
