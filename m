Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333BDC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 11:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1213D601FC
	for <git@archiver.kernel.org>; Thu, 27 May 2021 11:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhE0LsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 07:48:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55408 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhE0LsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 07:48:04 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A7533218DD;
        Thu, 27 May 2021 11:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622115990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmKBQ2mE8jg7V8E19PBNTlphDxSqS/7de7KEnq/f3Lk=;
        b=HenWR/f5UBdbdx3BmMJFlo1X/ZmhwB4Dqf8VM8TGEZCS3cwqCAPFSzG6czcVFRGbgTQIfQ
        fJfDNwUc1AAnuIVYAzs4jAhQskp8qjty5/my5Xfj02lks/bnLvNZQ4uM/y8QT/vEkOfixC
        dljXfrTooMVbLzNkwEDf7L4WULCWiF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622115990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmKBQ2mE8jg7V8E19PBNTlphDxSqS/7de7KEnq/f3Lk=;
        b=Wil7w1U6t4gvppd9WTcVWL/kFuuJ+DPCuMAlQx7mxrBN9V10GzrZRfm+3mixDIFti/sH3q
        adkWlLm7yK2VDyCA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 98C0011A98;
        Thu, 27 May 2021 11:46:30 +0000 (UTC)
Date:   Thu, 27 May 2021 13:46:29 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Varun Varada <varuncvarada@gmail.com>
Cc:     Robert Coup <robert.coup@koordinates.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210527114629.GD8544@kitsune.suse.cz>
References: <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz>
 <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz>
 <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz>
 <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz>
 <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 06:49:58PM -0500, Varun Varada wrote:
> On Thu, 13 May 2021 at 04:48, Michal Suchánek <msuchanek@suse.de> wrote:
> > Yet Felipe insists that 'impact' is somehow generally bad word to use or
> > that it should be abolished solely because he finds it bad and nobody
> > objected to the alternative wording.
> >
> > Opinions on use of 'impact' differ both among the participants of this
> > discussion and authorities like authors well-known dictionaries.
> >
> > It looks like this is generally matter of stylistic preferences and
> > opinions. That is even if there is some slight stylistic preference for
> > not using the word 'impact' it is very hard to prove such and then it is
> > very hard to request change based only on writing style preferences.
> 
> The argument is not that it is generally a bad word to use, but that
> it is generally bad to use words when they don't mean what one thinks
> they mean, especially when all evidence says otherwise.

Not all evidence. There are people who think the use is fine.

> 
> All major dictionaries define "impact" as "a strong effect" or "to
> affect strongly". This is not style, but semantics. In the same way

Not all dictionaries, actually. And when there is no meaningful
difference between "strong efffect" and "effect" using word that means
one or the other is just style.`

> that "per se" being used to mean "necessarily" is not a style issue,
> using "impact" to mean "an effect" or "to affect" is not a style
> issue.
> 
> As has been stated already, the clear and substantial argument for
> this change is that it reduces the confusion that arises from
> improperly using the word "impact" in the instances without any loss

There is no final authority on 'correct' word use in English.
Authorities and readers disagree. In some cases local language variation
disagrees so completely that no use is correct everywhere - eg. color vs
colour.

We should learn to work together with people that use different
variant of the language rather than insist that the variant that I or my
teacher uses is the only correct one and everyone else should use it.

Thanks

Michal
