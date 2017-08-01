Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4442047F
	for <e@80x24.org>; Tue,  1 Aug 2017 20:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbdHAUrk (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 16:47:40 -0400
Received: from mout.web.de ([217.72.192.78]:64384 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752512AbdHAUrj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 16:47:39 -0400
Received: from [192.168.209.18] ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLxD-1dVXLK418J-011kLQ; Tue, 01
 Aug 2017 22:47:30 +0200
Subject: Re: core.autocrlf=true causes `git apply` to fail on patch generated
 with `git diff-index HEAD --patch`
To:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
References: <CA+dzEBmsgUjmf5fUmeiwS=Q81OgpL6K5p=8dBuTjuZ4XE1V5SA@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <287407ac-b0d0-ef24-4950-0982a2db9bed@web.de>
Date:   Tue, 1 Aug 2017 22:47:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CA+dzEBmsgUjmf5fUmeiwS=Q81OgpL6K5p=8dBuTjuZ4XE1V5SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zMUgpW2CmA2H3mw6mCH0A2hllMAjEdlD9PYNKYS2lbtEvUtw24w
 D1jtq8lXfCYxNXuFY+c/RypMwp3dATX6ZBzkLKcYXTEbe9BrmP93iqgoxZuHkKWP6XQJdyy
 D6Z6q9dURZ4jeVQSd7PK0xsn4+25I/JXTfVDcOANOuwVLj79HazX74LNiyTgDVmfLAxS1xL
 xz7EShpzmAMiGflCULRwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pw5RA74BKAA=:0Bm7PBjfWBlG56ySpu94FS
 KonXwyCPAxY85cCioAeyb/MXkNwikGWDJujIBxxWhv5fjAgxxX2q3eW6WVntUqqaMnzsy8Yfk
 H8izvNagOu7EFxaHi4d8TJJbUHp7kao6bSfb+w3JSqeESwQ488yBGFXoY/TBB4zGzxMCOKMCg
 OMQW6PNFvI+MBFWjahRJyuRETij8JwISHqB4tusaDXDES7UINSACMNGMo9Yj8IjK/phcyLQWD
 nUKLGgPVIcU9SmH8/KrvOHoqIOSftKoVCQQ1IJKVZS8/5LzRTQKEU6ju7+bdpfmh9ZXd9YLdL
 ppO5m6bwt07CCPogyDBVG2SyAB5W4ONpnvKVDBsS9mOt3seaIkkP09agOKa2An+5yilmufUXZ
 Yhaq4+Y+xJTOM2Krl5oe8aHv57viHRK7Tilh5xlxV1X7G3W2ig2DiWMpRsyZi9bODJI8tFC5t
 AYl1CxkeqTkkMoA1CBGgocBSE+ld+ryotZCBzNwXhAYaj9o7hzkbtzTHTzTkkpvhJMS0M/aum
 O33q2EWZsT5yvi1HkAktlCFSrbRhm6uOq/vTaHVBkV7WlbaHel7cxk9pyVHknAdwRyEqB5Tyf
 97KCVSP6v8MBPFzWcfdKKOj3EQ2JEpM4mnDVGH0vclj9vIp7Bq/NH8C6qrULUZPNFnUsyos9O
 nJgAUdOxBeJjlrjmj7R076DelMQYC+E32GfrBFCQlU/uF/OMKSlsy9shA4+NG1uI24MPQey+0
 u402mGea03j1LzpKBuU8WU5/ckD9vodcC9GFVFwyh6M96QiCPNqwF45PkHp+7Z4+04Ce8X24r
 RHsE8LGCNrIphl8V7e8LYjyjZUNw2dWYiXmXwTTSFQFTfWFjfY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/01/2017 08:24 PM, Anthony Sottile wrote:
> Here's my minimal reproduction -- it's slightly far-fetched in that it
> involves*committing crlf*  and
> then using `autocrlf=true` (commit lf, check out crlf).
>
> ```
> #!/bin/bash
> set -ex
>
> rm -rf foo
> git init foo
> cd foo
>
> # Commit crlf into repository
> git config --local core.autocrlf false
> python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n")'
> git add foo
> git commit -m "Initial commit with crlf"
>
> # Change whitespace mode to autocrlf, "commit lf, checkout crlf"
> git config --local core.autocrlf true
> python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n\r\n\r\n\r\n")'
>
> # Generate a patch, check it out, restore it
> git diff --ignore-submodules --binary --no-color --no-ext-diff > patch
> python3 -c 'print(open("patch", "rb").read())'
> git checkout -- .
> # I expect this to succeed, it fails
> git apply patch
> ```
>
> And here's the output:
>
> ```
> + rm -rf foo
> + git init foo
> Initialized empty Git repository in/tmp/foo/.git/
> + cd foo
> + git config --local core.autocrlf false
> + python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n")'
> + git add foo
> + git commit -m 'Initial commit with crlf'
> [master (root-commit) 02d3246] Initial commit with crlf
>   1 file changed, 2 insertions(+)
>   create mode 100644 foo
> + git config --local core.autocrlf true
> + python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n\r\n\r\n\r\n")'
> + git diff --ignore-submodules --binary --no-color --no-ext-diff
> + python3 -c 'print(open("patch", "rb").read())'
> b'diff --git a/foo b/foo\nindex bd956ea..fbf7936 100644\n---
> a/foo\n+++ b/foo\n@@ -1,2 +1,5 @@\n 1\r\n 2\r\n+\r\n+\r\n+\r\n'
> + git checkout -- .
> + git apply patch
> patch:8: trailing whitespace.
>
> patch:9: trailing whitespace.
>
> patch:10: trailing whitespace.
>
> error: patch failed: foo:1
> error: foo: patch does not apply
> ```
>
> I also tried with `git apply --ignore-whitespace`, but this causes the
> line endings of the existing contents to be changed to*lf*  (there may
> be two bugs here?)
>
> Thanks,
>
> Anthony


I can reproduce you test case here.

The line

git apply patch

would succeed, if you temporally (for the runtime of the apply command) set
core.autocrlf to false:

git -c core.autocrlf=false apply patch

So this seems to be a bug (in a corner case ?):

Typically repos which had been commited with CRLF should be normalized,
which means that the CRLF in the repo are replaced by LF.
So you test script is a corner case, for which Git has not been designed,
It seems as if "git apply" gets things wrong here.
Especially, as the '\r' is not a whitespace as a white space. but part
of the line ending.
So in my understanding the "--ignore-whitespace" option shouldn't affect
the line endings at all.

Fixes are possible, does anyone have a clue, why the '\r' is handled
like this in apply ?

And out of interest: is this a real life problem ?



  


