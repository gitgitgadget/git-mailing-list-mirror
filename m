Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2498E20958
	for <e@80x24.org>; Thu, 30 Mar 2017 04:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754627AbdC3E7x (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 00:59:53 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59521 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754233AbdC3E7w (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 00:59:52 -0400
X-AuditID: 1207440d-041ff70000003721-be-58dc90c52bcd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C5.D7.14113.5C09CD85; Thu, 30 Mar 2017 00:59:50 -0400 (EDT)
Received: from [192.168.69.190] (p579060CC.dip0.t-ipconnect.de [87.144.96.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2U4xkJC010526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 30 Mar 2017 00:59:48 -0400
Subject: Re: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
To:     Junio C Hamano <gitster@pobox.com>
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
 <1490747533-89143-3-git-send-email-bnmvco@gmail.com>
 <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
 <xmqqk278av4x.fsf@gitster.mtv.corp.google.com>
Cc:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org,
        sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <e412ef09-276b-92df-d2c0-0bf2f80238d2@alum.mit.edu>
Date:   Thu, 30 Mar 2017 06:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqk278av4x.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqHtswp0Igw1nlC0ef3rLZtF1pZvJ
        oqH3CrNF95S3jBabN7ezOLB67Jx1l91jwaZSj4uXlD0+b5ILYInisklJzcksSy3St0vgyti8
        ZSZTwVf2imnLL7I0MK5g62Lk5JAQMJF4+GMjkM3FISSwg0micVkDM0hCSOA8k8T850UgtrCA
        r0TDmbUsILaIgJrExLZDLBAN9xglDh6eD9bALJAtcfjGalYQm01AV2JRTzMTiM0rYC9x/NdR
        RhCbRUBV4sL+nWA1ogIhEnMWPmCEqBGUODnzCdgCTgFriX+3bzBBzNST2HH9FyuELS+x/e0c
        5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpGermZJXqpKaWbGCHh
        y7uD8f86mUOMAhyMSjy8FWtvRwixJpYVV+YeYpTkYFIS5V1SdCdCiC8pP6UyI7E4I76oNCe1
        +BCjBAezkgiv1iegct6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG95
        P9BQwaLU9NSKtMycEoQ0EwcnyHAeoOG1IDW8xQWJucWZ6RD5U4yKUuK8Ln1ACQGQREZpHlwv
        LL28YhQHekWYtw2knQeYmuC6XwENZgIaLG5zC2RwSSJCSqqBMVroVEH8UjXnh5OOJge3qYmb
        /NXZNo37oY5x8Fr1A77XHly2OVgpXmRjUfV4htoeTa95ah+y1l091Vq87cjayPtWBZkxs/Ju
        viu8+eGRS7efTBbL3H4j+YVNWVsXHl/G2W2Ysc1U2alM3VVV8fi06C2czZtusZ0xec/ZLfAk
        cu3Xrawxd4MWKLEUZyQaajEXFScCAMBCE54KAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/29/2017 06:46 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I also realize that I made a goof in my comments about v3 of this patch
>> series. Your new option is not choosing between "depth-first" and
>> "breadth-first". Both types of iteration are depth-first. Really it is
>> choosing between pre-order and post-order traversal. So I think it would
>> be better to name the option `DIR_ITERATOR_POST_ORDER`. Sorry about that.
> 
> That solicits a natural reaction from a bystander.  Would an
> IN_ORDER option also be useful?  I am not demanding it to be added
> to this series, especially if there is no immediate need, but if we
> foresee that it would also make sense for some other callers, we
> would at least want to make sure that the code after this addition
> of POST_ORDER is in a shape that is easy to add such an option
> later.

I think IN_ORDER really only applies to *binary* trees, not arbitrary
trees like a filesystem.

Michael

