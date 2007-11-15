From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [BUG] t9101 (master) busted on Leopard
Date: Thu, 15 Nov 2007 22:13:18 +0100
Message-ID: <1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com> <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-35--41849420"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 22:14:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ism25-0002dD-Ow
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 22:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283AbXKOVNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 16:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933287AbXKOVNf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 16:13:35 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:40935 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933283AbXKOVNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 16:13:34 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Ism1k-0003a0-92; Thu, 15 Nov 2007 22:13:32 +0100
In-Reply-To: <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65160>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-35--41849420
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

On Nov 15, 2007, at 5:11 PM, Wincent Colaiuta wrote:

> El 15/11/2007, a las 17:04, Brian Gernhardt escribi=F3:
>
>> On Nov 15, 2007, at 8:46 AM, Wincent Colaiuta wrote:
>>
>>> Was just running the test suite against the master branch and saw =20=

>>> that t9101 is currently failing on Leopard, and a review with git-=20=

>>> bisect indicates that it has been ever since it was first =20
>>> introduced (in commit 15153451). Not sure if this problem is =20
>>> Leopard-specific or not as I only have one machine.
>>
>> It is not a Leopard specific problem, as far as I can tell.  I =20
>> just ran the test and had no errors on my Leopard machine.  So =20
>> perhaps it's some other detail of your setup?
>>
>>> I'm not a git-svn user myself, but if there's anything I can do =20
>>> to help diagnose this problem further on Leopard please let me know.
>>
>> I just tested it using svn from fink and (after discovering it =20
>> exists) from Leopard.  No problems.  Do you have an old svn =20
>> package (client, admin, or perl binding) installed from Darwin =20
>> Ports or Fink perhaps?
>
> I don't use Darwin Ports or Fink, and this is a clean Leopard =20
> install (ie. nothing installed in /usr/local apart from git and a =20
> very small number of other tools that aren't related to Subversion).
>
> This is the output of "/usr/bin/svn --version":
>
> svn, version 1.4.4 (r25188)
>    compiled Sep 23 2007, 22:32:34
>
> Perhaps then it is something in the environment.

Hi Wincent,
Can you reproduce this deterministically?  If yes, can you re-run the =20=

test with the --verbose flag and post the gzipped output (or send it =20
to me if the list doesn't like this sort of attachment).

Thanks.

--=20
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-35--41849420
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHPLZvwwE67wC8PUkRAr/RAKCXJ1V2Am8FDQTnbW/hPU04+U0MCwCgrT7y
bMoeWUPt6j+WR6BdSgePthc=
=vutW
-----END PGP SIGNATURE-----

--Apple-Mail-35--41849420--
