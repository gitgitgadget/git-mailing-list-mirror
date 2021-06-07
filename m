Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94038C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD0461108
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 20:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhFGUWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 16:22:07 -0400
Received: from mout02.posteo.de ([185.67.36.66]:39999 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231698AbhFGUWD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 16:22:03 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 9DE2C2400FF
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 22:20:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1623097209; bh=ToKNPlsXGA06b7Lri1Y3K7Ex7cwrxWBh7qZkHd1It0Q=;
        h=Date:From:To:Cc:Subject:From;
        b=OP+jhxClZPXRSrOwg85Qzs6vPWhLt9PD7gEHmuc+q6y+F8RxR+8aZKvv5EsoGUyj7
         oZIXU1aK7msVv8JCFXiuxQs3qVsUNx8D6kwaCMpS9qQJAVA83TzZR506AWDvkEpCQv
         acG0pnb+SBKxTvM4mRExaOX3xk7RCU9l2PIl+Yd5J4+uNBY1Y6sBwpTFb8JRGMgOXs
         s161Rkw9g7tDn8xYbriET5DWfxI1cPHIlNl8lRSARsPv53TI2u7I3jqvmraQ5lk9oO
         gqeNHfQIoQFJaL26nNOXr7jQvK0c28LmHiATZeJgCYlT5nr1ah8taiyzfpVqVtD9bX
         QZ4sXxoWD50Zw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FzPqq3nZ4z6tmJ;
        Mon,  7 Jun 2021 22:20:07 +0200 (CEST)
Date:   Mon,  7 Jun 2021 20:20:06 +0000
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Robert Karszniewicz <avoidr@posteo.de>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Message-ID: <YL5/diPpLTOdRjoB@BDZ>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 04:57:48PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Technical writing seeks to convey information with minimal friction. One
> way that a reader can experience friction is if they encounter a
> description of "a user" that is later simplified using a gendered
> pronoun. If the reader does not consider that pronoun to apply to them,
> then they can experience cognitive dissonance that removes focus from
> the information.
> 
> If we use singular "they/them" pronouns instead of "he/him" or "she/her"
> pronouns, then we can avoid this congitive load on the reader.

That is funny, because I experience cognitive dissonance exactly when
people use singular plural-pronouns. ("What? Did I read right? Is it a
group? Or a company?" [seek back to verify, or explicitly ignore the
hiccup])

On the other hand I strongly doubt that such a cognitive dissonance
happens when people come across a wrong gender.  When documentation
speaks of "the user" -- *any* user -- then it does not in any way
conflict that that "any user" might be female.

And I'm not just theorizing, as I /did/ have the following experience
(anecdote):
One time I was presented a document which I was supposed to read and
sign. I read through the whole document all fine and only at the very
end I noticed that the whole document is consistently written in the
female form (and that was in German, there is no distinct neutral
"the"). I made a joke about it asking where the document version for
males is, to which he responded: "Now you know how it feels being
female". Which -- and I want to stress this -- I found deeply insulting.

"He or she" is problematic in its own way, but you already propose
against it.

As one of the users whose happiness is being discussed here, I can only
ask not to change from singular to plural pronouns. If you must, pick
"she", I don't mind. Or "it", or "person", whatever, as long as it
matches the cardinality of "the user".

> Using singular "they" is also incredibly efficient. Choosing a gendered
> pronoun is usually arbitrary between "he" or "she". Using constructs
> such as "he or she", "s/he", or "(s)he" are more complicated than
> singular "they".
> 
> When choosing a gendered pronoun, that pronoun no longer applies to
> nearly half of possible readers. Even if we alternated between "he/him"
> and "she/her" perfectly evenly, we would still expect male and female
> readers to experience an incorrect pronoun half the time. However, some
> readers will not prescribe to either of these binary genders. Those
> readers hence suffer an incorrect pronoun the entire time. Singular
> "they" applies to every reader.

The 'singular "they"' does not apply to every reader and might not even
apply to most readers. It might be natural for native speakers to know
that "they" is "1 or more people", but that is not what foreigners are
taught what "they" means. In my entire curriculum at school I have not
once been taught that "they" can mean "one person". Therefore, whenever
I see it used that way, I cannot help but stumble. Every time.

Not to mention that the documentation does not talk about "the reader"
but "the user". Yes, had the documentation talked about me specifically,
the reader, and I suddenly had to assume another gender, I might ask
myself what's going on. But it never crossed my mind to assume the
identity of an unspecified, indeterminate "the user".

Thank you,
Robert Karszniewicz
