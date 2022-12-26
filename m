Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA32C4167B
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 19:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiLZTxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Dec 2022 14:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLZTxU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2022 14:53:20 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F84117C
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672084391; bh=U1Yrjciubp811cKfdv94kbDsxnDTZZFjWnzFWecwLQU=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
        b=vdsbqHiGUrWwnQr7yAEGFYqz9egzYYkJR+mVmEh2DlLHaE3dzh29cvhwxhEXGHpyb
         4q1z/no9JvSL8LlNnG6FvMUpXTbB8IG6SRLe3S3pSNlsEw9zsHZjlmIiIqWSgHxpzO
         opOpoenVv9Q1m6rwJ9BK/jgBEkFEN3kwrUhwtN9jGCKDYhVB0HV4oqoMvaG2Sj0OHR
         J6j5Vs90P/s98VeE0Qurxl1+pZy1WvPsHIwUbMrGiSfGexlkMGTTc/WuhE0hHK4Xx1
         brJb7a1K9FIs5JQ/40iw9PwcD0VNw301vhMmiwjzJ2DwJKq7ONACNyeq3VLM6F/sV9
         D4vSmcX12Vfvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.151.35]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kEP-1pE08c0NVp-004jUB; Mon, 26
 Dec 2022 20:53:11 +0100
Message-ID: <2a5433ae-ec48-0c24-c18e-9a415d29e590@web.de>
Date:   Mon, 26 Dec 2022 20:53:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: js/drop-mingw-test-cmp, was Re: What's cooking in git.git (Dec
 2022, #03; Sun, 11)
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqpmcqv7qh.fsf@gitster.g>
 <o428pr88-sn2p-o715-52ns-1r6750762572@tzk.qr> <xmqqa63ss3fl.fsf@gitster.g>
 <c57ecd23-7ca7-2501-983f-6661c7872a01@gmx.de> <xmqq7cyksy88.fsf@gitster.g>
 <3c55ac67-5090-b7af-a212-2996bad66fb2@kdbg.org>
 <2090204b-52e9-a22f-f0c9-f812d1231863@web.de>
 <ef79236a-1c47-8775-3acb-aa23b7a300f9@kdbg.org>
Content-Language: en-US
In-Reply-To: <ef79236a-1c47-8775-3acb-aa23b7a300f9@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SMh9eiMg0zQhHFurke6viqX3AcAGnSfWOnOBKKjVuHKR5bDo57L
 2qbJsL07rhAcEly+M8lt2XjZWosN1i8Tez2CTtPueC2lZ9uhSgACu/CAMICRdtyAFn0m898
 p/fUOvXylRM8gh35vgHzWCB3+tw/sqy5ewFMN9nNfeclS+um/hXoDHknYBj/0RQw8rln8zq
 fGIqcfp4zp2jQe8ciF/Jw==
UI-OutboundReport: notjunk:1;M01:P0:mNVvP9xYrXA=;M3nD66Xd81nsmfPMhl61oWLn8dD
 vuBf5FqtVY69LjfEVDNDMfsiZbUgthG88SQlN2KaGOKN5aLqJgtE+PtxN9UQ5P+gyJ9GRYdSP
 D2eikI0Jx64d3WBRCe2DLf5ktBJZEBDZML1MtzLXKHKEuxdH0ybiXoTtW58dm1nUQ02yEX6rh
 EQ5fOG6Oc9yvfp5zZkHFyH93kJTNl8RqBtoXz1HrleG3hqLiqIK3BgDLED2cWdA5eY77CnsAH
 EpqQkm0QFXIGZU1XBL0LAWL+39jdB/VkvgPxtqLKDZhoNolETQyvGfggVbnLT5GJ8l6vEIBip
 275xmSPSzin913SwzWKUx1W4Ah+gbMdzb4oPeWjglwj4WTkriM62gc0GAdhTS9c89L3zAYWDQ
 HhNPe+Z2jYV3nqrpf5KxoOGVXNo6CmbrxT7CyFl/EKM6X2zvR056QZ1yyYl583Mo92vUahS3t
 W5N5PF6nHa+uXrl75wxUr+/bihcXLwpdJCww29RtYIqav4EqhtgANVfWfQa6BmQOH7QYSPmH3
 8MsmaC7w5OrbXFJ89c2cqQx7qDotiOaq5PJiVuHwURmuZNByELVWlm5nR2fPlYfzyWmuCm6Nc
 2p0rcGgtKZQ2nliHxViES5v3PHRw7yyJre8Jf/FaCCNP4D5xZk8D7BY3klAMguIrel0w30PgT
 dPWXGoNK9ZPnr56p6fkKk8UbnDIERGjWcoXbBnoFjhTzToWDnAVszbIK1UqD8Oq8Nu68sRJx2
 pY/0i7fC7RpmmTxcpoLHDeKDfLbl1FIwBNBiY8s9CuzaEJXixDj8SVM2JUo+D7of4JU0xjNeP
 HGWPefMED8Qqmojz4Dio0xcpPNft7XXA+b/SlFM4AKtU5UEwpidyUAwbtKxZMeRz1RhUWbBuA
 EsEkyz6r1cLaViRG0f6G1Rh0JBqGRBKYkRXxCAvfGdChbrICR5QNTN1iyLbN+F2ToOJ6Np3Iw
 lfznPQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.12.2022 um 16:44 schrieb Johannes Sixt:
> Am 24.12.22 um 14:31 schrieb Ren=C3=A9 Scharfe:
>> Am 24.12.22 um 09:10 schrieb Johannes Sixt:
>>> Am 21.12.22 um 14:05 schrieb Junio C Hamano:
>>>> I know we have been operating under such a test environment, but
>>>> after seeing the exchange between R=C3=A9ne and J6t, I was hoping tha=
t we
>>>> do not have to keep being sloppy.
>>>
>>> Things did not turn out to be as simple. After ripping out all
>>> special-casing of GIT_TEST_CMP from a MinGW build, I notice at least o=
ne
>>> case that needs special treatment (it's `tar tf` that writes CRLF
>>> output).
>>
>> That would affect t6132 and perhaps t9502, right?
>>
>> How can I reproduce it?  I get only LF:
>>
>>    $ uname -rs
>>    MINGW64_NT-10.0-22621 3.3.6-341.x86_64
>>
>>    $ git archive HEAD Makefile | tar tf - | hexdump.exe -C
>>    00000000  4d 61 6b 65 66 69 6c 65  0a                       |Makefil=
e.|
>>    00000009
>>
>> Is there some configuration option that I need to set?
>
> Good catch! Looks like I am wrong. In my environment I give the Windows
> tools precedence over the MinGW tools. There is a tar.exe in
> C:\Windows\System32 that writes CRLF (instead of just LF) that I was
> using in my test runs.

Interesting, I have that program as well:

   $ git archive HEAD Makefile | /c/Windows/System32/tar.exe tf - | hexdum=
p.exe -C
   00000000  4d 61 6b 65 66 69 6c 65  0d 0a                    |Makefile..=
|
   0000000a

   $ /c/Windows/System32/tar.exe --version
   bsdtar 3.5.2 - libarchive 3.5.2 zlib/1.2.5.f-ipp bz2lib/1.0.6

And indeed on my system the SDK's variant is used:

   $ which tar
   /usr/bin/tar

There are a few more commands in System32 that could shadow the ones
in the SDK:

   $ for f in /c/Windows/system32/*.exe; do p=3D${f%.exe}; w=3D"$(which ${=
p##*/} 2>/dev/null)" && test "$p" !=3D "$w" && echo "$w"; done
   /usr/bin/bash
   /usr/bin/cmd
   /mingw64/bin/curl
   /usr/bin/expand
   /usr/bin/find
   /usr/bin/klist
   /usr/bin/notepad
   /usr/bin/sort
   /usr/bin/tar
   /usr/bin/timeout
   /usr/bin/whoami

Windows' find and sort are quite different from GNU's.  That's handled
in t/test-lib.sh by forcing the use of the variants from /usr/bin.
Should we do the same for tar?

Not sure about curl; /mingw64/bin/curl writes CRLFs as well.

expand.exe is very different from GNU's, but we only use it in
t/t4135/make-patches, which is not executed during a test suite run.

>>> For the time being, I suggest to take Dscho's patch.
>>
>> The patch is intended to make comparisons faster.  That works for big
>> files, but the test suite compares small ones.   The total duration of
>> a test suite run is about one minute longer with the patch than without
>> it for me [1].  I retried with 7c2ef319c5 (The first batch for 2.40,
>> 2022-12-19), and that's still the case.  Do you get different numbers?
>
> I'm not going to measure it (one full run takes ~2 hours). I trusted
> Dscho's argument that this patch brings a much better improvement based
> on the one case that is cited in the commit message, but if that was
> just an extraordinary outlier, I am not sure anymore...

Painful, I know.

Logged the sizes of files handed to test_cmp (on macOS).  19170 calls,
median size 42 bytes, average size 617 bytes.  2307 calls with empty
files, 1093 of which in t1092 alone.  The two biggest files in t1050,
2000000 and 2500000 bytes.  t9300 in third place with 180333, one
magnitude smaller.

t1050 at 8a4e8f6a67 (The second batch, 2022-12-26) on Windows:

Benchmark 1: sh.exe t1050-large.sh
  Time (mean =C2=B1 =CF=83):     18.312 s =C2=B1  0.069 s    [User: 0.000 =
s, System: 0.003 s]
  Range (min =E2=80=A6 max):   18.218 s =E2=80=A6 18.422 s    10 runs

... and with the patch:

Benchmark 1: sh.exe t1050-large.sh
  Time (mean =C2=B1 =CF=83):      5.709 s =C2=B1  0.046 s    [User: 0.000 =
s, System: 0.003 s]
  Range (min =E2=80=A6 max):    5.647 s =E2=80=A6  5.787 s    10 runs

So it works as advertised for big files, but calling an external
program 19000 times takes time as well, which explain the longer
overall test suite duration.

If we use test_cmp_bin for the two biggest comparisons we get the
same speedup:

Benchmark 1: sh.exe t1050-large.sh
  Time (mean =C2=B1 =CF=83):      5.719 s =C2=B1  0.089 s    [User: 0.000 =
s, System: 0.006 s]
  Range (min =E2=80=A6 max):    5.659 s =E2=80=A6  5.960 s    10 runs

Is this safe?  The files consist of X's and Y's at the point of
comparison, so they aren't typical binary files, but they don't
have line endings at all or any user-readable content, so I think
treating them as blobs is appropriate.

=2D--
 t/t1050-large.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index c71932b024..c184540855 100755
=2D-- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -90,7 +90,7 @@ test_expect_success 'checkout a large file' '
 	large1=3D$(git rev-parse :large1) &&
 	git update-index --add --cacheinfo 100644 $large1 another &&
 	git checkout another &&
-	test_cmp large1 another
+	test_cmp_bin large1 another
 '

 test_expect_success 'packsize limit' '
@@ -192,7 +192,7 @@ test_expect_success 'pack-objects with large loose obj=
ect' '
 	test_create_repo packed &&
 	mv pack-* packed/.git/objects/pack &&
 	GIT_DIR=3Dpacked/.git git cat-file blob $SHA1 >actual &&
-	test_cmp huge actual
+	test_cmp_bin huge actual
 '

 test_expect_success 'tar archiving' '
=2D-
2.38.1.windows.1
