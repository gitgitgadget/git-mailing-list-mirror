From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] git-show.txt: mention that object path must be relative in EXAMPLES.
Date: Sat, 7 Feb 2009 22:59:28 -0600
Message-ID: <200902072259.29121.bss@iguanasuicide.net>
References: <87zlgxzydw.fsf@jondo.cante.net> <m3mycxvn55.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1502714.uMMtAi4gcF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 06:04:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW1pz-0007JX-7l
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 06:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbZBHE7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 23:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbZBHE7g
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 23:59:36 -0500
Received: from eastrmmtao103.cox.net ([68.230.240.9]:34597 "EHLO
	eastrmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZBHE7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 23:59:36 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090208045930.JBLM11476.eastrmmtao103.cox.net@eastrmimpo03.cox.net>;
          Sat, 7 Feb 2009 23:59:30 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id DGzV1b0052i4SyG02GzWB1; Sat, 07 Feb 2009 23:59:31 -0500
X-Authority-Analysis: v=1.0 c=1 a=dYEE7ghI7JkA:10 a=E3tRDs2SsMMA:10
 a=Fq1VQ0LPAAAA:8 a=_HW-ugibS8X_vK1JGzsA:9 a=g-gV-6kEyq3JT5dhhtDqDT8JvasA:4
 a=Aks6A_XPZJcA:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=Tj02R9weyKmXONmNBssA:9 a=rR6iYkdrEHU_FQy-R5t7dfFFn7IA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LW1lR-000FB4-74; Sat, 07 Feb 2009 22:59:29 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <m3mycxvn55.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108920>

--nextPart1502714.uMMtAi4gcF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 07 February 2009 17:31:47 Jakub Narebski wrote:
> Jari Aalto <jari.aalto@cante.net> writes:
> > @@ -57,7 +57,11 @@ git show v1.0.0^\{tree\}::
> >  git show next~10:Documentation/README::
> >  	Shows the contents of the file `Documentation/README` as
> >  	they were current in the 10th last commit of the branch
> > -	`next`.
> > +	`next`. *Note:* the 'object' path must always be relative to git
> > +	project root. This wouldn't have worked:
> > +
> > +	$ cd Documentation
> > +	$ git show next~10:README
>
> Actually that is not exactly true.  In the <tree-ish>:<path> the
> 'object' path must be always relative to <tree-ish), in this case
> to "next~10", which means relative to project root at given commit
> (important in case of subtree merge).

Also important if one of your commits moves everything into a subdirectory =
in=20
preparation for adding new top-level directories.  Sure, everyone on this l=
ist=20
always knows exactly what their project tree should look like from the firs=
t=20
commit, but there may be users of git that aren't that sophisticated.  ;)

So, I think better additional text would simply be:
*Note:* the path is interpreted relative to the tree-ish.

A example of what not to do is probably not useful in this case.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart1502714.uMMtAi4gcF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmOZrEACgkQ55pqL7G1QFntQACgi6WZSdRhlqOeLwAxTWxdKltl
R28AnRO9vuda3XfsEEKmd+uXKUXVJhyD
=uX9e
-----END PGP SIGNATURE-----

--nextPart1502714.uMMtAi4gcF--
