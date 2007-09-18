From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: testsuite problems
Date: Tue, 18 Sep 2007 21:35:48 +0200
Message-ID: <20070918193548.GB10067@genesis.frugalware.org>
References: <20070917211742.GF19019@genesis.frugalware.org> <46EEF6A8.1030308@lsrfire.ath.cx> <20070917220408.GG19019@genesis.frugalware.org> <46EFE75D.7000805@lsrfire.ath.cx> <20070918155214.GQ19019@genesis.frugalware.org> <46F0054F.8060503@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:36:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXira-0003DK-Hi
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 21:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbXIRTf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 15:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbXIRTf5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 15:35:57 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:34032 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341AbXIRTf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 15:35:57 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IXirP-00086M-Hy
	from <vmiklos@frugalware.org>; Tue, 18 Sep 2007 21:35:51 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F19181678013; Tue, 18 Sep 2007 21:35:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46F0054F.8060503@lsrfire.ath.cx>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=BAYES_00,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58630>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2007 at 07:05:19PM +0200, Ren=E9 Scharfe <rene.scharfe@lsrf=
ire.ath.cx> wrote:
> Well, looks OK to me at least.  The Debian package (and thus Ubuntu's
> too) has a symlink related fix, from Christian Spieler, no less:
>=20
>   http://packages.debian.org/changelogs/pool/main/u/unzip/unzip_5.52-9/ch=
angelog
>   http://ftp.de.debian.org/debian/pool/main/u/unzip/unzip_5.52-9.diff.gz
>=20
> Perhaps this is missing from your version?

that was the problem. using vanilla unzip works fine, or after applying
the two security fixes a small patch is needed.

for the archives, here is the small patch that fixed the problem:

http://git.frugalware.org/gitweb/gitweb.cgi?p=3Dfrugalware-current.git;a=3D=
commit;h=3Dc27277b2354b9ed4d6b0fbdb988643ad203f73c8

so the problem is not git-related

sorry for the noise and thanks for your help :)

- VMiklos

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG8CiUe81tAgORUJYRAn6kAKCCvy1/E0T0vQ1vpS9BxNZI38SzuQCgqY+h
uB2TYNxEXEWjhem05Myh8OU=
=L4Qo
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
