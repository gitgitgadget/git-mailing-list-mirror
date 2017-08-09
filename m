Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9931F991
	for <e@80x24.org>; Wed,  9 Aug 2017 14:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbdHIOPd (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 10:15:33 -0400
Received: from mout.web.de ([217.72.192.78]:58413 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbdHIOPc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 10:15:32 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPNm-1detne0ogE-000bkc; Wed, 09
 Aug 2017 16:15:12 +0200
Subject: Re: [PATCH] t4062: stop using repetition in regex
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
 <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
 <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de>
 <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
 <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com>
 <cd60d779-fe38-4f0e-4d36-2c40b2afec7d@web.de>
 <xmqqtw1h8g1u.fsf@gitster.mtv.corp.google.com>
 <50c2eaab-d1d8-3376-6e7a-1c898d978d12@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e3e65635-2dc8-de58-5662-3eab619aedb3@web.de>
Date:   Wed, 9 Aug 2017 16:15:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <50c2eaab-d1d8-3376-6e7a-1c898d978d12@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BBUIPZSQvP9IfOqGpETt9FHSQ4gt/S0atpbhSpPOyg/nyHfdK4f
 iM+LaaT1AmWj10078ObpvinuIh8yMHHmryaD+NENZ3PYsaoF6yklnk1ufrs8OvFVAJWmYWd
 OM+JUn3n+7YzJ/jCYfTV7UN/UE7yc2mEbznKMjEAal/KvzWtwQZEpzQIpAZXd4Y4/A4Sfle
 2ICOwQ2qBBBdR0SQ1Hl7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yFC/q4yLZI0=:gjyssht2JB1pbuUlg/tYMF
 cBX654Ar+ujDg8iD/ZBk9rzxVi85IHITduIcGtFzt4E2lSu1pOVpAgQIgwXC1gPLqjFUchJYB
 zOXYbGMjPKaZ2rp2aQfdkoIcD7S4tY72W3fag4DoVrprV+Bw+wTBRXWU/PLVo8CTf44MwGxp+
 /ynTU6Z+K70mzajy8vC6wvbg/MqF9mVKDvsVuI0Ua103CoqBqSxOI4LtAYN0qhhbZ87EN1XQz
 prGI1R+yV9Bg8jNbgVFrMrKCCJyf+k3K4kEMWOSj+sMxbQlMU2Y7XkH3I6nusB8kmjHAtqSYd
 Hj8ahjQVU2+cNE6wwrUSFC9Qd00eseqZv24Y3hoE2RcQCWi0KrzrBc0chWzAqFd6mkpLaSGNq
 gk2KfVTjfAY3q6iFbhh8FCjQQ5afbMTUieWcKPnaFmN4W8DwyXXeaqn+0W+HxQ5Xa0Qi7Pc72
 uSClTnh3Vi7U/1sckDfm9KxWHICymJbSxDVOgUeiLdXSaJxSq0nBfbKgSUw8xVwLrzSpX2fWj
 OrHw4dhommL4/NOspfykw/I3g8i4wyqwBNkJhLD9fOlpHqABb416cfA0io0fGJXVYs+iaZF0X
 FdHwZd8PAY6HR/G61Fw7RM3380u2/Wqw+6a9zFl2H8Rf1aJ8S/JS/XOnBVKfAPbM1iv4YIbfy
 63GQA3g9OnEVk57DRT/Y/eyauTXMMtAXoxyALjG9E67CYa0zHi/mETiJnoPL1nGfh3paxEKfV
 YGvDFsJGH0vgsd1qeuk4voqlvedmXrrUT4PJo0BAqplsz/ZKjfNRMb4EaVLU+fR9humfijmAm
 DD+9rmQpZo9oOfx+yCRTb06QBXVD7bTVeHwDD/nM2LG8BULN4E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.2017 um 08:15 schrieb René Scharfe:
> Am 09.08.2017 um 07:29 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> Am 09.08.2017 um 00:26 schrieb Junio C Hamano:
>>>> ... but in the meantime, I think replacing the test with "0$" to
>>>> force the scanner to find either the end of line or the end of the
>>>> buffer may be a good workaround.  We do not have to care how many of
>>>> random bytes are in front of the last "0" in order to ensure that
>>>> the regexec_buf() does not overstep to 4097th byte, while seeing
>>>> that regexec() that does not know how long the haystack is has to do
>>>> so, no?
>>>
>>> Our regexec() calls strlen() (see my other reply).
>>>
>>> Using "0$" looks like the best option to me.
>>
>> Yeah, it seems that way.  If we want to be close/faithful to the
>> original, we could do "^0*$", but the part that is essential to
>> trigger the old bug is not the "we have many zeroes" (or "we have
>> 4096 zeroes") part, but "zero is at the end of the string" part, so
>> "0$" would be the minimal pattern that also would work for OBSD.
> 
> Thought about it a bit more.
> 
> "^0{4096}$" checks if the byte after the buffer is \n or \0 in the
> hope of triggering a segfault.  On Linux I can access that byte just
> fine; perhaps there is no guard page.  Also there is a 2 in 256
> chance of the byte being \n or \0 (provided its value is random),
> which would cause the test to falsely report success.
> 
> "0$" effectively looks for "0\n" or "0\0", which can only occur
> after the buffer.  If that string is found close enough then we
> may not trigger a segfault and report a false positive.
> 
> In the face of unreliable segfaults we need to reverse our strategy,
> I think.  Searching for something not in the buffer (e.g. "1") and
> considering matches and segfaults as confirmation that the bug is
> still present should avoid any false positives.  Right?

And that's not it either. *sigh*

If the 4097th byte is NUL or LF then we can only hope its access
triggers a segfault -- there is no other way to distinguish the
result from a legitimate match when limiting with REG_STARTEND.  So
we have to accept this flakiness.

We can check the value of that byte with [^0] and interpret a
match as failure, but that adds negation and makes the test more
complex.

^0*$ would falsely match if the 4097th byte (and possibly later
ones) is 0.  We need to make sure we check for end-of-line after
the 4096th byte, not later.

Sorry, Dscho, I thought we could take a shortcut here, but -- as
you wrote all along -- we can't.

So how about this?

-- >8 --
Subject: [PATCH] t4062: use less than 256 repetitions in regex

OpenBSD's regex library has a repetition limit (RE_DUP_MAX) of 255.
That's the minimum acceptable value according to POSIX.  In t4062 we use
4096 repetitions in the test "-G matches", though, causing it to fail.
Combine two repetition operators, both less than 256, to arrive at 4096
zeros instead of using a single one, to fix the test on OpenBSD.

Original-patch-by: David Coppa <dcoppa@openbsd.org>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4062-diff-pickaxe.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index 7c4903f497..1130c8019b 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -14,8 +14,10 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m "A 4k file"
 '
+
+# OpenBSD only supports up to 255 repetitions, so repeat twice for 64*64=4096.
 test_expect_success '-G matches' '
-	git diff --name-only -G "^0{4096}$" HEAD^ >out &&
+	git diff --name-only -G "^(0{64}){64}$" HEAD^ >out &&
 	test 4096-zeroes.txt = "$(cat out)"
 '
 
-- 
2.14.0
