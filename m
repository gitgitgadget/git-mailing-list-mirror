Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A0D207D6
	for <e@80x24.org>; Sat, 22 Apr 2017 05:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037371AbdDVFGg (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 01:06:36 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:46531 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1035761AbdDVFGf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Apr 2017 01:06:35 -0400
X-AuditID: 1207440e-797ff70000007d8a-38-58fae4d4d0a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 52.05.32138.4D4EAF85; Sat, 22 Apr 2017 01:06:31 -0400 (EDT)
Received: from [192.168.69.190] (p57907D7C.dip0.t-ipconnect.de [87.144.125.124])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3M56P1f029594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 22 Apr 2017 01:06:27 -0400
Subject: Re: [PATCH v4 0/5] Kill manual ref parsing code in worktree.c
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20170318100206.5980-1-pclouds@gmail.com>
 <20170404102123.25315-1-pclouds@gmail.com>
 <xmqqk26nojfm.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <93a5e70b-9c37-6c77-7c42-be253d27f277@alum.mit.edu>
Date:   Sat, 22 Apr 2017 07:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqk26nojfm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqHv9ya8Igz2tqhZdV7qZLBp6rzBb
        dE95y2ixeXM7iwOLx85Zd9k9Fmwq9bh4Sdnj8ya5AJYoLpuU1JzMstQifbsEroyWfbuZC76w
        Vay5uoe1gXE/axcjJ4eEgInE1u+tzF2MXBxCAjuYJD48WM4G4Vxgkjg26xkLSJWwgJvE5OOr
        wTpEBEol+hZ+hyqazCjR9WYhG0iCWcBaYvWDZrAiNgFdiUU9zUwgNq+AvcSV5TMZQWwWAVWJ
        nw+mgg0VFQiRmLPwASNEjaDEyZlPwOKcQHP2XuhmhZipLvFn3iVmCFteonnrbOYJjPyzkLTM
        QlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSmlmxghYcu3g7F9vcwh
        RgEORiUe3hUsvyKEWBPLiitzDzFKcjApifKG/P4ZIcSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
        t+ouUDlvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYL382OgRsGi1PTU
        irTMnBKENBMHJ8hwHqDh7o9AhhcXJOYWZ6ZD5E8x6nLMuff1PZMQS15+XqqUOO9OkEECIEUZ
        pXlwc2Dp5hWjONBbwrxbQKp4gKkKbtIroCVMQEvO+v0AWVKSiJCSamBcsq/opfeDyVxhuXen
        cP5ti3mrwp/IEKa6g/tss+nJ7ean9k+Pyfi7fVPRlv0GqsGsoWcsLkeb3mvmP37rVbfm1E3d
        3PsDLs35wqnC71kzU2mB3Sv7g8v/qKiun6TY/PGnR4kWx+I30erdHpEn+6Przryzv9WydtfO
        u0o9rI5Xag5rrij1OOSuxFKckWioxVxUnAgApJTxhxIDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/14/2017 03:40 AM, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
>> v4 adds a new patch, 2/5, which makes the hashmap related functions in
>> refs.c generic, so I could add a new map for worktree ref stores and
>> not abuse submodule hashmap.
>>
>> I mentioned about moving these hashmap back to submodule.c and
>> worktree.c where it can map more than just ref stores (in worktree
>> case, we can cache 'struct worktree', for example). But I'm not doing
>> it now to keep things small.
>>
>> The commit message in 1/5 is rephrased a bit, hopefully clearer.
> 
> Michael, does this look good to replace what has been queued?

I finally reviewed this patch series. The refs-related changes look
fine, and the submodule-related changes (which I'm not so familiar with)
looks plausible.

It's a nice cleanup :-)

Michael

