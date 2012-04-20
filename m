From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Documentation: explain push.default option a bit more
Date: Fri, 20 Apr 2012 13:13:57 -0700
Message-ID: <20120420201357.GA13103@sigill.intra.peff.net>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
 <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1334933944-13446-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Apr 20 22:14:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLKDY-0002wZ-9m
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 22:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420Ab2DTUOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 16:14:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39337
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab2DTUOB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 16:14:01 -0400
Received: (qmail 14168 invoked by uid 107); 20 Apr 2012 20:14:11 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Apr 2012 16:14:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Apr 2012 13:13:57 -0700
Content-Disposition: inline
In-Reply-To: <1334933944-13446-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196018>

On Fri, Apr 20, 2012 at 04:59:01PM +0200, Matthieu Moy wrote:

> The previous documentation was explaining _what_ the options were doing,
> but were of little help explaining _why_ a user should set his default to
> either of the options.

I think your explanations are a definite improvement.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index fb386ab..368a770 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
>[...]
>  * `tracking` - deprecated synonym for `upstream`.

This is not directly related to your patch, but maybe it is worth
removing this (from the documentation) for the sake of simplicity. We
will still support the synonym (it has only been deprecated for a year),
but new users don't need to see it in the already-large list of options.

-Peff
