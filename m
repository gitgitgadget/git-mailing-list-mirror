From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-filter-branch.sh: clarify an error message
Date: Sun, 5 Jul 2015 09:07:07 -0400
Message-ID: <20150705130706.GA5435@peff.net>
References: <1436053144.3463091.315316457.1BAF8BA7@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
To: Chris Jones <chris@christopherjones.us>
X-From: git-owner@vger.kernel.org Sun Jul 05 15:07:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBjdn-0004WA-1L
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 15:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbbGENHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 09:07:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:55873 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751124AbbGENHK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 09:07:10 -0400
Received: (qmail 30263 invoked by uid 102); 5 Jul 2015 13:07:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Jul 2015 08:07:09 -0500
Received: (qmail 25751 invoked by uid 107); 5 Jul 2015 13:07:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Jul 2015 09:07:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Jul 2015 09:07:07 -0400
Content-Disposition: inline
In-Reply-To: <1436053144.3463091.315316457.1BAF8BA7@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273363>

On Sat, Jul 04, 2015 at 07:39:04PM -0400, Chris Jones wrote:

> Make git filter-branch output a useful error message when a single
> commit is given instead of a range.  Currently, when given a command
> like git filter-branch --msg-filter 'echo "TEST"' -- abc123, it will
> give the message "Which ref do you want to rewrite?".  Instead, what
> is needed is a range of commits to rewrite.  This makes it give an
> error message that says "You didn't provide a valid range of
> commits".

Yeah, I agree the current message is a little confusing, and I think
your message is an improvement. I wonder if we can even go a step
further, like mentioning that at least one of the positive tips in your
range must be a ref.

-Peff
