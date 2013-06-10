From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] templates: Fix ASCII art in pre-rebase hook
Date: Mon, 10 Jun 2013 17:29:32 -0400
Message-ID: <20130610212932.GF13333@sigill.intra.peff.net>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
 <1370889365-6239-6-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:29:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9em-0004qB-Up
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968Ab3FJV3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:29:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:48379 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530Ab3FJV3g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:29:36 -0400
Received: (qmail 1178 invoked by uid 102); 10 Jun 2013 21:30:27 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 16:30:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 17:29:32 -0400
Content-Disposition: inline
In-Reply-To: <1370889365-6239-6-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227385>

On Mon, Jun 10, 2013 at 08:36:04PM +0200, Richard Hartmann wrote:

> The example assumes 8-char wide tabs and breaks for people with
> 4-char wide tabs.

If you end up re-rolling, it might be worth saying "Let's just convert
all of the tabs to spaces" in the commit message. I was curious what
your solution was (all spaces, or consistent start-tab indentation
followed by spaces), and it was somewhat hard to see in the patch since
the changes were pure whitespace. :)

-Peff
