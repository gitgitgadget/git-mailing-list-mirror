From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCHi v4] git-send-email.perl: make initial In-Reply-To apply
 only to first email
Date: Fri, 12 Nov 2010 23:51:00 +0100
Message-ID: <20101112235100.efad9631.ospite@studenti.unina.it>
References: <7v62w5hsd4.fsf@alter.siamese.dyndns.org>
	<1289573708-18573-1-git-send-email-ospite@studenti.unina.it>
	<7v1v6qfc9e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__12_Nov_2010_23_51_00_+0100_tXb7U7I6Mh4PRAvB"
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 23:51:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH2Sx-0006MW-J6
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 23:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab0KLWv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 17:51:26 -0500
Received: from smtp208.alice.it ([82.57.200.104]:48347 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757601Ab0KLWvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 17:51:25 -0500
Received: from jcn (87.3.146.122) by smtp208.alice.it (8.5.124.08) (authenticated as fospite@alice.it)
        id 4C1A271609FD5644; Fri, 12 Nov 2010 23:51:09 +0100
In-Reply-To: <7v1v6qfc9e.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161366>

--Signature=_Fri__12_Nov_2010_23_51_00_+0100_tXb7U7I6Mh4PRAvB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Nov 2010 13:44:13 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ospite@studenti.unina.it> writes:
>=20
[...]
> I'll do the obvious fix-up (below) at my end, so if there is nothing else
> there is no need to resend.
>
>     Look at the v2 series in the illustration to see what the new behavior
>     ensures:
>=20
>            (before the patch)          |      (after the patch)
>      [PATCH 0/2] Here is what I did... | [PATCH 0/2] Here is what I did...
>        [PATCH 1/2] Clean up and tests  |   [PATCH 1/2] Clean up and tests
>        [PATCH 2/2] Implementation      |   [PATCH 2/2] Implementation
>        [PATCH v2 0/3] Here is a reroll |   [PATCH v2 0/3] Here is a reroll
>        [PATCH v2 1/3] Clean up         |     [PATCH v2 1/3] Clean up
>        [PATCH v2 2/3] New tests        |     [PATCH v2 2/3] New tests
>        [PATCH v2 3/3] Implementation   |     [PATCH v2 3/3] Implementation
>=20
[...]

Thanks for taking care of that, I won't forget the lesson.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__12_Nov_2010_23_51_00_+0100_tXb7U7I6Mh4PRAvB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzdxNQACgkQ5xr2akVTsAGM/wCdE/FZvt8eZjXkH2k7MIhxdUGP
i4oAnRP9RhSFUT6R7Cm16lovmgP1/iLD
=qQvm
-----END PGP SIGNATURE-----

--Signature=_Fri__12_Nov_2010_23_51_00_+0100_tXb7U7I6Mh4PRAvB--
