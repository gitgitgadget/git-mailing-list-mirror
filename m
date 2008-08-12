From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] filter-branch: use --simplify-merges
Date: Tue, 12 Aug 2008 07:47:19 +0200
Message-ID: <200808120747.22228.trast@student.ethz.ch>
References: <7viqub9dzi.fsf@gitster.siamese.dyndns.org> <7vljz3t2ts.fsf@gitster.siamese.dyndns.org> <7v7iant1yx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1343318.E6vqctpQD8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 07:48:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSmjx-0003bv-B9
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 07:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbYHLFrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 01:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbYHLFrP
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 01:47:15 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:2992 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbYHLFrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 01:47:14 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 07:47:15 +0200
Received: from [192.168.0.4] ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 07:47:13 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7v7iant1yx.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Aug 2008 05:47:13.0401 (UTC) FILETIME=[DEAB7690:01C8FC3E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92069>

--nextPart1343318.E6vqctpQD8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> > Thomas Rast <trast@student.ethz.ch> writes:
> >
> >> -		ancestor=3D$(git rev-list -1 $ref -- "$filter_subdir")
> >> +		ancestor=3D$(git rev-list --simplify-merges -1 \
> >> +				$ref -- "$filter_subdir")
> >
> > Hmm, where does this preimage come from?
>=20
> Nevermind.  You based this on top of the "fix ancestor discovery" patch.
>=20
> I'll squash these two and queue them in 'pu' for now.

Please don't.  I'm still convinced the "fix ancestor discovery" is a
fix to current code that works independent of --simplify-merges.  If
you squash them, it cannot go into a release before --simplify-merges
even if I manage to convince Dscho of this.

Thanks.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart1343318.E6vqctpQD8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkihI+oACgkQqUud07tmzP14FACfYggVs60yPWoUtuAq0GnRmquh
bZYAnjjh2FiywBk/6JwurVfi5RiHRgEe
=ABDW
-----END PGP SIGNATURE-----

--nextPart1343318.E6vqctpQD8--
