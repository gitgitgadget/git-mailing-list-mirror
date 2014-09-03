From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] fsck: check tag objects' headers
Date: Wed, 3 Sep 2014 17:38:49 -0400
Message-ID: <20140903213848.GA28769@peff.net>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
 <xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
 <20140829234327.GF24834@peff.net>
 <xmqqiol527co.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:38:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPIGY-0005JT-S0
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 23:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbaICVix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 17:38:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:43759 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756693AbaICViv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 17:38:51 -0400
Received: (qmail 4303 invoked by uid 102); 3 Sep 2014 21:38:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Sep 2014 16:38:51 -0500
Received: (qmail 22429 invoked by uid 107); 3 Sep 2014 21:39:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Sep 2014 17:39:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2014 17:38:49 -0400
Content-Disposition: inline
In-Reply-To: <xmqqiol527co.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256418>

On Tue, Sep 02, 2014 at 11:41:11AM -0700, Junio C Hamano wrote:

> > Personally, I think the cover letter is a good place for such things.
> 
> Yeah, and I saw it explained in the cover.  It looked somewhat out
> of place to see it duplicated only for this patch in the 6 patch
> series and I was wondering if there was something special about this
> specific patch, hence my question.

Ah. For some reason the cover letter did not make it to me[1]. I agree
that what is there is fine, and it can be dropped from the individual
commit message.

-Peff

[1] It did make it to gmane, so I guess the problem was on my end.
