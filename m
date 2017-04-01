Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7785720969
	for <e@80x24.org>; Sat,  1 Apr 2017 04:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750790AbdDAEyk (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 00:54:40 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47905 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750786AbdDAEyk (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Apr 2017 00:54:40 -0400
X-AuditID: 12074412-4a3ff70000000b04-ff-58df328ea8b4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 57.37.02820.E823FD85; Sat,  1 Apr 2017 00:54:38 -0400 (EDT)
Received: from [192.168.69.190] (p57906954.dip0.t-ipconnect.de [87.144.105.84])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v314sXxF023669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 1 Apr 2017 00:54:35 -0400
Subject: Re: [PATCH v7 22/28] refs: new transaction related ref-store api
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
 <20170326024241.31984-23-pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <07e96aa2-6733-474a-118b-05c533f49592@alum.mit.edu>
Date:   Sat, 1 Apr 2017 06:54:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170326024241.31984-23-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqNtndD/C4OtjA4uuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGix8tPcwWM69aW2ze3M7iwOGxc9Zddo8PH+M8Fmwq9ehqP8Lm8ax3
        D6PHxUvKHvuXbmPz+LxJLoAjissmJTUnsyy1SN8ugSvj5LmrjAVvuSu6Di5nb2B8wNnFyMkh
        IWAisbapm6WLkYtDSGAHk8TNKw8ZQRJCAueYJP4/kwexhQU8Je6camQFsUUE0iQWT37PDNEw
        kVHi1Y4rYA6zwGdGiSl3z4N1swnoSizqaWbqYuTg4BWwl9j3yg0kzCKgIrH973ImEFtUIERi
        zsIHYOW8AoISJ2c+YQGxOQUsJHZc2wsWZxZQl/gz7xIzhC0v0bx1NvMERv5ZSFpmISmbhaRs
        ASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQCBDawbj+pNwhRgEORiUe
        XgW/exFCrIllxZW5hxglOZiURHm/FwOF+JLyUyozEosz4otKc1KLDzFKcDArifAmfgHK8aYk
        VlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8EYa3o8QEixKTU+tSMvMKUFI
        M3FwggznARqeDFLDW1yQmFucmQ6RP8WoKCXOq24AlBAASWSU5sH1whLUK0ZxoFeEeWNB2nmA
        yQ2u+xXQYCagwRZf74IMLklESEk1MHpuYFPUq/ljF+W0xkUnetnPZ+FC16r9+l/9feUrVL7m
        vkPSVpGZ/ufmXatSmPlRMPRTro1Sw81YzvtzEk4+ET/6Wjc08vlKOdHS9kSLt2oSWsG5yTe7
        ausere06387COreZrf/jmxD7XvuCormnpM9eafkysXvNOVudmZYVTPeXpb0qCrXoVmIpzkg0
        1GIuKk4EAFle7g8rAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/26/2017 04:42 AM, Nguyễn Thái Ngọc Duy wrote:
> The transaction struct now takes a ref store at creation and will
> operate on that ref store alone.

Having worked downstream of this patch series for a while, I started to
wonder why a `ref_store` has to be baked into a `ref_transaction` at
creation. I haven't noticed any technical reason why it must be so.

If we expected to need to virtualize `ref_transaction_begin()` sometime,
then of course your design would be preferable.

It surprised be, because until now `ref_transaction` has been a plain
old data structure unconnected with a particular `ref_store`. I would
have expected `ref_transaction_commit()` to gain a more general sibling,
`refs_ref_transaction_commit()` [*], that takes an additional `ref_store
*` object argument, and for `ref_transaction_commit()` to call that
function. It would feel slightly more natural to me, given that
`transaction_commit` is a virtual method of the `ref_store` class, for
`refs_ref_transaction_commit()` to take an explicit `refs` pointer
rather than having that pointer buried in the `ref_transaction`.

I think this is mostly an aesthetic issue (about which opinions can
legitimately differ) rather than a concrete problem. I haven't yet had
any difficulties working with your interface. But I wanted to mention my
observation anyway. As far as I'm concerned, you don't need to change it.

> [...]

Michael

[*] The name could obviously be improved, but you get the idea.

