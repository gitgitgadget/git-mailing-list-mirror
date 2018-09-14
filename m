Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91051F404
	for <e@80x24.org>; Fri, 14 Sep 2018 23:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbeIOE3C (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 00:29:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:39633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeIOE3C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 00:29:02 -0400
Received: from [10.2.0.3] ([217.235.87.139]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaIsi-1gGIFm2eRk-00Jrv3; Sat, 15
 Sep 2018 01:12:18 +0200
Subject: Re: [RFC PATCH v4 3/3] t0014: Introduce alias testing suite
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180907224430.23859-1-timschumi@gmx.de>
 <20180907224430.23859-3-timschumi@gmx.de>
 <CAPig+cR1JpZqxBAsR+6_WjLwofnU8siB9VXYdUkXY2P-xQnsuQ@mail.gmail.com>
From:   Tim Schumacher <timschumi@gmx.de>
Message-ID: <bd63006e-18a7-1c41-252c-cf47a65ba7cb@gmx.de>
Date:   Sat, 15 Sep 2018 01:12:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cR1JpZqxBAsR+6_WjLwofnU8siB9VXYdUkXY2P-xQnsuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zs4vA2lOLCOAgpk41MK8himOZ9+yGB+hBjyrhNY6mQWqHM+3vOu
 kel1rFMPRDjTzelw/94C+HI5YJkw+jcsVE3GHO5gpnoRIAX+ihu/TGezdZHyX2z2g6PPljJ
 9J+qjJmwsuNvvLWv7Ile+SOfmerjkpzFmAItyhlMccd8Vjny9waqkk+5ePkx8SGiuVAuyph
 YgH/XAFLgdK8Aik/6vhfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PtjT6OguuAw=:4YIkpnxulWjt0W+mw4S2Ku
 RH7H9VDuWfdMCEGx33bXGQFTJkswjU8amuxcyw9UayRtTtfm6AiVVPrKgM0f5c83epmciZ8fq
 d7nT9mphFfUV3CrmfYcyciGWpZTpqyT3D6tqZ85QnzzCjGQFaanRUEiAVfK826H6eUvxtxFAi
 +So9Xbb4sEW+Bw7jHtzhQgHtTmQlm7qj7TukpUbc5iE+cxf1cHUi+LPa+qkbOPF+oHahSautQ
 lGgf/3YvlII1iKT/0SYfEyX6Vz/BFhdJ0lygIlg/TmykoxZ/OJPpQziEm1rk4qOC9cQWDR08c
 4FrM+Vkqi3RG4ESrMw7tFKFTsFuQ//JYR5uub4jC4muWbnqXpfeEm01S/b6nYKuhOpMZSzBYs
 f2qThEB/AsF9UhxBLkV76n5aHtShOqqAp5z6GJDsbka1XZhKJT3NpOmfZ3W8jhzeyIcvCXw+P
 AOKZnN89C0PJ7lv2YGkURrftUDbafY9X6DkllTicVAitZUCJSYqxvTyNBrrZrIgEJkYX1Mvle
 end1wxiRJD/cw8Rj6yc8YQFvAN1gbhKWpCRXKxtSq8GMWwi3hi6WudHl+zWKmnq+NlYpquBJx
 fwKHr9XVcBPWC38MLthW6nKTSPPhy1uPxGlUhSaanGNCgx3Ikn0VA0Ggl79NgJ91ZiWsglJ/v
 L9Ehth6adMEi4gjaYXP3jX6ApW8V95T2ABaR3ZZUX1tafKVAdmcF8E172phtgNl8f0gjgNEMW
 qnlXrndsfRetkC1LoNuaYZXUlVue7DbF16pMkbCCOO1euzb75pJFJdYeWrK+QZNmL3/feuyUv
 adbg9H2h/j8p57Aee0c/SuJf1f2q2QNBNqf7SoI+utDzosJajo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.09.18 01:38, Eric Sunshine wrote:
> On Fri, Sep 7, 2018 at 6:44 PM Tim Schumacher <timschumi@gmx.de> wrote:
>> Introduce a testing suite that is dedicated to aliases.
>> For now, check only if nested aliases work and if looping
>> aliases are detected successfully.
>>
>> The looping aliases check for mixed execution is there but
>> expected to fail because there is no check in place yet.
>>
>> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
>> ---
>> Unfortunately I don't have a fix for the last one yet, so I
>> marked it as expect_failure. The problem is that the test suite
>> is waiting a full minute until it aborts the running command
>> (which I guess should not take that long, as it blocks the whole
>> test suite for that span of time).
>>
>> Should I try to decrease the timeout or should I remove that
>> test completely until I manage to get external calls fixed?
> 
> Perhaps just comment out that test for now and add a comment above it
> explaining why it's commented out.

That will probably be the easiest thing to do. I commented it out for
now, added a short information about that to the code itself and a longer
explanation to the commit message.

> 
>> As a last thing, is there any better way to use single quotes
>> than to write '"'"'? It isn't that bad, but it is hard to read,
>> especially for bash newcomers.
> 
> You should backslash-escape the quotes ("foo \'bar\' baz"), however,
> in this case, it would make sense to use regex's with 'grep' to check
> that you got the expected error message rather than reproducing the
> message literally here in the script.

Backslash-escaping didn't work, that resulted in some parsing error.
I'm using i18ngrep now to search for the part of a message, which
eliminates the need for quotes completely.

> 
> More below.
> 
>> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
>> @@ -0,0 +1,38 @@
>> +#!/bin/sh
>> +
>> +test_description='git command aliasing'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup environment' '
>> +       git init
>> +'
> 
> "git init" is invoked automatically by the test framework, so no need
> for this test. You can drop it.
> 
>> +test_expect_success 'nested aliases - internal execution' '
>> +       git config alias.nested-internal-1 nested-internal-2 &&
>> +       git config alias.nested-internal-2 status
>> +'
> 
> This isn't actually testing anything, is it? It's setting up the
> aliases but never actually invoking them. I would have expected the
> next line to actually run a command ("git nested-internal-1") and the
> line after that to check that you got the expected output (whatever
> "git status" would emit). Output from "git status" isn't necessarily
> the easiest to test, though, so perhaps pick a different Git command
> for testing (something for which the result can be very easily checked
> -- maybe "git rm" or such).

Whoops, I didn't know when that went missing. I added it into a new version
of this patch.

Also, I decided to keep `git status`, because it seemed to be the only
command which doesn't need any files to produce some checkable output.
Checking the "On branch" message should be enough to confirm that the
command works as intended.

> 
>> +test_expect_success 'nested aliases - mixed execution' '
>> +       git config alias.nested-external-1 "!git nested-external-2" &&
>> +       git config alias.nested-external-2 status
>> +'
> 
> Same observation.
> 
>> +test_expect_success 'looping aliases - internal execution' '
>> +       git config alias.loop-internal-1 loop-internal-2 &&
>> +       git config alias.loop-internal-2 loop-internal-3 &&
>> +       git config alias.loop-internal-3 loop-internal-2 &&
>> +       test_must_fail git loop-internal-1 2>output &&
>> +       grep -q "fatal: alias loop detected: expansion of '"'"'loop-internal-1'"'"' does not terminate" output &&
> 
> Don't bother using -q with 'grep'. Output is hidden already by the
> test framework in normal mode, and not hidden when running in verbose
> mode. And, the output of 'grep' might be helpful when debugging the
> test if something goes wrong.
> 
> As noted above, you can use regex to match the expected error rather
> than exactly duplicating the text of the message.
> 
> Finally, use 'test_i18ngrep' instead of 'grep' in order to play nice
> with localization.
> 
>> +       rm output
> 
> Tests don't normally bother cleaning up their output files like this
> since such output can be helpful when debugging the test if something
> goes wrong. (You'd want to use test_when_finished to cleanup anyhow,
> but you don't need it in this case.)

I incorporated both of these suggestions.

> 
>> +'
> 

This is the first multi-patch series that I submitted, so I'm unsure if I
should send the updated patch only or if I should send the complete series
again as v5. Any pointers to what the correct procedure for this case is would
be appreciated.

Thanks for looking at this.

Tim
