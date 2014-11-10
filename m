From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1410: Fix for case insensitive filesystems
Date: Mon, 10 Nov 2014 01:23:56 -0500
Message-ID: <20141110062356.GA8047@peff.net>
References: <1415584086-41637-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 07:24:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XniOR-00072n-82
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 07:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbaKJGX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 01:23:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:38593 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750833AbaKJGX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 01:23:58 -0500
Received: (qmail 15101 invoked by uid 102); 10 Nov 2014 06:23:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 00:23:59 -0600
Received: (qmail 32429 invoked by uid 107); 10 Nov 2014 06:24:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 01:24:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 01:23:56 -0500
Content-Disposition: inline
In-Reply-To: <1415584086-41637-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 09, 2014 at 08:48:06PM -0500, Brian Gernhardt wrote:

> A pair of recently added tests used branches a and a/b, but earlier
> tests created files A and A/B.  On case insensitive filesystems (such
> as HFS+), that causes git to complain about the name being ambiguous
> between branch and file.  Resolve by renaming the branches to aa and
> aa/bb.

Already being discussed here:

  http://thread.gmane.org/gmane.comp.version-control.git/259250/focus=259253

:)

-Peff
