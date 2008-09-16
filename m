From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: replace [^~] with escapes everywhere
Date: Tue, 16 Sep 2008 02:05:19 +0200
Message-ID: <200809160205.23371.trast@student.ethz.ch>
References: <1221470398-8698-1-git-send-email-trast@student.ethz.ch> <1221470398-8698-3-git-send-email-trast@student.ethz.ch> <32541b130809151656n4f39018fu2045eb6280d6da00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3402142.n7vD2WKXPr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 02:06:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfO5T-0001h6-Vz
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 02:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbYIPAF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 20:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbYIPAF1
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 20:05:27 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:59951 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754151AbYIPAF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 20:05:27 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 02:05:24 +0200
Received: from [192.168.0.7] ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 02:05:24 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <32541b130809151656n4f39018fu2045eb6280d6da00@mail.gmail.com>
X-OriginalArrivalTime: 16 Sep 2008 00:05:24.0800 (UTC) FILETIME=[EB0C8C00:01C9178F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95962>

--nextPart3402142.n7vD2WKXPr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Avery Pennarun wrote:
> Rather than uglifying all the documentation to work around the syntax,
> perhaps we just want to disable subscripts and superscripts
> altogether?  I can't really imagine the git documentation needing
> them.
>=20
> To do so, we can add these lines to asciidoc.conf (I just did this on
> another project yesterday, but I haven't tested in git.git):
>=20
> [replacements]
> # Disable superscripts.
> \^(.+?)\^=3D^\1^
> # Disable subscripts.
> ~(.+?)~=3D~\1~

That's indeed a far superior solution.  I withdraw my patches in
favour of this.

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart3402142.n7vD2WKXPr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjO+EMACgkQqUud07tmzP1SnACeNDJyanQe5bAg32KtgCJ9qO8M
0TEAniMST1tMt36y8RZJg7zhkr8i9XFZ
=iIGr
-----END PGP SIGNATURE-----

--nextPart3402142.n7vD2WKXPr--
