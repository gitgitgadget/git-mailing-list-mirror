Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147AF1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbeIFXmu (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 19:42:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:56883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbeIFXmu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 19:42:50 -0400
Received: from [10.2.0.3] ([217.235.91.60]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0xbD-1fk21P2WtD-00v9a1; Thu, 06
 Sep 2018 21:05:52 +0200
Subject: Re: [PATCH v3] Allow aliases that include other aliases
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180906101658.1865-1-timschumi@gmx.de> <87pnxqrags.fsf@evledraar.gmail.com>
 <20180906145708.GA1209@sigill.intra.peff.net>
From:   Tim Schumacher <timschumi@gmx.de>
Message-ID: <dea58ad8-4e2a-955a-8dc6-b93e9592398c@gmx.de>
Date:   Thu, 6 Sep 2018 21:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180906145708.GA1209@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:paaQDqdVWgQihxEG+UPqkomjtJ2bzvNh0hOGMJ3rE75TPKqggQ1
 okf9P1+iJ47doSwaqz2Ob8YtQ7uX34Xcr/vjmnw9TGPqEokbfZ4XYMumKf3YGkDqS9Y59Dk
 yeExBcrDWzRQyVbkN8ocGc38Bb0QOmb3dJmPc+5kgppjwoKNuONAOqU/8vwzoKME/66kYYf
 +9gpMt5Mzm0Tsa+dC+fGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gk2ccGdWHNg=:fStGzflm13/Ks9+t+jZ5Mi
 GU6krKJoiQqRvcWNOzuV0N1z8ADphPJwHO2INy+HOBEX8ZjCEkTmsxk8TJhHWalCj572+WXi0
 daToM4uEd06IqbIlhEJrMd/tfDzS4Izj0PMlcunID9Q5KmEEIwFBZHD/NOlJCCSimDN+O3i8e
 lXsPLeKwtOtU9uvSwYhY698WJcXJ9CslGQOFbPt6UZfOH7uMqAEPeY1jCbCBDpzlderecez+l
 9ec+C9/DWQlGajMpBLeECrto8n5R5uY+Y2uW8896aD+RZBXmr/smEysKrfNL9sDrochHIzzM6
 XRAAysjV8IcEaWIYqTmcSlI8/ybjjOxCq1rK5MnMU64J6NhXZRupn96yTQ6Q56JXWPK6tZfXw
 GTff6tcmSwJcrgNVmkCz4FjBMY0ge/RjprEWF6SpLWE3f076FJzpT5fqyq4gdwmsIg9omTmtU
 qeTboT9cfRx9p9m0WuT9+IFdxeIexlEBhRYVWifDRglLOEd9k2Ib4U347mdsxVV5qhoBBSBpe
 9NOmdOaWxHvI1IDphjYSpKmAXN80C2l1oWNl6Y5NIJM1iH3/A9lNPITDL+w1YL+dIiJuaYWWn
 GAG0w/yLwsgAciG/OFURKOhExKWIOQI5mqQ+l7QqLQMzcjzIVUE/f/5sg4ULRKwAachz03U65
 RzdWxN0ttRAcfhs24++XYkN1o7kv6Ky1AlGn2QLQvVjkB6EhziD1rOLdyKaFahEiC9nfHnLsH
 majRiln5GDaG8tCeTlQRC0V1lT4/D0CEjSq06iK12ctB/9F8udhdIa2vMNwd/XUvJTg8N/eiR
 NGevvM9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.09.18 16:57, Jeff King wrote:
> On Thu, Sep 06, 2018 at 04:01:39PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>> If we don't have some test for these sort of aliasing loops that fails
>> now, we really should add that in a 1/2 and fix it in this patch in 2/2.
> 
> Yes, I'd agree that this is worth adding a test (especially if the
> output routines get more complex).

I'll try to come up with a few tests (or one at this point, as we only have
a solution for internal aliases so far) and put them as 1/2. However, I don't know
what file I should put those tests into. t0001-init and t1300-config both seem
to test aliases, but I'm unsure if the new tests should go into one of those
files or a completely new one that is dedicated to aliases.

> 
>> That makes sense from an implementaion perspective, i.e. we lookup "bar"
>> twice. But let's do better. If I have aliase like:
>>
>>      a = b
>>      b = c
>>      c = d
>>      d = e
>>      e = c
>>
>> It should be telling me that my "e" expansion looped back to the "c = d"
>> expansion. Here's a patch to implement that, feel free to either squash
>> it in with my Signed-Off-By, or tacked onto a v4 version of this,
>> whichever you think makes sense:
> 
> I don't have a strong opinion on whether this is worth it, but I think
> your implementation could be a little simpler:
> 
>> diff --git a/git.c b/git.c
>> index 64f5fbd572..38f1033e52 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -692,8 +692,64 @@ static int run_argv(int *argcp, const char ***argv)
>>   		/* .. then try the external ones */
>>   		execv_dashed_external(*argv);
>>
>> -		if (string_list_has_string(&cmd_list, *argv[0]))
>> -			die(_("loop alias: %s is called twice"), *argv[0]);
>> +		if (string_list_has_string(&cmd_list, *argv[0])) {
>> +			struct strbuf sb = STRBUF_INIT;
>> +			int i, seen_at_idx = -1;
>> +
>> +			/*
>> +			 * Find the re-entry point for the alias
>> +			 * loop. TODO: There really should be a
>> +			 * "return the index of the first matching"
>> +			 * helper in string-list.c.
>> +			 */
>> +			for (i = 0; i < cmd_list.nr; i++) {
>> +				if (!strcmp(*argv[0], cmd_list.items[i].string))
>> +					seen_at_idx = i;
>> +			}
>> +			assert(seen_at_idx != -1);
> 
> The string-list code doesn't generally deal in indices. You can use
> string_list_find_insert_index(), but its return value is a little funky
> for the existing case. You can also just do:
> 
>    struct string_list_item *seen;
>    ...
>    seen = string_list_lookup(&cmd_list, *argv[0]);
>    if (seen) {
> 	/* we have a loop */
> 	int idx = seen - cmd_list.items;
> 
> That's a little intimate with the string-list implementation as an array
> of string_list, but it's already pretty standard to walk over and
> dereference that list (including in your patch). But also see below.
> 
> Side note: there's actually a bigger problem with the original patch:
> the string list is unsorted (because it uses string_list_append(), and
> which is why your linear walk works here). But string_list_has_string()
> assumes it is sorted.  So I think we'd actually want to use
> unsorted_string_list_has_string() or unsorted_string_list_lookup().

I'll update v4 to use use unsorted_string_list_has_string().
> 
>> +			for (i = 1; i < cmd_list.nr; i++) {
>> +				if (i - 1 == seen_at_idx)
>> +					/*
>> +					 * TRANSLATORS: This is a the
>> +					 * re-enttry point in the list
>> +					 * printed out by the "alias
>> +					 * loop" message below.
>> +					 */
>> +					strbuf_addf(&sb, _("    %d. %s = %s <== The re-entry point in the loop\n"),
>> +						    i,
>> +						    cmd_list.items[i - 1].string,
>> +						    cmd_list.items[i].string);
> 
> This is always going to show the right-hand of the equals as the
> left-hand on the next line. Would it be simpler to just show the list?
> Likewise, the last item in the list is always going to be "where the
> loop started". Do we need to say that?
> 
> E.g., something like:
> 
>    seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
>    if (seen) {
>            for (i = 0; i < cmd_list.nr; i++) {
> 		struct string_list *item = cmd_list.items[i];
> 
> 		strbuf_addf(&sb, "  %s", item->string);
> 		if (item == seen)
> 			strbuf_add(&sb, " <==");
> 		strbuf_addch(&sb, '\n');
> 	  }
> 	  /* We never added this to the list, but we were about to */
> 	  strbuf_addch("  %s\n", seen->string);
> 	  die(...);
>    }
> 
> I guess it's not that far off of yours. Not using words to describe the
> loop entry and exit points avoids translation, which avoids notes to
> translators, which is most of what makes your patch long. ;)
> 
> -Peff
> 

I'll tinker around with both code snippets, we'll see which one is
more convenient for the user.

Thanks to all of you for the input!

Tim
