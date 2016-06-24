Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481952018A
	for <e@80x24.org>; Fri, 24 Jun 2016 16:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbcFXQJr (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 12:09:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:59751 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751082AbcFXQJq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 12:09:46 -0400
Received: (qmail 22156 invoked by uid 102); 24 Jun 2016 16:09:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 12:09:46 -0400
Received: (qmail 20399 invoked by uid 107); 24 Jun 2016 16:10:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 12:10:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 12:09:43 -0400
Date:	Fri, 24 Jun 2016 12:09:43 -0400
From:	Jeff King <peff@peff.net>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: name for A..B ranges?
Message-ID: <20160624160943.GA3170@sigill.intra.peff.net>
References: <0648000B273C412AB7140AE959EBC99A@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0648000B273C412AB7140AE959EBC99A@PhilipOakley>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 08:25:59AM +0100, Philip Oakley wrote:

> Is there a common name for the A..B range format (two dots) that would
> complement the A...B (three dots) symmetric range format's name?
> 
> I was looking at the --left-right distinctions and noticed that the trail
> back to the symmetric range description was rather thin (it's buried within
> gitrevisions:Specifying Ranges, and even then its called a symmetric
> difference.

I would just call it a range, or possibly a set difference. But I don't
think we have any established naming beyond that.

-Peff
