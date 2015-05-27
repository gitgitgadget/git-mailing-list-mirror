From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] clone: add `--seed` shorthand
Date: Wed, 27 May 2015 04:19:10 -0400
Message-ID: <20150527081909.GA10008@peff.net>
References: <20150521041435.GA18978@peff.net>
 <20150521041619.GC5196@peff.net>
 <8895881cd3f324d2b8a827e311296a48@www.dscho.org>
 <3516DC60279A42188EE2AA394921FC70@PhilipOakley>
 <1be7702fa53d1705e913aff2e00eac21@www.dscho.org>
 <20150522064922.GA27716@peff.net>
 <xmqqtwv1bxpy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 10:19:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxWYZ-0000fm-9a
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 10:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbbE0ITO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 04:19:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:36546 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752232AbbE0ITM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 04:19:12 -0400
Received: (qmail 4628 invoked by uid 102); 27 May 2015 08:19:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 03:19:12 -0500
Received: (qmail 5500 invoked by uid 107); 27 May 2015 08:19:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 04:19:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 04:19:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwv1bxpy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270037>

On Sun, May 24, 2015 at 12:07:53PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Having slept on it, I really think "--seed" should be "fetch from the
> > seed into temp refs", and not what I posted earlier.
> 
> Yeah, I think that is the right way to do it.

In the meantime, do you want to pick up patches 1 and 2? I think they
are cleanups that stand on their own, whether we do patch 3 or not.

-Peff
