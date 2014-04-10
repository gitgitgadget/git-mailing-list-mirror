From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] Add support for commit attributes
Date: Thu, 10 Apr 2014 20:47:26 +0200
Message-ID: <934D49AB-0E6B-4DF8-A67C-CE311561378E@quendi.de>
References: <1397072295-7670-1-git-send-email-diego.lago.gonzalez@gmail.com> <5346d4adf4f_69dfeb32f0b9@nysa.notmuch>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_14F7758C-A3B7-46D9-B530-6CD90704CCF3"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Diego Lago <diego.lago.gonzalez@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 20:48:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYK1h-000077-VF
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 20:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758913AbaDJSrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 14:47:23 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:58124 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752918AbaDJSrV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2014 14:47:21 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WYK0M-0007YF-OP; Thu, 10 Apr 2014 20:47:18 +0200
In-Reply-To: <5346d4adf4f_69dfeb32f0b9@nysa.notmuch>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1397155641;ca02ec2b;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246032>


--Apple-Mail=_14F7758C-A3B7-46D9-B530-6CD90704CCF3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 10.04.2014, at 19:28, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:

> Diego Lago wrote:
>> Commit attributes are custom commit extra headers the user can
>> add to the commit object.
>>=20
>> The motivation for this patch is that in my company we have a custom
>> continuous integration software that uses a custom formatted commit
>> message (currently in YALM format) to show several information into
>> our CI server front-end.
>=20
> These attributes can be used for remote-helpers as well; to store =
extra
> information that cannot be stored otherwise in Git's data structures.

+1 to that. This is reminds me of what Kiln Harmony does as part of =
their effort to enable full round-robin transfer between Git and =
Mercurial (a goal from which all other tools I know of still are far =
away). See =
<http://blog.fogcreek.com/kiln-harmony-internals-the-basics/>.



Cheers,
Max

--Apple-Mail=_14F7758C-A3B7-46D9-B530-6CD90704CCF3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlNG50IACgkQIpJVslrhe1lmOQEApHFukKqjrG1IdnHXIc32LoKh
64vE+5A4WpURApxwtyoA/jlXv57L5Gg2otUGmi/7/YwqwRL+M6DjOmLuLJPKn21T
=WxlL
-----END PGP SIGNATURE-----

--Apple-Mail=_14F7758C-A3B7-46D9-B530-6CD90704CCF3--
