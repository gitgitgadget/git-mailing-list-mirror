From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: files are disappearing in git
Date: Fri, 25 Nov 2005 11:30:48 +0100
Message-ID: <20051125103048.GB30691@schottelius.org>
References: <20051123142303.GJ22568@schottelius.org> <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org> <20051124084633.GA3361@schottelius.org> <43866EDA.9050203@michonline.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Cc: Linus Torvalds <torvalds@osdl.org>, Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 11:33:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efarb-0007Lg-Va
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 11:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVKYKa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 05:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVKYKa5
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 05:30:57 -0500
Received: from wg.technophil.ch ([213.189.149.230]:53665 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751435AbVKYKa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 05:30:56 -0500
Received: (qmail 32454 invoked by uid 1000); 25 Nov 2005 10:30:48 -0000
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <43866EDA.9050203@michonline.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12732>


--mvpLiMfbWzRoNl4x
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ryan Anderson [Thu, Nov 24, 2005 at 08:54:34PM -0500]:
> Nico -telmich- Schottelius wrote:
> > Linus Torvalds [Wed, Nov 23, 2005 at 09:20:28AM -0800]:
>  >>Is the tree public so that we can look at it and perhaps make a guess
> from
> >>what happened around it?
> >=20
> >=20
> > I am sorry it is not. Perhaps I can convince my boss to allow access to=
 it for
> > some git developers, so someone could debug it. Thought, every informat=
ion
> > found in the tree would have to be treated confidental.
> >=20
> > Do you have some other hints on how to debug that? Perhaps some coniste=
ncy checking
> > tool?
> >=20
> > Or perhaps should I put that git directory under cvs? ;-)
>=20
> Is there anything in the directory structure that would be confidential?

The problem is that this is a project developed for a single company in
switzerland which uses it to manage elevators. We are right before to relea=
se
it and switch the customer away from MS Access to our program. It is curren=
tly
not clear, which license applies after the customer uses it, because he is =
interested
that some people should not use the software.

As soon as this is clearified the software may even become GPLed, but curre=
ntly
I may not publish it public.

> Can you maybe provide the output of "git-whatchanged" (with no
> parameters) or maybe
>=20
> 	git-whatchanged $commit1..$commit2 path/

If I do it as you described, I get the usage of git-rev-list:

[11:01] srsyg01:walderlift% git-whatchanged 4cc7ff0cb20df228e4db467114c1c67=
b0933592a..cfd54ffd2aa8e44ff5c341030e9c5f22fbbc7f9f Code/Spikes/       =20
usage: git-rev-list [OPTION] <commit-id>... [ -- paths... ]

I junh did git-whatchanged and stripped it manually. I included the initial
commit until the commit when it is gone. See attached file.

> If the output of one of those commands, which will be commit objects +
> tree differences, is less problematic, perhaps that would be easier to
> share?

I think this could be done.

Nico

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=git-log
Content-Transfer-Encoding: quoted-printable

diff-tree 056c65efea28066b7b241240f0d8421d3204b624 (from 7a9b0a3d72bc4f5417=
f3aecb9ca41c7dd5389ca9)
Author: Hansj=F6rg Hassler <hhassler@srsyg03.(none)>
Date:   Thu Nov 17 14:05:51 2005 +0100

    Bug 195 - Tagesarbeitsplan: Nur eine Wartung pro Seite
   =20
    Description:     	 Opened: 2005-05-01 20:23
   =20
    .. dies passiert manchmal. Wundi weiss angeblich warum.
   =20
    ------- Comment #1 From Daniel Wunderlin 2005-05-09 14:28 -------
   =20
    Nicht reproduzierbar, aber l=F6sbar: einfach Zeitbereich neu in
    Monatsterminierung generieren lassen
   =20
    ------- Comment #2 From Fabian Hernandez 2005-11-01 14:06 -------
   =20
    der bug ist pl=F6tzlich wieder aufgetreten.
   =20
    1.0 - Beta(Build 29.10.2005 15:00:07)
    lw26
   =20
    ------- Comment #3 From Sven Leser 2005-11-02 06:38 -------
   =20
    *** Bug 348 has been marked as a duplicate of this bug. ***
   =20
    ------- Comment #4 From Hansjoerg Hassler 2005-11-17 13:02 -------
   =20
    Dieses kahm durch verunreinigungen der DB bei Updatvorg=E4ngen der
    Monatsterminierung.
    Das ganze Anzeigen/Speichern der Daten wurde bei der Monatsterminierung=
 neu
    =FCberarbeitet. nun werden Tagesdaten korrekt abgespeichert was eine
    Voraussetzung ist damit beim Erstellen eines Tagesplanes die Darstellun=
g stimmt
    (Seitenumbr=FCche)
   =20
    CGarbeitsplan: Nur eine Wartung pro Seite

:100644 100644 b876a90c52d4b48130450c0af5a11467b14d8410 175e435835deab5e36d=
c25c17c398f74c55dae9c M	Code/Components/Utilities/LW1Calendar.pas
:100644 100644 ab01a0ad119927394e0a0d108251626480cffaba 5c0b5587aff550af0eb=
8c584826cf877e0e22738 M	Code/lw1/Client/Terminierung/FeinTerminierungForm.p=
as
:100644 100644 b5e2bd6d55ae7a2d4a70c02c6d021d8d00b9db11 0b7551631f6c425b61d=
aa60495803d35616844eb M	Code/lw1/Client/Terminierung/FeinTerminierungForm.x=
fm

diff-tree dcd70e89dc7b2280260628fd699aa906c319c68f (from 10ad8267d77d78b615=
cf2560fb030dcc8b85c9ad)
Author: Peter Portmann <peterp@srsyg03.(none)>
Date:   Thu Nov 17 10:24:56 2005 +0100

    Bug 359 - Defektmeldungen ueberarbeiten
    Das Suchen nach den Defektmeldungen ist nun eingebaut. Das =C4ndern des
    Statuses ist noch nicht m=F6glich. Zus=E4tzlich wurden noch die neuen
    Berechtigungen eingef=FCgt.

:100644 100644 0b3b339507a4199f1484d4981bdf4ee31770ec4f 1e8a27a3dfbac681a84=
2e4ac3b17caeba687cd28 M	Code/lw1/Client/Constants.pas
:100644 100644 0047fba049e1fb4a40a0a6385c9acb7f4fb7afbb 7381ca88f1741441bb4=
f8c3012f1655a1e43b438 M	Code/lw1/Client/DefektMeldung/DefektSearchForm.pas
:100644 100644 4a42ca39f4c74aedc32ac284240184284a05e8a0 d5234e556b2f7c671c7=
9bb133c08b1f49ab1b93b M	Code/lw1/Client/DefektMeldung/DefektSearchForm.xfm
:100644 100644 cb318c4231eb760ff0e6e8f0741b4eb0d68d46f3 0ae36dc7fc3d7740e79=
8b41d72452bab99e450ae M	Code/lw1/Client/MainForm.pas
:100644 100644 6d61131a11188762ac0f342afb820bc7aedb7079 e713a756a93da1d97fa=
ce30ee7298a062b66e4a7 M	Code/lw1/Client/MainForm.xfm

diff-tree 10ad8267d77d78b615cf2560fb030dcc8b85c9ad (from f1680a99ba34062c23=
060da1339898779f9a7a69)
Author: Peter Portmann <peterp@srsyg03.(none)>
Date:   Thu Nov 17 10:20:41 2005 +0100

    Datenbank auf lw29 umgestellt.

:100644 100644 fc46e27179ae8b3fb5b8c590988b7b5c905509e4 c3a5e848d4d43111f63=
ad86d5a6773ae81ca75e3 M	Code/lw1/Client/MainDataModule.xfm
:100644 100644 f1018c16eea62a15b3166c193a63dd52bd7cc5d8 048f85089d3e924848a=
9a29a5ee4eb36afcaafa3 M	Code/lw1/Client/lw1.conf

diff-tree f1680a99ba34062c23060da1339898779f9a7a69 (from 9e9b91166bfca448a8=
f1ddeb4580d73ac8ea0986)
Author: Peter Portmann <peterp@srsyg03.(none)>
Date:   Thu Nov 17 10:19:25 2005 +0100

    Neues Icon f=FCr lw1. Danke an Fabian Hernandez!

:000000 100644 0000000000000000000000000000000000000000 24f8254c06ea5efc899=
44a3a9f52d2c79c841c0b A	Code/lw1/Client/Pics/icon/lw1-icon.png

diff-tree 9e9b91166bfca448a8f1ddeb4580d73ac8ea0986 (from b4d9c2fc8df035a340=
e675fa405ad942b032830b)
Author: Peter Portmann <peterp@srsyg03.(none)>
Date:   Tue Nov 15 11:31:08 2005 +0100

    Neuer Spike: Statistik f=C3uer Auswertung.

:000000 100644 0000000000000000000000000000000000000000 5c8c47d855ee0f78a7f=
b81c4a49224b1607a88b7 A	Code/Spikes/Statistik/Project.dpr
:000000 100644 0000000000000000000000000000000000000000 7bd2de9b7142999bc6b=
badde06e73267d1b5ee0e A	Code/Spikes/Statistik/Statistik.pas
:000000 100644 0000000000000000000000000000000000000000 a0fb45e2b906bdac792=
9cfd8174053015ab629b4 A	Code/Spikes/Statistik/Statistik.xfm

--uQr8t48UFsdbeI+V--

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ4bn17OTBMvCUbrlAQJMmA//akQLPF1ccoK2LqE9pWidW/F+SGdJZhFW
DgmNKezZnmBKJMDgeIt8sN0WjZgquFw2WEi+GpL/rZPtKSJW2tz3P2JvNQw2PfB+
n1Vf10tQvTYKC0kE5G63Ud2jYHwh1agWrrqdpQ+tOOOrvaAW1HeW64MTrSs0uzAX
CeXvrvzGdZ9SWRJELvw1jd7/76lBUAg7LT9yxwFH7Hzh+T9ZJjwKm3Hc4xjkQQjj
b1PwZ3MmXELR98sbw+IuYJr0hr/lVNLDtATZCauZJYYiNgBPK3KtiiGgK/nStGmn
BmJ+y6W6Atx1s8e4sDaYZMwVYsqTp3Ycu0E68Qgv9FAVz8Votf6Sd9eRoMVKJP7r
ZphrOp1nuF2DH0TnX+Vqon8elQ2Q/RWXs1aEQSZNKUm4HgGch5NXEjOx9VUu+r6Y
MqsXmKHIn3QOW9IVO+Va+WrHA1HeHwk1h1I3dlxNeLLCqkmF1MC6RIrssQj1idHr
V6j8P9QM7YmEc0qd2HQrFYen5Yqb1eVbWJ7LyU1HD/ApsxP0Wh8ACXChcvFS0dsg
85DPnIYJZj2odUFzyThoDZsq12hz4Y7YBEoO7c+cWwJzFziU8JUimpsPsPx/+Yml
ErEVAtg9woaXBTNFqbtgwDn5mWGikq5+wAe8lkfIsAHYrRp4D4oOTNk1Jy8kHn+w
tDzZZqqs+R0=
=R7LJ
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
