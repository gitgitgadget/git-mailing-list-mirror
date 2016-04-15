From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Migrating away from SHA-1?
Date: Fri, 15 Apr 2016 01:50:05 +0000
Message-ID: <20160415015004.GB140502@vauxhall.crustytoothpaste.net>
References: <570D78CC.9030807@zytor.com>
 <CACsJy8DmPw+cbohp-X55bp9NJSbUVN=tsABXoF5Xh-6PgPTbiA@mail.gmail.com>
 <8722D9F3-8A42-4BF7-A945-305F483E8364@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 04:20:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arync-0004Gd-1w
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 04:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbcDRCUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 22:20:20 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52820 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751193AbcDRCT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2016 22:19:56 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C5C3C280A0;
	Fri, 15 Apr 2016 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1460685010;
	bh=OiFx2s3Gfandt0HahQgdZz3Zd7nEk30eFLDZEjXJ9/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enA8NWk6aRrd+BYuUSKgA/nQpf83mynzom3A3kvSe29O6lgS35LkQCCiTAUQDXiZo
	 nsj7DvHdH8k1RniCKTXTrGFPQTFXDAYlL2OIuIuhSbGXdSDeKsSQRSVq0HNzMxYHC6
	 pWMyj0raS/94EcxJ381MHcNEPZcUacLxx5eq2BFHtRGjNrJ4RF09zvqiYPgmgd1eQH
	 /uPJ/5FAtW8BGF3yORgSgQtrOa9dQmZBZ6SUZaKiKXvICR40yLOJ/FI01Rmo54GxiD
	 /6rmMRGlwggW7CQ3WMrDAtKQP8azn0S294kAG8XxVP0bYKyu/HDK0cVPrtKSeITVIj
	 yEq24RmP2NWPvsPTNvTiwvn2YpFcPry5sZj1axu87oXY0infDmJ2BzMjPyhq86aE9T
	 bd3Q9CgcKGuMgfMGhCnTx6mhI+0Q6mudjFWDZhC/2wcMtniadfMphdBQCwOzi9yp0G
	 YqxoTasiiJsxDAtka6272lBV6EPxXqPvLBknRPHWmzsxwLwVMKZ
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8722D9F3-8A42-4BF7-A945-305F483E8364@zytor.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.4.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291793>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 06:58:10PM -0700, H. Peter Anvin wrote:
> On April 12, 2016 6:51:12 PM PDT, Duy Nguyen <pclouds@gmail.com> wrote:
> >On Wed, Apr 13, 2016 at 5:38 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> >> OK, I'm going to open this can of worms...
> >>
> >> At what point do we migrate from SHA-1?
> >
> >Brian Carlson has been slowly refactoring git code base, abstracting
> >SHA-1 away. Once that work is done, I think we can talk about moving
> >away from SHA-1. The process is slow because it likely causes
> >conflicts with in-flight topics. A quick grep shows we still have
> >about 300 SHA-1 references, so it'll be quite some time.
>=20
> Well, at least it sounds like work is underway.  That is a big deal.

Yes, it's a bunch of slow manual refactoring, and I've been busy as
we've been doing house- and car-related things recently.  I'll try to
spend a little more time on it this weekend.

The first step is to convert all of the individual places that use
unsigned char [20] to use struct object_id, which can then be extended
to use different hash algorithms.  There are also constants,
GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ, that abstract the 20 and 40 values in
the codebase so they can be changed in the future.

While this is a project I've been mostly working on, I have no objection
to other people sending in a patch or series as they feel like it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJXEEjMAAoJEL9TXYEfUvaLrisQALZgtPPYsMcGCL6iVt06UR2d
pGu6RdXQHGczytinW79aWtckovnvFVjSXHW8autwTywFiD8EOabn7rqcB8UfxYcj
HgPAtRzWH7AULCryVhUIfvufaF9cSyJiSLo7YrHB2QwYc3fYL0DAmiiStqi00sbN
J8spnLmkyvFjups+sfJBW6/7aGyV0qzpbxDgteH/Qpd3y9+TXTizEuXWymgVJSKM
bIiTYae+R6j9a8nGVO/0zNmEVBiLjtPuz16k14jKXdnviy4MOms9BWIUqzgvLpWi
ihYTOXUlfzjYCFRiw+Ci3R1edLJO19/Jm/zDWz0ggfuVDNMOH2Udx2IZD0LV4RxZ
oAaj6ep7ZCLhVB3lzXN/NvwypsaDz+uQ1gBqhyk1r3MRgAi33lJLJc98Cn9MW7lu
1kHj34AXMY6lIbQhjjXf1XYgUMReTo/yKwXT6ZmY/l0a+OaDtiPwzuPeSRiLS45G
+h1xFBwEHAj/Fo+cG6XhN2dXHEfkBxeLkVHDWI0UcCkqDjV8im35gILHdp34Nagx
+Ha7kz1MP7p9KS5TgwQlxmbkGwFfxSs9CuZ4HuDyR5e//sJwzbnHCfoHBaHdth/e
xHW0waDTNB3FVCUvaDzjfr97zWu2wtDi2GZ3RVhGay2S69FWAlYadj3F9fjfGXm3
RC1m6+5KxJqXAp8u7Iuo
=F84r
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
