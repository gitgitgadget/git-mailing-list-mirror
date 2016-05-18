From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] minor cat-file optimizations
Date: Wed, 18 May 2016 12:54:11 -0400
Message-ID: <20160518165411.GA5563@sigill.intra.peff.net>
References: <20160518165253.GA5379@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 18:54:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34jj-0004wj-90
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbcERQyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:54:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:41320 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751967AbcERQyP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 12:54:15 -0400
Received: (qmail 12007 invoked by uid 102); 18 May 2016 16:54:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 12:54:14 -0400
Received: (qmail 24280 invoked by uid 107); 18 May 2016 16:54:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 12:54:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 12:54:11 -0400
Content-Disposition: inline
In-Reply-To: <20160518165253.GA5379@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294976>

On Wed, May 18, 2016 at 12:52:53PM -0400, Jeff King wrote:

> At Git Merge, Charles suggested that "--buffer" should be the default
> for "--batch-all-objects". This bit me again yesterday, so I thought I'd
> actually implement it. :)
> 
> That's in the second patch. The first one is another micro-optimization
> that happens to help the use case I was working on (the speedup there is
> "only" 40%, but the case I was looking at had a pathological number of
> packs, and so was even slower).
> 
>   [1/2]: cat-file: avoid noop calls to sha1_object_info_extended
>   [2/2]: cat-file: default to --buffer when --batch-all-objects is used

Whoops, meant to actually cc Charles.

-Peff
