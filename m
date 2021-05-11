Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16990C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C02617C9
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhEKT6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:58:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:51198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhEKT6c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:58:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29EA2AED7;
        Tue, 11 May 2021 19:57:25 +0000 (UTC)
Date:   Tue, 11 May 2021 21:57:23 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210511195723.GL12700@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <609ad9473d535_6011e2082@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <609ad9473d535_6011e2082@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 02:21:43PM -0500, Felipe Contreras wrote:
> Michal Suchánek wrote:
> > On Mon, Apr 05, 2021 at 04:48:58PM -0500, Varun Varada wrote:
> > > There are a bunch of places in the code/docs which use the word "impact"
> > > incorrectly. This is especially true of places where it says "will not
> > > impact", which suggests that it might have an effect, albeit not as
> > > strong of a one. This commit replaces all of these with their
> > > appropriate alternative so that the docs not only does not use jargon,
> > > but are also unambiguous.
> > 
> > Hello,
> > 
> > while using "will not impact" in an incorrect or unclear way may be a
> > problem the word "impact" in itself is not "jargon".
> 
> From Merriam-Webster:
> 
>   jargon _noun_
>   : obscure and often pretentious language marked by circumlocutions and
>     long words
> 
> > If you are concerned about correctness and clarity of the documentation please
> > avoid spreading misinformation.
> 
> Under certain definition of "jaron" Varun's statement would be
> incorrect, but not under all definitions. If you use the definition
> I stated above, "impact" can be considered jargon, because it's a bit
> obscure language.

Do you have any frequency data that supports your claim that the word
'impact' is obscure?

In my view it's common.

> Ultimately it doesn't matter if it's jargon or not, only that we have
> better alternatives.
'better' under what metric?

As already stated if we replaced words with synonyms solely on the basis
that some people find one word more fitting or commonly used we could
end up in a situation that we change between two wordings back and forth
because people from different parts of the world find different words
more fitting and common.

The bar for change should be that the word as used is very unfitting or
unintelligible.

Thanks

Michal
