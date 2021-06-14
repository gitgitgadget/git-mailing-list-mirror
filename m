Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68822C48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 22:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5E861183
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 22:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhFNWMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 18:12:42 -0400
Received: from mout01.posteo.de ([185.67.36.65]:46183 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhFNWMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 18:12:41 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 71DB7240027
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 00:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1623708636; bh=1+8WfXqydP0iyS7i4yorUymj/esWgV6L8PMXLjPblWU=;
        h=Date:From:To:Cc:Subject:From;
        b=h1Cf9Ur/BMOlUTKxTwhgi45UkNghl0JRhDoySrD9NPMEKMW2yTDnfs0ccYmhHmL2R
         eesWEdIyq3xZQuBXPwWrnqX0m7gQ5u0EL388m9lYCQCedfT1x4z9XiNo3ZQJUe0J7P
         8VC9pGzVvraFqScKoxFBFAo9LU+w6W5OS7D7MnZ5HgAeaWL89h2kNerD9y4iY+WAJn
         39oZw/aJH/zlLTVspvcsvceI2d9q5XKDHT/oAJc6Toc2yRIUKLBxwi19Wngw6USgbP
         jz3PN0s69QMsp5VkLTOCE2Yt7qQEJqfAwEBskZ0z0jNadNv6tlvOTntlIFgVpfeDve
         Qkbw+QExiI6Wg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4G3ly22TQtz6tm9;
        Tue, 15 Jun 2021 00:10:34 +0200 (CEST)
Date:   Mon, 14 Jun 2021 22:10:33 +0000
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Robert Karszniewicz <avoidr@posteo.de>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Message-ID: <YMfT2YrWiaOnfG9D@BDZ>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <YL+p+MlgJ754YoqB@google.com>
 <nycvar.QRO.7.76.6.2106100947170.57@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2106100947170.57@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 10:18:11AM +0200, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Tue, 8 Jun 2021, Emily Shaffer wrote:
> 
> > There is value in intentionally defaulting to "she/her", especially in
> > settings where women are underrepresented. It can be a nice way to shake
> > the foundations of unconscious bias in the reader's head. See
> > https://www.askamanager.org/2011/07/why-i-refer-to-everyone-as-she.html
> > as an example.
> 
> I am glad you brought this up.
> 
> It is all too easy for male readers such as myself to not even notice how
> effortless it is to read text that includes you, whether by the pronoun
> "he" or by avoiding any gendered pronoun altogether.
> 
> All the more surprising that the same male readers (again, I will include
> myself as it still happens to me, despite all the work I embarked on to
> become more conscious of my own biases) will stumble over sentences where
> a female pronoun "excludes" them.
> 
> And the first reaction, funnily enough, is rarely "Oh, _that_ is how I
> make half of the population feel all the time!". Instead it is more like
> "How dare they exclude me"?

Funnily enough, I was also in such a situation, and as I explained in
another email in this thread, I /didn't even notice until the very end/,
at which I didn't mind at all, but made a joke about it and the answer
implied that I'm some kind of sexist, which was deeply insulting to me.

> 
> Funny side note: this is precisely what happened recently in Germany,
> where a law was proposed, and in contrast to common practices (which
> dictates to use the "generic male form", i.e. "he/him", as the German
> language does not have a singular "they"), it used the "generic female"
> instead. I bet you can imagine the indignant backlash from male
> politicians...

Right, that's because there is no "generic femininum", it is a feminist
invention that didn't quite catch on, and not without reason. It is a
solution looking to create problems.

(I live in Germany) I've listened to how real people talk "on the
streets" and my experience is that they use the generic masculinum,
whether the speaker is male or female. Pretty much the only place I see
people gender their speech is on TV and in academia. And, "funnily
enough", they do so heavily inconsistently, as that is impossible to do
consistently, if the point is to actually convey information and not
neuro-linguistic programming.

The reason why the generic masculinum is the default is that in our
minds it is a no-op, and that's not because there is some kind of
conspiracy against non-males, but because nobody actually cares about
sex, because it is a completely irrelevant detail. The only way I can
see why someone would even notice the sex, is that he actually cares
about the sex.

However, if you use the female form, the brain will stumble. Not because
the listener is angry because females should not be spoken to or about,
but because it trips the brain's pattern recognition. Isn't it "funny"
how we listen up when a female is mentioned, but nobody cares when the
male is mentioned?

So if the male politicians backlashed on using a "generic femininum",
they were very right to do so; males have to share their gender with
everyone, females have their own exclusive gender. One might even dare
to assert that males do not actually have their own gender at all in the
first place.

Cheers,
Robert Karszniewicz
