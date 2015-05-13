From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: fix unmatched code fences
Date: Wed, 13 May 2015 00:36:09 -0400
Message-ID: <20150513043609.GA6038@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <xmqqk2wdcfbb.fsf@gitster.dls.corp.google.com>
 <20150513034553.GA25025@peff.net>
 <xmqq8uctcd1u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 06:36:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOP3-0000td-Ge
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 06:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbbEMEgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 00:36:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:57581 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750709AbbEMEgM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 00:36:12 -0400
Received: (qmail 721 invoked by uid 102); 13 May 2015 04:36:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 23:36:11 -0500
Received: (qmail 6743 invoked by uid 107); 13 May 2015 04:36:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:36:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 00:36:09 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8uctcd1u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268924>

On Tue, May 12, 2015 at 09:32:45PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> It obviously is not a title underline as the lengths are vastly
> >> different.
> >
> > Yes, but Python Asciidoc allows the lengths to differ.
> 
> Hmmm, I thought the title underline was a bit more strict. I do
> recall having to fix manual pages for many commands, but we do not
> add new commands these days anymore, so perhaps things have changed
> since then.

I think it is loose in AsciiDoc and strict in AsciiDoctor, so we have
been slowly making sure they are all consistent. And we missed one,
which will be in the series I'll send in a moment. :)

I suspect the potential ambiguity is one of the reasons that AsciiDoctor
went with the stricter rule.

-Peff
