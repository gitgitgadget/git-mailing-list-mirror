From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] diff-highlight: factor out prefix/suffix functions
Date: Tue, 3 Nov 2015 16:17:16 -0500
Message-ID: <20151103211716.GB22484@sigill.intra.peff.net>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
 <1446516334-27652-3-git-send-email-jonathan.lebon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Lebon <jonathan.lebon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:17:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtixY-0008BI-4y
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 22:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbbKCVRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 16:17:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:52300 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755968AbbKCVRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 16:17:19 -0500
Received: (qmail 728 invoked by uid 102); 3 Nov 2015 21:17:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 15:17:19 -0600
Received: (qmail 28829 invoked by uid 107); 3 Nov 2015 21:17:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 16:17:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Nov 2015 16:17:16 -0500
Content-Disposition: inline
In-Reply-To: <1446516334-27652-3-git-send-email-jonathan.lebon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280820>

On Mon, Nov 02, 2015 at 09:05:32PM -0500, Jonathan Lebon wrote:

> In preparation for the next patch, we factor out the functions for
> finding the common prefix and suffix between two lines.

Looks like a pretty straightforward movement. Your perl adjustments to
use array refs look good, and I think the multi-valued return is a good
interface.

-Peff
