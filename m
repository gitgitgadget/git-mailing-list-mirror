From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a
 corrupted repository
Date: Thu, 19 Mar 2015 17:52:00 -0400
Message-ID: <20150319215200.GC8680@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072844.GA25191@peff.net>
 <xmqqfv90iwjj.fsf@gitster.dls.corp.google.com>
 <20150319205147.GA7775@peff.net>
 <xmqqvbhwheb6.fsf@gitster.dls.corp.google.com>
 <20150319214707.GA8680@peff.net>
 <xmqqlhishd3i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:52:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYiMP-0000e2-JN
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbbCSVwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:52:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:35508 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750778AbbCSVwD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:52:03 -0400
Received: (qmail 6789 invoked by uid 102); 19 Mar 2015 21:52:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:52:03 -0500
Received: (qmail 17982 invoked by uid 107); 19 Mar 2015 21:52:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 17:52:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 17:52:00 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhishd3i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265843>

On Thu, Mar 19, 2015 at 02:49:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I'm inclined to leave it (we do confirm with the rev-parse call at
> > the end of the setup that our packed-refs file is working) unless you
> > feel strongly. If you do, I'd rather go the route of sticking each
> > corruption in its own separate sub-repo.
> 
> No, I don't feel strongly either way---otherwise I wouldn't be
> wondering if it makes a difference, but explaining why hand-crafting
> is a bad idea (or the other way around).

And here I thought you were just being polite. ;)

-Peff
