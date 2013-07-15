From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Bug in "git show"?
Date: Mon, 15 Jul 2013 14:23:50 +0200
Message-ID: <51E3E9D6.4070201@googlemail.com>
References: <51E3DC47.70107@googlemail.com> <vpqa9lof2e4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig26C1F7C527FD326E1850C2F4"
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 14:23:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyhod-0006AJ-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 14:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab3GOMXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 08:23:39 -0400
Received: from mail-bk0-f49.google.com ([209.85.214.49]:38280 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171Ab3GOMXi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 08:23:38 -0400
Received: by mail-bk0-f49.google.com with SMTP id mz10so4549879bkb.8
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=3NJ/K6YSdpePEj/LqAtQZSFt6Uv9awPz29TIHl+PKsc=;
        b=SCQjgcYb6YV7VknE4H7DHOcaBvPT7y2fdmIX97TL7lb33wJH6+TGALIMl7eJbwk30X
         8fOGFPLYUyxbdRlFDmbzVI2y3FEsmlr/dd8+3MoM6Skm8fRbmajvLTpPY9+EG2PLHBUw
         3n3YPWCuUdvGTnKvklIP45fiSgBRSaYY2vt30lv+PtlOPA8fFhF1F+Ne+65lGoqJzV9b
         /SKBasKInQa6cssvc+txsGaNgXnZQzPVZXaOdd2R5JShTTeGPvMd3dtL/te7qU8PwG/6
         Y1mLNcU9IIJA1QXQe8eZtM78deUPOo1IJ+fQKa6no4YaAzX/At8d0Ix4/5a0dg7QJJk1
         Vcig==
X-Received: by 10.204.232.12 with SMTP id js12mr7935023bkb.22.1373891017260;
        Mon, 15 Jul 2013 05:23:37 -0700 (PDT)
Received: from [131.234.75.130] (eduroam-75-130.uni-paderborn.de. [131.234.75.130])
        by mx.google.com with ESMTPSA id ct12sm1573598bkb.12.2013.07.15.05.23.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 05:23:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <vpqa9lof2e4.fsf@anie.imag.fr>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230459>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig26C1F7C527FD326E1850C2F4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/15/2013 02:12 PM, Matthieu Moy wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> However I sometimes also get:
>> sb@sb:~/OSS/git$ git show --format=3D"%ad" 0da7a53
>> Fri Jul 12 10:49:34 2013 -0700
>>
>> diff --git a/Documentation/RelNotes/1.8.4.txt
>> b/Documentation/RelNotes/1.8.4.txt
>> index 0e50df8..4250e5a 100644
>> --- a/Documentation/RelNotes/1.8.4.txt
>> +++ b/Documentation/RelNotes/1.8.4.txt
>=20
> "git show" will show the diff by default. For merge commits, it shows
> the --cc diff which is often empty, hence the behavior you see.
>=20
> You want to use "git show -s", which suppresses the patch output.
>=20

Thanks, that's exactly what I am looking for.
Stefan


--------------enig26C1F7C527FD326E1850C2F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR4+nWAAoJEJQCPTzLflhq9k4P/26162DWdWdy4kW6UP3BNfDd
FadGe8Pp/aH7bGQ4y8Nu0V+Gjj/oL5/Ux+XXk8y4YbKmXMQaEQ297YvCF6LO4xoR
8axYwna3+vtV7ihTeJeQGhkld0uDtAJ/6Op5u0ESZETXXVEViwpKXFjAe5rp1zt3
4VTQQFu/FDw/0a/VgG3UB2N+3ujcczfd419Xjm2dIXyaTQ/63vvcR/HQuuEf+T3s
+vNlAH8WgdgsXLARyslnpTAUpMsD3+UfpsGNz7cZVp6S1AXqenzQiGwoKqF4P7BW
OfOWF5uLJYaUSqiYaebj/28jS7vbt4UlPwBUR/4r0Pad5gGyvxi8XcF12PyiE2YI
iXFTmZ1sU8hE+JbHgD5RxQ+220FUKO3pfKyBBqDKYYEg9OxFvwtXODFIYoDcX/eQ
Fcp2awa+1/xzsH6o55B2NkBfCtg2o7ZrMxL/Joq2pIHjgie2yt2Cct8lxAdb47wU
gQc+WE+9t8lI3A4rUROK8PE6JI5VnfDyyhz9Qsx9m/GeezV8SRdcMauKLY99LKK0
RJY43keMiIg0BjlCtcHF5XzGHY/vQm/uyghrdrjRw5hvmw8S0E/+HhUJJX2iqrlb
hWRw3bDb47n5Hp+BQA8lFR8USJLqt3IE1Cp640bvD6qJP1URlKMjOLxJO9mloteR
5eLcK+nQ0VY62xHwPya0
=DPez
-----END PGP SIGNATURE-----

--------------enig26C1F7C527FD326E1850C2F4--
