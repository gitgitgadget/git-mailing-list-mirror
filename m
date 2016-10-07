Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B0F20986
	for <e@80x24.org>; Fri,  7 Oct 2016 20:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757161AbcJGUpl (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 16:45:41 -0400
Received: from mout.web.de ([212.227.15.4]:54020 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757143AbcJGUpj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 16:45:39 -0400
Received: from [192.168.178.36] ([79.213.121.94]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M3Bv5-1b3x6W3sGd-00sxx8; Fri, 07 Oct 2016 22:45:20
 +0200
Subject: Re: [PATCH 2/2] use strbuf_add_unique_abbrev() for adding short
 hashes, part 2
To:     Jeff King <peff@peff.net>
References: <b7a61c78-3c46-375c-4cc3-7c363e551bc6@web.de>
 <29e75b7b-6dd0-8c52-e444-cad1ba613cd0@web.de>
 <20161007004635.xbuaxvc6eyfkyyma@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <baff7c23-1c0b-3df5-bb4e-661bf0383fe4@web.de>
Date:   Fri, 7 Oct 2016 22:45:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161007004635.xbuaxvc6eyfkyyma@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:noIiyda9OggHjlfsJtulDCTvQBuDAM0vgyQm0q4WEYuQHTtKhJj
 5QerosDaqAFc5QbTL7+Nfx1rErrGwr70LPaL6e2I29xkHLdNvfoC1A64YYpO6FcrTiIXAyx
 zR4+UZmQmXaMaXyhlnzJY6fQ+UTnHF2utts/XLteTzy4b8TR1KxFoLAzp5AQU9k3r2baCtG
 tESTlRqM/lj8f6uJHyslQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:egLyR5ITQkQ=:sbCmWk4i6kBjrDu8+k+abv
 p2gEyDoCfqAgqJj/Rp2q65I+uWMb4fKowmRzAM9oQNJK6FRsaChssCTM+jTMzILdHR+v/SQFr
 mGXEgYKL1C6HHbe794CdgFifK9qJLzb7LoL19N+8Syb4VmcNettn7+J2mN1iFd1j7vsL9wnUD
 zHfHWI7dIDhn5KA54s8SjNfARLBgLSeNcERlyvL6R1L47T5qd3QREmCD8KMoiGUvAOkttZiEj
 NA8mVo4zgE2mnrREOC1dEvVC/Ut205hdNdzX+UE5OcqKVritTh940dAbOgDVCygV1iAsASiY7
 8iPmY1YglCXq3xZ/0gD8QU5jCnHzAbG815pGnxqTMckoCh6/l15CGmaZ+CbpIiOsUzpCYfkv+
 uxTQUaqn1tqxFc5SuRgza6IZWGDZBzzzGx8sM48sAAZwU7/iNvo7/nAeL+5MB3F+APxjPNzGl
 S7RvEK6I0kTtPgRkYFIeBs81dLVtoxSlg19z9FjQyas2Gb0rKx9ARrFNB06/havitEs8JVWAP
 gPlrtVZookbRDAU5hHHlwvpgDNDczAs9AD5rYXAJZz6vmtM1YRV24D1aQD3+GBsYnF7+7WgAf
 v/S4KQnoioxlToE+z8F+/GivGjW55ABQv+s3NHHTQq+/pHzRY6F98LULknKkA8T0R5wU4b6+U
 SN27rGGljQEJj9/GNQ1GYxdocolqWdLhrBoCdaeu7OypDTJD5geKbIkLtu/jhbs7XTKDxvPAQ
 R1Xjq1lXBD0tPkbAbcl+ji5I5L0QH9L9b6lLS3ND7lmpWxTaGHLeqI0SMUZZ1y+1yaCD0EARE
 uHkaGvM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.2016 um 02:46 schrieb Jeff King:
> On Tue, Sep 27, 2016 at 09:11:58PM +0200, René Scharfe wrote:
>
>> Call strbuf_add_unique_abbrev() to add abbreviated hashes to strbufs
>> instead of taking detours through find_unique_abbrev() and its static
>> buffer.  This is shorter and a bit more efficient.
>> [...]
>> diff --git a/diff.c b/diff.c
>> index a178ed3..be11e4e 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -3109,7 +3109,7 @@ static void fill_metainfo(struct strbuf *msg,
>>  		}
>>  		strbuf_addf(msg, "%s%sindex %s..", line_prefix, set,
>>  			    find_unique_abbrev(one->oid.hash, abbrev));
>> -		strbuf_addstr(msg, find_unique_abbrev(two->oid.hash, abbrev));
>> +		strbuf_add_unique_abbrev(msg, two->oid.hash, abbrev);
>>  		if (one->mode == two->mode)
>>  			strbuf_addf(msg, " %06o", one->mode);
>>  		strbuf_addf(msg, "%s\n", reset);
>
> This one is an interesting case, and maybe a good example of why blind
> coccinelle usage can have some pitfalls. :)

Thank you for paying attention. :)  In general I agree that the 
surrounding code of such changes should be checked; the issue at hand 
could be part of a bigger problem.

> We get rid of the strbuf_addstr(), but notice that we leave untouched
> the find_unique_abbrev() call immediately above. There was a symmetry to
> the two that has been lost.
>
> Probably either:
>
>   strbuf_addf(msg, "%s%sindex %s..%s", line_prefix, set
> 	find_unique_abbrev(one->oid.hash, abbrev),
> 	find_unique_abbrev(two->oid.hash, abbrev));
>
> or:
>
>   strbuf_addf(msg, "%s%sindex ", line_prefix, set);
>   strbuf_add_unique_abbrev(msg, one->oid.hash, abbrev);
>   strbuf_addstr(msg, "..");
>   strbuf_add_unique_abbrev(msg, two->oid.hash, abbrev);
>
> would be a more appropriate refactoring. The problem is in the original
> patch (which also lacks symmetry; either this predates the multi-buffer
> find_unique_abbrev, or the original author didn't know about it), but I
> think your refactor makes it slightly worse.

I still think the automatically generated patch is a net win, but we 
shouldn't stop there.

> I noticed because I have another series which touches these lines, and
> it wants to symmetrically swap out find_unique_abbrev for something
> else. :) I don't think it's a big enough deal to switch now (and I've
> already rebased my series which will touch these lines), but I wanted to
> mention it as a thing to watch out for as we do more of these kinds of
> automated transformations.

OK, then I'll wait for that series to land.

>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -396,7 +396,7 @@ static void show_submodule_header(FILE *f, const char *path,
>>  			find_unique_abbrev(one->hash, DEFAULT_ABBREV));
>>  	if (!fast_backward && !fast_forward)
>>  		strbuf_addch(&sb, '.');
>> -	strbuf_addstr(&sb, find_unique_abbrev(two->hash, DEFAULT_ABBREV));
>> +	strbuf_add_unique_abbrev(&sb->hash, two, DEFAULT_ABBREV);
>
> This one is a similar situation, I think.

Yes, and there are some more.  Will take a look.

I don't know how to crack printf-style formats using semantic patches. 
It's easy for fixed formats (silly example):

	- strbuf_addf(sb, "%s%s", a, b);
	+ strbuf_addf(sb, "%s", a);
	+ strbuf_addf(sb, "%s", b);

But how to do that for arbitrary formats?  Probably not worth it..

René
