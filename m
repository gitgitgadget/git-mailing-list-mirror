Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33B81F453
	for <e@80x24.org>; Tue,  6 Nov 2018 20:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeKGFnR (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 00:43:17 -0500
Received: from mout.web.de ([217.72.192.78]:38021 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeKGFnR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 00:43:17 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRCrb-1fxCXt3Wnf-00UXp4; Tue, 06
 Nov 2018 21:16:18 +0100
Date:   Tue, 6 Nov 2018 21:16:18 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?Adri=E1n?= Gimeno Balaguer <adrigibal@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-rebase is ignoring working-tree-encoding
Message-ID: <20181106201618.GA30158@tor.lan>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181104170729.GA21372@tor.lan>
 <CADN+U_MgrGHLQ5QNa-HgzxLN4zJLJPu4PaT2MTRoc18=gET+5Q@mail.gmail.com>
 <20181105181014.GA30777@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181105181014.GA30777@tor.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:JPIkLPf7zMoSErP2W2JeubtXcSuEIg+NiXegrdvGLQmVV62p2nk
 HCwfGAc2NCYUC9jUWi9AQiC25MJjBOdYdbYHlVziZ9rQViKPgo3o69sCrdRVwQ+HSj98ozO
 QJ71Z6imQlDuvNouCHD6ZF3F2E2R33mdYvDQ+MNuuAnJgT1iMDk/7SNi0fN8RC/Ts90Og2O
 V1BuHs6FAZeshOeEX9uuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JiGm1okMamI=:czyDZ5GidIBcEYa4SIoldQ
 Q3/DqHUYZtab6+8nnLKJLwL214IrIr+DuwXAwC/JnC5Y5tBIY/TSL/xWnfZpNZe37xOrXXlAr
 vDAXNcoTxPV+Uby01ffdFUGoj+yDMOhtuHSsMhAXUCrTDDHz/d6Jl36PMW2rMPHL6JdEbrmGI
 qhMou+siofRzDZb1zHSy7qG94z+9hjmDcwiXsoqZ3cYp4pgnTm1J45GJsTE0aP2F6Mh9vjylE
 UgvMaQjBZhNkdmj73DQUKp1vMzSYY2edQJj8SrixpkoR+FhgYYp8gAZzlX7wE+qXL5UxbiBmi
 IsVJaz4HihWCfcIX5JsPxGTtzgxuMFn/V4MNtoPM69q6JOLbRUX+6+pzo9+PYNWgupLIrf5Qc
 FS8vPU6NGHV76HTxHgaIGRIxQXuuRAe7oB2Pc6T7axWzWJkQpPeGqMCsR1bPfWKWVXVVVPEIN
 63C5UOG9t7yRtc13wK/ozxCILQQNjDciKHmq1O5igUG5F1Lip6wr1makpryOEz4OqJ88acafD
 fxgMO+tIeoC1/Wwh4mEnCjZGXqjd0o4v+feeNVkDE0SnjmzNDs5QnMBrEhqRjNJKw0TDbQUJx
 1C8ZkDAMYnUaWrtf2RmV6DG3W3X+nFK0FCbHxLa5YXl1DM6XBfeJxugtJEHKewmkJ1TzAOMrd
 phE9r7d3fFMxzFpUhzuIfAxZBAWIg8uymnEJYx1jh9oUlL0AN1KS0tX38MyiRNH72+1l63xVS
 YK8mseGYIbnk3P1ihm8JqqG5C++l7rWZHpIRUr3VmZpJjKpVZNq8VC3DSqYaxOt2j07Wv6rzq
 VAzxFA+52oJhrCi6rwhHoKdAoPwKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 05, 2018 at 07:10:14PM +0100, Torsten Bögershausen wrote:
> On Mon, Nov 05, 2018 at 05:24:39AM +0100, Adrián Gimeno Balaguer wrote:
> 
> []
> 
> > https://github.com/git/git/pull/550
>  
> []
>  
> > This is covered in the mentioned PR above. Thanks for feedback.
> 
> Thanks for the code,
> I will have a look (the next days)
> 
> > 
> > -- 
> > Adrián

Hej Adrián,

I still didn't manage to fully understand your problem.
I tried to convert your test into my understanding,
It can be fetched here (or copied from this message, see below)

https://github.com/tboegi/git/tree/tb.181106_UTF16LE_commit

The commit of an empty file seems to work for me, in the initial
report a "rebase" was mentioned, which is not in the TC ?

Is the following what you intended to test ?

#!/bin/sh
test_description='UTF-16 LE/BE file encoding using working-tree-encoding'


. ./test-lib.sh

# We specify the UTF-16LE BOM manually, to not depend on programs such as iconv.
utf16leBOM=$(printf '\377\376')

test_expect_success 'Stage empty UTF-16LE file as binary' '
	>empty_0.txt &&
	echo "empty_0.txt binary" >>.gitattributes &&
	git add empty_0.txt
'


test_expect_success 'Stage empty file with enc=UTF.16BL' '
	>utf16le_0.txt &&
	echo "utf16le_0.txt text working-tree-encoding=UTF-16BE" >>.gitattributes &&
	git add utf16le_0.txt
'


test_expect_success 'Create and stage UTF-16LE file with only BOM' '
	printf "$utf16leBOM" >utf16le_1.txt &&
	echo "utf16le_1.txt text working-tree-encoding=UTF-16" >>.gitattributes &&
	git add utf16le_1.txt
'

test_expect_success 'Dont stage UTF-16LE file with only BOM with enc=UTF.16BE' '
	printf "$utf16leBOM" >utf16le_2.txt &&
	echo "utf16le_2.txt text working-tree-encoding=UTF-16BE" >>.gitattributes &&
	test_must_fail git add utf16le_2.txt
'

test_expect_success 'commit all files' '
	test_tick &&
	git commit -m "Commit all 3 files"
'

test_expect_success 'All commited files have the same sha' '
	git ls-files -s --eol >tmp1 &&
	sed -e "s!	i/none.*!!" <tmp1 | uniq -u >actual &&
	>expect &&
	test_cmp expect actual
'

test_done
