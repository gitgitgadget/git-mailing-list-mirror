From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] branch, commit, name-rev: ease up boolean conditions
Date: Tue, 06 Aug 2013 22:18:31 +0200
Message-ID: <52015A17.6040204@googlemail.com>
References: <5200F3D6.5040004@googlemail.com> <1375794434-12257-1-git-send-email-stefanbeller@googlemail.com> <CAPig+cR05=vfutGJ1pB7JbOV9-rrtwwEeondWCBDs6Av94tTkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE195207FFC9A09645B0D48BE"
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 22:18:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6niG-0004ms-QE
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 22:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353Ab3HFUSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 16:18:33 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:42008 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312Ab3HFUSc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 16:18:32 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so435370ead.35
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=cKVWmIPX5xQIs9BVmauG9a1yQqepMVhZPyUo4pzH0lk=;
        b=bD08Y/rSdPjey8FwZJ5c7ETPk6PVGWEO6trlVAWNZ4RG07lL65hNXL/GBESv7RILdf
         FroOpy2kOufFqxy944uwuUkJVgYXmD/8kNDvEFKHsBnxVXDGDbH1SOrCznZbiPRmzYyQ
         j8NCwiRoqdqta3FergZ4vE60PgEInArBPQzd5hiY+MlkLkuMqx7yEWVnOB7ZYx6+y8/7
         +4oWgnOGa6wdrvFnac8HNCdt0F58ckZ6WeBjoBlTYGiVmh1EfkmwUOWJhp/2jPUH4o33
         g2Q1wtu3CqFI+GODB0LB3XMNyhNt1f9sAGIyqxQJNprSXoZBhuHnmNRLBh2nNHMTpUmq
         o17A==
X-Received: by 10.15.86.65 with SMTP id h41mr2539704eez.147.1375820311166;
        Tue, 06 Aug 2013 13:18:31 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id bp43sm4500478eeb.4.2013.08.06.13.18.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 13:18:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <CAPig+cR05=vfutGJ1pB7JbOV9-rrtwwEeondWCBDs6Av94tTkQ@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231783>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE195207FFC9A09645B0D48BE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/06/2013 08:46 PM, Eric Sunshine wrote:
> On Tue, Aug 6, 2013 at 9:07 AM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
>> Now that the variables are readin by OPT_BOOL, which makes sure
>=20
> Do you mean s/readin/read in/ ?
>=20
> Or should it be s/readin/set/ ?
>=20
>> to have the values being 0 or 1 after reading, we do not need
>> the double negation to map any other value to 1 for integer
>> variables.
>>
>> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>

I think s/readin/set/ is best.
Also s/after reading/after parsing/


--------------enigE195207FFC9A09645B0D48BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSAVoXAAoJEJQCPTzLflhqBacP+wVokj4qZEED/dESZZctDFEV
XXLOOA37yZS3r+ajfNDMspeda8GXH4qDUxFozyeS1Ap91ta7rnKrK3tek0UFlY5u
qtiADD4CNCGRBbJ5nDesPyy7JJO+qJ0FQbMHe5ydgvQPSX4FxxXv8H77lQpduwrm
Yu4sN4Lail/fl2blR9A+tyNTdur35xVe5YD0M9pGk8r/qSk25MKgT3vLxhY/195O
VbqoE3DrEB8oUvHcb/rF1GC+tROZRUbbAhetp20tfIfIfnwQD6PfEDiSRQqRfKrK
bzRIJJOLjXN5wUowT8qKneX8EKsAXqJbk3rgPzSWL+2jR9mF72R0CGbsuMBoyrz6
5ir9lKVaNU7I9Z2X32JLM93i+ExHP5f8hVhaLhcU5ptwTzKryqd1ax4fxX+URynK
NCm0SmSpSdfYSHnpqcHyGyjWcBbIPUKhQDn6tK4Uqbs0fCEZeODHH+tXz+NNx5DV
JK+S6w2rHxtlRfYPQ2/WjYlsI5QLP9l4yuDYkW+ny7uHpTpP87qt16H3ZPhvNtYE
C1GNWv17hkO67HB+vIamhGIwmseM6lFnsezsd7ibsdJ+mnp9vwmAl+ozFCkDxq4O
1JuU+GaBOVMAE41h876B32G9bQlByGFRhHxwiomyVdV+2JejO3WNKUIqR+fkPL8B
33hTU7GpU2HzUayK8Qvr
=Exs8
-----END PGP SIGNATURE-----

--------------enigE195207FFC9A09645B0D48BE--
