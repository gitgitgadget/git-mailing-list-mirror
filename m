From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pass transport verbosity down to git_connect
Date: Thu, 28 Jan 2016 22:47:48 -0500
Message-ID: <20160129034748.GA21125@sigill.intra.peff.net>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <20160128235339.GB10308@sigill.intra.peff.net>
 <20160129003816.GA26200@dcvr.yhbt.net>
 <xmqqpowljcn1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 04:47:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP02N-0000KS-KZ
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 04:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbcA2Drw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 22:47:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:34130 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751755AbcA2Drv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 22:47:51 -0500
Received: (qmail 15551 invoked by uid 102); 29 Jan 2016 03:47:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jan 2016 22:47:50 -0500
Received: (qmail 27428 invoked by uid 107); 29 Jan 2016 03:48:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jan 2016 22:48:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jan 2016 22:47:48 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpowljcn1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285059>

On Thu, Jan 28, 2016 at 07:19:30PM -0800, Junio C Hamano wrote:

> I just reviewed the output that are protected by CONNECT_VERBOSE;
> they look somewhere between pure debugging aid (like the protocol
> dump that are shown by "fetch -vv") and progress display, and at
> least to me they are much closer to the latter than the former, in
> the sense that they are not _so_ annoying as the protocol dump that
> are clearly not meant for the end users, and that they say "I am
> looking up this host's address", "Now connecting to this host:port",
> etc.
> 
> So, I personally find this addtional output not _too_ bad if we give
> it with "fetch -v" (not limiting to "fetch -vv").

Yeah, I do not feel that strongly, and am OK if it is attached to a
single "-v". I don't think we make any promises about scraping stderr,
so it is really just about end-user experience.  It is mostly just my
gut feeling on what I'd expect based on other parts of git (especially
"fetch -vv" in other circumstances).

-Peff
