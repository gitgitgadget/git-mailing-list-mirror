From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use child_process_init() to initialize struct
 child_process variables
Date: Thu, 30 Oct 2014 17:25:51 -0400
Message-ID: <20141030212551.GA26030@peff.net>
References: <54500212.7040603@web.de>
 <20141029172109.GA32234@peff.net>
 <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
 <xmqqlhnxwhw4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 22:26:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjxEE-0004VQ-Mf
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 22:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbaJ3VZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 17:25:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:35275 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934814AbaJ3VZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 17:25:54 -0400
Received: (qmail 2364 invoked by uid 102); 30 Oct 2014 21:25:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Oct 2014 16:25:54 -0500
Received: (qmail 9059 invoked by uid 107); 30 Oct 2014 21:25:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Oct 2014 17:25:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Oct 2014 17:25:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhnxwhw4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 30, 2014 at 11:07:39AM -0700, Junio C Hamano wrote:

> -- >8 --
> Subject: [PATCH] bundle: split out a helper function to create a pack data

s/a pack data/pack data/

> The create_bundle() function, while it does one single logical thing
> and tries to do it well, that single logical thing takes a rather
> large implementation.

I had minor trouble parsing this. I think it might be more clearly said
as just:

  The create_bundle() function, while it does one single logical thing,
  takes a rather large implementation to do so.

> Let's start separating what it does into smaller steps to make it
> easier what is going on.  This is a first step to separate out the

s/easier/& to see/

>  bundle.c | 64 +++++++++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 37 insertions(+), 27 deletions(-)

The patch itself looked OK to me.

-Peff
