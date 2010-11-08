From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2] git-send-email.perl: fix In-Reply-To for second and
 subsequent patches
Date: Mon, 8 Nov 2010 12:03:08 +0100
Message-ID: <20101108120308.df67214e.ospite@studenti.unina.it>
References: <20101015095651.b75c4b54.ospite@studenti.unina.it>
	<1287481964-8883-1-git-send-email-ospite@studenti.unina.it>
	<7v4oci11k6.fsf@alter.siamese.dyndns.org>
	<20101020004533.b64d446c.ospite@studenti.unina.it>
	<20101105214159.GA4457@burratino>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__8_Nov_2010_12_03_08_+0100_6EnwV8g40VhFr_YL"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 12:06:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFPYl-0005C4-1X
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 12:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab0KHLGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 06:06:42 -0500
Received: from smtp205.alice.it ([82.57.200.101]:43136 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190Ab0KHLGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 06:06:41 -0500
Received: from jcn (87.6.149.78) by smtp205.alice.it (8.5.124.08) (authenticated as fospite@alice.it)
        id 4C1A264509B8EC7F; Mon, 8 Nov 2010 12:03:16 +0100
In-Reply-To: <20101105214159.GA4457@burratino>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160925>

--Signature=_Mon__8_Nov_2010_12_03_08_+0100_6EnwV8g40VhFr_YL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Nov 2010 16:41:59 -0500
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Hi Antonio,
>=20
> Antonio Ospite wrote:
> > Junio C Hamano <gitster@pobox.com> wrote:
>=20
> >> You are breaking the && chain here.
> >
> > Some other tests do that as well, the last line is a command by
> > itself not and-chained with the git-send-email invocation. I guess the
> > logic behind this is that the test succeeds if the _last_ command
> > succeeds. If this is wrong then some other tests are affected too.
>=20
> Yes, breaking the && chain is never a good thing.
>=20
> See:
>=20
>  - t/README: "Chain your test assertions"
>  - v1.5.4~20 (t9001: add missing && operators, 2008-01-21)
>  - git log --grep=3D&&
>=20

Thanks Jonathan, I am fixing that also to some other tests in t9001
right now.

Let me know if the v3 in this series is going to be applied as is, so I
can fix the newly added test too. If a v4 is needed than I'll fix my
test there.

I would also like to point your attention on tests like
"confirm by default (due to cc)" and following in t9001, which are
storing return value of an intermediate command, how to fix those?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__8_Nov_2010_12_03_08_+0100_6EnwV8g40VhFr_YL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzX2OwACgkQ5xr2akVTsAGttQCeLDXlMY4yjl0xJTeXKRLIDLvh
fF8AoK8OWF+7N9PwixeyeH/weP/j0a6+
=PABH
-----END PGP SIGNATURE-----

--Signature=_Mon__8_Nov_2010_12_03_08_+0100_6EnwV8g40VhFr_YL--
