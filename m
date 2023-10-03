Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB4AE8FDB7
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 21:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbjJCVKf convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 3 Oct 2023 17:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjJCVKd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 17:10:33 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C867AC
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 14:10:27 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-65af8d30b33so2102266d6.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 14:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367426; x=1696972226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfWzeYQOwmS/Fy7qfBfp9frJk0k6F1jw6WZjLwbtt/M=;
        b=Z8vVMiNY9IIb3+tOzMfA4UsMRhNL7kEK1hObK05UCSzcT9V2sVS6XHs3RL1rnlKNQd
         YUc9nNhFValipIuL1mhNdvmzUvzYmE7FUl11d3v8t0rW3WzvAe24Vct75Vj98TT6ptd6
         LmDTZWcT4rMFhd/qRGoXQzhPmf+dRzqajJ/W7C/F9d2OMqAVtnVVAJUmEhJhrR7M4vq0
         jX+blN5Q8BJ0TIT8jeqm+v+xriCAHmknaHigxpgjPd6SBgn0cqM5mVTNIXFwFpSQTICi
         oGiOG0k02yxKywt2vHcVeKtGC8hnqpRFycpLxeyaS3a7g3m6L1jXMwjLC4aot79ZsCzp
         vb5w==
X-Gm-Message-State: AOJu0Yy7aihseZ61bSxh8wqqqRoFSw4iiFblDEyxx9OBoUIeQTKAtYy7
        N4bv6/dVpZ7ly+b7IyiH2fY5m11gdzjQKJOMsQlIpHwR
X-Google-Smtp-Source: AGHT+IF2hy3SoEzeX9diH21aa1Ekzo2QmEJgTFsoUgxT07mgV8CUTEUCF/soJ+06vRgPdY9a59kVAwdgeo8ijW02/Aw=
X-Received: by 2002:a05:6214:5299:b0:656:500e:7b64 with SMTP id
 kj25-20020a056214529900b00656500e7b64mr4633679qvb.16.1696367426204; Tue, 03
 Oct 2023 14:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231003082107.3002173-1-stepnem@smrk.net> <CAPig+cR2wgAsGCTphqHsf_pbM0q_xLcMx=acVD6MDKhpEt3HNA@mail.gmail.com>
 <20231003220951+0200.221551-stepnem@smrk.net>
In-Reply-To: <20231003220951+0200.221551-stepnem@smrk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Oct 2023 17:10:14 -0400
Message-ID: <CAPig+cTw-dZ8v33Ze1k35TQ3czq=4i-e9KEnMMPGsX4XKA848Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] Fix some typos, grammar or wording issues in the documentation
To:     =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2023 at 4:09 PM Štěpán Němec <stepnem@smrk.net> wrote:
> On Tue, 3 Oct 2023 14:30:38 -0400 Eric Sunshine wrote:
> > On Tue, Oct 3, 2023 at 4:28 AM Štěpán Němec <stepnem@smrk.net> wrote:
> >> diff --git a/contrib/README b/contrib/README
> >> @@ -24,14 +24,14 @@ lesser degree various foreign SCM interfaces, so you know the
> >>  I expect that things that start their life in the contrib/ area
> >> -to graduate out of contrib/ once they mature, either by becoming
> >> +graduate out of contrib/ once they mature, either by becoming
> >
> > You probably want to add a comma after "area".
>
> That would read awkward to me.  How about going the other way,
>
>   I expect things that start their life in the contrib/ area
>   to graduate out of contrib/ once they mature
>
> instead?

Sounds fine.

> >> @@ -579,11 +579,10 @@ This test harness library does the following things:
> >> -Here are some recommented styles when writing test case.
> >
> > Do you want to fix the spelling error while you're here or is that
> > done in a later patch?
> >
> >     s/recommented/recommended/
>
> You really had me double-checking both the branch and the patch I sent
> here. :-D Unless I'm very much missing something, that line is _removed_
> by the patch (seemed redundant given the title immediately preceding
> it).

Ugh, so it is. Sorry for the noise.

> >> - - Keep test title the same line with test helper function itself.
> >> + - Keep test titles and helper function invocations on the same line.
> >
> > This would be clearer if it was switched around. Either:
> >
> >     Keep the test_expect_* function call and test title on the same line.
> >
> > or, more verbosely:
> >
> >    Place the test title on the same line as the test_expect_* call
> >    which precedes it.
>
> I'll take your first suggestion.

I like the first suggestion better too.
