Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFDBC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF06461879
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhEKU0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:26:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhEKU0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:26:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 334C2AFC8;
        Tue, 11 May 2021 20:25:04 +0000 (UTC)
Date:   Tue, 11 May 2021 22:25:02 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210511202502.GM12700@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <609ae224aa509_6064920851@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 02:59:32PM -0500, Felipe Contreras wrote:
> Varun Varada wrote:
> > On Tue, 6 Apr 2021 at 04:24, Michal Suchánek <msuchanek@suse.de> wrote:
> > > while using "will not impact" in an incorrect or unclear way may be a
> > > problem the word "impact" in itself is not "jargon".
> > 
> > The word means "to have a strong or marked effect on" (v.) and "a
> > strong or market influence" (n.) when used figuratively; it is not
> > synonymous with "affect" and "effect", respectively, as shown even by
> > all of the entries you've cited. Using it as such is the incorrect
> > part, so those are the instances I've changed in the diff.
> 
> There are two ways impact can be used as a verb: transitive and
> intransitive, but git doesn't seem to be using the intransitive form. In
> the transitive form it usually means to strike "the car impacted the
> tree". But it can also mean to have a desired effect "reducing CO2
> emissions impacted climate change".

I don't know where you find the 'desired' effect meaning. Certainly none
of the dictionaries I consulted at random provides such definition.

> 
> None of these are used in the documentation, we have things like:
> 
>   the index does not impact the outcome
> 
> Which is clearly wrong (unless we are talking about possitive outcome of
> the outcome, which makes no sense).

It is not clearly wrong. To me it makes perfect sense. If you want to
claim it's wrong please provide a source for your claim. Otherwise it's
just matter of different opinions of more fitting formulation.

> 
> As a noun it can mean a siginificant or major effect: "the impact of
> science".
> 
> However, the documentation is not using it that way:
> 
>   the runtime impact of tracking all omitted objects
> 
> The noun usage is less wrong than the verb usage, but it's still wrong.

Why is that wrong?

How did you infer that the effect is insignificant or minor?

In fact while some dictionaries list 'impact' as 'have strong effect'
the Oxford dicrionary lists is as simply synonymous to 'affect'.

> The verb usage could be corrected by changing "the index does not
> impact", to "the index does not have an impact on".

Why is that change needed at all?

> But why bother? The word "affect" is a much superior choice.

Why bother with a chenge at all?

Thanks

Michal
