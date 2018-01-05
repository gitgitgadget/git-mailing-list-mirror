Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39E331F428
	for <e@80x24.org>; Fri,  5 Jan 2018 14:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeAEOpO (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 09:45:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:63671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbeAEOpN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 09:45:13 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MSdNs-1eNfa60mNI-00RVX3; Fri, 05 Jan 2018 15:45:02 +0100
Date:   Fri, 5 Jan 2018 15:45:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Subject: Re: [PATCH 5/5] convert: add support for 'checkout-encoding'
 attribute
In-Reply-To: <20171231080601.22444-1-tboegi@web.de>
Message-ID: <alpine.DEB.2.21.1.1801051542550.31@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com> <20171231080601.22444-1-tboegi@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TIYEs56/5zrrysC/xLGw6NU1Y2lG2ASQxjuxDiFHyTxbM4Thuon
 fKEuL4ld6QFAiWwrKIdeYe2fTEh/IBX5Sm3hDAqBw8FtLqQHPLtMHPHLMae71cSnaet8+5/
 eehbZYVJIhMXZwwl41GX9kFbO6MNf76bMXy4oIkqljNFM5PAiUuQXWReOW4EVMv7n1FVAaT
 j8aLZMiGw9qwWwzC8EzeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GyxN1iSfFoI=:ZnORSs+SV5Mk7/ym7nLk09
 Z2hLTEu3ObNlznzjXChwv/Ukg4mJKGbauFf0ypthnTbPHn01C9QaCg+XxssS4bnEmvR1T3bkC
 ynmjJQZqMsJ5llmBQcckLyMkWmMsg5pQ1Tit8VnU9N9OMPA9dSLmB8opOLFszjbk41o22W/ZJ
 8WrNWwzqLF7QKhjZk7/+IICBrmtNWznNmPeAfo5QfNjSW2JL43zlUYBLxWzhEgdGhTZUDsCMO
 ihMk18NwihQxRLKa5Lz/P03n6odUGKvag21sk0e1YuAvaHvYuAV9BVGp8rFU+Wy8zba4myOPm
 wW7ij5/QOaGJttXBmHHr6G5UR1TCsH2kh12MrnRbD/hoX+TTe6BQRVEV8ltiKRQ65yOwvFhpU
 2E6TSp9OwhWcXHn9umO04hCxriGU5vdzCe03crbF7Y97aDdOrdaz8UZcnUYJoN1HvUDGQGSoK
 em7a13ej3rAy7rkk2c/NxGvpYIdBFdxB5teohltkPxAX1mR20zs9E8iGdlN7FdVcqQrtos6u/
 3XkOKVsfbLJZpYcv2ogsSiSr7UYrinK1jjE/zO17HjOSPFBNK1M4JVBVwUabKpcwQ/A9Zt4SO
 nKP+20K4qWyHvC/pMmttx/ZuUJmSXp0uN2kZHb/5owKqVyusYNPVU7mUMJjUeJl2h/Agyb2gC
 bYbrgd/pDCSIW9Jae6n4kEI7jKxF1RJmRm//lvoQ57i+RGQcJLTtq8XYuc0TiQPTqPv+yo049
 pzG3IDO98MhQ+Lz3wEcK+BXgNLDjA0sVAVU8gxRo85GM24oN7bWR00LFnsUxrndj5NpLSYf6V
 CXEKRRj+B7CKlomgZi6TbPElzQpavCZwCEN6KHvy/hGucP5ovBaAcHmC0cEZCn5ie2N4Z43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 31 Dec 2017, tboegi@web.de wrote:

> diff --git a/t/t0028-checkout-encoding.sh b/t/t0028-checkout-encoding.sh
> new file mode 100755
> index 0000000000..1a329ab933
> --- /dev/null
> +++ b/t/t0028-checkout-encoding.sh
> @@ -0,0 +1,197 @@
> +#!/bin/sh
> +
> +test_description='checkout-encoding conversion via gitattributes'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup test repo' '
> +
> +	text="hallo there!\ncan you read me?" &&
> +
> +	echo "*.utf16 text checkout-encoding=utf-16" >.gitattributes &&
> +
> +	printf "$text" >test.utf8.raw &&
> +	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
> +	cp test.utf16.raw test.utf16 &&
> +
> +	git add .gitattributes test.utf16 &&
> +	git commit -m initial
> +'
> +
> +test_expect_success 'ensure UTF-8 is stored in Git' '
> +	git cat-file -p :test.utf16 >test.utf16.git &&
> +	test_cmp_bin test.utf8.raw test.utf16.git &&
> +	rm test.utf8.raw test.utf16.git
> +'
> +
> +test_expect_success 're-encode to UTF-16 on checkout' '
> +	rm test.utf16 &&
> +	git checkout test.utf16 &&
> +	test_cmp_bin test.utf16.raw test.utf16 &&

This fails here, due to an extra CR in test.utf16. This diff fixes it
(please include it in the next iteration of this patch series):

-- snipsnap --
diff --git a/t/t0028-checkout-encoding.sh b/t/t0028-checkout-encoding.sh
index 1a329ab933b..aaf61bc9d7c 100755
--- a/t/t0028-checkout-encoding.sh
+++ b/t/t0028-checkout-encoding.sh
@@ -6,6 +6,7 @@ test_description='checkout-encoding conversion via
gitattributes'
 
 test_expect_success 'setup test repo' '
 
+	git config core.eol lf &&
 	text="hallo there!\ncan you read me?" &&
 
 	echo "*.utf16 text checkout-encoding=utf-16" >.gitattributes &&

