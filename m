From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-send-email: threaded view issue with Thunderbird
Date: Thu, 24 Aug 2006 10:42:59 +0200
Organization: Polytechnique.org
Message-ID: <200608241043.02731.madcoder@debian.org>
References: <20060824081228.69110.qmail@web25808.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart16769434.ng5MahAEAW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 10:43:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGAnx-0001uU-GR
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 10:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWHXInJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 04:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWHXInJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 04:43:09 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:15587 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S1750898AbWHXInH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 04:43:07 -0400
Received: from mad.intersec.eu (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id E7C5F331B6;
	Thu, 24 Aug 2006 10:43:03 +0200 (CEST)
To: moreau francis <francis_moreau2000@yahoo.fr>
User-Agent: KMail/1.9.3
In-Reply-To: <20060824081228.69110.qmail@web25808.mail.ukl.yahoo.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Thu Aug 24 10:43:04 2006 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000099, queueID=12C95331C5
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25948>

--nextPart16769434.ng5MahAEAW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le jeu 24 ao=C3=BBt 2006 10:12, moreau francis a =C3=A9crit :
> Hi,
>
> Sometimes, actually most of the time, git-send-email _seems_ to not
> work properly with Thunderbird: for example if I send a patchset made
> up by 4 single patchs, then Thunderbird show me this patchset
> 'broken' that is [PATCH 2/4] is not shown as a reply to [PATCH 1/4].
>
> For example I can see:
>
> [=E2=80=A6]
>
> [PATCH 0/7] C cleanup series, mostly nasty shadowing
>
> Does anybody have an idea on what's going wrong ?

here the problem is that I manually sent the 0/7 as the initial mail,=20
and passed its msg-id into --in-reply-to switch of git-send-email. but=20
I did not specified the brackets, and those were not added, meaning=20
that the reference was bad formatted.

I don't know where your other problems come from. What I know for sure=20
is that I will write my own git-send-email version, with less perl, and=20
less broken features, because the two first try I had with=20
git-send-email were quite inconclusive, doing all *but* what I wanted=20
them to do.

if it's not too crude, I will consider submit it to the list as a=20
possible replacement/competitor for git-send-email.
=2D-=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--nextPart16769434.ng5MahAEAW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE7WaWvGr7W6HudhwRAn2VAKCknsXJKbbFwKyKH1dhh7tSZ9p2zgCfRfVs
82sjERQlSR7XlpiDzoQrlkI=
=BN3p
-----END PGP SIGNATURE-----

--nextPart16769434.ng5MahAEAW--
