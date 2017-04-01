Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CFC1FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 05:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750793AbdDAFFi (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 01:05:38 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47983 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750789AbdDAFFh (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Apr 2017 01:05:37 -0400
X-AuditID: 12074412-4a3ff70000000b04-4a-58df351f135e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 89.57.02820.F153FD85; Sat,  1 Apr 2017 01:05:36 -0400 (EDT)
Received: from [192.168.69.190] (p57906954.dip0.t-ipconnect.de [87.144.105.84])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3155Vko024166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 1 Apr 2017 01:05:32 -0400
Subject: Re: [PATCH v7 23/28] files-backend: avoid ref api targetting main ref
 store
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
 <20170326024241.31984-24-pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f86b6e02-43cc-c3eb-5383-ed57f2a2d1ef@alum.mit.edu>
Date:   Sat, 1 Apr 2017 07:05:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170326024241.31984-24-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqKtgej/C4OdjeYuuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGix8tPcwWM69aW2ze3M7iwOGxc9Zddo8PH+M8Fmwq9ehqP8Lm8ax3
        D6PHxUvKHvuXbmPz+LxJLoAjissmJTUnsyy1SN8ugSvj2beH7AVXWCuOXzzL2MB4nqWLkZND
        QsBEYv6+FtYuRi4OIYEdTBKdv3azQTjnmCQmrnnIBFIlLBAm0dI6lRnEFhFIk1g8+T0zRNFE
        Ron25WfBOpgFPjNKTLl7nhGkik1AV2JRTzNYN6+AvcTui2/AbBYBFYmDH8+wg9iiAiEScxY+
        YISoEZQ4OfMJ2E2cAhYSlxZcBdvGLKAu8WfeJShbXqJ562zmCYz8s5C0zEJSNgtJ2QJG5lWM
        cok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsYIVEgtINx/Um5Q4wCHIxKPLwKfvci
        hFgTy4orcw8xSnIwKYnyfi8GCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhTfwClONNSaysSi3K
        h0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuD9Znw/QkiwKDU9tSItM6cEIc3EwQky
        nAdo+CcjoBre4oLE3OLMdIj8KUZdjhvHD7xhEmLJy89LlRLnVQIZJABSlFGaBzcHlrxeMYoD
        vSXM+wukigeY+OAmvQJawgS0xOLrXZAlJYkIKakGRuXieoH06IJnBRkVl4z5G9tc+jmqneS5
        +X5PffDxdu8i7aDyP+dydsjeqO9JerZxZlWLz77z828bTmTjcedZ++WGZtXhlRM8l63JO/Px
        fKnJsvkrMmaqFOiwnjZevYAvSmtv1hl7lYPfqwWVNhrf3FO3zl7+mcTG8+9aRKQeH18SUbKi
        b1faMiWW4oxEQy3mouJEAJQrahQ5AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nits: s/targetting/targeting/ in the subject line.

On 03/26/2017 04:42 AM, Nguyễn Thái Ngọc Duy wrote:
> A small step towards making files-backend works as a non-main ref store
> using the newly added store-aware API.

s/works/work/

> For the record, `join` and `nm` on refs.o and files-backend.o tell me
> that files-backend no longer uses functions that defaults to
> get_main_ref_store().

s/defaults/default/

> I'm not yet comfortable at the idea of removing
> files_assert_main_repository() (or converting REF_STORE_MAIN to
> REF_STORE_WRITE). More staring and testing is required before that can
> happen. Well, except peel_ref(). I'm pretty sure that function is safe.
> [...]

Michael

