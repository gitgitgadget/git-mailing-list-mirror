From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Feature idea: git rebase --exec $CMD
Date: Sat, 5 May 2012 13:26:50 +0200
Message-ID: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__5_May_2012_13_26_50_+0200_88hq22NYjxs/ahKg"
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 13:32:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQdDt-0006Y3-AU
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 13:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993Ab2EELcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 07:32:20 -0400
Received: from smtp206.alice.it ([82.57.200.102]:55728 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754912Ab2EELcU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 07:32:20 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 May 2012 07:32:19 EDT
Received: from jcn (87.3.148.9) by smtp206.alice.it (8.6.023.02) (authenticated as fospite@alice.it)
        id 4F9BF1D300BD0F6D; Sat, 5 May 2012 13:26:52 +0200
X-Mailer: Sylpheed 3.2.0beta7 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197105>

--Signature=_Sat__5_May_2012_13_26_50_+0200_88hq22NYjxs/ahKg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I find the x/exec function in "git rebase -i" very useful, but it may
be tedious to edit the commit list to add something like "make test"
after each commit.

Can this functionality be exposed from the command line as well?
I am thinking to a [-x|--exec <command>] options which accepts a command
as an argument, and executes such command after each commit in the list
of commits which are going to be rebased, and stops the rebasing if the
command returns a non-0 value.

Maybe this -x option should conflict with -i to simplify its "execute
the command after each commit" semantics (what if it is combined with -i
and 'x/exec' lines?).

I can draft the man page section for it, but I doubt I can work on the
code for now, so I wanted to throw the idea here and see if anyone else
wants to pick it up.

I read that calling a "make test" command after each commit could be
done using "git rev-list" like in
http://sethrobertson.github.com/GitPostProduction/gpp.html#post-post-produc=
tion
but a more friendly way to do that from CLI would be great.

Thanks,
   Antonio

P.S. I am not subscribed to the list, please CC me.

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Sat__5_May_2012_13_26_50_+0200_88hq22NYjxs/ahKg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+lDnoACgkQ5xr2akVTsAEqQgCfYh77Uic5z/jB8S7fhgQEYX4m
nxsAniH3xlK2IwxUKZZVitWL1Kq+FHB0
=BDKq
-----END PGP SIGNATURE-----

--Signature=_Sat__5_May_2012_13_26_50_+0200_88hq22NYjxs/ahKg--
