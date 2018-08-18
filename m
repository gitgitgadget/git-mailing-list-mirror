Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6231F954
	for <e@80x24.org>; Sat, 18 Aug 2018 12:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeHRQCR (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 12:02:17 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41680 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeHRQCR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 12:02:17 -0400
Received: by mail-io0-f195.google.com with SMTP id q4-v6so9058593iob.8
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GbncNKYW8FxvylO+KyfBn20S969f2/Zk+tcVdtheMqo=;
        b=MyB+VRiwxCI/WBOa7exv7B9P3w0VjDwz+Le8/0LZ6sEyL6sQng1+fSslc6pMFwhlAZ
         dbf1lXTtAvsWxoLA5FMv0HwvCftWzzg791jYPGKxYYHPp8eqe3h8+XWVIMwuKFTkGulw
         d5yE+6NcbeYwJrxDRXkyF+prxci0TKXdZECpe9GDyIDZIfN5yQkcSldsEYIJbvSx5GRW
         FyYde4RjXFHmNltQQSktKkb6O1FjmPYTYOraMwwoF5gJavTBuAEllll4Us+avzhNhs+y
         UBsBMYB8uO9iJ1TAos6MflwFAhSsHFpWLK76wU0nXN82tZXIOADmrtsTLB26NEMt7dUO
         zOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GbncNKYW8FxvylO+KyfBn20S969f2/Zk+tcVdtheMqo=;
        b=MOLcXdKk4ZFCrXAwF/XLugpTGq8gMOAQb6yDC3zzm+3EFOF1qIaUQzKT2MSu6UVnBe
         a0lmPcMXdVa3gjPfH02cL9WY8j8v41XsELx4oTbbjzOWfLo0l9JLWiDruSV7bPtkWg4x
         ylihIT6CAzBB0behHfhLWGLi/NtfKHy7PH/DJeSQT63iSbjzIaXvecFpecRNsPnaA8Mg
         yDT1SmsC1HwZCOHzc+5AI9xx4JGBtMIHp1Y/h4UrK53wn7b41nnZllka3Jy73VxtlzWY
         hJBE4r0XbrVija6paUvq4VM3MI25CDx2LxPW7o2hJnHccAmJRG8pnysa7ISSNEPdW4Bk
         T8Zw==
X-Gm-Message-State: APzg51BBS3y1REo2PD5Zeja/hme6bql3nM4eUhLxCAJ0tTI8foN0bsaj
        1A0s4hzHa1QGnEoOVsn/vPMcf6JY9oh2zRp0owk=
X-Google-Smtp-Source: ANB0VdZ3g+GI8TqScye8Jf+7vMaI6GYSWZo9oBgLGA0vLfZAWwRT7xUTV4OZpbcIcBvEEZNKORBgdwsjgDa/SdpdqZQ=
X-Received: by 2002:a5e:9615:: with SMTP id a21-v6mr11483812ioq.53.1534596879035;
 Sat, 18 Aug 2018 05:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com> <CAP8UFD1BOqGER4-gnv8VQfsRbZ3yYFEx-ScL3s_WfoKgV=rk6A@mail.gmail.com>
 <876007rjqc.fsf@evledraar.gmail.com>
In-Reply-To: <876007rjqc.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 18 Aug 2018 14:54:27 +0200
Message-ID: <CAP8UFD3tyfvBbzUkcLyowNt0jfDR8Bv4MAFmirQPcOQJVBZisg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 1:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Aug 18 2018, Christian Couder wrote:

> > FYI this has been requested from GitLab by Drupal (as well as others)
> > see https://www.drupal.org/drupalorg/blog/developer-tools-initiative-pa=
rt-5-gitlab-partnership
> > which contains:
> >
> > "The timeline for Phase 2 is dependent on GitLab=E2=80=99s resolution o=
f a
> > diskspace deduplication issue, which they have committed to on our
> > behalf: https://gitlab.com/gitlab-org/gitlab-ce/issues/23029"
>
> This is not a critique of the delta islands feature, just something I'm
> curious about.
>
> Why is Drupal blocked on something like delta-islands? The blog post
> mentions they have 45k projects, which can be browsed at
> https://cgit.drupalcode.org
>
> Almost all of those are completely independent projects, so they
> wouldn't benefit from delta islands, and I'd guess >98% are of them are
> in an obscure long tail and probably won't have even a single fork.
>
> That leaves forks of say drupal.git, which is ~150MB, the mirror on
> GitHub has 1500 forks: https://github.com/drupal Even if there were 5000
> forks of that that would be 750G of disk space.
>
> So accounting for backups, me being off by a lot etc. let's say that's
> 5TB. That's relatively cheap today. Are they really just holding up
> their GitLab migration plans to save something on the order of that disk
> space, or have I missed something here?

I am not sure why. I haven't been in touch directly with Drupal people
and I haven't followed all the discussions with them.

When I discussed this topic with someone responsible for another
significant open source project. He told me that they don't want forks
at all on their self hosted GitLab instance because of the disk space
and management burden that would come with them. But they would like
people to fork on a separate GitLab instance like gitlab.com or
github.com (but then be able to send merge/pull requests to their self
hosted GitLab instance) because they know that developers like to have
their own fork :-)

So my guess is that Drupal people are also afraid of the possible disk
space burden, even if your numbers seem to say that they shouldn't.

> Again, not a critique of delta-islands, because it's most certainly
> useful for the likes of github/gitlab, but I wonder if for this
> particular problem it wouldn't be more straightforward of a solution for
> GitLab to allow anyone to push to
> refs/for-merge/<their-username>/<some-name-they-pick> on any
> repository. Then they could open a MR for an existing branch in the repo
> (which GitLab already supports).

My guess is that people are used to forks on GitHub and they like them
and want to have the same thing and same workflow on GitLab.

The delta islands documentation though says that it's possible to use
git namespaces along with delta islands, and if forks are indeed
implemented as namespaces, it will be kind of similar in the GitLab
internals as what you suggest. There are still discussions by the way
in the GitLab issue referenced above about whether it's better for
GitLab to use git namespaces or alternates to implement deduplication
in forks (along with delta islands).
