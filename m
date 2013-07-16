From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH v4 0/6] Make "git show -s" easier to discover for users
Date: Tue, 16 Jul 2013 20:07:30 +0200
Message-ID: <51E58BE2.9040504@googlemail.com>
References: <20130715185843.GH14690@google.com> <1373961940-31614-1-git-send-email-Matthieu.Moy@imag.fr> <20130716174636.GJ14690@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA8F2CCE110575A3BB9687D57"
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 20:07:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz9ez-0006fE-6c
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933374Ab3GPSHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:07:33 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:54652 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868Ab3GPSHc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:07:32 -0400
Received: by mail-we0-f179.google.com with SMTP id w59so915570wes.38
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=U4U5WgZcKhE2U3rnXFUOXSrHpyR0AFnoJEs7sUOi/sk=;
        b=bAy+gkHFv8oDECIzy2dOYQfMtIVNlSw0fY/81TCww9S9HWSgrXjhTLXFOHBOW7r1bd
         AX+cGen/3CgUSMbIBTdcC/V9yNqvybXP4piQ5pcCs9kTMDXFVAFieTd4hFA5utqyF6Pf
         kz8kI9byt6OnihNDVYOOlBEq+rHFlnwPbbtvMbXRg4SrK//wlNUWUVVlifULjFxyra6s
         CBQpMyJ9eRdr2xBXoPd0I1tXrOr8jK/rc6OXGxqLgNAZaXaawnSLo8HdB6M7f5bq//ka
         Q7n3EvgsjlZgE+CkdKYhyyjAzpoDQiW49eEI2LCEeqDGwSQVYS9CBAskIHzEdOY6oVBU
         kwaA==
X-Received: by 10.194.119.195 with SMTP id kw3mr2096459wjb.64.1373998051048;
        Tue, 16 Jul 2013 11:07:31 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id fb2sm29572989wic.4.2013.07.16.11.07.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 11:07:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130716174636.GJ14690@google.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230568>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8F2CCE110575A3BB9687D57
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/16/2013 07:46 PM, Jonathan Nieder wrote:
> Matthieu Moy wrote:
>=20
>> Matthieu Moy (6):
>>   t4000-diff-format.sh: modernize style
>>   diff: allow --no-patch as synonym for -s
>>   diff: allow --patch & cie to override -s/--no-patch
>>   Documentation/git-show.txt: include common diff options, like
>>     git-log.txt
>>   Documentation: move description of -s, --no-patch to diff-options.tx=
t
>>   Documentation/git-log.txt: capitalize section names
>>
>>  Documentation/diff-options.txt     |  5 ++++
>>  Documentation/git-log.txt          |  8 +++----
>>  Documentation/git-show.txt         |  9 +++++++
>>  Documentation/rev-list-options.txt |  3 ---
>>  diff.c                             | 30 ++++++++++++++----------
>>  t/t4000-diff-format.sh             | 48 +++++++++++++++++++++++++++++=
++-------
>>  6 files changed, 75 insertions(+), 28 deletions(-)
>=20
> Thanks!  I think this series is ready now.
>=20
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks as well. :)


--------------enigA8F2CCE110575A3BB9687D57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR5YviAAoJEJQCPTzLflhqyBEQAKBO9saxV3R8bQ4nTCRvLpEJ
aIvB/0wmWJADj/1rcfvqB9CbbuOtPZfpJExeMlOLwlQH0A+b5LcYPIRlnN8ub9pR
Ev5ZHhC0rGQ7vxAjkd0Aq3RnDBkwpg489fMTnhLYsjKx9UIvdqK3K6rCDpwJ0Sjb
2HJFgnpALVrjvtUh0kYd6qlONjQcEBwNl8Jrj4C4HY2dJ4cmqNNHi27sweuKPgQz
wsBMtMXELryFiDeWMiD3WcOoxxRzOh+GCUiDrSwkRqtLqfZiE+vTYOdhp7sGsb5X
YAY4FSvZVT6mrYkDJhXptOjiRDPViKLtW4Q/DHVnjBtmw7me0M2uJoLJQUK8psxY
02PdBhyC579j0/gQxkgwKeAAeRiMSTz/byIFD5kVDKZPqT/JoPJLQYYOeA6wfH7T
SQViRh5aeLoGiXAz5ee0ScPsMtG0azoIpceeZo41SoU/3bFxuLwf8uTZ1AG/Q7vc
nfu7SyBC/qnlTfblVyBDm2vPNT8gkwAV+myuWqgs/WIdo+cmV/JKRbYMIsYWu6fo
tlG9/dywmEtazJu7Sfdzkffka6zVehE52kqakPTq5tI7min1zd9mfyFYovkzbjem
7Hnoy8tHMkju3gvdSiXbVuXfKBEPoaP8tCslTmsK7S6TzLO/2roMkZqEUKjIxi7q
OCz64xR+bxmziM+8ENL4
=T3kq
-----END PGP SIGNATURE-----

--------------enigA8F2CCE110575A3BB9687D57--
