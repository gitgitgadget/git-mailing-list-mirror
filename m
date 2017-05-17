Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7757F201A7
	for <e@80x24.org>; Wed, 17 May 2017 14:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbdEQOCC (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 10:02:02 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49740 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752067AbdEQOCB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 10:02:01 -0400
X-AuditID: 12074411-cc7ff70000003efd-0c-591c57d89fab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 16.EF.16125.8D75C195; Wed, 17 May 2017 10:02:00 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HE1vPq006485
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 10:01:58 -0400
Subject: Re: [PATCH 01/23] t3600: clean up permissions test properly
To:     Jeff King <peff@peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <bb244c72ec6e6ab56171d82f7379a75c4eb5481f.1495014840.git.mhagger@alum.mit.edu>
 <20170517124255.62hdqwvcvfy2tdr7@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <e8ac4b86-12a7-57c0-421b-a3ba90709464@alum.mit.edu>
Date:   Wed, 17 May 2017 16:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170517124255.62hdqwvcvfy2tdr7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqHsjXCbSYN9xSYu1z+4wWXRd6Way
        aOi9wmyx5OFrZovuKW8ZLX609DBbbN7czuLA7rFz1l12jwWbSj262o+weTzr3cPocfGSssfn
        TXIBbFFcNimpOZllqUX6dglcGV/fT2EvuMdS0bp+GksD40PmLkZODgkBE4met99Zuxi5OIQE
        djBJ9O1ewwzhnGOSmHroGBtIlbCAi0Tr9YNgtoiArMT3wxsZIYoOMUr8v7mLBSTBLLCJSWLr
        WXsQm01AV2JRTzMTiM0rYC8xqfE4I4jNIqAqceLgTLDVogIREg87d7FD1AhKnJz5BGwOJ9Cy
        eVf3MULMVJf4M+8SM4QtL7H97RzmCYz8s5C0zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrF
        yYl5ealFuqZ6uZkleqkppZsYIYEuuINxxkm5Q4wCHIxKPLwRATKRQqyJZcWVuYcYJTmYlER5
        9z+QjhTiS8pPqcxILM6ILyrNSS0Gep2DWUmEtzEUqJw3JbGyKrUoHyYlzcGiJM7Lt0TdT0gg
        PbEkNTs1tSC1CCYrw8GhJMF7NwyoUbAoNT21Ii0zpwQhzcTBCTKcB2j4N5Aa3uKCxNzizHSI
        /ClGXY45976+ZxJiycvPS5US5+0BKRIAKcoozYObA0tQrxjFgd4S5uUGpishHmByg5v0CmgJ
        E9CSZpDveItLEhFSUg2M0wLvhvXPkT2bvC1UZ+GEBae7315Y9VhDa+lM61zm2WnAALfr/Cwf
        7b551sKO0qfp2VNf8+hvs0yPtHRb8ejEzL17HP/6fD11fcKVH8yn1a9nX9txij+JiVFzk883
        Bh/XoPLgq4xrxY+uk/gVbt1bn9IYIi3LZ59nuCJO5ACDe+Hs83OvvQhQYinOSDTUYi4qTgQA
        yKkRrisDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 02:42 PM, Jeff King wrote:
> On Wed, May 17, 2017 at 02:05:24PM +0200, Michael Haggerty wrote:
> 
>> The test of failing `git rm -f` removes the write permissions on the
>> test directory, but fails to restore them if the test fails. This
>> means that the test temporary directory cannot be cleaned up, which
>> means that subsequent attempts to run the test fail mysteriously.
>>
>> Instead, do the cleanup in a `test_must_fail` block so that it can't
>> be skipped.
> 
> This should be `test_when_finished` in the final paragraph, right?

Yes, thanks. Will fix.

Michael

