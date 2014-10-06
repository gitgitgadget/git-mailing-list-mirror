From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use skip_prefix() to avoid more magic numbers
Date: Sun, 5 Oct 2014 21:35:00 -0400
Message-ID: <20141006013459.GC11027@peff.net>
References: <5430427A.5080800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 06 03:35:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaxCf-0001OH-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 03:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbaJFBfF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2014 21:35:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:55276 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751809AbaJFBfE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2014 21:35:04 -0400
Received: (qmail 5557 invoked by uid 102); 6 Oct 2014 01:35:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Oct 2014 20:35:03 -0500
Received: (qmail 28196 invoked by uid 107); 6 Oct 2014 01:35:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Oct 2014 21:35:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2014 21:35:00 -0400
Content-Disposition: inline
In-Reply-To: <5430427A.5080800@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257906>

On Sat, Oct 04, 2014 at 08:54:50PM +0200, Ren=C3=A9 Scharfe wrote:

> Continue where ae021d87 (use skip_prefix to avoid magic numbers) left=
 off
> and use skip_prefix() in more places for determining the lengths of p=
refix
> strings to avoid using dependent constants and other indirect methods=
=2E

Thanks, these all look like nice improvements. I think both of the
suggestions made my Jonathan are good on top, though.

-Peff
