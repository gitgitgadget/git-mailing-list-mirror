From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Mon, 7 Dec 2015 14:39:07 -0500
Message-ID: <20151207193907.GA29673@sigill.intra.peff.net>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
 <20151202005338.GD28197@sigill.intra.peff.net>
 <xmqq37vl7fux.fsf@gitster.mtv.corp.google.com>
 <20151202024403.GA29329@sigill.intra.peff.net>
 <xmqqlh9c6byy.fsf@gitster.mtv.corp.google.com>
 <20151202164712.GA16636@sigill.intra.peff.net>
 <xmqqd1uo69vf.fsf@gitster.mtv.corp.google.com>
 <20151202175144.GA18550@sigill.intra.peff.net>
 <xmqqr3j0nsk8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James <rouzier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 20:39:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a61cx-00045z-AP
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 20:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbbLGTjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 14:39:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:38444 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932342AbbLGTjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 14:39:10 -0500
Received: (qmail 12362 invoked by uid 102); 7 Dec 2015 19:39:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 13:39:10 -0600
Received: (qmail 22399 invoked by uid 107); 7 Dec 2015 19:39:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 14:39:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 14:39:07 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3j0nsk8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282110>

On Sat, Dec 05, 2015 at 07:51:03PM -0800, Junio C Hamano wrote:

> In any case, what we've been discussing may be an interesting and
> potentially important tangent, but it still is a tangent while
> evaluating the patch in question.  I do not think I'd be using the
> new "--exclude-from=<file>" option to "clean" (simply because I do
> not think I've ever used the existing "-e" option to it unless I am
> merely testing the command to make sure it works as advertised)
> myself, but I do not immediately see how it would hurt us in the
> future to add it now.  So...

I think that is OK. The reason I brought it up was "let's stop and make
sure we don't want to go this other route before we add more potentially
redundant options that we cannot get rid of later". But based on this
discussion it is not at all clear that "clean --exclude-from" would
become redundant, so let's cross that off as an objection.

-Peff
