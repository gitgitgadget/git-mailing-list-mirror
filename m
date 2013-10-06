From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: GSS-Negotiate authentication requires that all data fit into
 postbuffer
Date: Sun, 6 Oct 2013 15:29:08 +0000
Message-ID: <20131006152908.GD3460@vauxhall.crustytoothpaste.net>
References: <20131006004236.GB3460@vauxhall.crustytoothpaste.net>
 <20131006105013.GA24950@LK-Perkele-VII>
 <alpine.DEB.2.00.1310061658330.6366@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Sun Oct 06 17:29:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSqGm-0001Wj-17
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 17:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab3JFP3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 11:29:16 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60930 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753066Ab3JFP3P (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Oct 2013 11:29:15 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C4FC22807A;
	Sun,  6 Oct 2013 15:29:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1310061658330.6366@tvnag.unkk.fr>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235741>


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2013 at 05:00:02PM +0200, Daniel Stenberg wrote:
> On Sun, 6 Oct 2013, Ilari Liusvaara wrote:
>=20
> >>GSS-Negotiate authentication always requires a rewind with CURL.
>=20
> >Isn't 'Expect: 100-Continue' meant for stuff like this (not that
> >it is always supported properly)?
>=20
> Yes it is and libcurl uses 100-Continue by default for that purpose.
> But the harsh reality is that lots of (most?) servers just don't
> care and aren't setup to respond properly and instead we end up
> having to send data multiple times in vain.

If there's a way to make Apache with mod_auth_kerb do that with curl,
then it doesn't require a change to git, and I'm happy to make it on my
end.  But using the curl command line client, I don't see an Expect:
100-continue anywhere during the connection using Debian's curl
7.32.0-1.  Do I need to send a certain amount of data to see that
behavior?

The command line I used was

  curl -v -d '0000' -H'Transfer-Encoding: chunked' -H'Content-Type: applica=
tion/x-git-receive-pack-request' --negotiate -u bmc: https://git.crustytoot=
hpaste.net/git/bmc/test.git/git-receive-pack

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSUYHDAAoJEL9TXYEfUvaLBp0QALylaxnfQTyP8apIKNLuJEcR
HuhmaqGL31SyP2hwIiRKPC0vECynMKzsl1iOGWRj543L8B/jJc8sthGAG6+W5zqC
B5mSEjh8PPyykHzxDhjzGxAaItGsYZo8I3lwiVlErhNAGu78lT+9OmBRdLogvlpn
gDBvJg7H5ZMvHIAG8/0MHnWCk1k3fxbcXiyq7P5fQBdcgAZcXmkFxtCj4fIJqb3T
Dhx3s3ZVRXArS3WaT2jHHLVX2Yi0WmEH84NxCYBqo2hKQNyoiKSt3TMwrPsBejDl
iE3xWZLfvi4MwXSqKDW74tfU8cUZzoi5TMwk3kOtaZNi+x4kDPHXCxz5ilob0kVu
iI5CkKb0eUIg66ZCUhscF+qi4XnvUBZGupCUe29rOUAf3QdjHqQPmnrtctDUTQXX
uSAJ2B92xhrmc/MGCveGChG7oCytoJ6DMmDJ7T+whcSQ278Id+pJU2HWNhOFGNBM
JsEBplhUQx/T4Zc+Dya7x0aeNQ8aBq0ZOmFRmKA0YBE7ErLUy7qQr9sdnNXfzNTh
BPbQmb/NQBEAWIu4PuG/MuAHVVHHmvQFzyrbvfrq6BHF52N7Ghy9xd8BwjnPsWTb
YZyuYUccNfdKyivixMUr9ZNICQpcftSS6Zfqz8TIeWWksd5cjc51zygo9K/soojl
ptWyW+LMF9GLKOe3W2UI
=aDnH
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
