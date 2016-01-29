From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pass transport verbosity down to git_connect
Date: Fri, 29 Jan 2016 12:41:45 -0500
Message-ID: <20160129174144.GA22600@sigill.intra.peff.net>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <20160128235339.GB10308@sigill.intra.peff.net>
 <20160129003816.GA26200@dcvr.yhbt.net>
 <xmqqpowljcn1.fsf@gitster.mtv.corp.google.com>
 <20160129034748.GA21125@sigill.intra.peff.net>
 <xmqqlh78jnmk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 18:41:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPD3S-0008Nv-MI
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 18:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579AbcA2Rlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 12:41:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:34367 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756493AbcA2Rlu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 12:41:50 -0500
Received: (qmail 14813 invoked by uid 102); 29 Jan 2016 17:41:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jan 2016 12:41:50 -0500
Received: (qmail 32536 invoked by uid 107); 29 Jan 2016 17:42:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jan 2016 12:42:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2016 12:41:45 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlh78jnmk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285080>

On Fri, Jan 29, 2016 at 09:34:27AM -0800, Junio C Hamano wrote:

> Yeah, after re-reading the messages in this thread, I realize that I
> missed the fact that you do consider these CONNECT_VERBOSE messages
> as debugging aid and from that point of view "fetch -v" that shows
> these messagse in addition to what you get from "fetch" may be a bad
> idea.
> 
> But after inspecting what CONNECT_VERBOSE would add to the output, I
> am inclined to say that, especially if some of these steps can
> exhibit multi-second stalls, they fall more into the "progress
> indicator" (aka "do not worry, we are not stuck, be patient")
> category than "debugging aid" category.

OK, I can buy that line of reasoning (and I agree it implies showing
with a single "-v").

-Peff
