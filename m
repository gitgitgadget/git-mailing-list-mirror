From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] log: properly handle decorations with chained tags
Date: Thu, 19 Dec 2013 03:18:09 +0000
Message-ID: <20131219031809.GG259467@vauxhall.crustytoothpaste.net>
References: <20131217004044.GB259467@vauxhall.crustytoothpaste.net>
 <1387254501-319329-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq38lrknbd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 04:18:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtU83-0004s6-DH
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 04:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab3LSDSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 22:18:23 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34898 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751885Ab3LSDSX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 22:18:23 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:25f2:d8a1:a1:c2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 045662806B;
	Thu, 19 Dec 2013 03:18:15 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Content-Disposition: inline
In-Reply-To: <xmqq38lrknbd.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239513>


--ISKrrfpKsPiF35CV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 04:36:06PM -0800, Junio C Hamano wrote:
> I think all we need to do, in addition to what the existing code
> does, is to make sure that we _parse_ the object that the tag points
> at, to avoid this problem.  Something like this, perhaps, instead?

Yeah, that's the clean fix I was looking for, but couldn't quite come up
with.  I'm going to re-roll with your fix instead of mine and my tests.
Any objections to adding your sign-off?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSsmVxAAoJEL9TXYEfUvaLB+0QALjeX47pB54BwsUp+o7AvAk6
yQMltszRqHgqZQmLnyoFP6aTnAYDPW64e2ZY0VsjbNt6sYh9JODL3KVJf+HIvwZd
11NN/JI0cUrGbdF3ZYXqI+MlizhR42DUELUYBXYwZ+tQx8VPY4CZgKGrfqxv1ZXD
f2H6XxMnL+k311hdHW8+H6aQeJZWcnUBIY4uipZG20KV2MMWsB6VuRac03mxZpDL
z2XgEWx8hcYB/iUh8SxteRW0QkqnYAegBe8jjIR5J8KqUc/vm4O+VnWJuPIA8SY2
6TthYndK4pRNPCcOOW9b2ZEWVZkHS/VOYIwyIb92Ji5shNJiUWvItqSLAvum3ND6
5qMiJ2CI9XqNql9RMIU8/M8nTUF2RJ7fitcy61ajXzalNzkqRxiceZX1zNOduH+y
CKZJZ+Fkzk/IjU2wdONyu2UUe/upH/x33gL6GypXV0oAe1+c5k1I1vbJTlYRqvgD
t3NfJkf1/f419nwlgv1XoHBGSeY1LeiyhijAfVS/VCld2YeFXvDG8T1aP6cySffq
XUxwTyMpJBpxiSMiKIHCUlxvB9aIx4KiiHfjYtPkWxpac86+j+j2NvtrQN88cprt
AQcLVCmahmooGebhGmP6/kYTmg7tdPCirReiPSC0PA9ddqhsJjydnUVhtkKumXvi
wjZB/Ctk8OfQ29b+qLmV
=gcuA
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--
