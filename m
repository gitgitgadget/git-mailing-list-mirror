Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C259820951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbdCNVAp (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:00:45 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:32862 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbdCNVAo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:00:44 -0400
Received: by mail-io0-f178.google.com with SMTP id f84so8053558ioj.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sN+3zB6vCnsBs7QnRdhzbS0InoyqV6ezfKEmmj/dhvY=;
        b=BsX4t6nnFBTjCrTA9DijTZIZCLeTMD90CT7rfn62JWgbPDeqaIDFqEoVXFMxH+Jdkx
         KdDCdCHZZpDXqnYHNndEaqsU64AJkiNqiKGKg2vZyc1aAvhjiWFbh4SQkHm9WHdshQJr
         hqJs3uhyk3ruGa9QAJYIQpBHf+EEKpfqiCp1DV/sjcqZlSyZa3Q9rCIaAInnzi3Y9Yc+
         Ufk3Xi9v2IG1bcC9Zf1zDT1xjDHTUCZtxePeeu0FTbgrD8olIAb0miQrHaJwXrahU108
         onMpiNnk0mp6ICekTvGC7zhQHiya4aesXPSinDbQUvblxZXGm+tCqqTvxdGlu/Y3VGWy
         kCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sN+3zB6vCnsBs7QnRdhzbS0InoyqV6ezfKEmmj/dhvY=;
        b=ECdJ9J2cPGDa5W8w2SHo0kE0VrIa8RSSXbTgk3OBoSCY5f9gdiqanaAOikW9QF34o6
         brMF/k6umQBnyyO0OVXbGxXgqBzR/k6o8U3ku1MQcgFWahpC67vjFQK5dglxJIaxmA0H
         J0QHSxPV4STN5NnQZU22bjMTVHRnEPwiQna2WroeHlpAl5plOa+8aLHGFzKfHYwa9KVR
         JWDUg7x7K8K2AXJXU9/h9e+O9KSaryAsw1xWtNLXZmti3QpQ3lrXSrEd8doSzXXzuRVL
         oRqQJq2uQbP06m6lcQLCaBONYhtKCChlSfGvDMTblt23Wmxh0RCk06IyrhmA2T2lD1Is
         6S5g==
X-Gm-Message-State: AFeK/H1qzKjFdQ53TvjAQwCXV9jzJ29sN6eVYaTnVFFd85Wu8/dpYbYR8BTdIjs9m/NZsm0u3VkBVQOCnk7EqA==
X-Received: by 10.107.200.139 with SMTP id y133mr2124823iof.147.1489525242498;
 Tue, 14 Mar 2017 14:00:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 14 Mar 2017 14:00:21 -0700 (PDT)
In-Reply-To: <xmqq1su2ujsf.fsf@gitster.mtv.corp.google.com>
References: <20170312200248.3610-1-jn.avila@free.fr> <20170312200248.3610-2-jn.avila@free.fr>
 <xmqq1su2ujsf.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 14 Mar 2017 22:00:21 +0100
Message-ID: <CACBZZX4EGfBAu0M0y4xboVAtWf5N07XY8s40npQ1hN3rbgqmSw@mail.gmail.com>
Subject: Re: [PATCH] l10n: add framework for localizing the manpages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jean-Noel Avila <jn.avila@free.fr>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 1:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jean-Noel Avila <jn.avila@free.fr> writes:

Jean: Comments on the patch:

- Firstly thanks for working on this. When I hacked up the initial po
support in v1.7.8-rc2-1-g5e9637c629 I always meant to try out po4a,
but never got around to it. It's much easier than I thought.
- Consider submitting a more minimal patch that doesn't have the giant
fr.po (or just some minor cut version) as the tip of the series, to
make this easier to review
- The git-add.txt file is hardcoded in po4a.conf, won't this file need
to be generated in some final version of this series?

> This shows that even after adding just _one_ new option to the
> command, the whole thing need to be re-translated (the SYNOPSIS
> section may be a bad example, as not much is subject to i18n,
> though).  If each paragraph of the description section becomes a
> single string that need to be re-translated, as we can see below, I
> am not sure if it really helps the translators.  A mere single
> rephrasing of a word in a large paragraph would have to result in
> the entire paragraph to be translated again?
>
> [...]
>
> It almost makes me suggest that a totally different approach might
> be more manageable.  For example, we can pick one version of a
> source file (say, "v2.12.0:Documentation/git-add.txt"), have it
> fully translated to the target languages, _and_ make it a convention
> to record the original blob object name at the end of the translated
> file.  Perhaps "Documentation/l10n/fr/git-add.txt" may record the
> result of such translation effort.
>
> And then, when somebody wants to update the translation for v2.13.0,
> perhaps
>
>     git diff --color-words $old_blob v2.13.0:Documentation/git-add.txt
>
> (where $old_blob is taken from Documentation/l10n/fr/git-add.txt)
> can be examined and then Documentation/l10n/fr/git-add.txt can be
> adjusted to match the changes between the two versions.  After that,
> update the "source" blob object name in the translation.
>
> So, I dunno.  I like the goal and appreciate the effort to get to
> that goal.  I am not sure what the best approach would be and the
> sample translation mechanism I see in this patch makes me doubt that
> it is the best approach.

Junio: The concerns about long strings being altered & needing to be
translated is something already addressed by the gettext toolchain.
Your existing translations turn "fuzzy", and you can see a
before/after version of what changed in popular tools.

The proposal to do something like "git diff --words" is suboptimal
because it just gives you the same things these gettext tools give
you, but more importantly even though it's pretty feature similar in
theory you lose the advantage of plug-in integration with any
arbitrary gettext tool, e.g. the transifex or weblate tools Jean
mentioned.

Also, having done a lot of translations myself (although not for Git,
just the translation infra), it's a huge advantage to be able to
partially translate certain things out of order (e.g. parts of
git-add.txt), and even have different people do different parts. This
is trivial and you get out of the box support for it with the gettext
tooling, but not if we just have git-add.txt translated in its
entirety to e.g. French & record what the blob sha1 was.

I think this series is on the right track, and that po4a is the right
tool for the job.
