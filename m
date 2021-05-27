Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1494DC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA880613D8
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhE0OhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:37:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36122 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhE0OhR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:37:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B4BE1FD2E;
        Thu, 27 May 2021 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622126143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olNuLpUTCbxdzMgUl5bRMlryaiz8Z2nD6PoNirkqbRY=;
        b=D1EG1TCMmwOUFg3KmpiyM0Rj8R1XILvHmfFfonykU34TQ9E7it2SnzamA9XuCh/altENRI
        CgxuDV7+tMareVmc3bHDf7hoeXBc1gu6FrO8qjrNswX5tUQOcSBh9mEwsmte6y7WW/056s
        BJIGh0ZYM69jzCuAbINXAiryJJ6skFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622126143;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olNuLpUTCbxdzMgUl5bRMlryaiz8Z2nD6PoNirkqbRY=;
        b=peWL/NeTmLtmoa8iB5E5EorgjQXrxB4vMLyrMxXWUmoZmdXz0QmyvrFGxQB5Po9+ffcoLi
        C1xOQnyKSRZfLjDA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 2F7C211A98;
        Thu, 27 May 2021 14:35:43 +0000 (UTC)
Date:   Thu, 27 May 2021 16:35:41 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210527143541.GH8544@kitsune.suse.cz>
References: <20210512170153.GE8544@kitsune.suse.cz>
 <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz>
 <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz>
 <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz>
 <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
 <20210527114629.GD8544@kitsune.suse.cz>
 <60afa7d9d4ca_2056d208d9@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60afa7d9d4ca_2056d208d9@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 09:08:25AM -0500, Felipe Contreras wrote:
> Michal Suchánek wrote:
> > On Wed, May 26, 2021 at 06:49:58PM -0500, Varun Varada wrote:
> > > On Thu, 13 May 2021 at 04:48, Michal Suchánek <msuchanek@suse.de> wrote:
> > > > Yet Felipe insists that 'impact' is somehow generally bad word to use or
> > > > that it should be abolished solely because he finds it bad and nobody
> > > > objected to the alternative wording.
> > > >
> > > > Opinions on use of 'impact' differ both among the participants of this
> > > > discussion and authorities like authors well-known dictionaries.
> > > >
> > > > It looks like this is generally matter of stylistic preferences and
> > > > opinions. That is even if there is some slight stylistic preference for
> > > > not using the word 'impact' it is very hard to prove such and then it is
> > > > very hard to request change based only on writing style preferences.
> > > 
> > > The argument is not that it is generally a bad word to use, but that
> > > it is generally bad to use words when they don't mean what one thinks
> > > they mean, especially when all evidence says otherwise.
> > 
> > Not all evidence. There are people who think the use is fine.
> 
> What people think is not evidence.
> 
> There's people who think the Earth is flat.

And there's people who think it's not ok to use 'impact' as synonym for
effect/affect, too.

> 
> > > All major dictionaries define "impact" as "a strong effect" or "to
> > > affect strongly". This is not style, but semantics. In the same way
> > 
> > Not all dictionaries, actually.
> 
> You don't need all dictionaries.
> 
> If 50% of trials show a drug is safe, and 50% show it's not, you don't
> approve bit because "not all say say it's unsafe".
> 
> If there's evidence that A is bad, you should consider avoiding A,
> especially when you have B, and you have *zero* evidence showing B is
> bad.

Indeed, but what the dictionaries provide is a definition.

Based on the definition some people think it's not OK, and some people
think it's OK.

That's only opinion, not evidence.
> 
> > > that "per se" being used to mean "necessarily" is not a style issue,
> > > using "impact" to mean "an effect" or "to affect" is not a style
> > > issue.
> > > 
> > > As has been stated already, the clear and substantial argument for
> > > this change is that it reduces the confusion that arises from
> > > improperly using the word "impact" in the instances without any loss
> > 
> > There is no final authority on 'correct' word use in English.
> 
> You don't need a final authority.
> 
> There is evidence that A is problematic.

So we should stop using words that have different spelling in British
and American English because no matter what spelling you choose somebody
can find it 'problematic'?

> 
> > We should learn to work together with people that use different
> > variant of the language rather than insist that the variant that I or my
> > teacher uses is the only correct one and everyone else should use it.
> 
> Except one variant is problematic, and the other is not.
> 
> 
> Do you have *ANY* evidence that shows a problem with "effect"?

I find problem with the proposition that 'impact' should be replaced
with 'effect' based solely on the opinion that use of 'impact' is
somehow inferior.

This will bring in reviews that focus on hairsplitting when the
formulation with 'impact' reads better than 'effect' and where the
change does not make it read any better so it should not be changed.

It also brings in reviews of the sort that simply say that use of
'impact' is OK, and there is no need to change.

You can reason the change in different, more objective ways. You
refuse and insist that people acknowledge that the use of 'impact' is
wrong. It is not universally true in the same way that writing neither
'color' nor 'colour' is not universally correct.

Also I have so far not seen any real evidence that 'impact' is in fact
used incorrectly, only some opinions and reference to a style guide.

So if you want to compare to physicians and drug trials how many
double-blind studies on the effect of the use of word 'impact' can you
refer to?

Thanks

Michal


