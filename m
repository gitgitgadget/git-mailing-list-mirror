From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use child_process_init() to initialize struct
 child_process variables
Date: Mon, 10 Nov 2014 02:14:10 -0500
Message-ID: <20141110071410.GE7677@peff.net>
References: <54500212.7040603@web.de>
 <20141029172109.GA32234@peff.net>
 <545F7106.7070300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 08:14:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnjB2-0005wU-S8
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 08:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbaKJHON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2014 02:14:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:38640 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750850AbaKJHOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 02:14:12 -0500
Received: (qmail 17242 invoked by uid 102); 10 Nov 2014 07:14:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 01:14:13 -0600
Received: (qmail 621 invoked by uid 107); 10 Nov 2014 07:14:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 02:14:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 02:14:10 -0500
Content-Disposition: inline
In-Reply-To: <545F7106.7070300@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 09, 2014 at 02:49:58PM +0100, Ren=C3=A9 Scharfe wrote:

> -- >8 --
> Subject: [PATCH] trailer: use CHILD_PROCESS_INIT in apply_command()
>=20
> Initialize the struct child_process variable cp at declaration time.
> This is shorter, saves a function call and prevents using the variabl=
e
> before initialization by mistake.
>=20
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  trailer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks, both this one and the other you just sent (to use
child_process.args in more places) look good to me.

-Peff
