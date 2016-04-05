From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 4/4] pretty: test --expand-tabs
Date: Mon, 4 Apr 2016 21:47:03 -0400
Message-ID: <20160405014703.GA29953@sigill.intra.peff.net>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
 <1459817917-32078-1-git-send-email-gitster@pobox.com>
 <1459817917-32078-5-git-send-email-gitster@pobox.com>
 <CAPig+cSTp6R0XNwNAU=QhKOTqB4=uSuPd_mnwfvy6wHs8X7FRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 03:49:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anG77-0002t9-R7
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 03:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbcDEBrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 21:47:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:44171 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751718AbcDEBrW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 21:47:22 -0400
Received: (qmail 23010 invoked by uid 102); 5 Apr 2016 01:47:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 21:47:07 -0400
Received: (qmail 32314 invoked by uid 107); 5 Apr 2016 01:47:08 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 21:47:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Apr 2016 21:47:03 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSTp6R0XNwNAU=QhKOTqB4=uSuPd_mnwfvy6wHs8X7FRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290751>

On Mon, Apr 04, 2016 at 09:10:46PM -0400, Eric Sunshine wrote:

> > +       count=$1 ;# expected tabs
> 
> Why semicolon before the hash here and above?

I am in the habit of doing this, too. I have a vague recollection of
getting bitten by a shell that treated:

  echo foo # bar

or something similar as not-a-comment. But neither bash, dash, nor ksh
seem to. So I'm not sure if it was some other shell in my past, or if I
simply have an irrational fear.

-Peff
