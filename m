From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [Illustration PATCH] add -i: accept single-keypress input
Date: Wed, 4 Feb 2009 09:51:44 +0100
Message-ID: <200902040951.50018.trast@student.ethz.ch>
References: <20090203062437.GB21367@sigill.intra.peff.net> <200902031035.04978.trast@student.ethz.ch> <7vljsm9492.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3813377.g2HbkvW7NZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Suraj Kurapati <sunaku@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 09:53:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUdVp-0004p4-3e
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 09:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbZBDIwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 03:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbZBDIwK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 03:52:10 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:2547 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbZBDIwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 03:52:09 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Feb 2009 09:52:07 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Feb 2009 09:52:06 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <7vljsm9492.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 04 Feb 2009 08:52:07.0027 (UTC) FILETIME=[DBB07430:01C986A5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108316>

--nextPart3813377.g2HbkvW7NZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > Junio C Hamano wrote:
> >
> >> Hmm, you could trigger the action immediately after seeing _enough_ nu=
mber
> >> of characters to disambiguate instead of stop-and-prompt, I guess?  Th=
at
> >> way, you would get a single-key merely as a degenerate case when the
> >> choices are all distinct.
> >
> > I don't think that's very nice.  On the one hand, you'd really want to
> > allow the user to delete some of the input again if he decides to do
> > something else instead, and we'd either need readline or need to
> > reinvent it for that....
>=20
> But doesn't the original "single-keypress" theme shares that problem
> anyway?  It trades the ability to "delete some of the it again if he
> decides to" away, in exchange for something else (probably "quicker input"
> or "perceived ease of use").

I don't think so: With the single-key input, you _know_ that whatever
key you press will be executed immediately.  In a prefix scheme, the
prompt might (you don't even know; you'll have to look and check) wait
for more input, but you cannot undo the choice even though it has not
been executed yet.

*shrug*

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3813377.g2HbkvW7NZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmJVyUACgkQqUud07tmzP1LygCghQPE3AHE2FQ0AfnFihVQNgUn
nCIAn0NTDAvZcnjlGDB445ECmImd/Jkk
=xQRP
-----END PGP SIGNATURE-----

--nextPart3813377.g2HbkvW7NZ--
