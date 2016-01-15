From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/21] Peace with CRLF
Date: Fri, 15 Jan 2016 15:49:16 -0500
Message-ID: <20160115204916.GJ11301@sigill.intra.peff.net>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:49:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKBJD-0006aB-2g
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbcAOUtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:49:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:54685 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750897AbcAOUtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:49:18 -0500
Received: (qmail 11569 invoked by uid 102); 15 Jan 2016 20:49:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:49:18 -0500
Received: (qmail 23981 invoked by uid 107); 15 Jan 2016 20:49:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:49:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 15:49:16 -0500
Content-Disposition: inline
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284216>

On Thu, Jan 14, 2016 at 03:58:15PM -0800, Junio C Hamano wrote:

> This is a reroll of
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/282614
> 
> which is a continuation to $gmane/275735, which is filed in the
> archive under another mailing list:
> 
>   http://thread.gmane.org/gmane.comp.version-control.msysgit/21773

I just read through the whole thing and made a few comments. Please feel
free to ignore my "how about this on top" suggestions if you don't like
them, or just don't want to deal with them. Patches I didn't respond to
all looked good to me.

There are a few "iffy" conversions where we take unconstrained input and
there's no "usual" quoting mechanism available (you mentioned the one in
"grep", and I pointed out a few more). I hate to break
backwards-compatibility in any way, but I think in all of those cases
that we are much more likely to be helping the user than hurting them.

So I think it's a net benefit in all of the cases.

-Peff
