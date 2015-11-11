From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: make formatting more consistent
Date: Wed, 11 Nov 2015 16:41:06 -0500
Message-ID: <20151111214106.GA2208@sigill.intra.peff.net>
References: <CACayv=gEGY-JNfu26fOzztXwhV_bkG8pv_iOXLC5L-Mig9f0kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: =?utf-8?B?0JDQvdC00YDQtdC5INCg0YvQsdCw0Lo=?= <rybak.a.v@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:41:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwd8k-0001wR-M7
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 22:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbbKKVlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2015 16:41:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:56311 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752435AbbKKVlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 16:41:09 -0500
Received: (qmail 2830 invoked by uid 102); 11 Nov 2015 21:41:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Nov 2015 15:41:08 -0600
Received: (qmail 9716 invoked by uid 107); 11 Nov 2015 21:41:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Nov 2015 16:41:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Nov 2015 16:41:06 -0500
Content-Disposition: inline
In-Reply-To: <CACayv=gEGY-JNfu26fOzztXwhV_bkG8pv_iOXLC5L-Mig9f0kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281204>

On Wed, Nov 11, 2015 at 06:47:25PM +0300, =D0=90=D0=BD=D0=B4=D1=80=D0=B5=
=D0=B9 =D0=A0=D1=8B=D0=B1=D0=B0=D0=BA wrote:

> Documentation/git.txt: enclose all Environment Variables in single qu=
otes.

This tells "what", but we can already see that from the diff. The more
interesting part is "why". Later you say:

> Signed-off-by: Andrey Rybak <rybak.a.v@gmail.com>
> ---
> Documentation/git.txt is not consistent in the way it stylizes mentio=
ns
> of Environment Variables. Most of them are enclosed in single quotes,
> some are enclosed in backticks, some are not enclosed.

which I think is the more interesting bit, and should go into the commi=
t
message (but parts after the "---" generally do not). I've grabbed it
manually in this case.

I know we've discussed this particular spot before, and I think there
may have been some disagreement about which style was the best. But
since clearly no patch came out of the last discussion, and since
an inconsistent set of styles is probably worse than consistent use of
any of the choices, this makes sense to me as an incremental step.

If we want to move to all-backticks (for example) later on, we can
easily do so (or we can leave this as the final state).

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index c2e2a94..900272b 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1056,7 +1056,7 @@ of clones and fetches.
>   cloning of shallow repositories.
>   See 'GIT_TRACE' for available trace output options.

Your patch seems whitespace-damaged (the leading tabs were converted to
spaces). It was pretty easy to fix up in this case, so I did so (i.e.,
no need to re-send), but please check your mailer settings.

Thanks.

-Peff
