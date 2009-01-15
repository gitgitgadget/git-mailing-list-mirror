From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Wed, 14 Jan 2009 23:00:26 -0600
Message-ID: <200901142300.31718.bss@iguanasuicide.net>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <200901142049.54775.bss@iguanasuicide.net> <buo8wpdfbv9.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4195275.GvrKddoKyG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 06:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNKMi-0006AE-BT
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 06:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbZAOFAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 00:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbZAOFAf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 00:00:35 -0500
Received: from eastrmmtao104.cox.net ([68.230.240.46]:53144 "EHLO
	eastrmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbZAOFAe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 00:00:34 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090115050034.HNPN3752.eastrmmtao104.cox.net@eastrmimpo01.cox.net>;
          Thu, 15 Jan 2009 00:00:34 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id 3h0Y1b0062i4SyG02h0Y6L; Thu, 15 Jan 2009 00:00:33 -0500
X-Authority-Analysis: v=1.0 c=1 a=J-l0xwG6isUA:10 a=sIHEJvGgCqYA:10
 a=Fq1VQ0LPAAAA:8 a=urPD8HbQ8acez3gXogIA:9 a=9kmuhx5lOPydZlaFxe7GvEXtBLwA:4
 a=ii61gXl28gQA:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=7LXDMP4DtsOJJlYy6c8A:9 a=YZibI8wQamZYaNLW5Bq_GUZ0zegA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LNKLH-0005kO-SF; Wed, 14 Jan 2009 23:00:31 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <buo8wpdfbv9.fsf@dhapc248.dev.necel.com>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105767>

--nextPart4195275.GvrKddoKyG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 14 January 2009, Miles Bader <miles@gnu.org> wrote about 'Re:=
=20
[RFC PATCH] Make the rebase edit mode really end up in an edit state':
>"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
>>>We may need a version bump to 1.7.0 to update the UI for this command,
>>> but please do test rigorously to build a stronger case for a saner UI.
>>
>> Instead of changing the meaning of edit, how about introducing a
>> "replace" command?
>
>That seems like at best an awkward workaround, not a real solution to
>the problem,

Actually, I think it's a better solution (or rather a solution to the real=
=20
problem) because others have already said they like and expect the current=
=20
edit behavior.

The "real problem" is you need different behavior for your interactive=20
rebasing.

>which is that the term "edit XXXX" suggests you're starting=20
>with XXXX and modifying it.

Exactly. "edit" is: While interactively rebuilding history (rebase -i), you=
=20
get to the first place that commit existed and then modify it=20
(commit --amend or other tools).

>The term "replace" by contrast, seems more=20
>to connote entirely removing XXXX and substituting something else.

Exactly. "replace" is: While rebasing you stop just before the commit=20
existed (changes are even staged) and decide to do something else (like=20
using add -i and a few commit commands to split the thing up or whatever).

>[I do wonder how on earth the current awkward behavior was accepted in
>the first place...]

(Actually, I do too, but it's accepted and expected behavior now--good=20
reason not to change it.)
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart4195275.GvrKddoKyG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkluwusACgkQ55pqL7G1QFl2mACdEQyFzN2Ar+EGlBJnj+LGJX72
eEUAniE7uCiSiLcRfJDuwjxvKcn/Siqy
=C4Sa
-----END PGP SIGNATURE-----

--nextPart4195275.GvrKddoKyG--
