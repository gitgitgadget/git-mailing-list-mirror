Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584C71FCA9
	for <e@80x24.org>; Mon, 19 Sep 2016 06:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758142AbcISGfr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 02:35:47 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:65396 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757409AbcISGfp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Sep 2016 02:35:45 -0400
X-AuditID: 1207440f-e17ff70000000955-91-57df873f109e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 34.C4.02389.F378FD75; Mon, 19 Sep 2016 02:35:43 -0400 (EDT)
Received: from [192.168.69.190] (p57906704.dip0.t-ipconnect.de [87.144.103.4])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u8J6ZdeL002984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 19 Sep 2016 02:35:40 -0400
Subject: Re: [PATCH v3 0/8] Better heuristics make prettier diffs
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1473068229.git.mhagger@alum.mit.edu>
 <xmqqr38vjns0.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c381d458-4c81-f46c-592a-98957b3a177c@alum.mit.edu>
Date:   Mon, 19 Sep 2016 08:35:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqr38vjns0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqGvffj/c4MtmNYuuK91MFg29V5gt
        di/uZ7ZYcXUOs8WZrUDWj5YeZouZV60tNm9uZ3Hg8Ng56y67x4JNpR7Pevcwely8pOyxf+k2
        No/Pm+Q8bj/bxhLAHsVlk5Kak1mWWqRvl8CV8WztNfaCSSwVG/ZcZ2xgnMLcxcjJISFgInHx
        2mzGLkYuDiGBrYwS29b9YgNJCAmcY5K4OUcYxBYWcJR4Pu88E4gtIqAmMbHtEAtETYbE3aZn
        7CDNzALrmSRut/wHm8omoCuxqKcZrIFXwF7i6dT1QEUcHCwCqhJzNpWDhEUFQiTal62HKhGU
        ODnzCdhMTgFriTVfV4DZzAJ6Ejuu/2KFsOUltr+dwzyBkX8WkpZZSMpmISlbwMi8ilEuMac0
        Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMk7Pl3MHatlznEKMDBqMTDyxBwP1yINbGs
        uDL3EKMkB5OSKO+OknvhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4J7UAlfOmJFZWpRblw6Sk
        OViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHhT24AaBYtS01Mr0jJzShDSTBycIMN5gIYH
        gNTwFhck5hZnpkPkTzHqciz4cXstkxBLXn5eqpQ4bxtIkQBIUUZpHtwcWLp6xSgO9JYwbytI
        FQ8w1cFNegW0hAloyepZt0GWlCQipKQaGNef/ZB4y+Xzia4NEhej5vjHzJ/m+k374oK049fl
        L63syNyeUq8nvrx/kfci6/yW+U1fOn8s23Zx8t3aBSq/eApXNsZemudw6s3LDcZsD1tmFsUG
        fG5eGqyz1jq8a0204KNPfXn5r2wny4sHNhaUe54TnW1veWvlhUL3lK9Rybw9hydfCJvkME+J
        pTgj0VCLuag4EQAB2BYIMgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/2016 01:25 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>   * Add test t4059 as part of this commit, not as part of its
>>     successor.
> 
> Which needs to be moved to somewhere else, as another topics that
> has already been in 'next' uses t4059.
> 
> I'd move it temporarily to t4061 with a separate SQUASH??? at the
> tip for now, as I am running out of time today.

I didn't realize you were waiting for an ACK. Yes, it's totally OK to
rename the test.

Michael

