Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB251F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 15:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJJW0b (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 18:26:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37748 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJW0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 18:26:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id y11-v6so6128307wrd.4
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DawGTovyVOw9XADuN72AUklr6gVog1JJf9VqZ4DdkHk=;
        b=XjkauMEToDG//71PUdFP0OGk7v9h6LvzCnffHyw2wPqpYySBk6xt2X7ZNo8TvmH6b3
         ykEaKEI8xuArJm7JjcruMDHrWbW3o0L5QVxv5okrr//G+9oYSjyM9YjicmixvwRPvPXh
         q3UPcl6Gokp8sYM+W5D8EGhsp3oIh5Cmghi8jGSpjEXEOmQtxTfk+5s83zT9gc83UUXy
         4U1i3AMAU9Wfy4NZ/6Zswg0bf5ouJqaVRRqUe/wkr5egzC1iX5A//KwoU0DQ956iCaS4
         WOOhNwg6YZ9SKHrVQ6kOaJMeI2wEhSnOTP1J6stvbCFZbOMAJS65UuCBvKs6kl6vdXYW
         6kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DawGTovyVOw9XADuN72AUklr6gVog1JJf9VqZ4DdkHk=;
        b=RdknZytSchhhFeARMG7VpzP8pkrzX/qO1yXZxyRGybb1bfujO1qb0hD6psLUgbbIUX
         2PP7GWMuWqI4U2EB7T9btubrydLySQ87dAOJLiyVLSKLhGC0AEq5YAeRDMpcbyQUNpR5
         X5QCtIL+FIKjd6xPA8IhEsBpnevyov3l7w5o2XZVSubNN+idkHYW4J96Ahp1n8QJiDbH
         xCXjTyEqp+SFYq7qx8xEIZ+Y3gdcYrZuC96OOTJElEwmTJCLO1wjy+FLv7tlSy/K3OB8
         aroZW1YjNQABvhQ5tSfVWVen7o/cLzaRSV17m0cpQyfDe9kHIXViWzf/bDEeN8Uz51wh
         sgbA==
X-Gm-Message-State: ABuFfoiNEjjQBlfCjcYANq/2InYvNEs7tmRzhpIGDwF73iRGVtljJf6o
        KnqExZU+IUNeadrn+tqG0SbAtTwPprA=
X-Google-Smtp-Source: ACcGV63bqJOdp8C/ZUNNHsGkbnC8kNuoIjfX0Omq5dA7rQ7RBH/eui9PyGG6GXbfjjHMJj6aKEhiRQ==
X-Received: by 2002:adf:81b5:: with SMTP id 50-v6mr22125577wra.10.1539183834102;
        Wed, 10 Oct 2018 08:03:54 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id e6-v6sm21788581wrc.70.2018.10.10.08.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 08:03:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] branch: introduce --current display option
References: <20181009182006.9446-1-daniels@umanovskis.se>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181009182006.9446-1-daniels@umanovskis.se>
Date:   Wed, 10 Oct 2018 17:03:52 +0200
Message-ID: <87woqpetd3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 09 2018, Daniels Umanovskis wrote:

> I often find myself needing the current branch name, for which
> currently there's git rev-parse --abrev-ref HEAD. I would expect `git
> branch` to have an option to output the branch name instead.
>
> This is my first patch to Git, so process-related comments (patch
> formatting, et cetera) are quite welcome.

Thanks for your first patch, and sorry to give you this feedback on it
:)

I'm mildly negative on this because git-rev-parse is plumbing, but
git-branch is porcelain, as listed in "man git", and it helps to be able
to clearly say what's a stable API or not.

But of course I wrote the above paragraph seeing that that's a lie. We
also list git-rev-parse as porcelain, just under "Porcelain / Ancillary
Commands / Interrogators".

Should we just move it to plumbing? I don't know.

In any case, if we're adding such a feature to an existing command it
should be prominently noted in the docs that this option and not others
in git-branch are plumbing-ish, like we do for the (very confusingly
named) --porcelain option to git-status. Users writing scripts need some
reasonable high-level overview of what they can and can't use for
scripting purposes if they expect the output to be stable.

Also, as much as our current scripting interface can be very confusing
(you might not think "get current branch" is under rev-parse), I can't
help but think that adding two different ways to spew out the exact same
thing to two different commands is heading in the wrong
direction. I.e. should we perhaps instead add a new git-ref-info and
start slowly moving/recommending to use that for the various ref (but
not rev) stuff that git-rev-parse is doing, or maybe add a "git
rev-parse --current-branch" and document that it's just a convenience
alias for "git rev-parse --abbrev-ref HEAD"?
