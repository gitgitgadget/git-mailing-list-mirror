From: Jan Hudec <bulb@ucw.cz>
Subject: Re: How-to setup an empty remote repository?
Date: Tue, 4 Sep 2007 21:47:49 +0200
Message-ID: <20070904194749.GB3786@efreet.light.src>
References: <d4cf37a60708251400t17b0a097t91f77cbb4e996810@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:48:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISeNV-0001gU-LL
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 21:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbXIDTr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 15:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbXIDTr5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 15:47:57 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:47455 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415AbXIDTr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 15:47:56 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 13EE75733F;
	Tue,  4 Sep 2007 21:47:55 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id kDa1RzAJe3V9; Tue,  4 Sep 2007 21:47:52 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 151AD5724B;
	Tue,  4 Sep 2007 21:47:51 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1ISeNJ-0004u0-TM; Tue, 04 Sep 2007 21:47:49 +0200
Content-Disposition: inline
In-Reply-To: <d4cf37a60708251400t17b0a097t91f77cbb4e996810@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57637>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 25, 2007 at 14:00:33 -0700, Wink Saville wrote:
> Hello,
>=20
> I thought I'd try to setup a shared "empty" remote repository and then
> clone it and then push the initial commit from another maching.
> This failed as shown below:
>=20
>  $ cd ~/git-repos
>  $ mkdir test.git
>  $ cd test.git
>  $ git --bare init --shared
>  Initialized empty shared Git repository in /home/wink/git-repos/test.git/
>  $ git-daemon --reuseaddr --verbose --base-path=3D/home/wink/git-repos \
>     --export-all --enable=3Dreceive-pack
>=20
> On my other machine:
>=20
> $ git clone git://192.168.0.8/test.git
> Initialized empty Git repository in /home/wink/prgs/test/.git/
> fatal: no matching remote head
> fetch-pack from 'git://192.168.0.8/test.git' failed.
> $

Did it configure the repository though? Like setting the url and tracking
branches for origin? If it did, it actually did all you needed, so you can
count it as success (and the message should talk about having nothing to do
rather than failing).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3bZlRel1vVwhjGURAnqaAKCYLd+DzBeZN4gqU9ZpigvnKrTdYACgsKaY
FyhwJjhyMd2YgwkNDItwRQo=
=miQE
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
