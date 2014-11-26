From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] pre-commit hook updates
Date: Wed, 26 Nov 2014 13:56:11 -0500
Message-ID: <20141126185610.GA1734@peff.net>
References: <cover.1416953772.git.oystwa@gmail.com>
 <20141126045246.GD15252@peff.net>
 <xmqqfvd5res5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:56:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XthlA-00059z-TR
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 19:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbaKZS4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2014 13:56:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:45378 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750780AbaKZS4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 13:56:12 -0500
Received: (qmail 30193 invoked by uid 102); 26 Nov 2014 18:56:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Nov 2014 12:56:12 -0600
Received: (qmail 9331 invoked by uid 107); 26 Nov 2014 18:56:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Nov 2014 13:56:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Nov 2014 13:56:11 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfvd5res5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260293>

On Wed, Nov 26, 2014 at 10:35:22AM -0800, Junio C Hamano wrote:

> I _think_ "give only info that is necessary" is cleaner as an
> interface in theory, but have two niggles myself:
>=20
>  1. the hooks must do the "argument parsing" loop (you already
>     mentioned this);
>=20
>  2. the hooks cannot tell if the lack of "amending" argument is
>     because the version of Git predates that "amending" hint
>     support, or because the user action is a straight "commit" not
>     an "commit --amend".
>=20
> In any case, I do not have strong preference myself.

That agrees with my thinking exactly.

At this point since both of us seem on the fence, I am happy to let
=C3=98ystein, as the person who is actually writing the patch, decide.

-Peff
