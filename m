From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Mon, 6 Jan 2014 07:58:49 -0800
Message-ID: <20140106155849.GS3156@odin.tremily.us>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com>
 <20140105203349.GB3737@book.hvoigt.net>
 <CALas-ijydCqhx5mgmMkcBE73TqNVckRooZ5x22uSq1Ldm4CGDA@mail.gmail.com>
 <20140106141805.GB27265@t2784.greatnet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ffBYM5qgR8HH9Mta"
Cc: Francesco Pretto <ceztko@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 16:59:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0CZu-0005wf-J1
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 16:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbaAFP6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 10:58:54 -0500
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:51279
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753572AbaAFP6x (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 10:58:53 -0500
Received: from omta15.westchester.pa.mail.comcast.net ([76.96.62.87])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id Aepc1n00A1swQuc59fysvY; Mon, 06 Jan 2014 15:58:52 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta15.westchester.pa.mail.comcast.net with comcast
	id Afyr1n00U152l3L3bfysCA; Mon, 06 Jan 2014 15:58:52 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 1866AE90D36; Mon,  6 Jan 2014 07:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389023930; bh=tLbbo3z91Zs5b7c0BCd4heNeAaKSPUFYGxf6ldi/cvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I4V6Qlfo2m9mBExE5zDfTrK/hbpymKM5/pjYLJLbEzKgjF/ssYKytrmTqjoYaS2D4
	 R2NN1ExmibeEVtc9QfRYB0OQA6ORCaaqBZEasTdAGivWBepq6EsRYgsvOCsPmw7DOB
	 Ze//qAPHbXPt1ce+TPjPtDAGEqdH7cy7Y2kzy6qc=
Content-Disposition: inline
In-Reply-To: <20140106141805.GB27265@t2784.greatnet.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389023932;
	bh=1Ga+Ob+tYZ+Z+ZeK40EiJen3veo0iGLnitOBsBHUMTY=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=Pzs0OLCUQZpcBiQdNCXzGxTWQj7p2f8O2RFEiLXH8ZrofqfabDXiydhz5Xk0CUWoL
	 nR0OYu7aOaBjDbE/3DaZBmDdfiBb72H0PE47B6IiOP4Sy6PiZtmG2lVf2IO7oqNcUz
	 eltK9T3I16ByQCtIGGcAzkTgMoUSzo5tYyqGJn3NHEw5+bYrOGe8QenL4zRN6g+pW+
	 Byec5DYGBPUHbZLXsPch+UO1aFOYNFfD32vp3/oJdrlXhXxNOzRbI8WgQ3fNHNkMR/
	 I9I9vVAU6UaG1ueZrMKeTZ7EG7spqq+G2uAuomsAPNKZjdXCdqcFTQiCPKmrHPj32l
	 /gotT6j31n3QA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240019>


--ffBYM5qgR8HH9Mta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 03:18:05PM +0100, Heiko Voigt wrote:
> If you simply want to always checkout the development tip of some
> project you could do something like this:
>=20
> 	git submodule foreach 'git fetch && git checkout origin/master'

Or (respecting submodule.<name>.branch):

  $ git submodule update --remote

You can even:

  $ git submodule update --remote --recursive

whenever you get an itch to upgrade everything everything in one
sweeping, hard-to-debug move ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--ffBYM5qgR8HH9Mta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSytK3AAoJEKKfehoaNkbtsmMQAJJMF56oCruv1mIuvEkEOlic
XuaHTKZXRoAPS76MQozgyJ6+k8YVBsW3eyezu2mNs1TU0p1lz1qHiy0sjte62bLS
9qsAaqu3/xoWi60t4y7uxRchkHFHEi1d0FwOeJ8lX0rTtRT0IanzWAZILsozpIv+
84fQNAzEJCkQhaFytwGBbwjCtsqXXZ1aMTZ/rGznzGdAOO33Lzh4DdohScQJHVas
Z3c2K6XiJa+avRANyjZyIgUOJKwhu45rmlIbv/OuuD9jMJbmrUe3KlXweT0R2/f+
UfRomE0rcv7BdZq1kmox8e5WHYv6Ho0tyr1QPs28Sw86fOJPfEyLFqfSOLBD+AI2
tzEeOKYYJyEjIi6QYy0e25wc43jxnVUWVf9sVcffEV480sdflH3TzyIVg6JlUYI1
RRle76pPxt2PCpaMIUnkD1B0ftxwSINakv6w3opfJk+zecx0yu9JhXaNpMdkL1kM
pgDPnxCuXNSY7JQ1J27DkJWbgkQ0CEpFOaCEotVFYNJZ9EDEQYgGx8wEDPaxT9bZ
+ZbWk6cjj7iVlE7vWT/c+ZNIiIFUKCtKt7DPHz/VfywtfmoeLSVeycmmWutW3JfO
YPJs8xQ9lHSCmJeBgykR0mm4hcj2WsqehALgpXaPqnYFSz0mL/CwrM+AzJJuW6GP
yKtpNHOHd26I9Pt8lDdx
=8+ol
-----END PGP SIGNATURE-----

--ffBYM5qgR8HH9Mta--
