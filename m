Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF437201A7
	for <e@80x24.org>; Sat, 20 May 2017 16:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755824AbdETQzq (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 12:55:46 -0400
Received: from mout.web.de ([212.227.15.4]:57329 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755431AbdETQzp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 12:55:45 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lx77p-1e11JO2z8b-016f2c; Sat, 20
 May 2017 18:55:19 +0200
Subject: Re: [PATCH v2 4/6] fsmonitor: add test cases for fsmonitor extension
To:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <20170518201333.13088-5-benpeart@microsoft.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <da2523fc-e6ef-ff26-0449-83f8d46bed84@web.de>
Date:   Sat, 20 May 2017 18:55:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170518201333.13088-5-benpeart@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:F0Kx/FI13ELfc6/6o/qFOVAAqLMJ3d4IYz+ILj+5DGskoTBTODr
 w/NY0rUlBnbx865ub7zjbJ4fxLGNRlOR27WjywdaicPbQ04/SogqNMeqoZTSKoH+WoERyKI
 EfFSkkd1X/mAhcvPeS026ACIyIBRgt+wEAyk18/nDMcSP9tgx8uAHpHk6LXrUrTml+wcNt9
 IOf7E7VjwLZw0WW6u9qPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MsVdEjzMmWA=:uXV3ehgjbzSiLlMm92Mvt0
 w6/4nr+5oGobYtB49Rx/WYX8PCi5DiGESWd9cfK+9HspVfrT7qUQJsqH+6vR1J1V40nVFN6u2
 m8wjELpamXsIcp4wEYrEpKd3EjLIaq6IsZ8uawoFel1Xxl+MudSZZpJqEZWWRq4miVaaC/zp6
 6F1aygUBbKbyApvWNZ2nddbmhU9k8wg6tb2f8c63qGRxw4EWFFi+0Ipx9rTKrelA/H07OH/87
 yXDA7gOiChalEOpEcET85ZLiSSLvbY94MlDQcAbd+d5pC/r8FvLHZS8vkA1PS9zUd/kqoL+qB
 JvTjs7A1042Z0auSDmMUa9YNftpU5eDb/isHTHFx3opralZjeDkEsZK0ItqXfUeA38jqwpVRr
 nq0fqkZiWqA4jIMpAMGYKYBMHbmnYArcAzd5P0IYlPAAiC4bXqt6uaN43qVSUS8VtMe32fhgJ
 GHns0wlMw3sYBWBL7b0nZwVb+UHXWvij12newtBHNRn0lXIabKjb9/6VI3d56RUwN2PLDB3Wd
 vvYfRAWmQvPA+U1SOYaRH4z/DYr8JreVRXvzzD54pANBE2cS1rLNkFrD/qc5+rxar86oSLgEl
 326bWXUgPoEMRNklWo3gxv62S2c1W0fsu+MjlQjTXAjYrqOqLMH07klMQ5MskZyh5xj+Ze29M
 Asn2dy/v2zbT50AabG144FcBQlWbGAbA6YKl7f6Mk2+jzhybPyMBtSlUv9Vj1TXttS6KlF7G+
 T9ADJGm+ozCIx8DiEMcV9Agd+fACM0DO0CuJffKbJ9ZuKWG58kQK3jtIwZ3jNfLde5NBrv+ko
 6GaWjoz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> new file mode 100755
> index 0000000000..d3cffc758f
> --- /dev/null
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -0,0 +1,153 @@
> +#!/bin/sh
> +
> +test_description='git status with file system watcher'
> +
> +. ./test-lib.sh
> +
> +clean_repo () {
> +	git reset --hard HEAD
> +	git clean -fd
> +	rm marker -f

This Works under Linux, but not e.g. Mac OS X. Should be

rm -f marker

> +}

