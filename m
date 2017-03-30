Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295211FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 07:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933300AbdC3Hqs (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 03:46:48 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52349 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932555AbdC3Hqr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 03:46:47 -0400
X-AuditID: 12074412-4a3ff70000000b04-81-58dcb7e41bf8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.20.02820.4E7BCD85; Thu, 30 Mar 2017 03:46:45 -0400 (EDT)
Received: from [192.168.69.190] (p579060CC.dip0.t-ipconnect.de [87.144.96.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2U7kgS6017601
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 30 Mar 2017 03:46:43 -0400
Subject: Re: [PATCH v5 4/6] dir_iterator: add tests for dir_iterator API
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
 <1490844730-47634-5-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <ab7a326c-0189-4542-76e8-649eb6e804c9@alum.mit.edu>
Date:   Thu, 30 Mar 2017 09:46:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490844730-47634-5-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqPt0+50Ig65vGhaPP71ls+i60s1k
        0dB7hdmie8pbRovNm9tZHFg9ds66y+6xYFOpx8VLyh6fN8kFsERx2aSk5mSWpRbp2yVwZbx7
        dYup4K5xxfb/11kbGPdpdjFycEgImEh0/rfvYuTiEBLYwSSx8/AuZgjnPJPE/YnTgBxODmEB
        D4nnf/4xgzSICFhLXF/jBRIWEiiX2PtqNTuIzSxgI3G8qZcRxGYT0JVY1NPMBGLzCthLtK/9
        xAJiswioSvz9NQXMFhUIkZiz8AEjRI2gxMmZT8DinAKOEutOtjJCzNST2HH9FyuELS+x/e0c
        5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZJXqpKaWbGCGh
        K7SDcf1JuUOMAhyMSjy8FWtvRwixJpYVV+YeYpTkYFIS5d08906EEF9SfkplRmJxRnxRaU5q
        8SFGCQ5mJRFeu8VAOd6UxMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZDg4lCd6J
        24AaBYtS01Mr0jJzShDSTBycIMN5gIYfBanhLS5IzC3OTIfIn2JUlBLnfQCSEABJZJTmwfXC
        UssrRnGgV4R5jYGJRogHmJbgul8BDWYCGixucwtkcEkiQkqqgTFDW5dh1/Tq+0YbvWQsRWqd
        hecWtWRd7zMKVbjzx/fHnd/bb6hMufVy56rdL5f6fLO8sTHl+xyPFM4NhyUu2qdZm7xeVr01
        w97pwaNHE16nWtRUK+666Zfkvqpvwu/l6nu+h+yYelM/y1A8cu25NSGcXsodwQnzJy5Vu5Z6
        YPvfvs65aTs/u19XYinOSDTUYi4qTgQANjZg+wgDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30/2017 05:32 AM, Daniel Ferreira wrote:
> Create t/helper/test-dir-iterator.c, which prints relevant information
> about a directory tree iterated over with dir_iterator.
> 
> Create t/t0065-dir-iterator.sh, which tests that dir_iterator does
> iterate through a whole directory tree and that post-order directory
> iteration is correctly implemented.

Thanks for adding these tests (which really I should have added when I
first introduced `dir_iterator`).

As a general rule, it's best to add tests:

* of pre-existing functionality as soon as possible in a patch
  series so that the tests can be used to check your own work,
  commit by commit

* of new functionality in the commit that adds the new functionality,
  so that it is obvious that the new functionality works

* of fixes to existing bugs *before* the bug fix, as a
  `test_expect_failure` test, to prove that the bug exists and that
  your test catches it. Then in a second commit, actually fix the bug
  and change the test from `test_expect_failure` to
  `test_expect_success`, to prove that your change fixed the bug.

Concretely, for this patch series, that means that you should add part
of the helper program and part of t0065 (i.e., everything that applies
to pre-order iteration) as the first patch of your series. Then you
should add the rest in patch "dir_iterator: iterate over dir after its
contents", at the same time as you add post-order iteration.

> ---
>  Makefile                     |  1 +
>  t/helper/test-dir-iterator.c | 32 +++++++++++++++++++++++++++++++
>  t/t0065-dir-iterator.sh      | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 t/helper/test-dir-iterator.c
>  create mode 100755 t/t0065-dir-iterator.sh
> 
> diff --git a/Makefile b/Makefile
> index a5a11e7..d0245f3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -607,6 +607,7 @@ TEST_PROGRAMS_NEED_X += test-ctype
>  TEST_PROGRAMS_NEED_X += test-config
>  TEST_PROGRAMS_NEED_X += test-date
>  TEST_PROGRAMS_NEED_X += test-delta
> +TEST_PROGRAMS_NEED_X += test-dir-iterator
>  TEST_PROGRAMS_NEED_X += test-dump-cache-tree
>  TEST_PROGRAMS_NEED_X += test-dump-split-index
>  TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> new file mode 100644
> index 0000000..b4a148f
> --- /dev/null
> +++ b/t/helper/test-dir-iterator.c
> @@ -0,0 +1,32 @@
> +#include "cache.h"
> +#include "blob.h"
> +#include "dir.h"
> +#include "streaming.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"

Three of these includes are unneeded and should be removed.

> +
> +int cmd_main(int argc, const char **argv) {
> +	if (argc < 2) {
> +		return 1;
> +	}
> +
> +	struct strbuf path = STRBUF_INIT;
> +	strbuf_add(&path, argv[1], strlen(argv[1]));
> +
> +	unsigned flag = 0;
> +	if (argc == 3 && strcmp(argv[2], "--post-order") == 0)
> +		flag = DIR_ITERATOR_POST_ORDER_TRAVERSAL;

It's conventional to handle options *before* other arguments. Even
though this is only a test script, it's preferable to adhere to
convention unless there is a strong reason to deviate from it. You might
looks at `test-submodule-config.c` for example code.

> +	struct dir_iterator *diter = dir_iterator_begin((&path)->buf, flag);

`(&path)->buf` can be shortened to `path.buf`.

> +
> +	while (dir_iterator_advance(diter) == ITER_OK) {
> +		if (S_ISDIR(diter->st.st_mode))
> +			printf("[d] ");
> +		else
> +			printf("[f] ");
> +
> +		printf("(%s) %s\n", diter->relative_path, diter->path.buf);
> +	}
> +
> +	return 0;
> +}
> diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
> new file mode 100755
> index 0000000..3c8ea9a
> --- /dev/null
> +++ b/t/t0065-dir-iterator.sh
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +
> +test_description='Test directory iteration.'
> +
> +. ./test-lib.sh
> +
> +ITER_SORTED_OUTPUT='[d] (a) ./dir/a
> +[d] (a/b) ./dir/a/b
> +[d] (a/b/c) ./dir/a/b/c
> +[d] (d) ./dir/d
> +[d] (d/e) ./dir/d/e
> +[d] (d/e/d) ./dir/d/e/d
> +[f] (a/b/c/d) ./dir/a/b/c/d
> +[f] (a/e) ./dir/a/e
> +[f] (b) ./dir/b
> +[f] (c) ./dir/c
> +[f] (d/e/d/a) ./dir/d/e/d/a'
> +
> +test_expect_success 'dir-iterator should iterate through all files' '
> +	mkdir -p dir &&
> +	mkdir -p dir/a/b/c/ &&
> +	date >dir/b &&

Is there a special reason to write the date to the file as opposed to, say

    touch dir/b

? (Some people use `: >dir/b` for this purpose, though I've never found
out why.) If you write the date to the file, the reader will be
distracted unnecessarily wondering whether the contents are important to
the test.

> +	date >dir/c &&
> +	mkdir -p dir/d/e/d/ &&
> +	date >dir/a/b/c/d &&
> +	date >dir/a/e &&
> +	date >dir/d/e/d/a &&
> +
> +	test-dir-iterator ./dir >it &&
> +	test "$(sort it)" == "$ITER_SORTED_OUTPUT"

We generally prefer to write the expected and actual program outputs to
files, then `test_cmp` the files. This has a couple of advantages:

* It doesn't risk missing an error return from the program under test,
  which could happen in your second test below.

* If there is a disagreement, `test_cmp` shows how the files differed.

* If you run the test using `-d`, you can inspect the contents of the
  files by hand to help investigate what happened.

Typically that would be done like

	cat >expected-sorted <<-\EOF &&
	[d] (a) ./dir/a
	[d] (a/b) ./dir/a/b
	[d] (a/b/c) ./dir/a/b/c
	[d] (d) ./dir/d
	[d] (d/e) ./dir/d/e
	[d] (d/e/d) ./dir/d/e/d
	[f] (a/b/c/d) ./dir/a/b/c/d
	[f] (a/e) ./dir/a/e
	[f] (b) ./dir/b
	[f] (c) ./dir/c
	[f] (d/e/d/a) ./dir/d/e/d/a
	EOF

	test-dir-iterator ./dir >actual &&
	sort actual >actual-sorted &&
	test_cmp expected-sorted actual-sorted

I also think it would be prudent to run this test twice; once for
pre-order and once for post-order traversal. You could use the same
directory setup and the same `expected-sorted` file for both tests
(e.g., set them up in a preliminary "setup" step).

> +'
> +
> +ITER_POST_ORDER_OUTPUT='[f] (a/b/c/d) ./dir2/a/b/c/d
> +[d] (a/b/c) ./dir2/a/b/c
> +[d] (a/b) ./dir2/a/b
> +[d] (a) ./dir2/a'
> +
> +test_expect_success 'dir-iterator should list files properly on post-order mode' '
> +	mkdir -p dir2/a/b/c/ &&
> +	date >dir2/a/b/c/d &&
> +
> +	test "$(test-dir-iterator ./dir2 --post-order)" == "$ITER_POST_ORDER_OUTPUT"
> +'

How about adding a test for pre-order traversal, too? It would look
almost identical to this test.

> [...]

Michael

