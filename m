From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Where to report security vulnerabilities in git?
Date: Mon, 24 Aug 2015 09:43:22 +0530
Message-ID: <55DA99E2.7090707@gmail.com>
References: <CAO5O-EKaarYDBd-cpVvKVXTWfKm10ttqd3A6wNe2cXGriGux1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dtPTkWEUg5TqwhS6suS7vu4klDXi7bLUA"
To: Guido Vranken <guidovranken@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 06:13:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTj8V-0005oa-QX
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 06:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbbHXEN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 00:13:27 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34649 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbbHXEN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 00:13:27 -0400
Received: by pdbfa8 with SMTP id fa8so48440219pdb.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 21:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type;
        bh=bycPuMj8XuANfZOOicqAzM2QXLWNCvny4hSp6LBDUoY=;
        b=UaS5ALjr2a1u/uGjHdpafzAiqzxAVy7aOPNqGgmjfYz153FHFb63BkSWwBvIwkendH
         egkPQQv0LASBLROESLOiRO7UVwMOCxDF02DnzU9vNsuLgDfUifQwGyicybbTtBqVAxmI
         CT76sNmTpwizfyNXR5nUjy6n1UMvfE/UojSnMI7eyBJCQumTg+bCKBt24OUJxZaVpL8P
         X9r6Yvr/U17KieeJOTL1VyW1lgJSsGmFgCIENiOhHitY5LPFHHpUC6tgBKfuO8zApx2z
         DVsgcEs3a7fLDhYEDVMo0TCBw1RhXBeIe4AwPl8V7IyRxHMNrZdAChIL+F7ptmPy9aqQ
         Sacw==
X-Received: by 10.70.95.99 with SMTP id dj3mr14504242pdb.8.1440389606569;
        Sun, 23 Aug 2015 21:13:26 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by smtp.googlemail.com with ESMTPSA id mw3sm15521137pdb.76.2015.08.23.21.13.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2015 21:13:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CAO5O-EKaarYDBd-cpVvKVXTWfKm10ttqd3A6wNe2cXGriGux1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276430>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dtPTkWEUg5TqwhS6suS7vu4klDXi7bLUA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/22/2015 04:25 AM, Guido Vranken wrote:
> List,
>=20
> I would like to report security vulnerabilities in git. Due to the
> sensitive nature of security-impacting bugs I would like to know if
> there's a dedicated e-mail address for this, so that the issues at
> play can be patched prior to a coordinated public disclosure of the
> germane exploitation details. I did find an older thread in the
> archive addressing this question (
> http://thread.gmane.org/gmane.comp.version-control.git/260328/ ), but
> because I'm unsure if those e-mail addresses are still relevant, I'm
> asking again.

If it has anything to do with remote access (via ssh or http) please
copy me also.  I wrote/write/maintain gitolite, which is a reasonably
successful access control system for git servers.

regards
sitaram



--dtPTkWEUg5TqwhS6suS7vu4klDXi7bLUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV2pniAAoJEKRCkIUIgjelQs0P/2OqAZ2Fy0DAXT4/6ffV7B3a
flv5a+V4+IXzQrZCBp1/oTluZ+ZS76RXEYhurbr2fpyInzubn05yT84BVGN7IFWP
Tn0khxBdIMvmr9JUWPn1MT/rWELyZjzSlYI7MKPgYvLJUkbCXF6CCWiOeN2oeH7C
sQncbNQa0whoeq/bgXXhvzc4TGtsYmj5yKYIGlTiiEoyKnEzDKEMVkt4vJONLKLG
Td3Q6vmy7EsxmTefNmmTfQzHaK1Kj1G+ijaeFR+FMiew+kCwsY4cj5a4cVxfUpYc
jlX+5e7wYrxLoCk5/z5yvXwC5P88nGfYgWmVFmagjeXFokGxNRB5Nh00ktcFX09L
sfm1SIfeMh2wRkWOA+RXf2L6XEuiG46OEUNqGIQWt8Pfpk1tKM+rqvkxD+G7XuhI
qf7VXtMwLcOodGHerBEt5M7osR0pjWtV2F4uor0qkbWqJYS3xis5VRZ/xxN4i3J7
4WeznNfx/hYIzbV0QZfp02dMeWjx4vyVadhkMQna4vQinhrI6svrL4HghF1QEvZl
drUFzDqjwdNf4yXRa04SQw0J0n56AiuNy1peu/4W/4I0yMccKZJjDbhLB4eEFsvF
U3QmzyNfqmUePa/QTJQrZi+5eAvMsa3gm6nOyaRYOrQSK3b6fq8mcxnmOXxPLTcV
ZqIHn3kSVVhycTXG2IyA
=IEu4
-----END PGP SIGNATURE-----

--dtPTkWEUg5TqwhS6suS7vu4klDXi7bLUA--
