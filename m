Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1E720133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbdCCRCB (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:02:01 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52395 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752164AbdCCRB6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 12:01:58 -0500
X-AuditID: 1207440c-aa5ff70000002e8f-2f-58b99f145392
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.5F.11919.41F99B85; Fri,  3 Mar 2017 11:51:32 -0500 (EST)
Received: from [192.168.69.190] (p5B105007.dip0.t-ipconnect.de [91.16.80.7])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v23GpTAu005860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 3 Mar 2017 11:51:30 -0500
Subject: Re: [PATCH v5 24/24] t1406: new tests for submodule ref store
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-25-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <eb088421-11c1-a6d7-398e-b2b8b4d785e3@alum.mit.edu>
Date:   Fri, 3 Mar 2017 17:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-25-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqCsyf2eEwesLVhZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgyji3+xtrwWW2ircLV7E3MC5l7WLk4JAQMJGY2FDUxcjF
        ISSwg0mi/fc/9i5GTiDnNJPEv68hILawgJvEzn3vmEBsEYE0icWT3zNDNExglFjT8JoNxGEW
        uMEocWniR7AqNgFdiUU9zWA2r4C9xIbD8xhBtrEIqEhcPlwNEhYVCJGYs/ABI0SJoMTJmU9Y
        QGxOAQuJqVMmsYHYzALqEn/mXWKGsOUlmrfOZp7AyD8LScssJGWzkJQtYGRexSiXmFOaq5ub
        mJlTnJqsW5ycmJeXWqRrqJebWaKXmlK6iRES6jw7GL+tkznEKMDBqMTDyzB5Z4QQa2JZcWXu
        IUZJDiYlUd4F04BCfEn5KZUZicUZ8UWlOanFhxglOJiVRHi1JwLleFMSK6tSi/JhUtIcLEri
        vKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvKfmAjUKFqWmp1akZeaUIKSZODhBhvMADd8PUsNb
        XJCYW5yZDpE/xajLceP4gTdMQix5+XmpUuK8v+cAFQmAFGWU5sHNgaWoV4ziQG8J8/4GGcUD
        TG9wk14BLWECWuInA7akJBEhJdXAWPZYL/GY/lKT7++8Zvr1ZV4JKZOYvl3C7tbR3YWcqk8/
        8b08NdNCrafoH+uNQIansfKtTooPlfZv7TpoXBTTy5J7+qGx6HzzYzvvRs3m+H/ULeaVQszJ
        znWbUieHsU7MCLsvXud1h+HUF8WTj//supN90XDZl9cVoueChaQ/8e3e9uhl06dMPSWW4oxE
        Qy3mouJEAP3CrcgsAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/t1406-submodule-ref-store.sh (new +x) | 95 +++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100755 t/t1406-submodule-ref-store.sh

I wonder if you could reduce some of the repetition between this test
file and t1405, at least for the functions that should work for both the
main repository and for submodules? For example, if you were to define

    GIT='git'

in one case and

    GIT='git -C sub'

in the other, then maybe some of the setup code could be made to look
alike? Then the division could be one test file for the functions that
work for both main and submodules, and a second for the functions that
only work for main. Just a thought...

Michael

