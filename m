From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] git-show.txt: mention that object path must be relative in EXAMPLES.
Date: Sun, 8 Feb 2009 02:47:36 -0600
Message-ID: <200902080247.44151.bss@iguanasuicide.net>
References: <87zlgxzydw.fsf@jondo.cante.net> <200902072259.29121.bss@iguanasuicide.net> <87skmpxt5g.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5046675.qnLjxJlzLY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 09:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW5Mj-0001HS-4N
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 09:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbZBHIrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 03:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbZBHIrs
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 03:47:48 -0500
Received: from eastrmmtao106.cox.net ([68.230.240.48]:58469 "EHLO
	eastrmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbZBHIrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 03:47:48 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090208084748.QDFU18213.eastrmmtao106.cox.net@eastrmimpo01.cox.net>;
          Sun, 8 Feb 2009 03:47:48 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id DLnl1b0062i4SyG02Lnmq8; Sun, 08 Feb 2009 03:47:47 -0500
X-Authority-Analysis: v=1.0 c=1 a=dYEE7ghI7JkA:10 a=E3tRDs2SsMMA:10
 a=Fq1VQ0LPAAAA:8 a=ElXa-5SHskcdwL_bIN8A:9 a=ytF7DCRhJqeT-vL-PssA:7
 a=4iXc4OvBKTsmy0Uk40wFVTnH-FcA:4 a=T3brmoaXcPoA:10 a=Aks6A_XPZJcA:10
 a=LY0hPdMaydYA:10 a=v2yvgfUef4TJJFYwwcsA:9 a=5xVn-Jg_znoP_WG94x2EsmVbZP0A:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LW5KL-000FVs-4N; Sun, 08 Feb 2009 02:47:45 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <87skmpxt5g.fsf@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108931>

--nextPart5046675.qnLjxJlzLY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 08 February 2009 01:52:11 Jari Aalto wrote:
> "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
> > On Saturday 07 February 2009 17:31:47 Jakub Narebski wrote:
> >> Jari Aalto <jari.aalto@cante.net> writes:
> >> > +	`next`. *Note:* the 'object' path must always be relative to git
> >> > +	project root.
> >> Actually that is not exactly true.  In the <tree-ish>:<path> the
> >> 'object' path must be always relative to <tree-ish), in this case
> >> to "next~10", which means relative to project root at given commit
> >> (important in case of subtree merge).
> > Also important if one of your commits moves everything into a
> > subdirectory in preparation for adding new top-level directories.
> >
> > So, I think better additional text would simply be:
> > *Note:* the path is interpreted relative to the tree-ish.
>
> Changed, See below.

Thanks.

> > A example of what not to do is probably not useful in this case.
>
> It is important to give examples. This is a common mistake:
>
>     $ cd todir
>     $ ls file.txt
>     file.txt
>
>     $ git show 8b2de93:file.txt
>
>     fatal: ambiguous argument '8b2de93:file.txt':
>     unknown revision or path not in the working tree.

I agree with both of your statements.  I'm just not sure about the wisdom o=
f=20
giving an example of what *not* to do.  There's a lot more incorrect=20
invocations of git there there are correct invocations.  Perhaps an example=
=20
that illustrated to the user how the "unintuitive" behavior was *useful* wo=
uld=20
be better.

> The path is in working tree from user's point of view

No.  At least, not from a right-thinking user's point of view.  The phrase=
=20
"working tree" has a very specific meaning in git, it is not "the current=20
directory".

> Not intuitive if you're
> deep/in/the/directory/hierarchy

I'm not sure "not intuitive" is a useful metric.  Different people simply=20
expect different results.  HCI studies are hard; we shouldn't assume we can=
=20
guess their results so easily.

Even with my objections above, I'm still slightly positive toward the patch=
 as=20
is.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart5046675.qnLjxJlzLY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmOnCoACgkQ55pqL7G1QFkuuwCcCiKozYjpcXesf3XB+gqEbjws
ThYAn3U1Xo0NGQh/llE3S1MMlci/04GW
=PDB9
-----END PGP SIGNATURE-----

--nextPart5046675.qnLjxJlzLY--
