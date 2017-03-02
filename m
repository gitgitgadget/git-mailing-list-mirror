Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5C71F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 18:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754665AbdCBSYd (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 13:24:33 -0500
Received: from mout.web.de ([217.72.192.78]:62896 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753232AbdCBSYc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 13:24:32 -0500
Received: from macce.lan ([213.64.64.87]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M57Vi-1cN3Vi1MZK-00zEGe; Thu, 02
 Mar 2017 19:17:00 +0100
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with
 CRLF conversions
To:     Mike Crowe <mac@mcrowe.com>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
 <20170301170444.14274-1-tboegi@web.de> <20170301212535.GA6878@mcrowe.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <5d92d3b8-f438-9be5-9742-22f8cd8fe03d@web.de>
Date:   Thu, 2 Mar 2017 19:17:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170301212535.GA6878@mcrowe.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:SZfzg4PYPvvHzVO6kbUz62V3MNOv+wbPxcEj1xoECyQDfaP2R0C
 livQr3kSyyWwDGwZuvmBE+iBO7a78VVeg9z4FxjR5CGBoyKxeI4Kf6I5aNFoteQaHvjM2Sw
 gbH70thdLhdSH8EwLGgQ1rxhyvHMUixFS0qwZkemEUBGVxTnaVXH5QuUFYDZKZxmVyoE86Q
 j5IpfaF6r7K+W5UJmtQIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XHEqz7d5YhM=:mumHOxJhTWZUR0YcVXVpRO
 ThwHdU2bR8x5eCnwNTQ4K8L4lJwPLUodtroE1we+Bd4PtOsB7LhSK16I28zWxPnVcFMxomO//
 sFxHLt5mVpaHi5j5eBRpGlMW9lhE36zv4P9EZ6p4BlepNYIEgX/VouThCj241qOkdLSXt5deA
 6lHKaN5R431w53igN/kjfMWANHahsrGQZCWfr3YouNnGZywKQFKQ853vm3SsPI0nl3VyzFqj9
 Cy0F+3IjRTxM/YCI0UvgCduLoJYxpg9XdSQaywdf+smVWRQYe8KBrPge5uE+JWr+9o8Y58rZw
 fi/qiAPmka3K1OOF2kuUDAxgkaxYtbwORtOJbyj6N8cksGYc4YSIvUQqwtSRjSc9TGj8uAytC
 2veIONziHpECw71Nqc4XhbnfLxo9fN/zgOdaZjw2MAmxfRuzmzHCFn9doatWHTNZSvL2DtqSs
 FldbZb58f8M6JuewtVUIDN4E6KkgaDHomP2fQbJe8zxG/oiPajEl2XyHOT/cYFwNwoIy30aT8
 mWOoGm1ve3muf6SdZz5OtS9eVrvpEC5EcJD0vtXYXFvNutYRXPCd+04HsLIyfthThk6idhbru
 hF0frMwMko2g93y7EsNlH4817FPgM0J5vVb+iQg140+oHPFmUew2+m7DAL1Zr52Cwt0mDUTGN
 A3dX7FUjaDPLLF8L0JCxJpyDmUZDW2Ma9ila3sp+aThqlE8jLDOjYP0SSxZoeNvWAbFw3TVtr
 oTxYlyXQAA2qtsjegu4WlcU3joJ8lCvXKibb6voVqLwzty2XAfqxr+4XXN09ys3F06mlg4Wt7
 ZWKXexZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-03-01 22:25, Mike Crowe wrote:
> On Wednesday 01 March 2017 at 18:04:44 +0100, tboegi@web.de wrote:
>> From: Junio C Hamano <gitster@pobox.com>
>>
>> git diff --quiet may take a short-cut to see if a file is changed
>> in the working tree:
>> Whenever the file size differs from what is recorded in the index,
>> the file is assumed to be changed and git diff --quiet returns
>> exit with code 1
>>
>> This shortcut must be suppressed whenever the line endings are converted
>> or a filter is in use.
>> The attributes say "* text=auto" and a file has
>> "Hello\nWorld\n" in the index with a length of 12.
>> The file in the working tree has "Hello\r\nWorld\r\n" with a length of 14.
>> (Or even "Hello\r\nWorld\n").
>> In this case "git add" will not do any changes to the index, and
>> "git diff -quiet" should exit 0.
>>
>> Add calls to would_convert_to_git() before blindly saying that a different
>> size means different content.
>>
>> Reported-By: Mike Crowe <mac@mcrowe.com>
>> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
>> ---
>> This is what I can come up with, collecting all the loose ends.
>> I'm not sure if Mike wan't to have the Reported-By with a
>> Signed-off-by ?
>> The other question is, if the commit message summarizes the discussion
>> well enough ?
>>
>> diff.c                    | 18 ++++++++++++++----
>>  t/t0028-diff-converted.sh | 27 +++++++++++++++++++++++++++
>>  2 files changed, 41 insertions(+), 4 deletions(-)
>>  create mode 100755 t/t0028-diff-converted.sh
>>
>> diff --git a/diff.c b/diff.c
>> index 051761b..c264758 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4921,9 +4921,10 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
>>  	 *    differences.
>>  	 *
>>  	 * 2. At this point, the file is known to be modified,
>> -	 *    with the same mode and size, and the object
>> -	 *    name of one side is unknown.  Need to inspect
>> -	 *    the identical contents.
>> +	 *    with the same mode and size, the object
>> +	 *    name of one side is unknown, or size comparison
>> +	 *    cannot be depended upon.  Need to inspect the
>> +	 *    contents.
>>  	 */
>>  	if (!DIFF_FILE_VALID(p->one) || /* (1) */
>>  	    !DIFF_FILE_VALID(p->two) ||
>> @@ -4931,7 +4932,16 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
>>  	    (p->one->mode != p->two->mode) ||
>>  	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
>>  	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
>> -	    (p->one->size != p->two->size) ||
>> +
>> +	    /*
>> +	     * only if eol and other conversions are not involved,
>> +	     * we can say that two contents of different sizes
>> +	     * cannot be the same without checking their contents.
>> +	     */
>> +	    (!would_convert_to_git(p->one->path) &&
>> +	     !would_convert_to_git(p->two->path) &&
>> +	     (p->one->size != p->two->size)) ||
>> +
>>  	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
>>  		p->skip_stat_unmatch_result = 1;
>>  	return p->skip_stat_unmatch_result;
>> diff --git a/t/t0028-diff-converted.sh b/t/t0028-diff-converted.sh
>> new file mode 100755
>> index 0000000..3d5ab95
>> --- /dev/null
>> +++ b/t/t0028-diff-converted.sh
>> @@ -0,0 +1,27 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2017 Mike Crowe
>> +#
>> +# These tests ensure that files changing line endings in the presence
>> +# of .gitattributes to indicate that line endings should be ignored
>> +# don't cause 'git diff' or 'git diff --quiet' to think that they have
>> +# been changed.
>> +
>> +test_description='git diff with files that require CRLF conversion'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success setup '
>> +	echo "* text=auto" >.gitattributes &&
>> +	printf "Hello\r\nWorld\r\n" >crlf.txt &&
>> +	git add .gitattributes crlf.txt &&
>> +	git commit -m "initial"
>> +'
>> +
>> +test_expect_success 'quiet diff works on file with line-ending change that has no effect on repository' '
>> +	printf "Hello\r\nWorld\n" >crlf.txt &&
>> +	git status &&
>> +	git diff --quiet
>> +'
>> +
>> +test_done
> 
> Hi Torsten,
> 
> Thanks for investigating this.
> 
> I think that you've simplified the test to the point where it doesn't
> entirely prove the fix. Although you test the case where the file has
> changed size, you don't test the case where it hasn't.
> 
> Unfortunately that was the part of my test that could only reproduce the
> problem with the sleeps. Maybe someone who understands how the cache works
> fully could explain an alternative way to force the cache not to be used.
> 
> Also, I think I've found a behaviour change with this fix. Consider:
> 
>  echo "* text=auto" >.gitattributes
>  printf "Hello\r\nWorld\r\n" >crlf.txt
That should give
"Hello\nWorld\n" in the index:

git add .gitattributes crlf.txt
warning: CRLF will be replaced by LF in ttt/crlf.txt.
The file will have its original line endings in your working directory.
tb@mac:/tmp/ttt> git commit -m "initial"
[master (root-commit) 354f657] initial
 2 files changed, 3 insertions(+)
 create mode 100644 ttt/.gitattributes
 create mode 100644 ttt/crlf.txt
tb@mac:/tmp/ttt> git ls-files --eol
i/lf    w/lf    attr/text=auto          .gitattributes
i/lf    w/crlf  attr/text=auto          crlf.txt
tb@mac:/tmp/ttt>

>  git add .gitattributes crlf.txt
>  git commit -m "initial"
> 
>  printf "\r\n" >>crlf.txt
> 
> With the above patch, both "git diff" and "git diff --quiet" report that
> there are no changes. Previously Git would report the extra newline
> correctly.
Wait a second.
Which extra newline "correctly" ?

The "git diff" command is about the changes which will be done to the index.
Regardless if you have any of these in the working tree on disk:

"Hello\nWorld\n"
"Hello\nWorld\r\n"
"Hello\r\nWorld\n"
"Hello\r\nWorld\r\n"

"git status" and "git diff --quiet"
should not report any changes.

So I don't know if there is a mis-understanding about "git diff" on your side,
or if I miss something.


