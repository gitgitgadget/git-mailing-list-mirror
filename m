From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 02 Nov 2007 09:42:07 +0100
Message-ID: <20071102084207.GC20200@artemis.corp>
References: <20071022063222.GS14735@spearce.org> <20071102022335.GU18279@machine.or.cz> <200711020825.23464.jnareb@gmail.com> <200711020828.30969.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="SO98HVl1bnMOfKZd";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 09:42:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ins6i-0000z8-V2
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 09:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbXKBImL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 04:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbXKBImL
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 04:42:11 -0400
Received: from pan.madism.org ([88.191.52.104]:48110 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbXKBImK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 04:42:10 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F2FF327656;
	Fri,  2 Nov 2007 09:42:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 4534B34602B; Fri,  2 Nov 2007 09:42:07 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200711020828.30969.jnareb@gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63074>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2007 at 07:28:30AM +0000, Jakub Narebski wrote:
> Jakub Narebski wrote:
> > Petr Baudis wrote:
> > > On Fri, Nov 02, 2007 at 01:04:03AM +0100, Jakub Narebski wrote:
> >=20
> > >> Is 'getopts' bash-ism, or is it in POSIX?
> > >=20
> > > 	http://www.opengroup.org/onlinepubs/009695399/utilities/getopts.html
> > >=20
> > > (Also, most modern distributions have manpage section 1p (3p, ...) wi=
th
> > > the same contents, so you can check for this stuff pretty easily.)
> >=20
> > Thanks.
> >=20
> > I have just realized however that it doesn't help any (option parser
> > not only for C builtin, but also for shell scripts, Perl scripts and
> > Python scripts). First, we (the git development community) do not
> > consider fact that something is in POSIX as indicator that we can use
> > the construct. Second, getopts delas IIRC only with _short_ options.
>=20
> Just a thought:
>   http://www.systhread.net/texts/200704optparse.php

Well, I'm sure we could probably do the same with our own `git-parseopt`
tool, couldn't we ?

I'll try to give it a shot, and it'll have all the features shell-script
currently have at great costs of code length (like the lazy way to type
long options: -q|--q|--qu|--qui|...)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHKuLfvGr7W6HudhwRAqLZAJ9sJJTRXFLZsy6u3Xodfi0gL3+RbQCgh6oj
D9up9du3oZh3oiYyyCJQK38=
=QDcA
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
