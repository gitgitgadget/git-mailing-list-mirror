From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Feature idea: git rebase --exec $CMD
Date: Sun, 6 May 2012 12:44:20 +0200
Message-ID: <20120506124420.bc796b6e2852e6aec5da36d8@studenti.unina.it>
References: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
	<vpqobq1mxru.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__6_May_2012_12_44_20_+0200_y57ko_mQJ6YkEixl"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 12:44:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQyxE-0002BZ-Rk
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 12:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab2EFKog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 06:44:36 -0400
Received: from smtp207.alice.it ([82.57.200.103]:57599 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258Ab2EFKog (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 06:44:36 -0400
Received: from jcn (87.3.148.200) by smtp207.alice.it (8.6.023.02) (authenticated as fospite@alice.it)
        id 4F05A6650DF57D45; Sun, 6 May 2012 12:44:34 +0200
In-Reply-To: <vpqobq1mxru.fsf@bauges.imag.fr>
X-Mailer: Sylpheed 3.2.0beta7 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197166>

--Signature=_Sun__6_May_2012_12_44_20_+0200_y57ko_mQJ6YkEixl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 06 May 2012 12:03:49 +0200
Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> Antonio Ospite <ospite@studenti.unina.it> writes:
>=20
> > Maybe this -x option should conflict with -i to simplify its "execute
> > the command after each commit" semantics (what if it is combined with -i
> > and 'x/exec' lines?).
>=20
> Actually, implementation-wise, it's simpler to have '-x' imply '-i', and
> suggest a todo-list containing 'x' lines. Then, the code would simply
> have to add these "x whatever" lines, and let the
> "git-rebase--interactive.sh" mechanics do the job. That would show the
> "x whatever" lines to the user, but that can be seen as added value,
> since it gives an opportunity to the user to remove or edit some of them
> if needed.
>

Thanks Matthieu,

this sounds like a reasonable default behavior for the case of '-x' and
'-i' _combined_, but I still think '-x' with no invocation of $EDITOR
can have its use case (e.g. a "make validate-commits" calling 'git
rebase -x "make test" master').

But I'd like to hear other opinions about that.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Sun__6_May_2012_12_44_20_+0200_y57ko_mQJ6YkEixl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+mVgQACgkQ5xr2akVTsAF0LgCcDrYiwsgEaJ9NXIbOFOfti+N+
xBwAoJlY7ListR2TOA5q2rs/yoYFsHDR
=5YYS
-----END PGP SIGNATURE-----

--Signature=_Sun__6_May_2012_12_44_20_+0200_y57ko_mQJ6YkEixl--
