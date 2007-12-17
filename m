From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 7/7] git-tag: fix -l switch handling regression.
Date: Mon, 17 Dec 2007 20:03:28 +0100
Message-ID: <20071217190328.GF22554@artemis.madism.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org> <1197915797-30679-2-git-send-email-madcoder@debian.org> <1197915797-30679-3-git-send-email-madcoder@debian.org> <1197915797-30679-4-git-send-email-madcoder@debian.org> <1197915797-30679-5-git-send-email-madcoder@debian.org> <1197915797-30679-6-git-send-email-madcoder@debian.org> <1197915797-30679-7-git-send-email-madcoder@debian.org> <1197915797-30679-8-git-send-email-madcoder@debian.org> <20071217185652.GE22554@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="yRA+Bmk8aPhU85Qt";
	protocol="application/pgp-signature"; micalg=SHA1
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 20:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4LFt-00019G-Km
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 20:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760606AbXLQTDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 14:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760495AbXLQTDa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 14:03:30 -0500
Received: from pan.madism.org ([88.191.52.104]:40165 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760344AbXLQTD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 14:03:29 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 166063085B;
	Mon, 17 Dec 2007 20:03:29 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 77FCD37DE7A; Mon, 17 Dec 2007 20:03:28 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071217185652.GE22554@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68600>


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 06:56:52PM +0000, Pierre Habouzit wrote:
>   And I managed to resend the broken version, hurray myself.
>=20
> > +		OPT_INTEGER('l', NULL, &list, "list tag names"),
>                 OPT_BOOLEAN
>=20
>=20
>=20
> Both these last minute fixes are applied to my public git.git.
>=20
> Let's now write 1000 times: I will run the test-suite before I send
> patches, I will rune the test-suite before I send patches, =E2=80=A6

  oh and t7004 doesn't pass anymore because of the:

  git -n xxx -l or git -n "" -l tests. If we really want to allow that
(but it _REALLY_ feels wrong to me) we have to make '-l' a callback that
groks non integers as 0. Else the test also has to be fixed, I'm not
sure what to do here.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZsgAvGr7W6HudhwRAuF1AJwKcT1j+W/E9hVkKVaN5SghbpZWrACePZ80
ACSp5PVpjGOhkYylwRJHvXE=
=xzey
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
