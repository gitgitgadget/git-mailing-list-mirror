From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: Produce better output with --inline or
	--attach
Date: Wed, 30 Jul 2008 01:24:01 -0400
Message-ID: <20080730052401.GC4034@sigill.intra.peff.net>
References: <1217375356-80287-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 07:25:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO4BT-0001dn-2s
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 07:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbYG3FYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 01:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbYG3FYG
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 01:24:06 -0400
Received: from peff.net ([208.65.91.99]:3266 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbYG3FYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 01:24:04 -0400
Received: (qmail 5242 invoked by uid 111); 30 Jul 2008 05:24:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Jul 2008 01:24:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jul 2008 01:24:01 -0400
Content-Disposition: inline
In-Reply-To: <1217375356-80287-1-git-send-email-kevin@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90743>

On Tue, Jul 29, 2008 at 04:49:16PM -0700, Kevin Ballard wrote:

> The first is to write a newline preceding the boundary. This is needed
> because MIME defines the encapsulation boundary as including the
> preceding CRLF (or in this case, just LF), so we should be writing
> one. Without this, the last newline in the pre-diff content is
> consumed instead.

Hmm. I am surprised we haven't had more bug reports about this, but
perhaps these features aren't used too frequently. But I double checked
the MIME specs just to be sure, and you are definitely right.

> The second change is to always write the line termination character (default: newline)

Can you please wrap your commit messages at some more reasonable length?
This line is 86 characters long.

-Peff
