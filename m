From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/67] war on sprintf, strcpy, etc
Date: Wed, 16 Sep 2015 06:35:00 -0400
Message-ID: <20150916103500.GG13966@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <xmqq4mivt9gr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 12:35:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcA3Y-00027F-7H
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 12:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbbIPKfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 06:35:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:59866 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752196AbbIPKfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 06:35:09 -0400
Received: (qmail 17052 invoked by uid 102); 16 Sep 2015 10:35:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 05:35:09 -0500
Received: (qmail 16713 invoked by uid 107); 16 Sep 2015 10:35:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 06:35:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 06:35:00 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mivt9gr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278018>

On Tue, Sep 15, 2015 at 06:54:28PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Obviously this is not intended for v2.6.0. But all of the spots touched
> > here are relatively quiet right now, so I wanted to get it out onto the
> > list.  There are a few minor conflicts against "pu", but they're all
> > just from touching nearby lines.
> 
> Thanks.  Looks like a lot of good work you did ;-)

I forgot to mention my favorite part:

  $ git diff --stat @{u} | tail -1
   88 files changed, 872 insertions(+), 980 deletions(-)

:)

-Peff
