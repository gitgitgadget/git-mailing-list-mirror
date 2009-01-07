From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Wed, 7 Jan 2009 00:27:17 -0600
Message-ID: <200901070027.21721.bss@iguanasuicide.net>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com> <20090106080300.GA10079@coredump.intra.peff.net> <slrngm6hoj.n4a.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3770615.AuIvVuBkf7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 07:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKRuS-000118-Bb
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 07:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbZAGG10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 01:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbZAGG10
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 01:27:26 -0500
Received: from eastrmmtao107.cox.net ([68.230.240.59]:40870 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbZAGG1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 01:27:24 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090107062722.GNFG23750.eastrmmtao107.cox.net@eastrmimpo01.cox.net>;
          Wed, 7 Jan 2009 01:27:22 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id 0WTN1b0062i4SyG02WTPXS; Wed, 07 Jan 2009 01:27:23 -0500
X-Authority-Analysis: v=1.0 c=1 a=XIUFG8x78GMA:10 a=1ZNW-1C8qG0A:10
 a=Fq1VQ0LPAAAA:8 a=H8jIwcHr2qg9GC8OD8YA:9 a=4TeyOto9yEML7lAqsX_hlz2KKrMA:4
 a=MSl-tDqOz04A:10 a=OdWmie4EkE0A:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=KxFS3G6h0a6gpthevgkA:9 a=ETjjfQBXTTeoxNCwMLZLm1GIDsYA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LKRsw-000P22-0X; Wed, 07 Jan 2009 00:27:22 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <slrngm6hoj.n4a.sitaramc@sitaramc.homelinux.net>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104762>

--nextPart3770615.AuIvVuBkf7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 06 January 2009, Sitaram Chamarty <sitaramc@gmail.com> wrote=20
about 'Re: Error: unable to unlink ... when using "git gc"':
>On 2009-01-06, Jeff King <peff@peff.net> wrote:
>> If you are going to have multiple users sharing a repository, generally
>> they should be in the same group and the core.sharedrepository config
>> option should be set (see "git help config", or the "shared" option to
>> git-init).
>If you're not worried about the finer-grained access control
>that acl(5) gives you, just do what "git init
>--shared=3Dgroup" does:
>
>    git config core.sharedrepository 1 # as mentioned above
>    chmod g+ws .git
>
>Now set the group to something (I use "gitpushers" ;-)
>
>    chgrp -R gitpushers .git
>
>amd make sure all your users are part of that group.
>
>Works fine for small teams...

ISTR this breaking here when someone on the team had a umask like 077 and=20
was using file:// or ssh:// to push.  I tended up "fixing" things with a=20
cronjob, (which is a bit of a hack) IIRC.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3770615.AuIvVuBkf7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklkS0UACgkQ55pqL7G1QFnQbQCdF78OcB26WE/Ir+Zk8A0ZwneG
miEAnRBR0+40RsAcT49nSUqJxi0HGAPN
=Glcb
-----END PGP SIGNATURE-----

--nextPart3770615.AuIvVuBkf7--
