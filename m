From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: Fix inconsistent quotes
Date: Wed, 29 Apr 2015 14:51:41 -0400
Message-ID: <20150429185141.GA32207@peff.net>
References: <1430330932-10578-1-git-send-email-stefan@sevenbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stefan Tatschner <stefan@sevenbyte.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:51:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnX5J-00077M-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 20:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbbD2Svp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 14:51:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:51750 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751100AbbD2Svo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 14:51:44 -0400
Received: (qmail 15703 invoked by uid 102); 29 Apr 2015 18:51:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 13:51:44 -0500
Received: (qmail 29543 invoked by uid 107); 29 Apr 2015 18:52:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 14:52:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 14:51:41 -0400
Content-Disposition: inline
In-Reply-To: <1430330932-10578-1-git-send-email-stefan@sevenbyte.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267991>

On Wed, Apr 29, 2015 at 08:08:52PM +0200, Stefan Tatschner wrote:

> While reading 'man git' I realized that the highlighting of the
> environment variables is not consistent. This patch adds missing single
> quotes and substitutes backticks with the proper quotes as well.

I think this is OK in that it makes things consistent, and chooses the
style that is already in the majority.

But IMHO, using backticks looks much better. In the roff-formatted
manpages single quotes underline, but backticks use bold. The former is
hard to read when the content has underscores. For the HTML, the single
quotes produce italics, versus a typewriter font for backticks. Which
is...OK, I guess, but I think I like the backtick behavior better.

I think we're wildly inconsistent about this throughout the
documentation, though.

-Peff
