Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C04201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 18:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbdB1SVS (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 13:21:18 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:46668 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751599AbdB1SUe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 13:20:34 -0500
X-AuditID: 1207440f-141ff70000003517-4e-58b5bf666ebc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 24.40.13591.66FB5B85; Tue, 28 Feb 2017 13:20:23 -0500 (EST)
Received: from [192.168.69.190] (p5B10410E.dip0.t-ipconnect.de [91.16.65.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1SIKJpI018251
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 28 Feb 2017 13:20:20 -0500
Subject: Re: [PATCH v5 00/24] Remove submodule from files-backend.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c525b1cf-3bb0-452c-8a8d-b07c58f00c84@alum.mit.edu>
Date:   Tue, 28 Feb 2017 19:20:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqJu+f2uEwZmvchZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgyljz9gBrwW6mip0b/7E1MH5l7GLk5JAQMJH49qSJtYuR
        i0NIYAeTxOfTj5khnLNMEh9bXjGBVAkLOEuseLCKDcQWEUiTWDz5PTOILSSQJPHv+Sk2kAZm
        gRuMEpcmfgRrYBPQlVjU0wxm8wrYS1w99oYdxGYRUJVYd3Ia2CBRgRCJOQsfMELUCEqcnPmE
        BcTmFDCXeDX5KVgvs4C6xJ95l5ghbHmJ5q2zmScw8s9C0jILSdksJGULGJlXMcol5pTm6uYm
        ZuYUpybrFicn5uWlFuma6OVmluilppRuYoSEO/8Oxq71MocYBTgYlXh4Mzq3RgixJpYVV+Ye
        YpTkYFIS5Q2aARTiS8pPqcxILM6ILyrNSS0+xCjBwawkwrujGCjHm5JYWZValA+TkuZgURLn
        VV+i7ickkJ5YkpqdmlqQWgSTleHgUJLgddoH1ChYlJqeWpGWmVOCkGbi4AQZzgM0PGkvyPDi
        gsTc4sx0iPwpRl2OG8cPvGESYsnLz0uVEuetBykSACnKKM2DmwNLU68YxYHeEubdB7KOB5ji
        4Ca9AlrCBLTkhQrYkpJEhJRUA6MoY3+fQJK1fHmjb57rHfXHvnqrxbbdX8C44JFC+Z0zB6sz
        Tgv/72rXc0tLKrxR/87nquCEX2z7GPfEmHjtcljxK+X4xjn/9eOzvjdmNjXYumeca67wlr+f
        vGXt/PzXOtWxn44klWxIEWyUP3148f0lM6NUPF8Glyxn1K1XVzgafk+2jkG0RYmlOCPRUIu5
        qDgRAOGrm/wuAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> v5 goes a bit longer than v4, basically:

I've read through patch 14/24 so far, and they all look good except for
the mostly superficial comments that I have sent so far. I like the way
this is heading!

I'll try to continue tomorrow.

Michael

