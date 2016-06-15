From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Tue, 20 Jan 2009 09:57:50 +0100
Message-ID: <200901200957.54603.trast@student.ethz.ch>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <200901192317.23079.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1625846.Gjmq12dox8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 09:59:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPCRs-0004Xy-To
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 09:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbZATI5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 03:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbZATI5j
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 03:57:39 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24675 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726AbZATI5j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 03:57:39 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Jan 2009 09:57:37 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Jan 2009 09:57:37 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.18-0.2-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <200901192317.23079.bss@iguanasuicide.net>
X-OriginalArrivalTime: 20 Jan 2009 08:57:37.0331 (UTC) FILETIME=[245E9830:01C97ADD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106458>

--nextPart1625846.Gjmq12dox8
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Boyd Stephen Smith Jr. wrote:
> Is there anywhere you are publishing these refs?  Of course, I see the=20
> commits in 'pu', but sometimes I would like to merge something you have=20
> in 'next'/'pu' into a branch based on 'master' or one of my local=20
> branches, and I have to go hunting for the commit SHA.
[...]
> $ git pull origin jk/color-parse
> fatal: Couldn't find remote ref jk/color-parse

You could try the script I posted here:

  http://article.gmane.org/gmane.comp.version-control.git/106129

Just 'git resurrect -m jk/color-parse' and you should be good to go.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1625846.Gjmq12dox8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl1khIACgkQqUud07tmzP1VCACgk62c6ZFhaAqKDhu3X7Wmnvl/
YEEAniaSQzcMpCfDvc7aqW2nycm55NQf
=wVny
-----END PGP SIGNATURE-----

--nextPart1625846.Gjmq12dox8--
