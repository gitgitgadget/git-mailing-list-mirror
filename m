From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] git-credential-netrc: fix uninitialized warning
Date: Tue, 08 Oct 2013 21:58:41 +0200
Message-ID: <525463F1.2050308@googlemail.com>
References: <87zjqjx25g.fsf@flea.lifelogs.com>	<20131008194147.GF9464@google.com> <87li23v8p5.fsf@flea.lifelogs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BIa5LCn5XX9CEkFnPCECHfws76xrL0ffH"
Cc: git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 21:58:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTdQX-0000tS-IG
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 21:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab3JHT6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 15:58:38 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:63905 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301Ab3JHT6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 15:58:36 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so4269248eaj.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=70WEJMTxo0/54RchC12Srncz220Uw/a7dBnclxIudNQ=;
        b=lh/uWxN3QgPzbt9XwK57+b+uQeQQzqVo8/iFyNtTvDqV3+ZWK01RHkEGgYmJEHZUF3
         t1RjhBMg4aDDxHWT1jIq74UvfRiXyWgNhzRCm6QH1EIHEd9xhHyzdtkXxKVeh+5AGaXO
         /Wzo5zxy8LBF0dvE79l8eJPRBSNwY5qsnKc60Sw7dSXXP7S52yy6+b1N1ymA8PS42A9d
         VhKBeobxdUfCZKcWVlZB/FN++OlHcNIQPTrdDkBNqRR+SG9ok2XxnVTHgerQx/BmwCI/
         cRhagzTyzopAdEd6v3+g65bDRIXEvi0BKnHV9oZMaMbnKEkcBHuIjWbcjaJ1zF25ZGh8
         111g==
X-Received: by 10.14.225.199 with SMTP id z47mr5180014eep.24.1381262315037;
        Tue, 08 Oct 2013 12:58:35 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k7sm79669866eeg.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 12:58:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <87li23v8p5.fsf@flea.lifelogs.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235787>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BIa5LCn5XX9CEkFnPCECHfws76xrL0ffH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/08/2013 09:55 PM, Ted Zlatanov wrote:
> JN> Sign-off?
>=20
> I didn't realize it was a requirement, must I?

Yes, this is a requirement. See Documentation/SubmittingPatches
to read what signing off actually means here.

Stefan


--BIa5LCn5XX9CEkFnPCECHfws76xrL0ffH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVGPxAAoJEJQCPTzLflhq+wMQANOoqiXaK0G3VAl5icGu+4aZ
Vh1ih3qoSHVOU5O6Rz6TNJa0iuxwrn2a4o+mr1KaU1JTqqJnExep8HTeyz+DOpqN
cfS3U8QNfvOZh3/cUz+kWWI5neADXlIqNqnPrJw6NuYGrMXzUfVqTrOBJO46k13X
/RcImpLwZslx+IWlDrKxljartf5mfaQBwYjoUntjwqrr0YfwZrHz0cweDSehLrTV
EnbMiVIX39ap5ItUP7R2NVtrbBq4aXlzf4UmIIWuYaSirbohpRXFNrtf1IbYgswc
DJseOHoob4cxqG9aqhfWcsELZkP8DGs+aPPOszDUJOPlCn3tuBFy7UBZtME4Wdj5
x9kZk+e1iDoCvNyN8rkNjesMKUaKGR3GWRxoV6v+Dw+gFN4Oj9Fb4LGvYX5j7l7a
2LO/CuXMJhiKhPXELg7ycXsTNQzYLK9FVu9V3kWxpM9idCGWtsWj3bHwsru8RaA9
iKDov0EaZP7N7rQqQYY6WaIFx7WCQXUkRCcvG905836uooHrsB5ynHMWeLGoReCi
qqlZTfnb6qN+Y1Vvudf2w21xFntxi2ri9wLBUdAx4oTCyLTRSbk/21Os4TK6M/3D
/mAW2dScYDuottvigRcM3jN0ky5bxjWw5up7Y+xiZInOA2NJpJVMcE+YP+h9gjoS
isZQS+Jj6OcVUi144Au6
=eGus
-----END PGP SIGNATURE-----

--BIa5LCn5XX9CEkFnPCECHfws76xrL0ffH--
