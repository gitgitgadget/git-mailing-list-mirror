Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47F7215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbeD3Pli (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:41:38 -0400
Received: from mout.web.de ([217.72.192.78]:51611 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753973AbeD3Plh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:41:37 -0400
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSads-1eliRf3EkW-00Ra9e; Mon, 30
 Apr 2018 17:41:35 +0200
Subject: Re: [PATCH v1 1/1] test: Correct detection of UTF8_NFD_TO_NFC for
 APFS
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
 <20180430063519.27122-1-tboegi@web.de>
 <CABPp-BHa7y8ggoCoLY0z4_=3njH=UV8GscXaz_YWvfNbfmPxhA@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <86b1fc05-b22c-cb9a-b5b5-d5e819d97c1e@web.de>
Date:   Mon, 30 Apr 2018 17:41:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHa7y8ggoCoLY0z4_=3njH=UV8GscXaz_YWvfNbfmPxhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Sg8jrbUg8kauDZwT+i4aaGSuQGoX8bU9q+b9MfmiUMeUlnBLjGI
 79Wo4VGhSa4tc4Tz9sXCjwyrNkSkoQ4kgapc5nwBUE1WNuzivb7SZ/2B/JGAq1Eon8WdEMI
 G72llz1zUx/neV4bqQA0Die8tdEWK/NLazlybkgc36W7pcNwrg93TesZK+j4qkG5o6bFuMl
 BnFcZ8Oo70Bh7YXcIrhyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NsByRDL+8xM=:PEi/s9OT2sHPgLr4AqBaSo
 SOUk7YXQZlCGkP0AqveuuQFPnd0FoQ1fH2KvZjcEJ92B/BD1QYEzGjzINZ/mNCknBlkCPe1eS
 /kzQKo61luqTclRqcXanKeWSoqLfYxAZw6sQOHxQJxy/ZD2942UstJaBJuDrw6+fgjD8k9oRw
 1NFLNlEJ1x6W4v37NTfuJNhgYmuqGwuWreSyVnbP6OBfKKnHQzBBUuZG/ZnlWVEfRNudFieIX
 nVm41YjfeOoYlI+AU+oSoymUi6qT41xxGA8buHKE5OIdPJVAGTfwRWkR4MjmjOk+NTnKMmbbe
 sIRpoZ9Tv1me8lvohjdKYtn8pgS5V6320n4qEuYqwueMZzkCy0ckGQsx+keZR9gDFyN0TSHAX
 EbfY1Et2jgscjwxaVVdLqQgFCqaq40IgTn2TRaT+ncxfHNK+Zf2ZwxwwflpmmzBbOMyyfH+SL
 fHj3ZLQhUr9WHDKZwa84zV095b7xSIF85uMZsON/THL2f6LB4WOb9a+xxiaCBWhRiE4XtQSOC
 z5Bl0AkNSqzwtcZYlqrVDLi6YNt0MKYZv4GqSAslX7gP6oOxxngZcCDWH6hMhZKLa3WXMduuv
 WQjG4dPKkbDirnuQvBh+EUWsP7hs2XIDSTG0ziuIohkYjnzvhL6vKGY24nLYwG7SQBMF4zWMj
 95L/ZqAXcA2QLUbQkOixTkhu7XxINTJAjVlKM3RsTDreBIb8u1ghfQtJwq0t7jCCW8IkmR1bT
 VZjJ/cPHC9pxzYp+7qmyPJCUjYab3OZBFyKNCDShsvRc9rj+Ufa5cqsQcUPPBBPJ7vApK3Oqb
 EIgq00L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.04.18 17:33, Elijah Newren wrote:
> Hi,
> 
> On Sun, Apr 29, 2018 at 11:35 PM,  <tboegi@web.de> wrote:
>> From: Torsten Bögershausen <tboegi@web.de>
>>
>> On HFS (which is the default Mac filesystem prior to High Sierra),
>> unicode names are "decomposed" before recording.
>> On APFS, which appears to be the new default filesystem in Mac OS High
>> Sierra, filenames are recorded as specified by the user.
>>
>> APFS continues to allow the user to access it via any name
>> that normalizes to the same thing.
>>
>> This difference causes t0050-filesystem.sh to fail two tests.
>>
>> Improve the test for a NFD/NFC in test-lib.sh:
>> Test if the same file can be reached in pre- and decomposed unicode.
>>
>> Reported-By: Elijah Newren <newren@gmail.com>
>> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
>> ---
>>  t/test-lib.sh | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index ea2bbaaa7a..e206250d1b 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1106,12 +1106,7 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
> 
> I'm not sure what "NFD" and "NFC" stand for, but I suspect the test
> prerequisite name may be specific to how HFS handled things.  If so,
> should it be renamed from UTF8_NFD_TO_NFC to something else, such as
> UTF8_NORMALIZATION?

NFD and NFC both come from the unicode standard, and are just taken
"as is" into the Git world:
https://en.wikipedia.org/wiki/Unicode_equivalence

If you are otherwise happy with the patch, would it be possible
to run it on your system ?
(I don't have a High Sierra box, but I am confident that the test work
 for you).

The other comments may be addressed later, may be.
In any case, they should go into a different commit.
 
