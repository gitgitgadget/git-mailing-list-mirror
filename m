From: Jeff King <peff@peff.net>
Subject: Re: t0008 test fails with ksh
Date: Sat, 21 May 2016 19:09:11 -0500
Message-ID: <20160522000911.GA9676@sigill.intra.peff.net>
References: <CALR6jEjWjJA0X2qXsxqObqc_yxrgX87LYf8cmJ0MmJFF6PkmTQ@mail.gmail.com>
 <20160512182055.GB13886@sigill.intra.peff.net>
 <xmqqr3cwg1ik.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 22 02:09:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4GxT-0001q7-EB
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 02:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbcEVAJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 20:09:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:42585 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751860AbcEVAJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 20:09:16 -0400
Received: (qmail 17661 invoked by uid 102); 22 May 2016 00:09:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 May 2016 20:09:15 -0400
Received: (qmail 15455 invoked by uid 107); 22 May 2016 00:09:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 May 2016 20:09:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 May 2016 19:09:11 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3cwg1ik.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295254>

On Fri, May 20, 2016 at 09:03:31AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   ... However,
> >   the double-quote character ( '"' ) shall not be treated specially
> >   within a here-document, except when the double-quote appears within
> >   "$()", "``", or "${}".
> >
> > So OK, that sounds like ksh is doing the right thing. But what's that
> > "specially" in the last sentence?
> 
> I would say: Just like \X is passed thru as-is without losing \, \"
> is passed thru without losing \, because " is not special, just like
> X is not special.

Yeah, that was my reading, too (sorry, my question was mostly
rhetorical; imagine me reading it in an exaggerated surprised "woah,
what's this?" voice. :) ).

-Peff
