From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one
 action multiple times
Date: Wed, 31 Jul 2013 12:34:06 +0200
Message-ID: <51F8E81E.6000705@googlemail.com>
References: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com> <7va9l3x34f.fsf@alter.siamese.dyndns.org> <51F83010.2060804@googlemail.com> <7vfvuvvg0r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB46113DE6BBBDB3E3E0D3A9C"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 12:33:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Tj9-00075S-2I
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 12:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759545Ab3GaKdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 06:33:51 -0400
Received: from mail-bk0-f45.google.com ([209.85.214.45]:33765 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab3GaKdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 06:33:50 -0400
Received: by mail-bk0-f45.google.com with SMTP id je2so178418bkc.32
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=HB8Xcc5HHmf2wF2uHS6h0WmC3Z33xifh72h89FlUiZ8=;
        b=Pxl/IJC40YQ2RYbqfN4CHyLxeG2EEWkohiRE3qxc5LHFZWGHrZbZE5BqWVuh8zDcup
         veh4A9OInHAl+YAUGDCbfJkWAMtmWzOUJ6fYWHKTIk6xeQfLIlRJOJDbn1Ag6dsd6mCD
         u0Rn24CvwBNKaIcv5eInI1Oubkd6Z9vDptTUH5mbmauOqVhktZocmIlLHWFQpafI/NVd
         +Cdri2IwsRUsmVUFMcpP1AWjj+DUu4linpcOJODBPUJn/5CTE76ZK5N4zBsxdcky3xif
         yvzQP16Kl9lUgBlplbp4uBZej0qKsrHlWiOIPGKZy2dU6Nu+StzVlJYvulubILWF9lvI
         TlaA==
X-Received: by 10.204.70.141 with SMTP id d13mr9861482bkj.10.1375266829051;
        Wed, 31 Jul 2013 03:33:49 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id od6sm296107bkb.11.2013.07.31.03.33.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 03:33:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vfvuvvg0r.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231415>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB46113DE6BBBDB3E3E0D3A9C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/31/13 00:28, Junio C Hamano wrote:
>=20
> we could just do
>=20
> #define OPT_CMDMODE(s, l, v, h) \
>     { OPTION_CMDMODE, (s), (l), (v), NULL, \
>       (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (s) }
>=20

I agree that's a better proposal than mine.


--------------enigB46113DE6BBBDB3E3E0D3A9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+OgeAAoJEJQCPTzLflhqzkAQAIsPft8NkRXcKkH21KDC8eW/
1kXTI8sjssybReO0zhp/q02dp1n0l0iOnUKDnxLlZxjAz/WAc3XvIVFdmT1f7Iop
nY8U3IsxFfXkLVGm6dSqWFGjKrHcVFo3wZtkOieohEVPjMQNKManF39RS+vuHB7t
5kJMqYHVnh3ceqARmQoEPV+RbJGFwm9yYrzBM46sqYSIdsUx3dhVb7cCoN2GVKf4
NYMwmHLaZeogjZdax+RN7CJVNySkEmjfSnFd+GsGVN7257A/9jBZtCQq+Rsy1kDf
4OhSKyzkclkWy6ZV4sbtmog5w+iHFirCT3bnBjNwuB8EYxP4pz6jlwBo0ZnYcS+3
mLmZB2L5aONoFnsGzQu4A84Kg5urPkcI/7nTngQF6ymQn6IVQ5V6DA4KS14tYde9
RDtQFPFLVS5Rs0GjkDb1ZJRkMVDUMquuERqI8O4LtJabJ1cLkoYekbzXLZjZI4B6
4F7THHCJLfce1v/ybUhvsNkrztFtAuL0tfJeqTOyvTlf/SuoO+Ks0yTH8URK8z/O
nReaxQNGHm6YDW3qQHXsy74kxudygevI62U/O/EfZ34X/4C3QxDLRSNKo3jt2kI0
1YcwBqchp4TKH1xk4DmB5jZ2YZ5TjKV8x0gJwYMhsddnePMKU40mIZ7dLbzp4vxd
llCQR5c8LrsjQ8u4fDq3
=zJMn
-----END PGP SIGNATURE-----

--------------enigB46113DE6BBBDB3E3E0D3A9C--
