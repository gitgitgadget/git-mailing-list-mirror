From: Jeff King <peff@peff.net>
Subject: Re: Signed-off-by vs Reviewed-by
Date: Thu, 31 Mar 2016 13:21:05 -0400
Message-ID: <20160331172104.GA1623@sigill.intra.peff.net>
References: <20160331123507.GC19857@collabora.co.uk>
 <CAFZEwPMzcqrd8NEP6MH5saXL2KdUKAyN51uuoS5=aeU0aPWjJQ@mail.gmail.com>
 <20160331143501.GE19857@collabora.co.uk>
 <xmqqtwjmpq6b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@collabora.co.uk>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:21:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algHR-0007SM-L0
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511AbcCaRVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:21:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:41723 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752346AbcCaRVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:21:08 -0400
Received: (qmail 31075 invoked by uid 102); 31 Mar 2016 17:21:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 13:21:07 -0400
Received: (qmail 15157 invoked by uid 107); 31 Mar 2016 17:21:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 13:21:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 13:21:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwjmpq6b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290426>

On Thu, Mar 31, 2016 at 09:28:44AM -0700, Junio C Hamano wrote:

> As to the last step of "integration", we cannot use short-and-sweet
> single letter options like '-s' (for sign-off) for each and every
> custom trailer different projects use for their own purpose (as
> there are only 26 of the lowercase ASCII alphabet letters), so the
> most general syntax for the option has to become "--trailer <arg>"
> or some variation of it, and at that point "-s" would look like a
> short-hand for "--trailer signed-off-by".

I can imagine it would be useful to give one short-and-sweet to "add my
standard trailers", where that standard set is defined in the config
file. But that is just a guess; I do not personally have a workflow
where such standard trailers exist, beyond the normal s-o-b.

-Peff
