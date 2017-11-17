Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24D14202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 20:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757809AbdKQUBD (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 15:01:03 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45897 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdKQUBC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 15:01:02 -0500
Received: by mail-qt0-f196.google.com with SMTP id r37so225494qtj.12
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+Hm7dR0CG3kqyBCEFzw/ztBwUdonG/Qr3ojJAzWEecc=;
        b=rsTXUv+PlKPCK2KQTNkLSmq10M0TolltxSFa/ke8/SpPn5iiXvuTEdNinz5YTXR994
         hFeOt1FpDVVo0DV3EKAkL63C25AiVlXIvMPp02oKOw9AndtCdpHwpdo4DMkc+388LZtT
         oMcYoGo/zZP8RwrdCU9MNI8yOZx0FfyrtEUXqJ5+cIUURvXKzcp5y9PG5OwfR7CFiraq
         3n3dlfLjPUPaNKnmUF+Tn+QYKLuj1B/Z1/6PmAzZYsv2NQDaTNd6+Izzp1rlV9g+suu8
         UNx5XHzWQD9btGr+8MQWjS02UE9iYkjgokhV7xAKFYd+M0XSPo1/d9ppJij5bTPlfMlG
         uBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+Hm7dR0CG3kqyBCEFzw/ztBwUdonG/Qr3ojJAzWEecc=;
        b=sdyom+M11Z7bVDDtf9IRMsq9egSmz36gWztInhJil91gi07q3DMLsVPI18FiXGlui8
         ZBl0k14gedOozjGe7iWPFHqvwUbmsFbPc20sudJU10hI9VmgTeky2YNxsijfPXdjzxHs
         /KqzbiZTvAAtZkhfUcidDD1H+chhvyWn8yyQ0PyR3wEQ8ZoX7TgeGok/ERvKIG+AQxIa
         fy9VrZVfUXdDBnVaQCDie1jdJPprKKdTor0EaPLKVeQAMvJievcwzm4p4ADYzOJbuR/8
         eX0dU+UtXfw36QXHrDxyca+WaajV8rhCq9+MobHwO3mUVJa+KmHa4pZatOso9kR3sFFc
         BmZw==
X-Gm-Message-State: AJaThX6e1SvfhJys7jtEggQ4bDgLqqZ0liviX6/dOrdVHmdP7WyTCzZH
        kg/490xNRibOSY8HTatXT0r4JYitp06punSLFIV1YA==
X-Google-Smtp-Source: AGs4zMbwLYFlvwmkssbYkAxIMPfr0Emrh5M79gVH0AV/qAnRuxSR1m5dEyAadOJsiToVdVgBne3XfKdR5xKGuOJvNDk=
X-Received: by 10.237.61.181 with SMTP id i50mr10732134qtf.29.1510948861079;
 Fri, 17 Nov 2017 12:01:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.203 with HTTP; Fri, 17 Nov 2017 12:01:00 -0800 (PST)
In-Reply-To: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
References: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Nov 2017 12:01:00 -0800
Message-ID: <CAGZ79ka5yEv0n+kZLk6p9j3HX1aR9MNs+uH7N7o7UvGx+akxxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation about triangular workflow
To:     Daniel Bensoussan <danielbensoussanbohm@gmail.com>
Cc:     git <git@vger.kernel.org>,
        ALBERTIN TIMOTHEE 11514771 
        <timothee.albertin@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for contributing to Git and making the documentation better!

On Fri, Nov 17, 2017 at 8:07 AM, Daniel Bensoussan
<danielbensoussanbohm@gmail.com> wrote:
> From: ALBERTIN TIMOTHEE 11514771 <timothee.albertin@etu.univ-lyon1.fr>

This is a place where you can describe why this change is awesome (and
hence the project is interested in including it.)

The Git projects requires your Sign-off (and by the differing author
and you as a sender, both of you)
See Documentation/SubmittingPatches or
https://developercertificate.org/ and if you can agree
to that add a line "Signed-off-by: name <email>" to the commit message
of the text.

>
> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
> index 02569d061..3f1ddba82 100644
> --- a/Documentation/gitworkflows.txt
> +++ b/Documentation/gitworkflows.txt
> @@ -464,6 +464,221 @@ in patches to figure out the merge base.  See linkgit:git-am[1] for
>  other options.
>
>
> +TRIANGULAR WORKFLOW
> +-------------------
> +
> +Introduction
> +~~~~~~~~~~~~
> +
> +In some projects, contributors cannot push directly to the project but
> +have to suggest their commits to the maintainer (e.g. pull requests).
> +For these projects, it's common to use what's called a *triangular
> +workflow*:
> +
> +- The project maintainer publishes a repository, called **UPSTREAM** in
> +this document, which is a read-only for contributors. They can clone and
> +fetch from this repository.
> +- Contributors publish their modifications by pushing to a repository,
> +called **PUBLISH** in this document, and request a merge.
> +- Opening a pull request
> +- If the maintainer accepts the changes, he merges them into the
> +  **UPSTREAM** repository.
> +
> +This workflow is commonly used on different platforms like BitBucket,
> +GitHub or GitLab which provide a dedicated mechanism for requesting merges.
> +
> +........................................
> +------------------               -----------------
> +| UPSTREAM       |  maintainer   | PUBLISH       |
> +|  git/git       |- - - - - - - -|  me/remote    |
> +------------------      <-       -----------------
> +              \                     /
> +               \                   /
> +        fetch | \                 / ^ push
> +              v  \               /  |
> +                  \             /
> +                   -------------
> +                   |   LOCAL   |
> +                   -------------
> +........................................

git/git as the upstream is a notable example which doesn't
use this triangular workflow, as most patches are accepted
via email, such that the PUBLISH remote may not exist when
contributing to git/git. (Though https://submitgit.herokuapp.com/
tries to emulate the triangular workflow for contributors)


> +This is just a side-effect of the "review before merge" mentionned
> +above but this is still a good point.

mentioned (typo)
