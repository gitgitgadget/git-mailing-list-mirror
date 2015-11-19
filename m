From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 00/10] refs backend pre-vtable
Date: Thu, 19 Nov 2015 09:58:48 -0500
Message-ID: <20151119145848.GA11484@sigill.intra.peff.net>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
 <1447699868.5082.0.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 15:58:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzQfo-00076V-28
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 15:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbbKSO6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 09:58:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:59741 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934375AbbKSO6v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 09:58:51 -0500
Received: (qmail 19075 invoked by uid 102); 19 Nov 2015 14:58:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Nov 2015 08:58:50 -0600
Received: (qmail 17211 invoked by uid 107); 19 Nov 2015 14:59:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Nov 2015 09:59:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Nov 2015 09:58:48 -0500
Content-Disposition: inline
In-Reply-To: <1447699868.5082.0.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281480>

On Mon, Nov 16, 2015 at 01:51:08PM -0500, David Turner wrote:

> > Since patch 01/11 of v7 was omitted, the patches in this version are
> > numbered differently. In particular, it is now patches 01 through 07
> > that form the core of this patch series. The last three patches can
> > easily be postponed if that will speed the progress of the first
> > seven.
> > 
> > These patches are also available from my GitHub fork [2] as branch
> > "refs-backend-pre-vtable".
> 
> This version looks good to me.

Thanks. Looks like patch 7 didn't make it to the list due to its size. I
picked it up from Michael's GitHub fork.

Just so I'm sure, this is replacing all of what Junio had queued in
dt/refs-backend-pre-vtable, right?

-Peff
