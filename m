From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] status_printf_ln: Suppress false positive warnings of
 empty format string.
Date: Fri, 19 Jul 2013 18:04:28 +0200
Message-ID: <51E9638C.9090207@googlemail.com>
References: <1374242889-14239-1-git-send-email-stefanbeller@googlemail.com> <7v7ggmy1wn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB121C8BE1BD2736B9E0992AD"
Cc: peff@peff.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 18:04:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0DAY-0000r2-Sp
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 18:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752Ab3GSQEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 12:04:30 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:52124 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab3GSQEa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 12:04:30 -0400
Received: by mail-wg0-f47.google.com with SMTP id l18so4076507wgh.2
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=YvZn5sARQ6DJn9/LhLXxFMGvs4yeVPZHMns5Yqbw2Hw=;
        b=mMv8tXbUVbiY+SSwwzdMhpAbZ7by50ISx1COMAZVDLwx7KrizEy1Em4ZK7nQvXOLs1
         ikyy/GxthFaSFfTmVKW55amCbpbqd05N/PECESDWE2Fv5I25FNhMyP3zjXfmPYuFi0D7
         BoOHb2phBKv7RgiYTdmD3So2gpShIXIiuRWoN+mH81/dIbgpyUH5kWxGXejqwL1yYIAF
         pCEJUGaUsQspwB9Xg0SaP62FYNcxby7UuY7a0v4xO4tjPBV2TN9OMrEMPRNE7fJSTsan
         0vaICWptF9tIe3oK7j6P6V4wU9le6uRAfIfaheK5mytJ8TEi0Zl6wdxCS76mZKE5ADm8
         TH9w==
X-Received: by 10.194.110.6 with SMTP id hw6mr12831973wjb.3.1374249868497;
        Fri, 19 Jul 2013 09:04:28 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id u7sm43587093wiw.9.2013.07.19.09.04.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 09:04:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7v7ggmy1wn.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230821>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB121C8BE1BD2736B9E0992AD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


>=20
> Even if the " " variant is faster, it does not matter if its output
> is incorrect ;-)

Agreed.

> I think we discussed this already?  The conclusion was it is silly
> for GCC to warn on -Wformat-zero-length for user-defined function in
> the first place, IIRC.  func(other, args, fmt,...), when invoked as
> func(other, args, ""), may very well do something useful regardless
> of the formatting part based on other args.
>=20

I am sorry, I did not pay attention enough to that specific topic. I
was just finding warnings on next and pu, so I wondered how to fix it.




--------------enigB121C8BE1BD2736B9E0992AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR6WOMAAoJEJQCPTzLflhqv0UQAKuFWm774NNuYfYzaSEG2f+r
YcgjFSnP7yk94Xf2ir9pk6XvHGaTd/UZMRMZpnC/H9hTKuzjce9rgg1v9yo9s5Pd
XGpMrSZCQHh5L/v/hD5EiwVRPou7TeLxeDZggOtglrHgUwCmD+b68F5K7DS87jm/
f5nuuYa1OAmg6E/dwvNg+pCJwplezWC9yBFDL3zsCmYD3x+4DeFIBeDIacUy612k
OzqvDdZTUV8e8gvjaaT0CskToL+2+z9c1CwHAmwf/gKbCC1NRUOEj+KyTyRKP+QG
4RZo9pMnD3MvLtBlF6ncHOrMaToPW5f2VdT32Ln5Jwg+mx2Ib0JaBCXWan5gMaao
Zc3WQqAkZiqhmL/K6FT7DFwa2Ki4WU9htpooYenAqQRAUiN/ehxYPtG38LTqe7/l
igiAVuixk5w6umuiSj+XgSrZnSKLpp6qZZ5rrAwIrFUcBJ1OlNCkNiWh8LwPLDb+
B/9OEvwufCjTljH+8bWtg7J3fU+xgx3g5NyVyhS5uaEepC1uq6dL7CN8MzXLCHjF
kLI0pAPolU/W/Hh9JCgjyuG2TZJ+WzrjXP3FBWrK7L6S7OuMG6UbwjMr/9he+VNn
0AXMmFfSWE52ZXNmdwOHupCz7HoVesLyabzo+jAzLwIdNn03TdR5mLTD5RNBsbr6
Gi9GgQ8c8VEESMb3rA7p
=DU/x
-----END PGP SIGNATURE-----

--------------enigB121C8BE1BD2736B9E0992AD--
