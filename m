From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Git - Pushing to a production website
Date: Fri, 9 Jan 2009 23:54:16 -0600
Message-ID: <200901092354.16973.bss@iguanasuicide.net>
References: <20090109222344.3539138a@family.dyweni.com> <200901092304.51986.bss@iguanasuicide.net> <20090109233037.31198694@family.dyweni.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1561215.2pxgmfzxpz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: 4jxDQ6FQee2H@dyweni.com
X-From: git-owner@vger.kernel.org Sat Jan 10 06:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLWp1-0001Xn-9C
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 06:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbZAJFyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 00:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbZAJFyV
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 00:54:21 -0500
Received: from eastrmmtao101.cox.net ([68.230.240.7]:36143 "EHLO
	eastrmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbZAJFyT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 00:54:19 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090110055419.EEZD26835.eastrmmtao101.cox.net@eastrmimpo03.cox.net>;
          Sat, 10 Jan 2009 00:54:19 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 1huH1b0082i4SyG02huJaU; Sat, 10 Jan 2009 00:54:18 -0500
X-Authority-Analysis: v=1.0 c=1 a=7kaFmLc_IIwA:10 a=Fq1VQ0LPAAAA:8
 a=oQGtd-tAe3DsXRzM8tcA:9 a=YAaMqporUzMWfDv1IlNqNabaGjIA:4 a=us3qeXs6y4EA:10
 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10 a=mjKv06sgr3P3RAOd_p4A:9
 a=mP2G6aQQQuIjfPwsEJ329W-IaSoA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LLWnZ-000HTK-4e; Fri, 09 Jan 2009 23:54:17 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <20090109233037.31198694@family.dyweni.com>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105078>

--nextPart1561215.2pxgmfzxpz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 09 January 2009, 4jxDQ6FQee2H@dyweni.com wrote about 'Re: Git -=20
Pushing to a production website':
>> > - Do a git pull
>>
>> I'm not enitirely sure you want post-update doing the pull.
>
>Let's say the website lives in /srv/www/htdocs
>Let's also say the git repository lives in /srv/www/git
>
>All developers pull/push from /srv/www/git  (git@server:/srv/www/git)
>
>The website is a clone of /srv/www/git and only tracks 'master'.
>Post-update (simplified) changes to /srv/www/htdocs and does 'git pull'.

Ah.  I was assuming you were "git pull"ing in the repository that the hook=
=20
was running from.  In this case you are "git pull"ing in a different=20
repository, which should be fine.

>> >This leaves 'working' =3D=3D 'master^'
>>
>> Actually, it leaves HEAD =3D=3D working and master =3D=3D working^.
>
>I'm sorry - I mixed up my terminology.
>
>I am referring to the branch's log.
>
>'working' has 1 more log entry than 'master'.

Yes, which means working^ =3D=3D master.

commit-ish^ means the first parent of commit-ish
commit-ish^2 means the second parent of commit-ish
commit-ish~2 means the "first grandparent" of commit-ish

>Example:
> - git log master | grep ^commit | tail -n 2 | head -n 1
> - git log working | grep ^commit | tail -n 1 | head -n 1
>
>Both of these commands should return the same commit hash.

As would:
=2D git rev-parse master
=2D git rev-parse working^
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1561215.2pxgmfzxpz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkloOAgACgkQ55pqL7G1QFnVtgCeK0pEBt+b5aRJjNYiKSJ4NtIB
+hgAnRAXRPfa7/8h2DBABqkqTHaSbYrA
=GSZd
-----END PGP SIGNATURE-----

--nextPart1561215.2pxgmfzxpz--
