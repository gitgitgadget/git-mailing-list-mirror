From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 3/2] test: factor out helper function test_must_contain
Date: Sat, 21 Nov 2015 10:35:24 +0100
Message-ID: <56503ADC.50908@web.de>
References: <564DF6BE.6020609@web.de>
 <CAPig+cSXiGVLvq59sUFAzTRoQFf-QswAoMSk20LvJqntzaf65A@mail.gmail.com>
 <564E371E.50606@web.de> <20151120111454.GB11198@sigill.intra.peff.net>
 <564F8781.1080902@web.de> <56502745.2000307@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 21 10:35:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a04aN-0005y1-22
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 10:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbbKUJfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Nov 2015 04:35:53 -0500
Received: from mout.web.de ([212.227.17.11]:51158 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbbKUJft (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2015 04:35:49 -0500
Received: from [192.168.178.36] ([79.253.191.33]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lu4uA-1aSIIg1GNS-011Shf; Sat, 21 Nov 2015 10:35:36
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <56502745.2000307@kdbg.org>
X-Provags-ID: V03:K0:OYXHHixQje1JYkBCq5CkyLWkPhQK/s9rqZQ4ubroW9zbAQIdrCr
 M8lPHs8Bp0VkN2emIoi5K/avTUgjVin7I+W26+Z5kekCtdp2ds7FhzDFwOUZSNUHIlq9pAe
 Dz92mSuIBkQi3p1mHzoMVg7E5uB5S5kfkK7zGPVhEH7HEeRirgY/PhlxHvDu/WscFMUCz2X
 ZCEVgPq2xyJXqQcVF86RA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6CR1gEufXwg=:YmgC0YYEkbvSdghyEsNjsE
 t5ElDDhQRn7tyZkIekps4I/V4YcMacXcN6xRPskKqYh5tlSfUnA6+T1iN8gLmO2g+g1nKKtmU
 OiwhWFQePpQIOi1DddHQdl4mWcJ/MwqReqJRepCJiqNyHrzaqYstGGv2Ev6tZSMOlhudL1gcd
 EpidRvq55jCm4ZuxPW2AKhbOOy9eC6UX8mH3kp4HnZo000dj1YB+Xf7KzL/lGzW1RdvryAGB8
 hCwSp2Pzvoi8r2kx3xMzIKa+4QTHLd3VO+Hdql5jSuIUhCLC2eidi8/XPpe9DOcCniVE3/oFZ
 552IsE2tXqZSQZo7D6A9mtEedd4jZcblpdwcCgX0uHmUznbJsOOidafbxKe5mKXsAaaNuyrRO
 qd/fD4OYuNSPTlooEqHYLpE/iejUyEyKHiEGl/4K+eGGgOpi/2zHRAW62lMDFbOi25PnOBws6
 x2IJmvnPUSGMrDLcLio/gx1d23iqPyXYeJUV3yaDyDLYxgnhMeKNlKLDrnPFXAc6Q2Nb8PN5k
 mYkC0wvfrGer+6oIDswNFB/I7GQajjfOZOwBI5p9xhNsNlZbynb0giZ/SDdb0E618ZQUp6Vs4
 RUlbF/04nX7Fzhnquw4n4O244PIDDjuVD6rfrdMDwM0frUHfvnEqgF84i0OTC187rBVCfiSLJ
 Cz+OQ8/z5cDyAdQzXZzoyKY/CgqHk3Ra8XSsQXgcOq9+E2NT881bDlNCf99rpU0+Ltn/5Ee+H
 2eKDN3iJCyRgKqY9B4g8buoQdlLTPzCBNgrOmnuAGATCRccyfmQwcukggJfBFQFYocvTclaO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281547>

Am 21.11.2015 um 09:11 schrieb Johannes Sixt:
> Am 20.11.2015 um 21:50 schrieb Ren=C3=A9 Scharfe:
>> Extract a helper function for searching for a pattern in a file and
>> printing the whole file if the pattern is not found.  It is useful
>> when starting tests with --verbose for debugging purposes.
>=20
>> +# Check if a file contains an expected pattern.
>> +test_must_contain () {
>> +    if grep "$1" "$2"
>> +    then
>> +        return 0
>> +    else
>> +        echo "didn't find /$1/ in '$2', it contains:"
>> +        cat "$2"
>> +        return 1
>> +    fi
>> +}
>=20
> There is already test_i18n_grep. Should it be folded into this functi=
on?=20

That's a good point.  But how?  test_i18ngrep can also work as a
filter and pass on options, so we'd need to parse all parameters and
redirect stdin to a temporary file unless a file was specified.  Or
we could be sloppy and just check if the last parameter is a file and
if yes then spew it out.

> Wouldn't we also want to have a function test_must_not_contain?

I doubt it.  In such a function grep would display the lines that match
unexpectedly already, so showing the whole file after that won't add
much more of interest.

> IMHO, we should not increase the number of functions that give a bonu=
s=20
> only when there is a test case failure. They do not scale well: There=
 is=20
> a permanent mental burden on every reviewer to watch out that they ar=
e=20
> used in new tests. But without those functions, the burden is on the =
one=20
> person investigating a test case failure, who has to live without the=
=20
> debugging support.

test_must_contain doesn't have to be used everywhere, only in cases
where a file is shown and grepped.  I agree that letting an existing
function do that job (or deciding that the job is not worth doing) is
preferable.

Here's how I imagine the sloppy add-on to test_i18ncmp to look:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 16c4d7b..db64600 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -985,13 +985,28 @@ test_i18ncmp () {
 test_i18ngrep () {
 	if test -n "$GETTEXT_POISON"
 	then
 	    : # pretend success
 	elif test "x!" =3D "x$1"
 	then
 		shift
 		! grep "$@"
 	else
 		grep "$@"
+
+		rc=3D$?
+		if test $rc !=3D 0
+		then
+			while test $# -gt 1
+			do
+				shift
+			done
+			if test -f "$1"
+			then
+				echo "Expected pattern not found, content is:"
+				cat "$1"
+			fi
+			return $rc
+		fi
 	fi
 }
=20
