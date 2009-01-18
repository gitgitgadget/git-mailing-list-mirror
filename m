From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: is gitosis secure?
Date: Sun, 18 Jan 2009 06:50:06 -0600
Message-ID: <200901180650.06605.bss@iguanasuicide.net>
References: <200812090956.48613.thomas@koch.ro> <1228813453.28186.73.camel@maia.lan> <873afgsul8.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1788165.guBA4dWreE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 13:51:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOX81-0004wu-Ob
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 13:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbZARMuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 07:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbZARMuP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 07:50:15 -0500
Received: from eastrmmtao103.cox.net ([68.230.240.9]:43093 "EHLO
	eastrmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763591AbZARMuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 07:50:11 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090118125012.SOCK18445.eastrmmtao103.cox.net@eastrmimpo03.cox.net>;
          Sun, 18 Jan 2009 07:50:12 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 50qA1b0032i4SyG020qAqg; Sun, 18 Jan 2009 07:50:10 -0500
X-Authority-Analysis: v=1.0 c=1 a=Fq1VQ0LPAAAA:8 a=1v-E7o_WKarpMOwZ0XAA:9
 a=Y0MN5hmT_ASMEnGSmp-UEqFcFw4A:4 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=-TO7Fyol--T2qwPhFKAA:9 a=0kLMHQV73qmqPGI2Oybg7cb0bHcA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LOX6M-000EM4-Mm; Sun, 18 Jan 2009 06:50:06 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <873afgsul8.fsf@mid.deneb.enyo.de>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106183>

--nextPart1788165.guBA4dWreE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 18 January 2009, Florian Weimer <fw@deneb.enyo.de> wrote=20
about 'Re: is gitosis secure?':
>* Sam Vilain:
>> Restricted unix shells are a technology which has been proven secure
>> for decades now.
>Huh?  Things like scponly and rssh had their share of bugs, so I can
>see that there is some concern.  (And restricted shells used to be
>circumvented by things like Netscape's print dialog.)

=46rom my understanding, a restricted shell is a difficult thing to escape=
=20
from unless a user is able to run binaries that they have written.  FWIW,=20
I don't remember sftp or scponly having this particular vulnerability.

Even if a user is allowed to run scripts they have written, escaping from a=
=20
chroot is more difficult, but per-user chroots have their own=20
administrative overhead.  They also might be escaped in the case of a=20
simultaneous privilege escalation bug (allowing the attacker to be root in=
=20
the chroot) and kernel bug (or "chroot feature") that gave chrooted root=20
to write outside the chroot (for example, to a file they would be=20
reasonably sure would be executed).

I can't speak directly to gitosis' security.  If users are allowed to, e.g.=
=20
change the hooks in their repository, there may be an issue there.  I=20
certainly haven't done any sort of audit to the source code AND I do not=20
hold any security certification--or even job experience in a security=20
field, yet.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1788165.guBA4dWreE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklzJX4ACgkQ55pqL7G1QFnmgACgiO08I/Vismv15yqFODCaoXi4
ozIAn0HUMJBR3eYQAPZuMHB9ySRwUxtE
=+GlZ
-----END PGP SIGNATURE-----

--nextPart1788165.guBA4dWreE--
