Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEBEC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 19:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbiHRTHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 15:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiHRTHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 15:07:16 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E00C00E1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 12:07:13 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-32a09b909f6so67545367b3.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 12:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DIVqkod2mvmEg4yFKS8uefDJgAhLGG8Yk7OoWwL5VYo=;
        b=YR2Y0dzoWtaqC3evUBfA3J+su+i2JeMC7wI3ljfh+0NXamr0d7JzPTmx/1O/S9ZPK9
         5HkowWjR56ZdS6O32at7nUUbn7c/EB03esgRLoqCy9FG0zhWnczR4mE9Ih1Xn0LC1Dzh
         2pdj49t3FvHFzS3mRHL1675rz7jS85dbZkx5HdzT4QbzphQFpI8Tya7u9J4MkhpuePMc
         LyEcxlmmyqMoLwJWp/1LRJPQmxE8j/WjDodiEcqADjpsv/KxkNMnr9D4dHpYWqeTQ8iR
         V6oSqOQla5baE2gZirbiVIr6mmuM5dit0sXS9pTjlIacOHl0MYVy9zr7j5+TIhWhb6G9
         fq5w==
X-Gm-Message-State: ACgBeo3N1MafuJTNzyDNYQq644PMuf+/Lq9vOqSV1oYiFjWoMAQupPSY
        6jKTLZt2+fDKHkfyoFTL778gwah95z/B3ubiSbA=
X-Google-Smtp-Source: AA6agR4E6KnRO8M4I31mQ5WW62qXkFntuSz2ptglSugsx/GYB106nfv0aFMBBwPe2ZGJlhwFicgcvGH8kEURpaGLCAY=
X-Received: by 2002:a81:1ecc:0:b0:334:45e1:6fa9 with SMTP id
 e195-20020a811ecc000000b0033445e16fa9mr4227766ywe.482.1660849632753; Thu, 18
 Aug 2022 12:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa68ixcrf.fsf@gitster.g> <CAPig+cSz9RKj43_kwQFDQpN2Ggrimrw_DcOFnxGS+nBCPqDK5Q@mail.gmail.com>
 <xmqqa68evodq.fsf@gitster.g> <o5340r34-027q-4ops-93o1-8368s4qropo5@tzk.qr>
In-Reply-To: <o5340r34-027q-4ops-93o1-8368s4qropo5@tzk.qr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Aug 2022 15:07:01 -0400
Message-ID: <CAPig+cRp4N=6EktoisKAH09aVAPkPgZfHJYcB5pJFJ-CUpBHFA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2022, #02; Fri, 5)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 5:26 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 8 Aug 2022, Junio C Hamano wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > On Fri, Aug 5, 2022 at 11:44 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >> * es/doc-creation-factor-fix (2022-07-28) 2 commits
> > >>  Expecting a reroll.
> > >
> > > Per [1] and [2], I think the intention was to drop these patches
> > > rather than moving forward with them.
> > >
> > I think we are expecting a submission by Dscho to replace these two
> > patches.
>
> Oh? I thought Eric was on top of things much more than I am, I just tried
> to provide clarity about the intentions behind the original wording.
>
> Eric, please do feel free to Cc: me on any new iteration you want to send;
> I won't be able to work on a patch to reword the `range-diff`
> documentation.

Unfortunately, I'm not going to be much help here since I don't grok
"creation factor" well enough to put an explanation into words, even
after having read the "algorithm" section multiple times[1]. The
situation is further confused (at least to me) by the "algorithm"
section in the `git range-diff` documentation stating that the "fudge
factor ... should be smaller than 100%", yet your position in this
discussion is that the creation factor can be greater than 100%.

FOOTNOTES

[1]: I likewise didn't understand it well enough when submitting[2]
which added --creation-factor to `git format-patch`, which is why I
punted at that time and simply referred the reader to the `git
range-diff` documentation.

[2]: https://lore.kernel.org/git/20180722095717.17912-14-sunshine@sunshineco.com/
