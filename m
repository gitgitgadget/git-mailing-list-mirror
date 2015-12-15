From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] prepare_packed_git(): find more garbage
Date: Tue, 15 Dec 2015 18:25:35 -0500
Message-ID: <20151215232534.GA30998@sigill.intra.peff.net>
References: <CAGZ79kaCNT06mAGQbHNgZmdBQUyxGFTFA2Y2FXvG2UG+P7s2kg@mail.gmail.com>
 <1448518529-2659-1-git-send-email-dougk.ff7@gmail.com>
 <20151215230957.GA30353@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:25:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8yyU-0005cT-4v
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 00:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933744AbbLOXZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 18:25:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:42669 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932286AbbLOXZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 18:25:37 -0500
Received: (qmail 19422 invoked by uid 102); 15 Dec 2015 23:25:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 17:25:37 -0600
Received: (qmail 21256 invoked by uid 107); 15 Dec 2015 23:25:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 18:25:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2015 18:25:35 -0500
Content-Disposition: inline
In-Reply-To: <20151215230957.GA30353@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282508>

On Tue, Dec 15, 2015 at 06:09:57PM -0500, Jeff King wrote:

> > @@ -1225,6 +1225,15 @@ static void report_helper(const struct string_list *list,
> [...]
> If I understand this function correctly, we're just trying to
> get rid of "boring" cases that do not need to be reported.

BTW, I wondered if this should perhaps just be calling bits_to_msg() and
seeing if it returns NULL. It seems like the logic for which cases are
"interesting" ends up duplicated. But maybe I am missing something.

-Peff
