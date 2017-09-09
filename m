Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF1C1FAD6
	for <e@80x24.org>; Sat,  9 Sep 2017 05:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbdIIF7J (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 01:59:09 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:48105 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751244AbdIIF7I (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Sep 2017 01:59:08 -0400
X-AuditID: 12074413-3a3ff70000007929-7e-59b3832bd8b0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 01.F4.31017.B2383B95; Sat,  9 Sep 2017 01:59:07 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC859.dip0.t-ipconnect.de [87.188.200.89])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v895x5CD019077
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 9 Sep 2017 01:59:06 -0400
Subject: Re: [PATCH v4 10/16] refs: remove dead for_each_*_submodule()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
 <20170823123704.16518-11-pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9705a733-76b4-e92c-1e4c-bb734b184529@alum.mit.edu>
Date:   Sat, 9 Sep 2017 07:59:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170823123704.16518-11-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixO6iqKvdvDnS4OhfK4uuK91MFg29V5gt
        uqe8ZbTYvLmdxYHFY+esu+weCzaVely8pOzxeZNcAEsUl01Kak5mWWqRvl0CV0bjrI+MBUtZ
        KqYtvc/YwPiXqYuRk0NCwETixJpmxi5GLg4hgR1MElenXGaGcM4xSRzbfA2sSljATWJd4zl2
        EFtEIE1i8eT3QEUcHMwCXhLzPpaDhIUEUiTWH54KVs4moCuxqKcZzOYVsJeYeWsxG4jNIqAi
        MWt+A9gYUYEIib63l9khagQlTs58wgIyklPAQmL1PS2QMLOAusSfeZeYIWxxiVtP5jNB2PIS
        zVtnM09gFJiFpHsWkpZZSFpmIWlZwMiyilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXXC83s0Qv
        NaV0EyMkwIV3MO46KXeIUYCDUYmHt2L7pkgh1sSy4srcQ4ySHExKorwXajdHCvEl5adUZiQW
        Z8QXleakFh9ilOBgVhLh5WsEyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRl
        ODiUJHjVmoAaBYtS01Mr0jJzShDSTBycIMN5gIZrgNTwFhck5hZnpkPkTzHqctx4eP0PkxBL
        Xn5eqpQ4rydIkQBIUUZpHtwcWGJ6xSgO9JYw73uQO3mASQ1u0iugJUxAS0qebwBZUpKIkJJq
        YJy7S2aL76Pp8mePVPxyt03f8mx3fUrbnrtt8y4ITt5p2Zw7cY3CAUcPvy7Pl2H6nTHJZo1b
        9dU3Pj7RH/Ij5c1JBi3xh7FXC7uMT1TObbjZ/pw74aNav27kxoV13mpP39q4FoseDfeatKHK
        2fcjg7PGQcUW/h93+v/siF96cWPEphdH5+zzWa/EUpyRaKjFXFScCABsdAZoJwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/23/2017 02:36 PM, Nguyễn Thái Ngọc Duy wrote:
> These are used in revision.c. After the last patch they are replaced
> with the refs_ version. Delete them.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/technical/api-ref-iteration.txt |  7 ++----
>  refs.c                                        | 33 ---------------------------
>  refs.h                                        | 10 --------
>  3 files changed, 2 insertions(+), 48 deletions(-)

What a lovely diffstat :-)

Michael
