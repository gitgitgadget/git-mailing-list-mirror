Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE5420282
	for <e@80x24.org>; Thu, 22 Jun 2017 07:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbdFVHg0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 03:36:26 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:60865 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751116AbdFVHgZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Jun 2017 03:36:25 -0400
X-AuditID: 1207440c-c4dff70000001e54-35-594b7378f97c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 65.63.07764.8737B495; Thu, 22 Jun 2017 03:36:24 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC644.dip0.t-ipconnect.de [87.188.198.68])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5M7aKCR026727
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 22 Jun 2017 03:36:22 -0400
Subject: Re: [PATCH 00/28] Create a reference backend for packed refs
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
 <xmqqzid3stdw.fsf@gitster.mtv.corp.google.com>
 <xmqqvanrsru4.fsf@gitster.mtv.corp.google.com>
 <20170619194315.tzdmo7xel2dztoju@sigill.intra.peff.net>
 <20170619195330.fhjlfiqmcwhgttaa@sigill.intra.peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <05ea33a0-adde-54df-07e8-bdfba9c7d503@alum.mit.edu>
Date:   Thu, 22 Jun 2017 09:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170619195330.fhjlfiqmcwhgttaa@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqFtR7B1psOOHmsXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx85Zd9k9Fmwq9ehqP8Lm8ax3D6PH
        xUvKHp83yQWwRXHZpKTmZJalFunbJXBlNHz+zlxwjLvi+aTV7A2M2zi7GDk5JARMJNY87mPt
        YuTiEBLYwSSxb+4RKOc8k0TDksksIFXCAq4SZ5cuALNFBBwlLmw5wgJR1Msk8fv1fEYQh1lg
        C5PEo6kHWUGq2AR0JRb1NDOB2LwC9hJvFrQxdzFycLAIqEocuy0AEhYViJB42LmLHaJEUOLk
        zCdgCzgFXCRett8Ca2UWUJf4M+8SM4QtL7H97RzmCYz8s5C0zEJSNgtJ2QJG5lWMcok5pbm6
        uYmZOcWpybrFyYl5ealFuoZ6uZkleqkppZsYISHPs4Px2zqZQ4wCHIxKPLwTGrwihVgTy4or
        cw8xSnIwKYny/s/zjhTiS8pPqcxILM6ILyrNSS0+xCjBwawkwiuUCpTjTUmsrEotyodJSXOw
        KInzqi5R9xMSSE8sSc1OTS1ILYLJynBwKEnwzisCahQsSk1PrUjLzClBSDNxcIIM5wEa3gKy
        mLe4IDG3ODMdIn+KUVFKnLetECghAJLIKM2D64WlpFeM4kCvCPO+A6niAaYzuO5XQIOZgAa/
        OOIBMrgkESEl1cAYWscRvezAq3vbF5nt2VczY5LPBY1J02L7LXQDTsWvTLmQNO3F0w9KS4T3
        TcvcudPrh9dniZ01rxN59IuV/vbus1DcF1s0N22zwgJ5Zpa4HT+fzclc3Xoh5K/iJb4e5kN1
        rc9zrZR5axmytvhqXtiko77d2ehsTtujA3rOv+TWZblOkltlPYldiaU4I9FQi7moOBEA5mr3
        2CQDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/19/2017 09:53 PM, Jeff King wrote:
> On Mon, Jun 19, 2017 at 03:43:15PM -0400, Jeff King wrote:
> 
>>>> Is the iterator over packed-refs correctly skipping over what are
>>>> covered by loose refs?  The entries in the packed-refs file that are
>>>> superseded by loose refs should be allowed to point at an already
>>>> expired object.
>>>
>>> Here it is in a test form for easier diagnosis.
>>
>> Thanks, I was just starting to do that myself. The problem is in
>> ca6b06eb7 (packed_ref_store: support iteration, 2017-05-15) and is
>> pretty obvious: the packed_ref iterator checks whether the entry
>> resolves.
>>
>> I think that _neither_ of the loose and packed iterators should be
>> checking this. It's only the merged result (where loose trumps packed)
>> that should bother checking.

Thanks for the bug report and the analysis, which is exactly right.

But I'd like to fix the problem a *little* differently than Peff
suggested. To keep `packed_ref_store` from deviating more than necessary
from the `ref_store` interface, I propose that we leave the code for
rejecting broken refs where it is, and instead invoke
`packed_ref_iterator_begin()` with the `DO_FOR_EACH_INCLUDE_BROKEN` flag.

I have prepared a re-roll of the patch series, but I can't submit it
until I have Junio's signoff on the test that he suggested [1]. Junio?

Thanks,
Michael

[1]
http://public-inbox.org/git/xmqqvanrsru4.fsf@gitster.mtv.corp.google.com/

