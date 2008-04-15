From: Nico Schottelius <nico-git-20080415@schottelius.org>
Subject: Re: [new tool] git-project-version.sh
Date: Tue, 15 Apr 2008 14:52:09 +0200
Message-ID: <20080415125209.GC17459@denkbrett.schottelius.org>
References: <20080415113629.GA17459@denkbrett.schottelius.org> <20080415120507.GB21572@bit.office.eurotux.com> <20080415113629.GA17459@denkbrett.schottelius.org> <8aa486160804150501p2f55a3e9g33df94c1d4274e48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Cc: Nico -telmich- Schottelius <nico-git-20080415@schottelius.org>,
	git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 14:51:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlkcy-0001sO-JD
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 14:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbYDOMu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 08:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbYDOMu2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 08:50:28 -0400
Received: from [62.65.138.77] ([62.65.138.77]:53767 "EHLO mx2.schottelius.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbYDOMu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 08:50:27 -0400
Received: from denkbrett.schottelius.org (natgw.netstream.ch [62.65.128.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id C515A25B125;
	Tue, 15 Apr 2008 14:50:21 +0200 (CEST)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id 0F80C1D0F1; Tue, 15 Apr 2008 14:52:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080415120507.GB21572@bit.office.eurotux.com> <8aa486160804150501p2f55a3e9g33df94c1d4274e48@mail.gmail.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.24.3-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79596>


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Santi B=E9jar [Tue, Apr 15, 2008 at 02:01:06PM +0200]:
Luciano Rocha [Tue, Apr 15, 2008 at 01:05:07PM +0100]:
> [...git describe...]

Looks also quite nice, also added it to the blog entry,
but it seems to work wrong here:

The last tag I created on the master branch is called 1.20.3pre6,
but git-describe uses pre5:

[14:39] denkbrett:gpm% git-describe=20
1.20.3pre5-17-gfccc331
[14:43] denkbrett:gpm% git tag=20
1.20.3pre1
1.20.3pre2
1.20.3pre3
1.20.3pre4
1.20.3pre5
1.20.3pre6
1.99.0
1.99.1
1.99.2
1.99.2.1
1.99.2.2
1.99.3
1.99.4
1.99.5
[14:44] denkbrett:gpm% git branch =20
  gpm-1-stable
  gpm-2-dev
* master
[14:51] denkbrett:gpm% git --version
git version 1.5.4.4


Nico

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIBKT4uL75KpiFGIwRArGoAJ0WGIsEKoFuvWnIrw2qMBlqSPZh/wCdEVcx
Cs5sVSICfyB6HUN+gIP2/F4=
=nPZ6
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
