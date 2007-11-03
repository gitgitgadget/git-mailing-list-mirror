From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 5/5] Migrate git-am.sh to use git-rev-parse --parseopt
Date: Sat, 03 Nov 2007 13:05:41 +0100
Message-ID: <20071103120541.GB13417@artemis.corp>
References: <1194043193-29601-1-git-send-email-madcoder@debian.org> <1194043193-29601-2-git-send-email-madcoder@debian.org> <1194043193-29601-3-git-send-email-madcoder@debian.org> <1194043193-29601-4-git-send-email-madcoder@debian.org> <1194043193-29601-5-git-send-email-madcoder@debian.org> <1194043193-29601-6-git-send-email-madcoder@debian.org> <20071103095556.GB2853@steel.home> <20071103115445.GA13417@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Yylu36WmvOXNoKYn";
	protocol="application/pgp-signature"; micalg=SHA1
To: Alex Riesen <raa.lkml@gmail.com>, gitster@pobox.com,
	torvalds@linux-foundation.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 13:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHlG-0003Ma-Eq
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbXKCMFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbXKCMFn
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:05:43 -0400
Received: from pan.madism.org ([88.191.52.104]:46105 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbXKCMFn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:05:43 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F239127EBA;
	Sat,  3 Nov 2007 13:05:41 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id AA8018525; Sat,  3 Nov 2007 13:05:41 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>, gitster@pobox.com,
	torvalds@linux-foundation.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071103115445.GA13417@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63244>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 03, 2007 at 11:54:45AM +0000, Pierre Habouzit wrote:
> On Sat, Nov 03, 2007 at 09:55:56AM +0000, Alex Riesen wrote:
> > Pierre Habouzit, Fri, Nov 02, 2007 23:39:52 +0100:
> > > diff --git a/git-am.sh b/git-am.sh
> > > index 2514d07..e5ed6a7 100755
> > > --- a/git-am.sh
> > > +++ b/git-am.sh
> > ....
> > > -	usage ;;
> > > -	*)
> > > -	break ;;
> > > +		-i|--interactive)
> > > +			interactive=3Dt ;;
> > > +		-b|--binary)
> > > +			binary=3Dt ;;
> >=20
> > Did you really have to change the indentation?
>=20
>   Well, I'm unsure what the standard is for git, I gladly use any
> indentation, I don't really care. I assumed that it wasn't indented
> before becauuse instead of -i|--interactive you had:
>=20
>   -i|--in|--int|....|--interactive which took a lot of space, as it
> seemed to me that the case ".." in foo) esac construction in git had the
> cases indented in most places. But I may be wrong.

  Okay seems I was wrong, sorry then, that wasn't done on purpose at
all.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLGQVvGr7W6HudhwRAt9DAJ4wWJigVmdYfB5JIRTixTK+rLpjmgCePIuz
kh2NyvLychTrNOQ+tBDvvNU=
=8gTh
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
