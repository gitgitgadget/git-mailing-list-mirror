From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential-store: don't pass strerror to die_errno()
Date: Wed, 16 Dec 2015 13:20:16 -0500
Message-ID: <20151216182016.GA31510@sigill.intra.peff.net>
References: <1449138687-23675-1-git-send-email-szeder@ira.uka.de>
 <1450264975-9760-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Dec 16 19:20:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Ggi-0002Qb-UR
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 19:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966691AbbLPSUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2015 13:20:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:43110 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965887AbbLPSUT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 13:20:19 -0500
Received: (qmail 8077 invoked by uid 102); 16 Dec 2015 18:20:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Dec 2015 12:20:19 -0600
Received: (qmail 31069 invoked by uid 107); 16 Dec 2015 18:20:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Dec 2015 13:20:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Dec 2015 13:20:16 -0500
Content-Disposition: inline
In-Reply-To: <1450264975-9760-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282580>

On Wed, Dec 16, 2015 at 12:22:55PM +0100, SZEDER G=C3=A1bor wrote:

> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>=20
> v2 fixed this, but it fell on the floor, I suppose because of the
> maintainer switch.  Anyway, I should have noticed it while the patch
> was still cooking, sorry.

Oops. I do remember seeing Eric point out the problem and I think I was
planning to fix it up before merging. But I didn't make a note in
whats-cooking, so Junio had no idea of my plan.

>  credential-store.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch is obviously correct. Thanks.

-Peff
