Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F661F453
	for <e@80x24.org>; Tue,  5 Feb 2019 09:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfBEJtC (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 04:49:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:34019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbfBEJtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 04:49:00 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFAaV-1gtR6Q168x-00GIc5; Tue, 05
 Feb 2019 10:48:41 +0100
Date:   Tue, 5 Feb 2019 10:48:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
In-Reply-To: <20190204200754.16413-1-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902051045460.41@tvgsbejvaqbjf.bet>
References: <20190126221811.20241-1-newren@gmail.com> <20190204200754.16413-1-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tz304WO5OBTslq+3jZEHp7hgLVmRhoGI2RgyJGXMRAOwZIgyV1M
 EChAiRpdsdzOHllzUsPfrLx/f4ABVXSi4qFXEiUQhBWTvenej3Vs4+DzmOv7NAr+syRLwLh
 yVfh0Mlb0naCHBozZIfHHQJTX3nxo3OXmCdEZWe21R/EF4ghxd86jK2V1RCAClSok7LwI7e
 2MzmkAH0K9H3Pbz+5nIDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/rIrKgtBfxs=:YDxrArvrK4XcTG+epNJmBX
 QbGniwKYC/H83JABd3Zcw/exAb652lU/Z8jtD6+y70chx71ULuC/fWk8OKAG3W/S9vuXAbjDJ
 d5tWtHmWM1wcTnuVEBVyDnIR5dNOE+n894wdHinzugzasoD3rqYtyBzodoL2qxTca9rDD/nCX
 0p8a81c0M778IJGYYP46W5jdutevqWCYvaI8R8xSwK7rQ2XfI4bEY5iNX0GWaZBZyJK9qAMsx
 2nBUXQPAhWIIBwHvWw1B7+4S7wWqRAl7x3TPggKKf6nBW/yWZ1Fd/P7vOLdIrz4kscPclxWvz
 Si04Wo5KVj/50EOO3503OiDQ5OoRHV6pvbvB1YPzhBsai4Lwrr4i6YttelrTYMORsBmk05ueI
 BfyFYQfDT+ls8UP/e0BuwBDZGWhsBhHseHwjLGROJqNEb6wMuui+KB3whlZF2rmdJhvhuLgxy
 Et1B/UZQpfh8mFiKGHJDKliYx2IShPDCw9fcIrg3VrE5JKke/6HvTcWEqPA8Pfwb/38zKhxeJ
 cuc3Lf/0y/GhTzboXoSAfi56FLK+W+RrRrdro7x9dglOdux4PKWEWRtUVUsk4OXk1/QHBwxoT
 VOuPWxKeCnvFeSzTk1hroBN2zk12v+BK6xCclLAux61w7jhopGGm8wRx2vbNjmrn8LEbowenp
 3TX//PhPz2KSLAjRfZ70LVJ+m+OsUB85LcK1+CKnpmWjwqtUHGOZ6Rc4TvO4IKzqFkOiSWvxE
 v0bqnX2TPRUwuY1hkVg4/9DsSG0YmLcJLOJZRYX541/HVrJTFNdgStTluB6K0Dws0L4N6mybr
 etssLiFYQn3U0uTRGC8yDfcgdTjDLOuUUGTAMEO5rHHz2ynwyZpI8P1E8A3m8h65+BClP+mwW
 JNbQHIFWcGaYGBLSJm9RkLp7cPLth+pJ5PGurqitiBc80aadAwzfw01qCD1aM+g/n+nG8k2Vm
 cBnpkkvuGpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 4 Feb 2019, Elijah Newren wrote:

> The combined diff format for merges will only list one filename, even if
> rename or copy detection is active.  For example, with raw format one
> might see:
> 
>   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
>   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	bar.sh
>   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	phooey.c
> 
> This doesn't let us know what the original name of bar.sh was in the
> first parent, and doesn't let us know what either of the original names
> of phooey.c were in either of the parents.  In contrast, for non-merge
> commits, raw format does provide original filenames (and a rename score
> to boot).  In order to also provide original filenames for merge
> commits, add a --combined-all-names option (which must be used with
> either -c or --cc, and is likely only useful with rename or copy
> detection active) so that we can print tab-separated filenames when
> renames are involved.  This transforms the above output to:
> 
>   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	desc.c	desc.c	desc.c
>   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	foo.sh	bar.sh	bar.sh
>   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	fooey.c	fuey.c	phooey.c
> 
> Further, in patch format, this changes the from/to headers so that
> instead of just having one "from" header, we get one for each parent.
> For example, instead of having
> 
>   --- a/phooey.c
>   +++ b/phooey.c
> 
> we would see
> 
>   --- a/fooey.c
>   --- a/fuey.c
>   +++ b/phooey.c
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

I do not really see where this needs to have tests with filenames
containing tabs, but your test does create such files. Which makes it
break on filesystems that do not allow tabs in file names, such as
NTFS. I need this to make the test pass again:

-- snip --
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 5bccc323f648..596705985baa 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -435,7 +435,7 @@ test_expect_success 'combine diff gets tree sorting right' '
 	test_cmp expect actual
 '
 
-test_expect_success 'setup for --combined-with-paths' '
+test_expect_success FUNNYNAMES 'setup for --combined-with-paths' '
 	git branch side1c &&
 	git branch side2c &&
 	git checkout side1c &&
@@ -456,7 +456,7 @@ test_expect_success 'setup for --combined-with-paths' '
 	git commit
 '
 
-test_expect_success '--combined-all-names and --raw' '
+test_expect_success FUNNYNAMES '--combined-all-names and --raw' '
 	cat <<-\EOF >expect &&
 	::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR	"file\twith\ttabs"	"i\tam\ttabbed"	"fickle\tnaming"
 	EOF
@@ -465,13 +465,13 @@ test_expect_success '--combined-all-names and --raw' '
 	test_cmp expect actual
 '
 
-test_expect_success '--combined-all-names and --raw -and -z' '
+test_expect_success FUNNYNAMES '--combined-all-names and --raw -and -z' '
 	printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
 	git diff-tree -c -M --raw --combined-all-names -z HEAD >actual &&
 	test_cmp -a expect actual
 '
 
-test_expect_success '--combined-all-names and --cc' '
+test_expect_success FUNNYNAMES '--combined-all-names and --cc' '
 	cat <<-\EOF >expect &&
 	--- "a/file\twith\ttabs"
 	--- "a/i\tam\ttabbed"
-- snap --

But maybe you want to get rid of the funny file names? Or test for them in
a separate, dedicated test case so that we do not have to guard *all* of
your added tests behind FUNNYNAMES?

Ciao,
Dscho
