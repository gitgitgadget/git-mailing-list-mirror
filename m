From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/7] t4026: test "normal" color
Date: Thu, 20 Nov 2014 14:00:48 -0500
Message-ID: <20141120190048.GA3741@peff.net>
References: <20141120151418.GA23607@peff.net>
 <20141120151609.GC23680@peff.net>
 <xmqqwq6p3dq3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Baker <bakers@canbytel.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 20:00:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWyN-0005Zx-ES
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 20:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959AbaKTTAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 14:00:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:42923 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757955AbaKTTAu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 14:00:50 -0500
Received: (qmail 21822 invoked by uid 102); 20 Nov 2014 19:00:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 13:00:50 -0600
Received: (qmail 15077 invoked by uid 107); 20 Nov 2014 19:01:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 14:01:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 14:00:48 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwq6p3dq3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 10:53:56AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If the user specifiers "normal" for a foreground color, this

Argh, s/specifiers/specifies/

> > We also check that color "-1" does the same thing. This is
> > not documented, but has worked forever, so let's make sure
> > we keep supporting it.
> 
> YLNTED, really?  I do not object to the conclusion, but I am
> mildly surprised ;-)

I was surprised by it, too, when writing the refactoring patch that
comes next in the series. :)

I was also surprised that we further check that "-2" is _not_ valid in
the tests.  I do not mind declaring everything negative to be the same
(either invalid, or "normal"), but I decided that there was really no
benefit to breaking compatibility in this case. And I suppose if you are
using 256-color mode, then "-1 255" is perhaps a natural way to write
it.

-Peff
