From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: t6023 broken under Mac OS
Date: Fri, 1 Jan 2016 18:49:47 +0100
Message-ID: <5686BC3B.5080302@web.de>
References: <56869D10.9090105@web.de> <5686B400.7000800@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	dev+git@drbeat.li, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 18:50:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aF3qf-0006sR-9a
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 18:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbcAARt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jan 2016 12:49:58 -0500
Received: from mout.web.de ([212.227.17.11]:58640 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbcAARt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 12:49:56 -0500
Received: from [192.168.2.107] ([79.223.114.113]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LvSPv-1a5t4H0Aa3-010ddn; Fri, 01 Jan 2016 18:49:50
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
In-Reply-To: <5686B400.7000800@ramsayjones.plus.com>
X-Provags-ID: V03:K0:dBHRtmf6g+vuhkcgrAA39QTtJt6goz6mJLAO9nugR7nB6byUTDj
 3i1+iGOD3CiEyNOHKyCZoHrpIv4PMc35V2Od7G5vk7The2xQWrBmNUuy297VchQbdZlGDNI
 1KNKEOOQWQPLnjTtGdDLdpfNk5OEfvBVSyPrz902GIziV3u2rOb23XA5JwQ6KhfWMpWQICp
 rQVKELXnGDTZLftFbryxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J0F3drPhGxQ=:gVxJX3g/kq/kb0GFr9cCo8
 SLoooxKg4avGzNauKxMfH4JlnCGQXT2Fsw5SnCyb/JAuqjnR6ckMwL9DDh6HtET3eAH3RAfTk
 ozEP73+MfhlhPTk3lSt+8Sanxl00ZLkeuzR1OC9eZkCyu1jLKes19Uw9mD9dFAWgK/xZs5BsL
 KRNGCqYNhMUS7a+e3yY+h6ROR5/Son0gfAwgpWO+NPFZP8VMBOouQoJLvb3Oabd6R4OGlWn7D
 Ulz6JWfhHvSBE+uwpHOMPWG9bikjAHDqx0hJkJZHHQMpoIbrW/P/QhWB9CfqFt6qkN+jFmqjL
 a79YnDi1aL5FwaE5xp55ujnj8k1yamf+/k3oVPlfYgaQG198c3w4Ovmh/qPaABguEaSCFcVB+
 uzx8rPVKChHMD0aWlMgzpL+hIJb4bjKwsRYJmsOpFsf5SWvfh0ygnQW8B0z80gEy0v7JOem27
 KaBadWe6vNchFjLBA21LhSVS5w6DOruM8Dr5SqXuCWmmK+NJJK7DdOAhHbD8QBf3L9dmr1arE
 nvEKBWh2EDl4X/774B301nZtq5BfxvGpRA+V4yN+F2tfTs0MBJuc/+u/+SyEvolqULAzP68CQ
 q/UkS5ij4rivuAkxbHxj/6Iv2aWtHvkOW22yya/6BGgluw9sVfLYEdihGf8xp4/w8coIxIQYb
 pFKeJEt7TQVwSeN6AiMtO/X+LhASgg72/Ao0yoeeQXKOXNAwjlwT/+Gxy5jHziLiUS9ztMlmG
 C0ovzFlCg2m2hAbVxRdgM7+6ULD0QQj7O/czdEP+FZgIZ2RXTkCrLkEMlb7hm8BFt71HhSIr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283260>

On 2016-01-01 18.14, Ramsay Jones wrote:
> Hi Torsten,
>=20
> On 01/01/16 15:36, Torsten B=C3=B6gershausen wrote:
>> The (last) test case
>> 'conflict markers contain CRLF when core.eol=3Dcrlf'
>>
>> does not work as expected under Mac OS: "wc -l" is not portable and =
the line
>> test $(sed -n "/\.txt\r$/p" output.txt | wc -l) =3D 3
>> fails.
>=20
> Hmm, I have never used a Mac, so I'm just guessing here, but
> you could try something like (obviously untested!):
>=20
> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
> index 245359a..68b306f 100755
> --- a/t/t6023-merge-file.sh
> +++ b/t/t6023-merge-file.sh
> @@ -350,7 +350,7 @@ test_expect_success 'conflict at EOF without LF r=
esolved by --union' \
>  test_expect_success 'conflict markers contain CRLF when core.eol=3Dc=
rlf' '
>  	test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>  		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> -	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) =3D 3
> +	test $(tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" | wc -l) -eq 3
>  '
> =20
>  test_done
Yes, this works.

>=20
> [The 'wc -l' portability should only be a problem if you rely on the
> exact textual form of the output, rather than the integer count.
> 'wc -l' is used in many many tests ...]
>=20
> Note that this test is not checking all conflict markers (the
> =3D=3D=3D=3D=3D=3D=3D marker does not have a filename appended). Shou=
ld that
> be fixed also?
This is may attempt (against pu)

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 68b306f..b1f8e41 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -350,7 +350,13 @@ test_expect_success 'conflict at EOF without LF re=
solved by
--union' \
 test_expect_success 'conflict markers contain CRLF when core.eol=3Dcrl=
f' '
        test_must_fail git -c core.eol=3Dcrlf merge-file -p \
                nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt=
 &&
-       test $(tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" | wc -l) -=
eq 3
+       tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" >out &&
+       cat >exp <<\EOF  &&
+<<<<<<< nolf-diff1.txtQ
+||||||| nolf-orig.txtQ
+>>>>>>> nolf-diff2.txtQ
+EOF
+        test_cmp exp out
 '
