From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Add a function skip_prefix_if_present()
Date: Wed, 5 Feb 2014 12:26:51 -0500
Message-ID: <20140205172651.GC7268@sigill.intra.peff.net>
References: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu>
 <52F1E04D.3090208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kent R. Spillner" <kspillner@acm.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 05 18:27:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6FV-0007Np-QZ
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbaBER0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Feb 2014 12:26:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:45114 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752964AbaBER0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:26:53 -0500
Received: (qmail 6223 invoked by uid 102); 5 Feb 2014 17:26:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:26:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:26:51 -0500
Content-Disposition: inline
In-Reply-To: <52F1E04D.3090208@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241615>

On Wed, Feb 05, 2014 at 07:55:09AM +0100, Michael Haggerty wrote:

> * Ren=C3=A9 Scharfe submitted a patch to use a function parse_prefix(=
)
>   (originally suggested by Peff) instead of Duy's suggested approach:
>=20
>       http://article.gmane.org/gmane.comp.version-control.git/239569
>=20
>   His patch appears to have been overlooked.
>=20
> * Duy seemed to offer to rewrite his patch series, but I don't think
>   that it has happened yet.
>=20
> And then the conversation was drowned by Christmas eggnog.
>=20
> I don't have a strong feeling about (Duy's proposal plus my patches) =
vs.
> (Ren=C3=A9's parse_prefix() approach).  But I definitely *do* like th=
e idea
> of getting rid of all those awkward magic numbers everywhere.

=46WIW, after coming down off my eggnog bender, I think I still prefer
Ren=C3=A9's (my?) approach.

-Peff
