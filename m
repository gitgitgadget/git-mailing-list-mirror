From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: --amend -m '' silently fails to wipe message
Date: Thu, 7 Apr 2016 16:28:19 -0400
Message-ID: <20160407202818.GB7705@sigill.intra.peff.net>
References: <20160406171503.GA2345@dinwoodie.org>
 <20160407044219.GA29710@sigill.intra.peff.net>
 <20160407044837.GA28859@sigill.intra.peff.net>
 <xmqqshyxz3ss.fsf@gitster.mtv.corp.google.com>
 <20160407190210.GA4478@sigill.intra.peff.net>
 <xmqq1t6hyyz9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
	Chris Webb <chris@arachsys.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 22:28:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoGXU-0002zD-9h
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 22:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbcDGU2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 16:28:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:46123 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753807AbcDGU2X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 16:28:23 -0400
Received: (qmail 1619 invoked by uid 102); 7 Apr 2016 20:28:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 16:28:22 -0400
Received: (qmail 30601 invoked by uid 107); 7 Apr 2016 20:28:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 16:28:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Apr 2016 16:28:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1t6hyyz9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290984>

On Thu, Apr 07, 2016 at 12:56:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, FWIW, those were the sites and reasons I identified last night.
> > Your patch looks like the right thing to me.
> 
> Thanks, let's do this then.  I'd already anticipated your sign-off ;-).
> 
> -- >8 --
> From: Jeff King <peff@peff.net>
> Subject: commit: do not ignore an empty message given by -m ''
> [...]

I don't know if I deserve authorship, but I am happy to take the blame. :)

Thank you for picking this up. I'm still traveling through the weekend,
so I'll be a bit slow on turnaround in general.

>  builtin/commit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I think this should pass Adam's tests, along with some new ones if we
cared to write them, but I'm not sure if it's worth testing such
specific items (i.e., it is not likely to break in exactly the same way
again).

I will leave it to you whether you think it's worth squashing them in.

-Peff
