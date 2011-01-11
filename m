From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Tue, 11 Jan 2011 01:55:09 -0500
Message-ID: <20110111065509.GG10094@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 07:55:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcY8U-0006rR-Vt
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 07:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378Ab1AKGzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 01:55:16 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54877 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab1AKGzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 01:55:11 -0500
Received: (qmail 11911 invoked by uid 111); 11 Jan 2011 06:55:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 06:55:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 01:55:09 -0500
Content-Disposition: inline
In-Reply-To: <20110107195417.GC6175@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164915>

On Fri, Jan 07, 2011 at 02:54:17PM -0500, Jeff King wrote:

> +test_expect_success 'checkout reports switch to detached HEAD' '
> +	grep "Switched to branch" stderr &&
> +	! grep "^HEAD is now at" stderr

Junio, one minor fixup here. The test is correct, but the description
should read "checkout reports switch to branch", not "...detached HEAD".

I had originally written the test the other way and forgot to update the
description when I tweaked it. The error is in my ambiguity test, but
got cut-and-pasted to your vagueness test, too.

-Peff
