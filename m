From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Pass amend to pre-commit hook
Date: Mon, 14 Sep 2015 10:47:28 -0400
Message-ID: <20150914144727.GA25003@sigill.intra.peff.net>
References: <55F6BA1C.7080507@teamwpc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Alan Clucas <alan.clucas@teamwpc.co.uk>
X-From: git-owner@vger.kernel.org Mon Sep 14 16:47:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbV2e-0004D3-2Y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 16:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbbINOrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 10:47:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:58724 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753996AbbINOrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 10:47:31 -0400
Received: (qmail 23654 invoked by uid 102); 14 Sep 2015 14:47:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Sep 2015 09:47:30 -0500
Received: (qmail 28671 invoked by uid 107); 14 Sep 2015 14:47:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Sep 2015 10:47:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2015 10:47:28 -0400
Content-Disposition: inline
In-Reply-To: <55F6BA1C.7080507@teamwpc.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277830>

On Mon, Sep 14, 2015 at 01:14:20PM +0100, Alan Clucas wrote:

> Pass a single parameter 'amend' to the pre-commit hook when performing a
> commit amend.

I think this is a sensible thing to want, and it has come up a few
times. I'm not sure why the last round didn't get merged, though. Looks
like it just slipped through the cracks.

Here are the relevant threads:

  http://thread.gmane.org/gmane.comp.version-control.git/260122

  http://thread.gmane.org/gmane.comp.version-control.git/260245

Looks like there was some question of what to pass in the normal,
non-amend case. I've added interested parties from the original thread
to the cc here.

-Peff
