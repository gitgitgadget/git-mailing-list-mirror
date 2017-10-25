Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1A26202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 08:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932184AbdJYIXT (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 04:23:19 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58235 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932175AbdJYIXQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2017 04:23:16 -0400
X-AuditID: 1207440f-a5bff70000007960-9b-59f049f124b0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E1.D2.31072.2F940F95; Wed, 25 Oct 2017 04:23:14 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC93E.dip0.t-ipconnect.de [87.188.201.62])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9P8NAgG022015
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 25 Oct 2017 04:23:11 -0400
Subject: Re: [PATCH 1/2] t1404: add a bunch of tests of D/F conflicts
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <cover.1508856679.git.mhagger@alum.mit.edu>
 <be088bd57e61f4ea0dc974a65829a928ecd30534.1508856679.git.mhagger@alum.mit.edu>
 <CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com>
 <20171024194634.pigmvgoqtdexvjhc@sigill.intra.peff.net>
 <e66694a3-98e2-33aa-4cdd-dac41d2a89d5@alum.mit.edu>
Message-ID: <371b9dfd-8aaf-c539-df8a-2d0ae05208e4@alum.mit.edu>
Date:   Wed, 25 Oct 2017 10:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <e66694a3-98e2-33aa-4cdd-dac41d2a89d5@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqPvJ80OkwfMTWhZdV7qZLBp6rzBb
        /GjpYbY486aR0YHF41nvHkaPi5eUPRY/8PL4vEkugCWKyyYlNSezLLVI3y6BK+NC5wv2gocc
        FTemtTM2MH5m62Lk5JAQMJGYv3khSxcjF4eQwA4mid3z50E555kkrt18wQJSJSzgKrF3zlew
        DjYBXYlFPc1MILaIgJvEh8knwWqYgezuW5vZIZr3M0msa5vNDJLgFbCXmLBzNlgRi4CqxMp5
        fUA2B4eoQITEho38ECWCEidnPgEr4RRwkLjz/wozxEx1iT/zLkHZ4hK3nsxngrDlJba/ncM8
        gVFgFpL2WUhaZiFpmYWkZQEjyypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2M
        kCDn38HYtV7mEKMAB6MSD6/A9PeRQqyJZcWVuYcYJTmYlER5wz0+RArxJeWnVGYkFmfEF5Xm
        pBYfYpTgYFYS4VV4BVTOm5JYWZValA+TkuZgURLnVV+i7ickkJ5YkpqdmlqQWgSTleHgUJLg
        vQoyVLAoNT21Ii0zpwQhzcTBCTKcB2h4AUgNb3FBYm5xZjpE/hSjLsezma8bmIVY8vLzUqXE
        eZeBFAmAFGWU5sHNgSWnV4ziQG8J89oDU5UQDzCxwU16BbSECWhJkyrYkpJEhJRUA2NUYH7q
        1XUJBfm5Ur2ZFx4vk2Tpa+j4r7PS/O2JQ/eetMQ/qgjhuB0rJ+Z28+z5OJPmmyIu06JDT5tJ
        Gn4uzHGa/GkKJ0tbm1jyjJ877v+7FqV4tClda5LGh/bl+7wtuhm/CHDLXIhsmXh3j+TOO9PL
        b34+oaL14NXe17HLJzvGXBF+eDj2SbsSS3FGoqEWc1FxIgCKY2jSKQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/2017 10:03 AM, Michael Haggerty wrote:
> On 10/24/2017 09:46 PM, Jeff King wrote:
>> On Tue, Oct 24, 2017 at 12:19:26PM -0400, Eric Sunshine wrote:
>>
>>> On Tue, Oct 24, 2017 at 11:16 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
>>>> @@ -34,6 +34,86 @@ test_update_rejected () {
>>>> +# Test adding and deleting D/F-conflicting references in a single
>>>> +# transaction.
>>>> +df_test() {
>>>> +       local prefix="$1"
>>>> +       shift
>>>> +       local pack=:
>>>
>>> Isn't "local" a Bash-ism we want to keep out of the test scripts?
>>
>> Yeah. It's supported by dash and many other shells, but we do try to
>> avoid it[1]. I think in this case we could just drop it (but keep
>> setting the "local foo" ones to empty with "foo=".
> [...]
> 
> But I agree that this bug fix is not the correct occasion to change
> policy on something like this, so I'll reroll without "local".

Oh, I see Junio has already made this fix in the version that he picked
up, so I won't bother rerolling.

Michael
