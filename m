From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: Clarify which paths git-clean will affect
Date: Wed, 6 May 2009 15:24:47 +0200
Message-ID: <200905061524.52186.trast@student.ethz.ch>
References: <20090505091302.GB27900@frsk.net> <200905051426.18814.trast@student.ethz.ch> <7vk54v1py6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1607759.pK7ipRFykW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Skolmli <fredrik@frsk.net>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 15:25:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1h8B-0007gY-8k
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 15:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbZEFNZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 09:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755357AbZEFNZm
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 09:25:42 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:19364 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161AbZEFNZm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 09:25:42 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 May 2009 15:25:41 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 May 2009 15:25:41 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.27.21-0.1-default; KDE/4.2.2; x86_64; ; )
In-Reply-To: <7vk54v1py6.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 06 May 2009 13:25:41.0631 (UTC) FILETIME=[272580F0:01C9CE4E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118340>

--nextPart1607759.pK7ipRFykW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > -If any optional `<path>...` arguments are given, only those paths
> > -are affected.
> > +If any optional `<path>...` arguments are given, those paths are
> > +affected.  Otherwise, the cleaning starts at the current directory.
>=20
> With or without path limiters, clean does not look outside the current
> directory; I think the "otherwise" makes things worse than the original.
>=20
> I'd suggest not touching this paragraph at all, but instead say something
> like this at the beginning:
>=20
> > -This allows cleaning the working tree by removing files that are not
>=20
>     Cleans the working tree by recursively removing files that are not
>     under version control, starting from the current directory.

Indeed, yours is better.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1607759.pK7ipRFykW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkoBj6QACgkQqUud07tmzP2DoQCffxWb8awQ+jdWZAve7OHyeUuX
WDMAniOXY3yK9XIfYgGby/1trp9MDvI6
=s/Mn
-----END PGP SIGNATURE-----

--nextPart1607759.pK7ipRFykW--
