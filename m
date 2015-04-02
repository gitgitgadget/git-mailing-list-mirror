From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] howto: document more tools for recovery corruption
Date: Wed, 1 Apr 2015 20:49:55 -0400
Message-ID: <20150402004955.GA25634@peff.net>
References: <20131016083400.GA31266@sigill.intra.peff.net>
 <20150401210856.GA23050@peff.net>
 <xmqq4mozmqw3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 02:50:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdTKd-0005Fd-PL
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 02:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbbDBAt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 20:49:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:41161 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751056AbbDBAt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 20:49:58 -0400
Received: (qmail 4751 invoked by uid 102); 2 Apr 2015 00:49:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Apr 2015 19:49:58 -0500
Received: (qmail 6120 invoked by uid 107); 2 Apr 2015 00:50:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Apr 2015 20:50:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Apr 2015 20:49:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mozmqw3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266627>

On Wed, Apr 01, 2015 at 03:21:16PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Long ago, I documented a corruption recovery I did and gave
> > some C code that I used to help find a flipped bit.  I had
> > to fix a similar case recently, and I ended up writing a few
> > more tools.  I hope nobody ever has to use these, but it
> > does not hurt to share them, just in case.
> 
> I am having a hard time deciding if I should take the Date: header
> of the patch e-mail into consideration.  The munge thing looks
> serious enough, though.

Heh, no, this is sadly a serious thing that I did today (but I was able
to detect and correct a single flipped bit in a 60MB packfile, which is
kind of neat, I guess).

I hesitated sending them at all because they are not really note-worthy.
OTOH, during today's exercise I found the instructions and sample
program I had written last time to be very useful, so perhaps it can
help somebody (or even me) at some later today.

-Peff
