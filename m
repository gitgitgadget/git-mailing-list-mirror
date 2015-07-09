From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] check_and_freshen_file: fix reversed success-check
Date: Thu, 9 Jul 2015 18:48:30 -0400
Message-ID: <20150709224830.GA24998@peff.net>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
 <20150707141305.GA629@peff.net>
 <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
 <20150707194956.GA13792@peff.net>
 <559D60DC.4010304@kdbg.org>
 <20150708180539.GA12353@peff.net>
 <20150708183331.GA16138@peff.net>
 <559D9006.20102@kdbg.org>
 <559EDEE6.1040807@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	X H <music_is_live_lg@hotmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 00:48:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKcV-00059f-IM
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbbGIWsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:48:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:58384 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750873AbbGIWsd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:48:33 -0400
Received: (qmail 3592 invoked by uid 102); 9 Jul 2015 22:48:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jul 2015 17:48:33 -0500
Received: (qmail 4039 invoked by uid 107); 9 Jul 2015 22:48:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jul 2015 18:48:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jul 2015 18:48:30 -0400
Content-Disposition: inline
In-Reply-To: <559EDEE6.1040807@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273785>

On Thu, Jul 09, 2015 at 10:51:50PM +0200, Johannes Sixt wrote:

> >Ah! That code is less than a year old. When I began to adopt a workflow
> >requiring force-pushes lately, I wondered why I haven't seen these
> >failures earlier, because I did do force pushes in the past, but not
> >that frequently. I thought that I had just been lucky. But this would
> >explain it.
> 
> And, in fact, with this patch these particular failures are gone! Thank you
> so much!

Great, thanks for testing. You can temper your appreciation by noticing
that I introduced the bug in the first place. ;)

-Peff
