Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658DA1F4DD
	for <e@80x24.org>; Wed, 30 Aug 2017 02:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdH3CwY (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 22:52:24 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59799 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751240AbdH3CwX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 22:52:23 -0400
X-AuditID: 12074411-f7dff70000007f0a-a3-59a628667e13
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id DF.FD.32522.66826A95; Tue, 29 Aug 2017 22:52:22 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC970.dip0.t-ipconnect.de [87.188.201.112])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7U2qKDA028177
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 22:52:21 -0400
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of
 string to list
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <91e365b5-6a5d-1e1c-ab7a-579efa7c1ae8@alum.mit.edu>
Date:   Wed, 30 Aug 2017 04:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1E3TWBZp8OaqvEXXlW4mi79vuhgd
        mDx2zrrL7vF5k1wAUxSXTUpqTmZZapG+XQJXxuVbe1gKEivW/FnF1MDo38XIySEhYCKxcs1G
        dhBbSGAHk8TmRypdjFxA9gUmiVeHP7OAJIQFoiTezNjODGKLCERI3J95lxmiaDGjxOf/L8ES
        bAK6Eot6mplAbF4Be4mOe1/ZQGwWAVWJJZvmgtWIAjX3vb3MDlEjKHFy5hOgBRwcnAKxEsvu
        cYGEmQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRG/llIumchaZmFpGUWkpYFjCyrGOUSc0pz
        dXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MUJCVHAH44yTcocYBTgYlXh4BSqWRgqxJpYV
        V+YeYpTkYFIS5Z0qtyxSiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvZUWgHG9KYmVValE+TEqa
        g0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgneVOlCjYFFqempFWmZOCUKaiYMTZDgP0PCf
        IDW8xQWJucWZ6RD5U4yWHPP+rfnCxPHhP4hs+rDlC5MQS15+XqqUOO8EkAYBkIaM0jy4mbCU
        84pRHOhFYd6nIFU8wHQFN/UV0EImoIWxXktBFpYkIqSkGhg7H85/labS/P94SoyE3IZfLT59
        3q6vc458Pnoozd/0LGfA6nTHj63fnjRtTnqn9DjLsk/TdLVmZfKZZFnWExmN529fCWG8aJl3
        USB4w7/cJYvnm/z6fmSW3mS+873CNj6mR6ffvXmj3PbY3VVVaQ+4Nsm/miKTcD9sV0jj98ez
        J/zSDmTbeU5KiaU4I9FQi7moOBEACkBmxhQDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 looks good to me. Thanks!

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael
