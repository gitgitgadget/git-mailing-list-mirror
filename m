From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 4 Dec 2008 12:28:58 -0600
Message-ID: <200812041228.58885.bss03@volumehost.net>
References: <49380D84.5050403@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4905501.fdEM0jHD12";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 19:31:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8IyQ-0008OI-6F
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 19:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbYLDS3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 13:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbYLDS3c
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 13:29:32 -0500
Received: from eastrmmtao101.cox.net ([68.230.240.7]:40938 "EHLO
	eastrmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbYLDS3b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 13:29:31 -0500
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081204182929.PXBX3950.eastrmmtao101.cox.net@eastrmimpo02.cox.net>;
          Thu, 4 Dec 2008 13:29:29 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo02.cox.net with bizsmtp
	id n6VV1a0052i4SyG026VV09; Thu, 04 Dec 2008 13:29:30 -0500
X-Authority-Analysis: v=1.0 c=1 a=hxm1ygmibCAA:10 a=QBLpfaYHh3oA:10
 a=nEQGfrJnAAAA:8 a=QzKfQiP7Be0FQ6YUsMQA:9 a=3X_Cj2eEDOoHAuWJ9kNwC7ZAP2QA:4
 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10 a=xBBZ_92U-EZ4izQP7JMA:9
 a=tcN5K1my7q_68s52xg-usdl1EJ0A:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss03@volumehost.net>)
	id 1L8Iwi-000GAW-0s; Thu, 04 Dec 2008 12:29:04 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <49380D84.5050403@fs.ei.tum.de>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102354>

--nextPart4905501.fdEM0jHD12
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 December 2008, Simon 'corecode' Schubert=20
<corecode@fs.ei.tum.de> wrote about '[PATCH] Allow passing of --directory=20
to git-am.':
>-	--whitespace)
>-		git_apply_opt=3D"$git_apply_opt $1=3D$2"; shift ;;
>+	--whitespace|--directory)
>+		quot=3D$(echo "$2" | sed -e "s/'/\\'/g")
>+		git_apply_opt=3D"$git_apply_opt $1=3D'$quot'"; shift ;;

Test:
bss@monster:~$ echo "don't" | sed -e "s/'/\\'/g"
don't
bss@monster:~$

I'm thinking your sed line doesn't do what you think it does.  You probably=
=20
want something like:
bss@monster:~$ echo "don't" | sed -e "s/'/'\\\\''/g"
don'\''t
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss03@volumehost.net                      ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.org/                      \_/    =20

--nextPart4905501.fdEM0jHD12
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk4IWoACgkQ55pqL7G1QFkxIQCfbhaUQnEnKa6fM94BmFf7p7ZF
trEAn2Vw0evTYNv8W7a0UAWPvkHkGNkz
=vtNA
-----END PGP SIGNATURE-----

--nextPart4905501.fdEM0jHD12--
