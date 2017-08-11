Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE42208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 08:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbdHKIxU (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 04:53:20 -0400
Received: from mout.web.de ([212.227.15.4]:57182 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbdHKIxR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 04:53:17 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKaHP-1dfH0N3iYp-0022w1; Fri, 11
 Aug 2017 10:52:52 +0200
Subject: Re: [PATCH] apply: remove prefix_length member from apply_state
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <24fb9d9c-0b1c-4aaa-7d89-12d322066cff@web.de>
 <20170810234157.fqsatxk4m3wncm3f@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <746a8339-a490-0a10-a4af-ead78b7b7a6e@web.de>
Date:   Fri, 11 Aug 2017 10:52:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170810234157.fqsatxk4m3wncm3f@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:GHDTU7IKBSD8a8QFR/sR+AAK83x+KddDGDBdx7AhCwoo9USzW5/
 9mHrDNHCJF/aHWjoN1iXVRT5YqSvJqKT2SdXf9aYVWMCw6QeknmiqOzwDIA8eydBpY00Ngx
 qi8BHNwPigCStGr5yx211xIv7AYt1/TY+/1o4hAYFn1i7nuMEM/6BL6uNGoWDq10ndDYmdI
 G1JnyBHPkZX95v/DozFdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KfCYpkgWCeQ=:e9CSa4SIdxMeuWsOTlpw5b
 iSjEyBLjxp0oOV50v9DK1ILpI9jRdpV172MMAKGK6fRn7ZOCHmF0qvKlDpNk4TJKE/akFidQ4
 1EcQEN9EHX22bwZkiTHQhyLl8YG74mAY547anxCcWelBR7gxdD1XXcGklGg6Lx4LPNl8P+F8R
 TFGJFdgJx2c6fd8sRE7p3IALIqwJVzyUAbpemHyZil5nZZI1MUyMlMZDf197Tw9swJXEY7t5E
 OWxSN9OfEotIgy9wPctMUm2agxxIAp5vNrUlYfWUMrFWX0mEeg6x0vmBf+LbNETS2aH8BUq9+
 1+QHJi9UTdl68RbQtnpWryDe4OA//azPg4XWJsiN0ZF8Li5yUkE/JqFRZPURGQbKXvQN0AZdb
 W+g8a2K59bLdRD2Y/UKpppd8CbgyeWsIrhrmIiqD4Jk/8vPhsxfZ17cu+vrjXHzl7yfkg8sNr
 ScdJ+kK3IrLpEkD4hCSBj2Ba3bEzFBd1LzardXB92eS0TxcN2oYXKOSpJOhAnz59P/xf1hBO+
 NyIeXEIIZEvouEC+Hajq6S5ibR7AO1zydb5H8zqzoPnlbPOoPfRxVd3+L868DBNvcRaCvxiff
 17Er7++dCUeX6YiWqqanbwe8zGDoE4LmzXuGN/ac1sqqwjoSLjaYegXqYLhKsfEY06iyi04lT
 dNM4fpfiwR/kyBSOZ7xZS3HOMpgwdtRJpEBVNjpI7R1YiwHlZQoInwIf+/R1oryrEdXfUgosc
 i0SPA0R5AMR7g3GImEZHSSPvEZhrqCoC/PWyfrpvH62s5LGINhyZgOlgEbS5MSGax+gQ25YqE
 SEODFf1YPP8FO4lb2JMEbAFK7tvf+VV1BzVhkHQKWSHCrPl9Ro=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.2017 um 01:41 schrieb Jeff King:
> On Wed, Aug 09, 2017 at 05:54:46PM +0200, René Scharfe wrote:
> 
>> Use a NULL-and-NUL check to see if we have a prefix and consistently use
>> C string functions on it instead of storing its length in a member of
>> struct apply_state.  This avoids strlen() calls and simplifies the code.
> 
> I had to read the code to figure out exactly what you meant by
> NULL-and-NUL (and even then it took me a minute).
> 
> I thought at first the latter half just means "use starts_with to walk
> the string incrementally rather than bothering to find the length ahead
> of time".  Which makes perfect sense to me.
> 
> But actually, I think you mean the final block which makes sure we have
> a non-empty string.

Yes; I meant: Check against NULL to see if we even have a string and check
its first byte against NUL to see if that string is empty instead of
checking that its length is greater than zero.

> 
>> diff --git a/apply.c b/apply.c
>> index 970bed6d41..168dfe3d16 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -80,7 +80,6 @@ int init_apply_state(struct apply_state *state,
>>   {
>>   	memset(state, 0, sizeof(*state));
>>   	state->prefix = prefix;
>> -	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
> 
> So we suspect that state->prefix might be NULL here.
> 
>> @@ -786,11 +785,11 @@ static int guess_p_value(struct apply_state *state, const char *nameline)
>>   		 * Does it begin with "a/$our-prefix" and such?  Then this is
>>   		 * very likely to apply to our directory.
>>   		 */
>> -		if (!strncmp(name, state->prefix, state->prefix_length))
>> +		if (starts_with(name, state->prefix))
>>   			val = count_slashes(state->prefix);
> 
> At first this looked wrong to me. Don't we need to check for NULL? But
> the check is simply just outside the context, so we are good.

Yes, diff -U5 or -W would have shown that easily. 

>> @@ -2088,10 +2087,9 @@ static int use_patch(struct apply_state *state, struct patch *p)
>>   	int i;
>>   
>>   	/* Paths outside are not touched regardless of "--include" */
>> -	if (0 < state->prefix_length) {
>> -		int pathlen = strlen(pathname);
>> -		if (pathlen <= state->prefix_length ||
>> -		    memcmp(state->prefix, pathname, state->prefix_length))
>> +	if (state->prefix && *state->prefix) {
>> +		const char *rest;
>> +		if (!skip_prefix(pathname, state->prefix, &rest) || !*rest)
>>   			return 0;
>>   	}
> 
> The check for *state->prefix here makes sure the behavior remains
> identical.

Right, the patch is only meant to stop storing the string length
without changing any user-visible behavior.

> I wondered at first whether it's actually necessary. Wouldn't
> an empty prefix always match?
> 
> But I think we're looking for the pathname to be a proper superset of
> the prefix (hence the "!*rest" check). So I guess an empty path would
> not be a proper superset of an empty prefix, even though with the
> current code it doesn't hit that block at all.
> 
> I'm still not sure it's possible to have an empty pathname, so that
> corner case may be moot and we could simplify the condition a little.
> But certainly as you've written it, it could not be a regression.

So you mean that removing the prefix length check would just cause
empty paths to be rejected if we have an empty prefix, which shouldn't
bother anyone because empty paths can't be used anyway, right?

Actually I'm not even sure it's possible to have an empty, non-NULL
prefix.

> The use of skip_prefix also took me a minute. I wonder if it's worth a
> comment with the words "proper superset" or some other indicator (it
> also surprised me that we're ok with matching "foobar" in the prefix
> "foo", and not demanding "foo/bar". But I didn't look at the context to
> know whether that's right or not. This may be a case where the prefix is
> supposed to have "/" on it already).

As the literal translation it is intended to be it should have been a
no-brainer. :)

Applying a patch to foobar when we're in foo/ is not intended ("Paths
outside are not touched").

I don't know if prefixes are guaranteed to end with a slash; the code
in setup.c seems to ensure that, but has it been spelled out
explicitly somewhere?  apply.c::use_patch() certainly relies on that.

René
