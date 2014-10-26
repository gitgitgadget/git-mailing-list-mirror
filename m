From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Makefile: Reorder linker flags in the git executable
 rule
Date: Sun, 26 Oct 2014 11:35:30 -0700
Message-ID: <20141026183530.GA18144@peff.net>
References: <87mw8iag72.fsf@gmail.com>
 <CAPig+cRUxXw4b2z1Gu4p6GKjnYrt_70h3kbR+jzbMP_jY24Sjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Michael <fedora.dm0@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 19:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiSfK-0000Jk-7D
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 19:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbaJZSfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 14:35:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:33773 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751428AbaJZSfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 14:35:37 -0400
Received: (qmail 6352 invoked by uid 102); 26 Oct 2014 18:35:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Oct 2014 13:35:36 -0500
Received: (qmail 31230 invoked by uid 107); 26 Oct 2014 18:35:37 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Oct 2014 14:35:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2014 11:35:30 -0700
Content-Disposition: inline
In-Reply-To: <CAPig+cRUxXw4b2z1Gu4p6GKjnYrt_70h3kbR+jzbMP_jY24Sjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 01:45:10PM -0400, Eric Sunshine wrote:

> On Sun, Oct 26, 2014 at 1:33 PM, David Michael <fedora.dm0@gmail.com> wrote:
> > The XL C compiler can fail due to mixing library path and object
> 
> Can you explain in the commit message the actual nature of the failure
> so that readers can understand more precisely how this change helps?

Based on past experience, it is probably "the compiler complains and
refuses to run" (or optionally "the compiler silently ignores your
LDFLAGS" depending on how irritating it wants to be). But it would not
hurt to be specific.

Either way, the patch looks good; the whole point of LDFLAGS versus LIBS
is to make this distinction in command-line positioning.

-Peff
