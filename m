From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Fri, 20 Mar 2015 14:04:48 -0400
Message-ID: <20150320180448.GC11844@peff.net>
References: <20150320100429.GA17354@peff.net>
 <xmqqegojftsj.fsf@gitster.dls.corp.google.com>
 <xmqq384zft22.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 19:05:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1Hz-0001cd-RM
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbbCTSEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:04:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:35979 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751185AbbCTSEu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:04:50 -0400
Received: (qmail 27389 invoked by uid 102); 20 Mar 2015 18:04:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 13:04:50 -0500
Received: (qmail 26210 invoked by uid 107); 20 Mar 2015 18:05:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 14:05:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 14:04:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqq384zft22.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265926>

On Fri, Mar 20, 2015 at 11:00:05AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I found 2026 and 5312 to be broken (there may be others that are
> > excluded in my usual test set) in 'pu'.  As to these topics in "git
> > log --first-parent master..pu", my preference is to queue fixups on
> > the broken-out topics (available at http://github.com/gitster/git)
> > independently.
> >
> > For example, this will go on top of nd/multiple-work-trees.

Heh, I just crossed emails with you over the same patch.

> ... and this goes on top of jk/prune-with-corrupt-refs until it is
> rerolled.

I'm actually about to send out a re-roll of that, as I think all of the
review comments have been addressed.

-Peff
