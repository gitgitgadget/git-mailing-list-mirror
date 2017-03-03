Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F5720133
	for <e@80x24.org>; Fri,  3 Mar 2017 16:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbdCCQnR (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 11:43:17 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59236 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751571AbdCCQnQ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 11:43:16 -0500
X-AuditID: 12074413-f67ff700000077e1-c0-58b99d1f5140
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id F6.60.30689.F1D99B85; Fri,  3 Mar 2017 11:43:11 -0500 (EST)
Received: from [192.168.69.190] (p5B105007.dip0.t-ipconnect.de [91.16.80.7])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v23Gh8kD005358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 3 Mar 2017 11:43:09 -0500
Subject: Re: [PATCH v5 23/24] t1405: some basic tests on main ref store
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-24-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <7769af97-3dc7-f23b-c7c1-1d6b227a2f83@alum.mit.edu>
Date:   Fri, 3 Mar 2017 17:43:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-24-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqCs/d2eEwd5V1hZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgyujZfYGtoE+r4tOX0ywNjJ8Uuxg5OSQETCRe7T3H3sXI
        xSEksINJ4vjiz2wQzmkmidYdDWwgVcIC7hI35+9gBbFFBNIkFk9+zwxRNIFR4tOVaywgDrPA
        DUaJSxM/MoFUsQnoSizqaQazeQXsJY68mgzWzSKgIrHqbQcjiC0qECIxZ+EDRogaQYmTM5+w
        gNicAhYS63+8BdvMLKAu8WfeJWYIW16ieets5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5urmJ
        mTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCEBL7yDcddJuUOMAhyMSjy8DJN3RgixJpYVV+Ye
        YpTkYFIS5V0wDSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhFd7IlCONyWxsiq1KB8mJc3BoiTO
        q7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB+3w2UKNgUWp6akVaZk4JQpqJgxNkOA/Q8LsgNbzF
        BYm5xZnpEPlTjIpS4ryOc4ASAiCJjNI8uF5YQnrFKA70ijCvMkgVDzCZwXW/AhrMBDTYTwZs
        cEkiQkqqgbFYZWXyySWtKv9S4veKnxSZ0b5lNlOM2N2Oo48yV6i3fjJmcOM9YPBeYrdG5/kc
        sWUXJOVmcd1w/HQxsu5eUuj5ewH8hxx2BJw8Im+uccmk7LlN5+szk9/56j+c9PGGeVKT55/d
        G+8yyi9cxdHvdOibmp7G9v4KkcI4rR08x/ifftzi3ftZ9IsSS3FGoqEWc1FxIgBB4JApIwMA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/t1405-main-ref-store.sh (new +x) | 123 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100755 t/t1405-main-ref-store.sh
> 
> diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> new file mode 100755
> index 000000000..0999829f1
> --- /dev/null
> +++ b/t/t1405-main-ref-store.sh
> @@ -0,0 +1,123 @@
> +#!/bin/sh
> +
> +test_description='test main ref store api'
> +
> +. ./test-lib.sh
> +
> +RUN="test-ref-store main"
> +
> +test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
> +	test_commit one &&
> +	N=`find .git/refs -type f | wc -l` &&

I think we prefer $() to ``. (Same throughout this file and also t1406
in the next commit.)

It's notable that these tests grep around the filesystem, so they won't
be applicable to future refs backends. Of course, "pack-refs" is
intrinsically only applicable to the files backend, so for this test
it's not surprising. But some tests could conceivably be written in a
generic way, so that they should pass for any refs backend.

Just food for thought; no need to change anything now.

> +	test "$N" != 0 &&
> +	$RUN pack-refs 3 &&
> +	N=`find .git/refs -type f | wc -l`

Didn't you mean to test the final `$N`?

> +'
> +
> +test_expect_success 'peel_ref(new-tag)' '
> +	git rev-parse HEAD >expected &&
> +	git tag -a -m new-tag new-tag HEAD &&
> +	$RUN peel-ref refs/tags/new-tag >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'create_symref(FOO, refs/heads/master)' '
> +	$RUN create-symref FOO refs/heads/master nothing &&
> +	echo refs/heads/master >expected &&
> +	git symbolic-ref FOO >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
> +	git rev-parse FOO -- &&
> +	git rev-parse refs/tags/new-tag -- &&
> +	$RUN delete-refs 0 FOO refs/tags/new-tag &&
> +	test_must_fail git rev-parse FOO -- &&
> +	test_must_fail git rev-parse refs/tags/new-tag --
> +'
> +
> +test_expect_success 'rename_refs(master, new-master)' '
> +	git rev-parse master >expected &&
> +	$RUN rename-ref refs/heads/master refs/heads/new-master &&
> +	git rev-parse new-master >actual &&
> +	test_cmp expected actual &&
> +	test_commit recreate-master
> +'

Isn't HEAD set to `refs/heads/master` prior to this test? If so, then I
think it should become detached when you rename `refs/heads/master`. Or
maybe it should be changed to point at `refs/heads/new-master`, I can't
remember. In either case, it might be useful for the test to check that
the behavior matches the status quo, so we notice if the behavior ever
changes inadvertently.

> +
> +test_expect_success 'for_each_ref(refs/heads/)' '
> +	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
> +	cat >expected <<-\EOF &&
> +	master 0x0
> +	new-master 0x0
> +	EOF
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'resolve_ref(new-master)' '
> +	SHA1=`git rev-parse new-master` &&
> +	echo "$SHA1 refs/heads/new-master 0x0" >expected &&
> +	$RUN resolve-ref refs/heads/new-master 0 >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'verify_ref(new-master)' '
> +	$RUN verify-ref refs/heads/new-master
> +'
> +
> +test_expect_success 'for_each_reflog()' '
> +	$RUN for-each-reflog | cut -c 42- >actual &&
> +	cat >expected <<-\EOF &&
> +	refs/heads/master 0x0
> +	refs/heads/new-master 0x0
> +	HEAD 0x1
> +	EOF
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'for_each_reflog_ent()' '
> +	$RUN for-each-reflog-ent HEAD >actual &&
> +	head -n1 actual | grep one &&
> +	tail -n2 actual | head -n1 | grep recreate-master
> +'
> +
> +test_expect_success 'for_each_reflog_ent_reverse()' '
> +	$RUN for-each-reflog-ent-reverse HEAD >actual &&
> +	head -n1 actual | grep recreate-master &&
> +	tail -n2 actual | head -n1 | grep one
> +'
> +
> +test_expect_success 'reflog_exists(HEAD)' '
> +	$RUN reflog-exists HEAD
> +'
> +
> +test_expect_success 'delete_reflog(HEAD)' '
> +	$RUN delete-reflog HEAD &&
> +	! test -f .git/logs/HEAD

Maybe also test the final state using `reflog-exists` to make sure that
function can also return false?

> +'
> +
> +test_expect_success 'create-reflog(HEAD)' '
> +	$RUN create-reflog HEAD 1 &&
> +	test -f .git/logs/HEAD
> +'
> +
> +test_expect_success 'delete_ref(refs/heads/foo)' '
> +	git checkout -b foo &&
> +	FOO_SHA1=`git rev-parse foo` &&
> +	git checkout --detach &&
> +	test_commit bar-commit &&
> +	git checkout -b bar &&
> +	BAR_SHA1=`git rev-parse bar` &&
> +	$RUN update-ref updating refs/heads/foo $BAR_SHA1 $FOO_SHA1 0 &&
> +	echo $BAR_SHA1 >expected &&
> +	git rev-parse refs/heads/foo >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'delete_ref(refs/heads/foo)' '
> +	SHA1=`git rev-parse foo` &&
> +	git checkout --detach &&
> +	$RUN delete-ref refs/heads/foo $SHA1 0 &&
> +	test_must_fail git rev-parse refs/heads/foo --
> +'

The last two tests have the same name.

You might also want to test these functions when the old oid is
incorrect or when the reference is missing.

> +test_done

Thanks for all the new tests!

Michael

