From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 18/25] t1301: use modern test_* helpers
Date: Tue, 24 Mar 2015 22:45:03 -0400
Message-ID: <20150325024502.GA15051@peff.net>
References: <20150320100429.GA17354@peff.net>
 <20150320101311.GR12543@peff.net>
 <20150325005120.Horde.ClYI1WJflnvTzVgcL6i8Sg8@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:45:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YabJf-0002cC-W7
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 03:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbbCYCpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 22:45:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:38114 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752036AbbCYCpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 22:45:06 -0400
Received: (qmail 10492 invoked by uid 102); 25 Mar 2015 02:45:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Mar 2015 21:45:06 -0500
Received: (qmail 10712 invoked by uid 107); 25 Mar 2015 02:45:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Mar 2015 22:45:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2015 22:45:03 -0400
Content-Disposition: inline
In-Reply-To: <20150325005120.Horde.ClYI1WJflnvTzVgcL6i8Sg8@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266248>

On Wed, Mar 25, 2015 at 12:51:20AM +0100, SZEDER G=C3=A1bor wrote:

> >@@ -33,7 +32,7 @@ do
> >  			git init --shared=3D1 &&
> >  			test 1 =3D "$(git config core.sharedrepository)"
> >  		) &&
> >-		actual=3D$(ls -l sub/.git/HEAD)
> >+		actual=3D$(ls -l sub/.git/HEAD) &&
> >  		case "$actual" in
> >  		-rw-rw-r--*)
> >  			: happy
>=20
> This hunk could go into the "moderate &&-chain breakage" patch.
> Doesn't really matter, what matters most is that it's fixed, but I re=
ally
> liked your classification of missing &&s in the early patches.

Yeah, these later ones are a mish-mash of real fixes and just quieting
--chain-lint. I pulled out ones that I felt needed a little more
explanation, and generally kept changes for a file together (though I a=
m
not sure not always). I'm not sure it's worth the effort to go through
another round of classifying.

-Peff
