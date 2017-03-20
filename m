Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CB520323
	for <e@80x24.org>; Mon, 20 Mar 2017 05:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbdCTF1Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 01:27:16 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48779 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750943AbdCTF1P (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 01:27:15 -0400
X-AuditID: 12074412-4a3ff70000000b04-7b-58cf682ed6f1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 43.C5.02820.E286FC85; Mon, 20 Mar 2017 01:27:12 -0400 (EDT)
Received: from [192.168.69.190] (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2K5R6wZ010915
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 01:27:07 -0400
Subject: Re: [PATCH v6 26/27] t1406: new tests for submodule ref store
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-27-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <37e76a4d-e197-f9b1-2546-d207656149a6@alum.mit.edu>
Date:   Mon, 20 Mar 2017 06:27:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170318020337.22767-27-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1DXIOB9hcP8lu0XXlW4mi4beK8wW
        /cu72CyWPHzNbNE95S2jxcyr1habN7ezOLB77Jx1l93jw8c4jwWbSj262o+weVy8pOyxf+k2
        No/Pm+QC2KO4bFJSczLLUov07RK4Mt4t/cpScICr4vPbpWwNjLs4uhg5OSQETCSeXX3P3MXI
        xSEksINJ4vekTUwQzgUmiQ3/r7F0MXJwCAu4Sbx5LAjSICKQJrF4MkzDREaJ3otXWUEcZoEb
        jBKXJn5kAqliE9CVWNTTDGbzCthLPL7cwgJiswioSsw4cxIsLioQIjFn4QNGiBpBiZMzn4DV
        cApYSGz+/oUdxGYWUJf4M+8SM4QtL9G8dTbzBEb+WUhaZiEpm4WkbAEj8ypGucSc0lzd3MTM
        nOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkHAX2sG4/qTcIUYBDkYlHt4bl85FCLEmlhVX5h5i
        lORgUhLl1fQ5HyHEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHdHAlCONyWxsiq1KB8mJc3BoiTO
        +3Oxup+QQHpiSWp2ampBahFMVoaDQ0mClzkdqFGwKDU9tSItM6cEIc3EwQkynAdoeAxIDW9x
        QWJucWY6RP4Uo6KUOG9oGlBCACSRUZoH1wtLR68YxYFeEebtB2nnAaYyuO5XQIOZgAYvu3EG
        ZHBJIkJKqoGx3DLXnG1j++n5p/V0tZ58Splcca9qxqn9NozT1EOS5UyeVKxaqpi3/1w9d3aV
        0yNF9sAvH64eTSpkN2JNXDC1s/rHWe9dYgVNil2zIqKOb9jiGfdNyn2TF+ORaYdyNzjff9z/
        jC9Bdvmd5Vr7a9IX79Di1cj9Es3Ifr7I+PfsRCue/Wk/TvQqsRRnJBpqMRcVJwIAr0nQlyID
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18/2017 03:03 AM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/t1406-submodule-ref-store.sh (new +x) | 95 +++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100755 t/t1406-submodule-ref-store.sh
> 
> diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
> new file mode 100755
> index 0000000000..22214ebd32
> --- /dev/null
> +++ b/t/t1406-submodule-ref-store.sh
> @@ -0,0 +1,95 @@
> +#!/bin/sh
> +
> +test_description='test submodule ref store api'
> +
> +. ./test-lib.sh
> +
> +RUN="test-ref-store submodule:sub"
> +
> +test_expect_success 'setup' '
> +	git init sub &&
> +	(
> +		cd sub &&
> +		test_commit first &&
> +		git checkout -b new-master
> +	)
> +'
> +
> +test_expect_success 'pack_refs() not allowed' '
> +	test_must_fail $RUN pack-refs 3
> +'

It's a little bit unfortunate but probably OK that this test and its
analog in t1405 hard-code internal numerical constants. At least in
t1405 the names of the constants appear in the test name, meaning that
anybody changing the constants' values in the future will probably find
the "3" in that file. Would you do the same here, please, or at least
mention the constant names in a comment here?

> [...]

Michael

