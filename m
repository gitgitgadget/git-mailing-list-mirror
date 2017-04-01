Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE611FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 05:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750797AbdDAFKD (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 01:10:03 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57113 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750792AbdDAFKC (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Apr 2017 01:10:02 -0400
X-AuditID: 1207440c-abdff70000002e8f-4a-58df3626801d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id CA.9D.11919.6263FD85; Sat,  1 Apr 2017 01:09:59 -0400 (EDT)
Received: from [192.168.69.190] (p57906954.dip0.t-ipconnect.de [87.144.105.84])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3159som024421
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 1 Apr 2017 01:09:55 -0400
Subject: Re: [PATCH v7 00/28] Remove submodule from files-backend.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <24c2d384-b719-6a36-5b65-8edf86191fdd@alum.mit.edu>
Date:   Sat, 1 Apr 2017 07:09:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqKtudj/C4MBxJYuuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGix8tPcwWM69aW2ze3M7iwOGxc9Zddo8PH+M8Fmwq9ehqP8Lm8ax3
        D6PHxUvKHvuXbmPz+LxJLoAjissmJTUnsyy1SN8ugSuj7fM91oJvrBX9v9+xNDDeZ+li5OSQ
        EDCRmP30CZDNxSEksINJ4tvvW1DOOSaJJT/OMIFUCQs4Syzrv8YKYosIpEksnvyeGcQWEkiW
        aGtsYAJpYBb4zCgx5e55RpAEm4CuxKKeZrBmXgF7iberW9lAbBYBFYmbT9vAbFGBEIk5Cx8w
        QtQISpyc+QTsJE4Bc4ndE4+A9TILqEv8mXeJGcKWl2jeOpt5AiP/LCQts5CUzUJStoCReRWj
        XGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZGSAzw7GD8tk7mEKMAB6MSD+8J73sR
        QqyJZcWVuYcYJTmYlER5vxcDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwJn4ByvGmJFZWpRbl
        w6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiUJHhTTO5HCAkWpaanVqRl5pQgpJk4OEGG
        8wANvw5Sw1tckJhbnJkOkT/FqMtx4/iBN0xCLHn5ealS4rxrQYoEQIoySvPg5sBS1ytGcaC3
        hHlfg1TxANMe3KRXQEuYgJZYfL0LsqQkESEl1cDI9Or5YZYLNY+LRbUZrt88JX6n9zPz1lCN
        2o9bLS4ac9x7ZvO9baFvgL10z/m/hbZ7VeQcNq6c3uSlmffA0+Jx4bFtvWt0rhRIZL/qTQ6p
        ldh05qPW3rbNgVHl13f8/rJyXrdDwaObsq5tt9oTZ348ffOrXLPt2m59qUk2tpPy5oq6vm11
        ecihxFKckWioxVxUnAgA/iVY/jgDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/26/2017 04:42 AM, Nguyễn Thái Ngọc Duy wrote:
> v7 is mostly about style changes except the one bug in
> test-ref-store.c, missing setup_git_directory().
> 
> There's one new patch, 03/28, which maps to the "if (!refs)" deletion
> in the interdiff.
> 
> The one comment from v6 I haven't addressed in v7 is whether to delete
> REF_STORE_READ. But if it is deleted, I think I'm doing it in
> nd/worktree-kill-parse-ref, which is partly about cleanup refs code
> anyway, to avoid another re-roll in this series.

I reviewed v7 pretty carefully, and send a couple of minor comments. But
with or without changes, it looks good to me and the whole series is

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Thanks!

Michael

