From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/14] implement @{push} shorthand
Date: Thu, 21 May 2015 00:52:34 -0400
Message-ID: <20150521045233.GA26507@peff.net>
References: <20150521044429.GA5857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:52:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvITK-0003r4-D7
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbbEUEwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:52:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:33737 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750815AbbEUEwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:52:36 -0400
Received: (qmail 2829 invoked by uid 102); 21 May 2015 04:52:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:52:36 -0500
Received: (qmail 31465 invoked by uid 107); 21 May 2015 04:52:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:52:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:52:34 -0400
Content-Disposition: inline
In-Reply-To: <20150521044429.GA5857@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269556>

On Thu, May 21, 2015 at 12:44:29AM -0400, Jeff King wrote:

> This is a re-roll of the series at:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/268185
> 
> The only changes here are the addition of patches 2 and 6, which are
> both cleanups that help make the other patches more readable/sensible.
> They are the same as what was posted during review of the thread linked
> above.  So there's nothing new here, but of course fresh reviews are
> welcome.

Actually, that's not quite true; I forgot to mention one change:

>   [03/14]: remote.c: drop "remote" pointer from "struct branch"

In this version, this one remembers to also update the API
documentation.

-Peff
