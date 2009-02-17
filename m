From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: git commit <path> scanning entire working tree?
Date: Mon, 16 Feb 2009 20:57:47 -0600
Message-ID: <200902162057.48460.bss@iguanasuicide.net>
References: <2729632a0902161458m732af362od59e5f35af5643c3@mail.gmail.com> <7vwsbpewkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3743124.5QelxT5nxL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 03:59:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZGB4-0004Pd-LR
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 03:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbZBQC5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 21:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbZBQC5v
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 21:57:51 -0500
Received: from eastrmmtao107.cox.net ([68.230.240.59]:58728 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbZBQC5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 21:57:50 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090217025749.USBM23750.eastrmmtao107.cox.net@eastrmimpo03.cox.net>;
          Mon, 16 Feb 2009 21:57:49 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id Gqxp1b0012i4SyG02qxpjd; Mon, 16 Feb 2009 21:57:49 -0500
X-Authority-Analysis: v=1.0 c=1 a=ohHnUL2ZxUIA:10 a=q3Gvrb_Qno0A:10
 a=Fq1VQ0LPAAAA:8 a=sTNlf8Jhr5LSyD-pvJ8A:9 a=kI3v3ODY67BNoOqLiCIA:7
 a=AOK3CvwkxrtUBo4F0N_okQ0qLS0A:4 a=MSl-tDqOz04A:10 a=T3brmoaXcPoA:10
 a=LY0hPdMaydYA:10 a=13Fcbj3vLCfy2GXz1BQA:9 a=CvEwjOKCYcwWlAq7qOPyBsndn-0A:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LZG9c-000Dum-Iu; Mon, 16 Feb 2009 20:57:48 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <7vwsbpewkl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110301>

--nextPart3743124.5QelxT5nxL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 16 February 2009 18:28:10 Junio C Hamano wrote:
> skillzero@gmail.com writes:
> > When I do a 'git commit <path to a single file>', git seems to scan
> > the entire working tree.  [I]t takes quite a while (5 or so
> > seconds) before I can even edit the commit message.
>
> Do you mean you edit the commit message, starting from the message
> template "git commit" gives you?
>
> The template lists "Changes to be committed", but
> also "Changed but not updated" and "Untracked files".  You cannot generate
> the latter two lists without checking with your work tree.

So, specify one or more -m options and you shouldn't see the scan.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart3743124.5QelxT5nxL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmaJ6wACgkQ55pqL7G1QFlP7QCeOdyrcGREaLMqk45dLnbM+ve0
Z+8An0DeMYGqfGh1uVVIICkhUUMFT9PO
=N7VC
-----END PGP SIGNATURE-----

--nextPart3743124.5QelxT5nxL--
