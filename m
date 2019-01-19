Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A3281F453
	for <e@80x24.org>; Sat, 19 Jan 2019 01:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfASBNW (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 20:13:22 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:42809 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfASBNW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 20:13:22 -0500
Received: by mail-vs1-f41.google.com with SMTP id b74so9531331vsd.9
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 17:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDd8+jvjI1W0V4fBlccQwl3pyW4NMB5S2MiHudr1S4I=;
        b=kEz8sigt8pTYrIEKXFXDW5nS4BjZ8hzAxIOY0uw8wBm5zuwdsUl8+Pe6cvwjZWfhMy
         h16aAar+qxLw8+QO/H9N19Jryqk3hZQx36kJSDPWQ22ZRyOOlfvw0mM09gT8sxLwV0Mt
         KwZOwuvnWprLmhRhqny9MMDu2/yjWyk1PRbo+2zRVQmawO8W5w+NasiVpfVE6kR36o1A
         vIleXZdVt6n4gtRGwwsLxbY+hAIQGUyc5TrBIHR1Q3ZUVvl0bvdrwHEKuVY1Wlb76zLl
         r8DmK1aWxJ1YX/nVRYAz/Qw+EyO8kL0b4qGXxflls77JeZQix0GhifJQaBLKXphHuKIA
         rRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDd8+jvjI1W0V4fBlccQwl3pyW4NMB5S2MiHudr1S4I=;
        b=DQ8ZLLEn2n1Vd+MVh2gNKbvKTxLq7ZlymNQHBrrZ8j7Vv6/kSBjHKghqeB+2GOTAkK
         vbIqml7lq4ksvaUZU9ZpG0Jc338P2ERY1jLBWtPbO8iFodemkXrgVlUn5DYhyseCA3DQ
         aEBHnR4yzOyw5mWEiMjC2dCX22cYYLRAvFAaQ+g7MCYNkCAXdyYSozUBQDOyGgTz+gYp
         smDRrEWY/9Ix1U+JObhmRsrTuJD8yXPZmngL7MqmvV8s2CYvYxNUsGVD3fpJuk+v3iWC
         NWJbpX9reoFETbUXIDPMQIsnGkVEqS3z4nMXMQrMzXbsEqZ4CMxHAGFGI/FtUj1pxG2V
         xk4w==
X-Gm-Message-State: AJcUukcKb0JOzxNneptJw2JP3VTnmEAKW64BqLr7iAfzkP5amE9jREsO
        BJrdqgcvFySxs9dePjTrC24ftLzcOIelg2QweHM=
X-Google-Smtp-Source: ALg8bN7HnG/S8b3J7DmCGSc0xujkCMvoi/73i3Hqs1XrDkFbYVOG8pXrLsqjwl5MLpzVcjgSVlnNUKuW4sFeMotyx50=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr8947122vsm.116.1547860400731;
 Fri, 18 Jan 2019 17:13:20 -0800 (PST)
MIME-Version: 1.0
References: <xmqqfttpimdc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqfttpimdc.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Jan 2019 17:13:08 -0800
Message-ID: <CABPp-BFmYoeiOaB9Pf70TC3XftXjMEHGrPqxS8TgiiXR39q2rQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2019, #03; Fri, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 3:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> * en/rebase-merge-on-sequencer (2019-01-07) 8 commits
>  - rebase: implement --merge via the interactive machinery
>  - rebase: define linearization ordering and enforce it
>  - git-legacy-rebase: simplify unnecessary triply-nested if
>  - git-rebase, sequencer: extend --quiet option for the interactive machinery
>  - am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
>  - t5407: add a test demonstrating how interactive handles --skip differently
>  - rebase: fix incompatible options error message
>  - rebase: make builtin and legacy script error messages the same
>
>  "git rebase --merge" as been reimplemented by reusing the internal
>  machinery used for "git rebase -i".
>
>  On hold.
>  cf. <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>

Is the "on hold" comment still accurate?  And if so, can I ask for
clarification on what the hold is so I can know what action if any I
need to take?  The two things mentioned in the linked email that I see
are (1) the need to lower-case part of the subject (which you squashed
in already to create commit 68aa495b590d), and (2) the semantic
conflict between js/rebase-am and my patch, for which you already
squashed my fix into your merge of his series and suggested I not
resend and just let the rerere logic handle it (cf.
<xmqqmunxluj8.fsf@gitster-ct.c.googlers.com>)

I'm beginning to wonder if I should just resubmit patches individually
or take some other dramatic action as the combined amount of time this
series has been on hold has been quite a bit longer than usual for me.
Suggestions welcome.

Thanks,
Elijah
