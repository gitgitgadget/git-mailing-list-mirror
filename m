From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: What's cooking in git.git (Jan 2009, #05; Wed, 21)
Date: Wed, 21 Jan 2009 23:21:34 -0600
Message-ID: <200901212321.50526.bss@iguanasuicide.net>
References: <7vab9kataf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1532220.HefNgn8h9j";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 06:23:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPs2A-0006uO-B9
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 06:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbZAVFVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 00:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbZAVFVy
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 00:21:54 -0500
Received: from eastrmmtao102.cox.net ([68.230.240.8]:52821 "EHLO
	eastrmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbZAVFVx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 00:21:53 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090122052152.OJSF8735.eastrmmtao102.cox.net@eastrmimpo03.cox.net>;
          Thu, 22 Jan 2009 00:21:52 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 6VMr1b0022i4SyG02VMrJW; Thu, 22 Jan 2009 00:21:52 -0500
X-Authority-Analysis: v=1.0 c=1 a=AHVSlz3QljUA:10 a=UjP9HbbQeAAA:10
 a=TSbVqHtbAAAA:8 a=Fq1VQ0LPAAAA:8 a=HTOx4SU2OsK2dj_ZXI8A:9
 a=8gWeymyVAXDw00JA0NBpSiFmnd0A:4 a=qIVjreYYsbEA:10 a=T3brmoaXcPoA:10
 a=LY0hPdMaydYA:10 a=Ew1hAbtXbDukJVQT7e4A:9 a=lKVmjQaYUBNifxPOY2pTg8LRT1kA:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPs0k-000KMD-LG; Wed, 21 Jan 2009 23:21:50 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <7vab9kataf.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106722>

--nextPart1532220.HefNgn8h9j
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 21 January 2009, Junio C Hamano <gitster@pobox.com> wrote=20
about 'What's cooking in git.git (Jan 2009, #05; Wed, 21)':
>* js/notes (Tue Jan 13 20:57:16 2009 +0100) 6 commits
> + git-notes: fix printing of multi-line notes
> + notes: fix core.notesRef documentation
> + Add an expensive test for git-notes
> + Speed up git notes lookup
> + Add a script to edit/inspect notes
> + Introduce commit notes
>
>It would be nice to hear a real world success story using the notes
>mechanism before casting this design in stone.

I'll see if I can't try to put this through some paces over the week. =20
Also, I'd like to see some support for notes in push/fetch, but it could=20
certainly be added afterwards.

>* js/diff-color-words (Tue Jan 20 21:46:57 2009 -0600) 8 commits
> + color-words: Support diff.wordregex config option
> + color-words: make regex configurable via attributes
> + color-words: expand docs with precise semantics
> + color-words: enable REG_NEWLINE to help user
> + color-words: take an optional regular expression describing words
> + color-words: change algorithm to allow for 0-character word
>   boundaries
> + color-words: refactor word splitting and use ALLOC_GROW()
> + Add color_fwrite_lines(), a function coloring each line
>   individually

I think my patch in=20
http://thread.gmane.org/gmane.comp.version-control.git/106567 should be=20
applied to the top of this.  It respells "wordregex" to match existing=20
uses throughout the repo.  Dscho had issues with one hunk, but I think I=20
addressed them in my follow-up.  It looks like 98a4d87b (color-words:=20
Support diff.wordregex config option) still has the internally-consistent=20
runtogether spelling that doesn't match other configuration variables etc.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1532220.HefNgn8h9j
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl4Al4ACgkQ55pqL7G1QFnjBwCfRdT++ugPjg9h/JTtHv03JlCh
P6UAn2JSwI+excNJPRio4dgSy+DZOSEx
=5v8I
-----END PGP SIGNATURE-----

--nextPart1532220.HefNgn8h9j--
