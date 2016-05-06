From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] utf8: fix duplicate words of "the"
Date: Fri, 6 May 2016 09:09:22 -0400
Message-ID: <20160506130922.GA5051@sigill.intra.peff.net>
References: <1462537893-18493-1-git-send-email-lip@dtdream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Li Peng <lip@dtdream.com>
X-From: git-owner@vger.kernel.org Fri May 06 15:09:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayfVd-0004Vc-QK
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 15:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758731AbcEFNJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 09:09:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:35121 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758274AbcEFNJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 09:09:26 -0400
Received: (qmail 3360 invoked by uid 102); 6 May 2016 13:09:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 May 2016 09:09:25 -0400
Received: (qmail 28624 invoked by uid 107); 6 May 2016 13:09:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 May 2016 09:09:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2016 09:09:22 -0400
Content-Disposition: inline
In-Reply-To: <1462537893-18493-1-git-send-email-lip@dtdream.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293775>

On Fri, May 06, 2016 at 08:31:33PM +0800, Li Peng wrote:

> Fix duplicate words of "the" in comment.

Obviously a good change, along with the other one of mine you found.

> ---
>  transport-helper.c | 2 +-
>  utf8.h             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

You seem to be breaking these up by file; was the change in
transport-helper supposed to be in a different patch?

IMHO it would be fine to just do all of these in a single patch. They're
different files, yes, but it's all conceptually the same change.

-Peff
