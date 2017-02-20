Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67BAA201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbdBTMo2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:44:28 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:44358 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752969AbdBTMo1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Feb 2017 07:44:27 -0500
X-AuditID: 12074412-4a3ff70000000b04-77-58aae43038f6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 61.B3.02820.034EAA85; Mon, 20 Feb 2017 07:42:25 -0500 (EST)
Received: from [192.168.69.190] (p579060C0.dip0.t-ipconnect.de [87.144.96.192])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1KCgMMd029564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Feb 2017 07:42:23 -0500
Subject: Re: [PATCH v4 00/15] Remove submodule from files-backend.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <cdf01f55-f3df-d3ce-149c-0249a03d27bf@alum.mit.edu>
Date:   Mon, 20 Feb 2017 13:42:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqGv4ZFWEQfcHLYuuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZfxdfJe54BNTxYkHNQ2My5i6GDk5JARMJBpb1zJ2MXJx
        CAnsYJL48P0HO4Rznkmid/dqFpAqYQFnifaNDYwgtohAmsTiye+ZQWwhgSSJeVd6mEAamAVu
        MEpcmvgRbCybgK7Eop5mMJtXwF7iwu4lrCA2i4CqxPrVV8CGigqESMxZ+IARokZQ4uTMJ2Bx
        TgEziXNbb4EtYBZQl/gz7xKULS/RvHU28wRG/llIWmYhKZuFpGwBI/MqRrnEnNJc3dzEzJzi
        1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJBgF9rBuP6k3CFGAQ5GJR7ehtkrI4RYE8uKK3MPMUpy
        MCmJ8t5ZsipCiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvm8tAOd6UxMqq1KJ8mJQ0B4uSOO/P
        xep+QgLpiSWp2ampBalFMFkZDg4lCV67x0CNgkWp6akVaZk5JQhpJg5OkOE8QMPLHoEMLy5I
        zC3OTIfIn2LU5Tj16cJLJiGWvPy8VClx3q0gRQIgRRmleXBzYEnqFaM40FvCvK0g63iACQ5u
        0iugJUxAS256rARZUpKIkJJqYAx7kjP1Q5t+7s6nFSGXv4Veu3A0efOLWG9pmaAvl0U8/SNL
        dTr+TjN8/Ng+OUPdYEf+Bqa4mzWNz4X3vzr5+tF/g+0vv0iGRP/Y5Hcv8cIipdCjj6YE5fct
        +vHN/9nVoBQV8/BNO1mrU/+Yx+6VirgpozeP6+v73a/fPcv1ePzjdfPjSP5LUxcrsRRnJBpq
        MRcVJwIAaJevXy0DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/18/2017 02:32 PM, Nguyễn Thái Ngọc Duy wrote:
> v4:

I very much like the direction of this patch series. I reviewed the
design pretty carefully and left some comments about it, and skimmed
through the code changes. But I haven't yet reviewed the code in detail.
I'll wait for your reaction to my design comments before doing so.

Thanks,
Michael

