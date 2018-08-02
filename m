Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A7C1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 15:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbeHBQ5q (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:57:46 -0400
Received: from mout.web.de ([212.227.15.4]:47099 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732488AbeHBQ5q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:57:46 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lu5BO-1fupa73qXm-011THL; Thu, 02
 Aug 2018 17:06:05 +0200
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stephen Boyd <bebarino@gmail.com>
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <87ftzwu9wg.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e7e5f54d-04b6-4d0f-0bcb-692801f0719c@web.de>
Date:   Thu, 2 Aug 2018 17:06:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87ftzwu9wg.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rMxnDG2w8eRkYkZRQ9zIKSwTeorHVLQplgFhfbNNAGrX/v/vI5z
 KelnDX1DKISqKmh6ThrJ1T9QJztX+0GSL5uAhJ8BurRgFGtrFeR5eOhW7jzBzqyO8RPDyVy
 OyadnRGngE6jkyl7nqo7rxPXN9LfZhVurMBg0pgTcZufTWpPBDj/MB1sOxxWZzShBIx+93z
 Hrn4TTQD3HtyCU2FYkNVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KYMdWYCB6dc=:pqoBKLZVxhUaeok+xdjaxG
 X+euIfyPObRYIOaJl1S2sW4mA6OfVDUh4wq7JZ5YIHwJebujD67h6KvxBjjz0XJ0ET4UnP20S
 VpAMBhuXsek0qZ1oeY3cgq+WRUKL3aOph2e21QDEp/W1zLjafTkO9DjAhPRctyRrTR7CLyblM
 JsxPBEKlije1SDkWilyQ/aWK9NHCPQjopanXif8aYNP2qPaWHD2kJQblD22elky1uo5BOCC/C
 +ihF6FX2XkRUzDGNnQArOMUFpsvQlGWuqvzVQANzibVaH4LU3rKppxGf/2LZhI6sm7g7fpLI9
 I1SfGazSHDAVt60RdeArWpiTRtTOFMxErCkMEBk5FevMH+jNJ0gBRjr+FObq62KV06H6oxQib
 uhAHqRwapelZXb6o9EU1bEXPrromVhHjU5t+U8aXY1nxQW80DHP1toPC+2zLHyfYicWXRrnGP
 P/o7/VsMtpFPM7i9avmaj/kB2yz8P9g2yCjZ8Cg3uYnp6bYUMZwFjJD2Jy4hvUahwDwIn2DoX
 el0lBppWqnlo8a6LV4gKBcbSTIhDTrrK/cZslDJKB6CFq3RD2i23gj1TynJWoM0fWadERY497
 Ch7xan8AqGLPjuQasrKN862kvxk1Uh8IFJNJDkEZ+CitkUsNuKUxwydoscdMeCExLMct8GHxe
 lS+48IE/YpkB0J0B9isiRDdC3pQ7gWZwHjf8HnH1/c4/7cwtPyHeWtdsqhiL61c3CQzBKiR5e
 4jPhK0+y2EsZWzQk1xJnj8rqLQhEOW6wUvVeKWhknvEzcH/bsk53j01DQi7tm8n7soIQAbCVz
 mau/w3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.2018 um 16:21 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Thu, Aug 02 2018, René Scharfe wrote:
> 
>> Am 02.08.2018 um 00:31 schrieb Ævar Arnfjörð Bjarmason:
>>> But looking at this again it looks like this whole thing should just be
>>> replaced by:
>>>
>>>       diff --git a/builtin/push.c b/builtin/push.c
>>>       index 9cd8e8cd56..b8fa15c101 100644
>>>       --- a/builtin/push.c
>>>       +++ b/builtin/push.c
>>>       @@ -558,9 +558,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>>                       OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
>>>                       OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
>>>                       { OPTION_CALLBACK,
>>>       -                 0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>>>       +                 0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
>>>                         N_("require old value of ref to be at this value"),
>>>       -                 PARSE_OPT_OPTARG, parseopt_push_cas_option },
>>>       +                 PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
>>>       +                 parseopt_push_cas_option },
>>>                       { OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
>>>                               N_("control recursive pushing of submodules"),
>>>                               PARSE_OPT_OPTARG, option_parse_recurse_submodules },
>>>
>>> I.e. the reason this is confusing is because the code originally added
>>> in 28f5d17611 ("remote.c: add command line option parser for
>>> "--force-with-lease"", 2013-07-08) didn't use PARSE_OPT_LITERAL_ARGHELP,
>>> which I also see is what read-tree etc. use already to not end up with
>>> these double <>'s, see also 29f25d493c ("parse-options: add
>>> PARSE_OPT_LITERAL_ARGHELP for complicated argh's", 2009-05-21).
>>
>> We could check if argh comes with its own angle brackets already and
>> not add a second pair in that case, making PARSE_OPT_LITERAL_ARGHELP
>> redundant in most cases, including the one above.  Any downsides?
>> Too magical?
> 
> I'm more inclined to say that we should stop using
> PARSE_OPT_LITERAL_ARGHELP in some of these cases, and change
> "refname>:<expect" to "<refname>:<expect>" in push.c, so that the help
> we emit is --force-with-lease[=<<refname>:<expect>>].
> 
> As noted in 29f25d493c this facility wasn't added with the intent
> turning --refspec=<<refspec>> into --refspec=<refspec>, but to do stuff
> like --option=<val1>[,<val2>] for options that take comma-delimited
> options.
> 
> If we're magically removing <>'s we have no consistent convention to
> tell apart --opt=<a|b|c> meaning "one of a, b or c", --refspec=<refspec>
> meaning "the literal string 'refspec'" and --refspec=<<refspec>> meaning
> add a <refspec> string, i.e. fill in your refspec here.

The notation for requiring a literal string is to use no special markers:

	--option=literal_string

Alternatives can be grouped with parentheses:

	--option=(either|or)

In both cases you'd need PARSE_OPT_LITERAL_ARGHELP.

I haven't seen double angle brackets before in command line help strings.
The commit message of 29f25d493c doesn't mention them either.  A single
pair is used to indicate that users need to fill in a value of a certain
type:

	--refspec=<refspec>

Multi-part options aren't special in this syntax:

	--force-with-lease=<refname>:<expect>

NB: The "--refspec=" in the example before that is a literal string, so
this is also already a multi-part option if you will.

According to its manpage the option should rather be shown like this:

	--force-with-lease[=<refname>[:<expect>]]

... to indicate that all three forms are valid:

	--force-with-lease
	--force-with-lease=some_ref
	--force-with-lease=some_ref:but_not_this

The current code doesn't allow that to be expressed, while it's possible
with my patch.  And nothing is removed -- you can specify as many angle
brackets as you like, if that turns out to be useful; parseopt just won't
add any more on top automatically anymore if you do that.

Side note: The remaining user of PARSE_OPT_LITERAL_ARGHELP in
builtin/update-index.c uses a slash for alternatives; we should probably
use pipe instead:

	{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
		N_("override the executable bit of the listed files"),
		PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
		chmod_callback},

René
