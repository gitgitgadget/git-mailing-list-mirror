From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 0/6] Corrections to the mailmap file
Date: Thu, 04 Jul 2013 16:37:36 +0200
Message-ID: <51D588B0.60007@googlemail.com>
References: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig970E5D3256DA4A7BA3513E0E"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 16:37:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UukfH-0007Y9-QA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 16:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab3GDOhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 10:37:40 -0400
Received: from mail-bk0-f49.google.com ([209.85.214.49]:39214 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517Ab3GDOhj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 10:37:39 -0400
Received: by mail-bk0-f49.google.com with SMTP id mz10so677693bkb.8
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type;
        bh=wtBmaZWTMbzTNLSOYoFNtUpY8Y1kK+nmaATI0DF4dbo=;
        b=08b8HgGKQosS8ce5+813CfEAqCZStSbUlsRK60t82ySP0AFEVZvM30EncftH/KBw+c
         aa7/WezfrbHkydwiDp377vIU/F0JAjH0CFPXlSE6C39XdDCQgcqplSMljDv3ADrECuPU
         JDm6i/na/3UiQah9Kp246aPIZpQThxsJpRSkalAVM2M8cVhe9jpZkM3mUzJtvsOHdGMJ
         Z4iYg3+5drey7QCCZKUkwvktZ3ofGR0UrbjoOvBn/dv6loh9IPFjVr8+4t3V0zYTKGXv
         QMG4TZXoabxzHmGKsy3AFSfcNUBw61Yn9efzMrPzumox+0crQ3Ttj1FHKG20d4VueiyF
         oufg==
X-Received: by 10.204.225.12 with SMTP id iq12mr1164437bkb.4.1372948658058;
        Thu, 04 Jul 2013 07:37:38 -0700 (PDT)
Received: from [131.234.74.151] (eduroam-74-151.uni-paderborn.de. [131.234.74.151])
        by mx.google.com with ESMTPSA id cy5sm1118469bkb.1.2013.07.04.07.37.36
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 07:37:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229590>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig970E5D3256DA4A7BA3513E0E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Here is a script to display the entries I was referring to:
---
#!/bin/bash

git shortlog -sne |awk '{ NF--; $1=3D""; print }' |sort |uniq -d > mailma=
pdoubles

while read line ; do
	# remove leading whitespace
	trimmed=3D$(echo $line | sed -e 's/^ *//g' -e 's/ *$//g')
	echo "git shortlog -sne | grep \""$trimmed"\""
done < mailmapdoubles > mailmapdoubles2


sh mailmapdoubles2
rm mailmapdoubles
rm mailmapdoubles2



On 07/04/2013 04:04 PM, Stefan Beller wrote:
> Hello,
>=20
> I noticed many duplicates in email addresses but having the same name b=
y
> running:
>=20
>     # Finding out duplicates by comparing names:
>     git shortlog -sne |awk '{ NF--; $1=3D""; print }' |sort |uniq -d
>=20
> Most of these entries are most probably the same person, but we cannot =
be=20
> sure, as there might be different persons having the same name, then th=
ey
> are only distinguished by the mail address.
>=20
> However I suspect most of these to be the same person, having changed=20
> mail addresses.
>=20
> Here comes an initial batch of corrections to the mailmap file, which
> maps people with email addresses of different capitalization onto
> the same entity.
> (Example Name@MIT.EDU is the same as Name@mit.edu)
>=20
> I intend to contact each of the persons individually and ask whether=20
> just their mail address changed, or if they are indeed different person=
s.
>=20
> Stefan Beller
>=20
> Stefan Beller (6):
>   .mailmap: Multiple email addresses of Alejandro R. Sede=C3=B1o
>   .mailmap: Multiple mail addresses of Alex Riesen
>   .mailmap: Multiple mail addresses of Paul Mackerras
>   .mailmap: Multiple mail addresses of Keith Cascio
>   .mailmap: Multiple mail addresses of Johannes Schindelin
>   .mailmap: Multiple mail addresses of Toby Allsopp
>=20
>  .mailmap | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20



--------------enig970E5D3256DA4A7BA3513E0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR1YiwAAoJEJQCPTzLflhqRY8P/0GMNMH051zjW42f/VUwCiBt
0fdtMb3stsQZvS0/n3GGV5ZE7MX1xPBr4BSXeQrAYdhoBxdOHQJLXemB9zxDlaY9
n7FKuNRFmmpFsCT9DUlg0D8cgPZjUYk8fIALJK10rQx2/X3/dvNPpJUOV1oStYTl
zXCM8CAFrqq6TWtZYB3Wf8SSaa+rtESYULsXwYY00zzMdYp6gtuezrt5xmAE9dGM
uGmYBYwh27b/yAnsX1soZRp+VFfEIhnVTDpumEuBY/hAacbLbf/WfKd09ZoAONbJ
9VA0zMe1UeF/REORuWFvFAyIaL5uI1EsrN035WT7ZjQirVs+185/IoOmzk/YzlW1
itqTCa3lYmpW/RLJJOn6xZjNuTAfK29Ngse2E2AJ7rdN5nhqkuthy56Drjho9y/9
JZEgeIdnYpjpg+KZmdIdrkEqPwg636IdLw/kcn0b845eZjBskUuYyNZnicMIp6O3
VL2SFUEkkNunY0OsVhFgDTu8VMJxD5sh/JQXm06Q7BTEIbvf3I/CrldnoxcsufO+
n4kYuEDNjOp0dhPr9qrO9Bz31wazPDGzw5YmchINjsnS8Xl1tp+3XRyf6b9dWvKd
AnB0CACsaI4SKkNXFG1qX6qE55TPH6w4UK7TtuFELeUUkqGFg1sWUbgwnWIVxjbO
jBnZVL77XWkqEUHx2TWj
=Jgps
-----END PGP SIGNATURE-----

--------------enig970E5D3256DA4A7BA3513E0E--
