Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D04C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 16:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbiDFQti (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbiDFQtV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 12:49:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167BC400FED
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 07:11:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p15so4527729ejc.7
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0a/rQibpM0dWhfp/lSNcm6CcI12F4Pf9Rq/F+M59FI=;
        b=CenfYuVex/Vi4DT3Q8VhP83dTShYanEtkEgATL99Y+qkSVQT8Dt8AaeITQkT/60un0
         lCdlDpghDmYhkh60Pt9ZXodbtk78S624eI6NfsOoVQ++Dd34ZSXwyDByB2VBiVR4OIRh
         yL83jR8gh1D4VcdGzg2yHINGIxyv2aRZhyTOjW+evUH1JHYMqOQwo3clQwpiCCSm2nse
         YDd3T4/kLQhCoTt8b0BdlZoxQ9iWNkVpGElD1eTVgT82qWB4UBq7bRijkLTeahkduz3Y
         SsyC+a4CAuqRYoYxlptvh0kIx2Uxt9t+d7bnoNyM39QnyQ9J7awN4dynmtjYq7WTWsI0
         T7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0a/rQibpM0dWhfp/lSNcm6CcI12F4Pf9Rq/F+M59FI=;
        b=WOjLxBxaclD6ucJ08DaEJKrba6138XHUNEtUmRFjiN1eo+2ZcxzjgMsqUQGzQZeaer
         aWcPgfbkzFpYbHz+9GxP21Vkw63nP578RbJFbFtj67122B3QeqImaCMw0vAJNstwM8bx
         NuUoxM50iAMgv7qR+/2mhKQJUOXfyFiVarKwKmuvlZD8+hK/IeKgDJ9VjFl/Es7QkKL6
         PzX49GkUy1rO5qJz5YTSftMNhrrDbnk/lE/l2Di26gD2h0bCITOXBQmwpLVx9PS/R//+
         62qqOUJlKRFtFMh/8HKpGNIHn0kbZUPNy211yyrs8BYmrcfYvW8OCJRMiIOIx5h3Q/A0
         +7CA==
X-Gm-Message-State: AOAM5312cU0aMbotSz5JyoiJr+vurjJAyiopiViINuub01gnk0Zu1HzY
        3s6A35YSjaHMRSqMR4S8fGAnQpL+J1JTo1DncFq8bttADw0=
X-Google-Smtp-Source: ABdhPJyYetYaljOy/AE/PrFdkYhpIAa+1M47X3tuYIcWzzm3iadul6ew7d77aQnXJrrEifrhRbt/ofYVymijgAbKSco=
X-Received: by 2002:a17:907:94ca:b0:6da:b785:f067 with SMTP id
 dn10-20020a17090794ca00b006dab785f067mr8556999ejc.654.1649254307126; Wed, 06
 Apr 2022 07:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <Yky7xb7nQRR8Vqtj@nand.local> <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
In-Reply-To: <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Wed, 6 Apr 2022 19:41:35 +0530
Message-ID: <CAC316V6mDowYpptox3KxYycpwpiQhW+LSmNOx8_F_8LKBG2gUw@mail.gmail.com>
Subject: Re: [GSoC] Contributor candidate introduction
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

As the topic begans, I think I should also give my updates. Last week
I spend time around "Croaring" library and right now, I start working
on the initial version of proposal which I am planning to share by end
of this week. I think if it's possible to split it into two, We can
look forward to it with I am okay with picking other project involving
bitmap too but only issue, I have to start again from scratch :)

Thanks,
Shubham

On Wed, Apr 6, 2022 at 11:55 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Taylor, Plato and all,
>
> On Tue, Apr 5, 2022 at 11:59 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > Hi Plato,
> >
> > On Wed, Apr 06, 2022 at 12:43:59AM +0300, Plato Kiorpelidis wrote:
> > > Hello,
> > >
> > > I'm interested in participating as contributor for the project
> > > "Reachability bitmap improvements".
> > > The area I'm interested in, the most, is the alternate compression scheme
> > > e.g. Roaring+Run, however I'm ecstatic about any bitmap performance improvement.
> > > Expected project size I'm targeting for is large (350 hours).
> > > I've already completed my micro-project and I will submit it in a few hours.
> > > I wanted to be sure I could submit v1 of it before committing to
> > > introducing myself.
>
> Though we appreciate it, we don't require introducing yourself. And if
> you choose to do it, you can do it whenever you want.
>
> > Hooray! I'm delighted to hear that you're interested.
> >
> > > I've gone through the mailing list and looked for other candidates that could
> > > also be interested in this project. Shubham Mishra is also interested.
> > > - Could we collaborate on this project considering how broad it is or only one
> > > can be selected?
> > > He/she already has experience in open source and has participated in
> > > GSoC before.
> >
> > I think there are a couple of options here, since we have a handful of
> > bitmap-related projects that are all up for grabs. If Shubham is also
> > interested in working on implementing Roaring+Run compression, then I
> > would be happy for the two of you to work together.
>
> Unfortunately, GSoC rules forbid contributors from working together.
>
> > Alternatively, if you each want to focus on different sub-projects, I
> > would be happy to work with multiple students on different areas within
> > the reachability bitmaps subsystem.
>
> I think this would require creating different independent project ideas.
>
> > > I should note that the best case scenario for me is if we are both selected,
> > > probably on different bitmap performance areas under "Reachability bitmap
> > > improvements" project, however I don't know if it's possible. It probably
> > > depends on the mentors listed for this project and the work load involved.
> >
> > Yeah. Even though I'd be happy to work with as many students as I have
> > time for, I'm not sure whether it's possible within GSoC's own rules,
> > much less whether or not it's been done before.
> >
> > Christian (cc'd) may have more information. Christian: is it possible to
> > accept multiple students for the same GSoC project?
>
> Unfortunately, I think there needs to be a different project for each
> GSoC contributor and GSoC rules ask for each contributor to work
> independently from other GSoC contributors. It's possible to have the
> same mentors for different projects though, so if the mentors for a
> project are OK with splitting it into different independent projects
> and mentoring all the independent projects, I think it could work.
>
> Best,
> Christian.
