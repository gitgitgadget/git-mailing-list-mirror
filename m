From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3 v2] parse-options: remove PARSE_OPT_NEGHELP
Date: Tue, 28 Feb 2012 14:09:36 -0500
Message-ID: <20120228190936.GC11260@sigill.intra.peff.net>
References: <4F49317A.3080809@lsrfire.ath.cx>
 <4F49336C.3000303@lsrfire.ath.cx>
 <4F4D25A1.8050702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:09:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2SQl-0007tz-VY
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259Ab2B1TJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 14:09:40 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60368
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030256Ab2B1TJi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:09:38 -0500
Received: (qmail 13012 invoked by uid 107); 28 Feb 2012 19:09:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Feb 2012 14:09:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2012 14:09:36 -0500
Content-Disposition: inline
In-Reply-To: <4F4D25A1.8050702@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191764>

On Tue, Feb 28, 2012 at 08:06:09PM +0100, Ren=C3=A9 Scharfe wrote:

> PARSE_OPT_NEGHELP is confusing because short options defined with tha=
t
> flag do the opposite of what the helptext says. It is also not needed
> anymore now that options starting with no- can be negated by removing
> that prefix. Convert its only two users to OPT_NEGBIT() and OPT_BOOL(=
)
> and then remove support for PARSE_OPT_NEGHELP.
>=20
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
> This version doesn't invert the logic in grep anymore.

Thanks, I like this one much better.

-Peff
