From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] Pay attention to GIT_DIR when searching the git
	directory
Date: Mon, 5 May 2008 17:30:29 +0200
Message-ID: <20080505153029.GA12733@alea.gnuu.de>
References: <1209946178-29398-1-git-send-email-joerg@alea.gnuu.de> <alpine.DEB.1.00.0805051234260.30431@racer> <20080505125302.GA11523@alea.gnuu.de> <m3r6cg6dur.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 18:25:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt3VG-0001aX-VK
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 18:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbYEEQYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 12:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbYEEQYi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 12:24:38 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1392 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471AbYEEQYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 12:24:37 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 1B70448802C; Mon,  5 May 2008 18:24:35 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jt2e6-0004n5-BK; Mon, 05 May 2008 17:30:30 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jt2e5-0003Kq-LD; Mon, 05 May 2008 17:30:29 +0200
Content-Disposition: inline
In-Reply-To: <m3r6cg6dur.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81294>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Jakub Narebski schrieb am Mon 05. May, 07:10 (-0700):
> J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:
> > Johannes Schindelin schrieb am Mon 05. May, 12:36 (+0100):
>=20
> > > If you do not say _what_ is affected by the change, you only confuse
> > > the readers.
> >=20
> > Do you want something like =E2=80=9Cinitialization: Pay attention to GI=
T_DIR when
> > searching the git directory=E2=80=9D?
>=20
> I think the idea was to use
>   "contrib/hooks/setgitperms: Use GIT_DIR if set"
> or something like that.

Well, if this is the prefered form, I'll use it. But I don't like it,
because the affected file is a piece of information that's already in the
commit object. And it makes the :/ syntax useless, because in a series of
commits all commits start with the same string: the filename. Thirdly, in
gitk I've the problem that the space is very limited (because of my
screen) and it is very annoying to see the same string at the begin of
every commit message, especially when I've filtered for one file.

> > Is there a document with guidelines for commit messages, e.g. write the
> > first letter upper or lower case?
>=20
> There are a few unwritten conventions.

Are there any plans to write them down?

Should I resend the patch or can Junio fix the commit message? I would
take your suggestion.

Bye, J=C3=B6rg.
--=20
Geld allein macht nicht gl=C3=BCcklich, aber es ist besser in einem Taxi zu
weinen, als in der Stra=C3=9Fenbahn.
	       	   	       			(Marcel Reich=E2=80=90Ranicki)

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIHygVwe0mZwH1VIARAurkAJsEGTLFr7qmVLLyNoIYk/rPI+35IQCeIUK7
JcvdqWjcZzi1fi92gW0/AZY=
=snp9
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
