From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: improve the example of overriding LESS
 via core.pager
Date: Mon, 29 Oct 2012 02:26:57 -0400
Message-ID: <20121029062657.GB5102@sigill.intra.peff.net>
References: <1351455166-2579-1-git-send-email-patrick@parcs.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Patrick Palka <patrick@parcs.ath.cx>
X-From: git-owner@vger.kernel.org Mon Oct 29 07:27:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSioc-0004A3-Pw
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 07:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab2J2G1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 02:27:01 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41834 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab2J2G1A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 02:27:00 -0400
Received: (qmail 15826 invoked by uid 107); 29 Oct 2012 06:27:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 02:27:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 02:26:57 -0400
Content-Disposition: inline
In-Reply-To: <1351455166-2579-1-git-send-email-patrick@parcs.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208591>

On Sun, Oct 28, 2012 at 04:12:46PM -0400, Patrick Palka wrote:

> You can override an option set in the LESS variable by simply prefixing
> the command line option with `-+`. This is more robust than the previous
> example if the default LESS options are to ever change.

Yeah, the current description is quite tortured and complex. I wondered
if there might be some reason, but I think it is simply that fee7545 was
over-zealous in adopting the original text. Yours is much more sensible.

Thanks.

-Peff
