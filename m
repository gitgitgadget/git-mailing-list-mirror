From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: /bin/sh portability question
Date: Sun, 25 Sep 2005 21:26:08 +0200
Message-ID: <20050925192608.GD19023@schottelius.org>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk> <7vzmq4faz6.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP05141C92C0F083A17B2EEFAE960@CEZ.ICE> <7vfyrwdtv0.fsf@assigned-by-dhcp.cox.net> <39450.10.10.10.28.1127471685.squirrel@linux1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 21:26:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJc8d-0004pl-FF
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 21:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVIYT0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 15:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVIYT0N
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 15:26:13 -0400
Received: from wg.technophil.ch ([213.189.149.230]:38062 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932278AbVIYT0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 15:26:12 -0400
Received: (qmail 19413 invoked by uid 1000); 25 Sep 2005 19:26:08 -0000
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <39450.10.10.10.28.1127471685.squirrel@linux1>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9280>


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sean [Fri, Sep 23, 2005 at 06:34:45AM -0400]:
> On Fri, September 23, 2005 5:19 am, Junio C Hamano said:
> > "Sean" <seanlkml@sympatico.ca> writes:
> >
> >> If not, would you accept a patch that first converted the shell scripts
> >> to
> >> #!/bin/bash and then added a "make install" option that allowed them to
> >> be
> >> replaced?   Something like "make install S=3D/bin/ash" for instance?
> >
> >     $ make SHELL_PATH=3D/bin/bash
> >
> > Perhaps?
> >
>=20
> Heh.. so you've already got that working :o)   So on Solaris one fix would
> be to just use the SHELL_PATH setting when installing to point to
> /bin/bash.   What do you think about making /bin/bash the default?

I think it's a bad idea, because some systems do not have and want bash,
because it's unneeded. On all systems here we've ash as /bin/sh and
/bin/zsh as primary user shell. Thus, /bin/bash does not exist, because
it's not as comfortable as zsh and not as small as ash.

Nico,
   who really likes man bash (very well documentated), but not the shell it=
self

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQzb5z7OTBMvCUbrlAQKB2Q//UprLM6bqeUdwxCSj5DmWHzuolEJ+JUne
4rFm4Ymujn5SMLLko8a3DqxrWsWW9E0aSNGQN2svaUrK09hAWarD0BTB4Pl28QVz
IVCaP/fOGsYzcecvk4RnIL/EKP/BibpQpgTkKCvuBXOoABVlV7Cn6m9Ul7RXQAq2
/ECRascNEBAO91XXBRPnep2zat1+uB8tiJWDMFyzt0ygq7V6yzXaTtSqcAZBeBYe
vuaqt4e2DomZskk95sozSi/PC99x3fgs8xslV7X/zsuUgGWGopib4wJkphlOuT8i
+QA/Fmr9eGjmZGVASeqXADAt2GQRuMeki/N9vgqLWaZG2hYQPn52m4BkK8vD65w7
b8oIZtpDVv0EWhkKLDU9KTZfAlEqljObvrYtcumo3iU7CZ4ED49ta1Dw1bEHLAK4
FgagbPRd3kv6ZC3s8FG6J3DYWsP7mvsf5KCNqkzmcp/OOrJt2vR40rK6lj3pHWX+
Cqk1ltZZXkv1Y4svoOj5DdM/fAqhhd8cCqI5MmA0z5AC2ueiiovU9IjuiDW0RkI1
FRX7VDSAXkAittdssgjVu1FVMnO9MIcA7BeTsZ24F563IifmBga8UxXQ/TJEZDd3
gQvH+E7JiMg6BRm9via48gKj9hQrB87U6IKxTvN7YyLqyIMWsm/05ItEskQn9++4
EQ7y+fD3xHY=
=MYUx
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
