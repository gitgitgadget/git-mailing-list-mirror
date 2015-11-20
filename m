From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] t1450: add tests for NUL in headers of commits and
 tags
Date: Fri, 20 Nov 2015 21:49:58 +0100
Message-ID: <564F8776.1050706@web.de>
References: <564DF6BE.6020609@web.de>
 <CAPig+cSXiGVLvq59sUFAzTRoQFf-QswAoMSk20LvJqntzaf65A@mail.gmail.com>
 <564E371E.50606@web.de> <20151120111454.GB11198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:50:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzsdZ-0001FC-AU
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 21:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760513AbbKTUuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Nov 2015 15:50:24 -0500
Received: from mout.web.de ([212.227.17.12]:53850 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760385AbbKTUuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 15:50:23 -0500
Received: from [192.168.178.36] ([79.253.144.111]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M8Qpi-1aLH6X1rCU-00w0op; Fri, 20 Nov 2015 21:50:11
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151120111454.GB11198@sigill.intra.peff.net>
X-Provags-ID: V03:K0:mqeLibYVSd0rYYaqpUG8pvjzuOzSwsAKyl1kPZr7kw6s0Bj+IfH
 mne9XLGuud2gofqEJlaulu/w5qevUok84Kn+OdNOVM4kwphkkYmq8mO4P7LpBtiRjoB010A
 0mlxRe/2UQ15rE5JIpAG93wT2LAReLSlaBWUQca1xQtXBKsMDrY8/FXOR2fuhQfbM3t5Uld
 KNmQlXOUdyH0j5B6xUPDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JnHzniLqAu8=:Q6vWWgcmsfEhKRZPWXmQwq
 RbmXYCZFHPm/mXbjBl6Ra08vW0bhfIRH0hP+3cwPPqs/c4VKRuh8crpOIZxJoHAR9SyGjVPCt
 6kVLVsWQS3iHPdP/NUEU2vHPqYPnwzW0XGwL7a3mCu9aXjID7xhSrzomsVWYwG6PRKZ/XIcZK
 YaqOCXnRyeCT35L76QMjLiJBVf0qfNYk6N8dMPD0CGjQxKOUGhMl6cZ5BdhePxxQnTHR9AV6K
 7QKc51IibqpJ1pNFCSh2jswO1u1IG5nQZ1HJA+0/wrg6qIV//Tu+1eJdnsGlzE8Gatb2S2gwx
 BPi/6tU+JNI9NCfLssxIzzdmSyNzYiuLvlhmG1npTN71yFykRmMSpeaUsisTFjT7dKUsvYoh/
 bqHMF7gSEXnqtM/kMkQq0TQQxvkkHdCJAiEXeABOGgqupaCxWMvY1znPOLX3luNIx8dmC3YY3
 lCrkHMICIKziDoxJ7dpuNUKt8R246ZRb2OCx1qs15NKokN6jrICJ5U7TAipzhMCaFhMrPR6SW
 SJFqK9eMunLKQMcI+s0zf6Vwqn6bhSXPNWmY+IKTEp0aUoOqLvWqLy3ug2LTJaVDHJoMLaQ32
 Y62oR0OfE1TJK7bVD2OQbEkdKPH9rVZ/rppw79BOdrKnxNd9MOKnIdPFUF4QrTcv65qLY7hvT
 x8N5mk4AOpKkmzOzGFsTg0oFRvY1LhexD3ouIMLw/JyFE/5+JSKp4UuFb6SO+eMTHWMVYw48K
 Z0Lf7iUMeBwjScfqDGzRxzSDm/rcdXkg9kRF9q+Eq7RUCtTEsRaE0Zc9sC8Xv2VAlLPB69vJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281532>

Am 20.11.2015 um 12:14 schrieb Jeff King:
> On Thu, Nov 19, 2015 at 09:54:54PM +0100, Ren=C3=A9 Scharfe wrote:
>
>>>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>>>> @@ -176,6 +176,18 @@ test_expect_success 'integer overflow in time=
stamps is reported' '
>>>> +test_expect_success 'commit with NUL in header' '
>>>> +       git cat-file commit HEAD >basis &&
>>>> +       sed "s/author ./author Q/" <basis | q_to_nul >commit-NUL-h=
eader &&
>>>> +       new=3D$(git hash-object -t commit -w --stdin <commit-NUL-h=
eader) &&
>>>> +       test_when_finished "remove_object $new" &&
>>>> +       git update-ref refs/heads/bogus "$new" &&
>>>> +       test_when_finished "git update-ref -d refs/heads/bogus" &&
>>>> +       test_must_fail git fsck 2>out &&
>>>> +       cat out &&
>>>
>>> What is the purpose of this 'cat'?
>>
>> It shows the full error message when the test is run with --debug, w=
hich is
>> convenient when the following grep doesn't match.  The same is done =
in most
>> tests in that file.
>
> I'm slightly negative on such a construct, just because it wastes a
> process in the case where we are not in --verbose mode. I don't mind =
it
> in this patch in the spirit of consistency within t1450, but I think =
we
> should probably avoid spreading it.

This practice is not used that much (yet).  We can contain it by
providing an alternative.  I'll send patches for adding a helper
function similar to test_must_be_empty for that.

Ren=C3=A9
