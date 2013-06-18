From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] --valgrind improvements
Date: Tue, 18 Jun 2013 01:46:07 -0400
Message-ID: <20130618054607.GC5916@sigill.intra.peff.net>
References: <cover.1368736093.git.trast@inf.ethz.ch>
 <cover.1371460265.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 18 07:46:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UookB-0003Xk-Vw
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 07:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595Ab3FRFqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 01:46:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:34328 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab3FRFqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 01:46:11 -0400
Received: (qmail 21975 invoked by uid 102); 18 Jun 2013 05:47:08 -0000
Received: from mobile-032-141-227-127.mycingular.net (HELO sigill.intra.peff.net) (32.141.227.127)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Jun 2013 00:47:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2013 01:46:07 -0400
Content-Disposition: inline
In-Reply-To: <cover.1371460265.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228155>

On Mon, Jun 17, 2013 at 11:18:45AM +0200, Thomas Rast wrote:

> Here's the promised reroll.  It integrates everyone's suggestions (I
> hope I didn't miss any), most notably the two by Peff:

Thanks. With the exception of a few comments on patch 3, this looks good
to me.

I agree with your "gross hack" assessment of patch 6/6 (besides the
general implementation, it would fail pretty badly for any test script
which had global state outside of the filesystem, like the lib-httpd
tests). But I also think it cannot not cause too much damage, being both
confined to the test scripts and only having an effect if the option is
enabled. So I'd be fine with it going in just to see if people end up
finding it useful.

-Peff
