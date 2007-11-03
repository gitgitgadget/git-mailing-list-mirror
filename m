From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 5/5] Migrate git-am.sh to use git-rev-parse --parseopt
Date: Sat, 03 Nov 2007 12:54:45 +0100
Message-ID: <20071103115445.GA13417@artemis.corp>
References: <1194043193-29601-1-git-send-email-madcoder@debian.org> <1194043193-29601-2-git-send-email-madcoder@debian.org> <1194043193-29601-3-git-send-email-madcoder@debian.org> <1194043193-29601-4-git-send-email-madcoder@debian.org> <1194043193-29601-5-git-send-email-madcoder@debian.org> <1194043193-29601-6-git-send-email-madcoder@debian.org> <20071103095556.GB2853@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Dxnq1zWXvFF0Q93v";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 12:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHag-0000yN-EO
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbXKCLyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 07:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbXKCLyt
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:54:49 -0400
Received: from pan.madism.org ([88.191.52.104]:39417 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbXKCLys (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:54:48 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 69FF2283B4;
	Sat,  3 Nov 2007 12:54:46 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8589778A4; Sat,  3 Nov 2007 12:54:45 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>, gitster@pobox.com,
	torvalds@linux-foundation.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071103095556.GB2853@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63240>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 03, 2007 at 09:55:56AM +0000, Alex Riesen wrote:
> Pierre Habouzit, Fri, Nov 02, 2007 23:39:52 +0100:
> > diff --git a/git-am.sh b/git-am.sh
> > index 2514d07..e5ed6a7 100755
> > --- a/git-am.sh
> > +++ b/git-am.sh
> ....
> > -	usage ;;
> > -	*)
> > -	break ;;
> > +		-i|--interactive)
> > +			interactive=3Dt ;;
> > +		-b|--binary)
> > +			binary=3Dt ;;
>=20
> Did you really have to change the indentation?

  Well, I'm unsure what the standard is for git, I gladly use any
indentation, I don't really care. I assumed that it wasn't indented
before becauuse instead of -i|--interactive you had:

  -i|--in|--int|....|--interactive which took a lot of space, as it
seemed to me that the case ".." in foo) esac construction in git had the
cases indented in most places. But I may be wrong.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLGGFvGr7W6HudhwRAhMLAJ9xJVeBQo4ct1eFxT+sLifvCXXrxQCeK+2q
O/8fLGpfj37puVvEdCxBNHc=
=huRG
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
