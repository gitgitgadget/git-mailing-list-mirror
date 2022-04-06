Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AD1C433FE
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 09:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiDFKAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 06:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbiDFJ4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 05:56:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD4A49DE8F
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 23:25:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 7so1562149pfu.13
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 23:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30AyJYEtXU39AbhmHfOh7bBj38UvL1r07o3XjOtBiDM=;
        b=kf5WF2un+nJkEdOynj4hNW5p2ou4rWENA8mhWwKX6tVAeZtUeQKotLvYC+ia826juY
         bPzEt+MvYEM9xls73uFUFgESIJyZydifOVmr5gv6mZTEV4xj2HrBhghVPIdYjkk9KxLf
         kURuAS4jSEywHB/ThHSwRkCcF6mFzzWBQI/Sc0Z6uMKIxg4sw9yivghdDohNNRjghKVf
         30v0Pet1Nfw17ffJsxTfwuR8fQK8k7LoxXkZArLJHUaOK1h3TjwLYMiaA8HroLcQWkU/
         uQXkT4Sjr8cKd3M6QBD9dfTlZKIg6GK50guRmHbMnfwPANdZmmLFum+tleJ6FCMXH9NM
         iQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30AyJYEtXU39AbhmHfOh7bBj38UvL1r07o3XjOtBiDM=;
        b=b39p7DwRuqGRri5GA0cDKZc5KaMDp/5JupTmpx9bbmS/DEy+h6asYz2bRGFX1OBLcg
         G32eFKtoQIqjDTQF28cPmlB7GWZEV6bbAbhumb0vZsvgKzB/XaB3eb4N9S5XGXQb3Vv/
         ztfU+0OXjTX80TivEdF+FxXT9McJ988K9XBF6aIGmz9SM2TEZFLHmX9jbvXQDRe4sMic
         5b21NCHSqPensJ3F9PBiqkM7MxIpm0y99kSnlsM1ZNO3R+QP9p/OlMwitq45lXNp81oZ
         1ru8eTQpvZzWAbBbJO5OUibMJUp0/h97f+BxgKPpseFSWS5JcG0P4AIAJSe3fX+uoJhv
         XQxw==
X-Gm-Message-State: AOAM531qjVaiFLCdYJv3zAsWCAkHSEJZoETC/cDuDQHB9oAp2CtT/XtI
        GjioXu1qztQf3OppeXzWY8yMqEK/4ww+gGkyMBA=
X-Google-Smtp-Source: ABdhPJycJOWyRaaM+rwuF+0xfTSiP8ieEvjfXeioSeSf0YUDo2xlGYiqj4hB6ZrfMNYRLP2GGdTu/OBpc5MpMi/w+aw=
X-Received: by 2002:a63:c10e:0:b0:381:6a51:6231 with SMTP id
 w14-20020a63c10e000000b003816a516231mr5844737pgf.189.1649226341342; Tue, 05
 Apr 2022 23:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <Yky7xb7nQRR8Vqtj@nand.local>
In-Reply-To: <Yky7xb7nQRR8Vqtj@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 6 Apr 2022 08:25:29 +0200
Message-ID: <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
Subject: Re: [GSoC] Contributor candidate introduction
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Plato Kiorpelidis <kioplato@gmail.com>, git <git@vger.kernel.org>,
        Shubham Mishra <shivam828787@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor, Plato and all,

On Tue, Apr 5, 2022 at 11:59 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Plato,
>
> On Wed, Apr 06, 2022 at 12:43:59AM +0300, Plato Kiorpelidis wrote:
> > Hello,
> >
> > I'm interested in participating as contributor for the project
> > "Reachability bitmap improvements".
> > The area I'm interested in, the most, is the alternate compression scheme
> > e.g. Roaring+Run, however I'm ecstatic about any bitmap performance improvement.
> > Expected project size I'm targeting for is large (350 hours).
> > I've already completed my micro-project and I will submit it in a few hours.
> > I wanted to be sure I could submit v1 of it before committing to
> > introducing myself.

Though we appreciate it, we don't require introducing yourself. And if
you choose to do it, you can do it whenever you want.

> Hooray! I'm delighted to hear that you're interested.
>
> > I've gone through the mailing list and looked for other candidates that could
> > also be interested in this project. Shubham Mishra is also interested.
> > - Could we collaborate on this project considering how broad it is or only one
> > can be selected?
> > He/she already has experience in open source and has participated in
> > GSoC before.
>
> I think there are a couple of options here, since we have a handful of
> bitmap-related projects that are all up for grabs. If Shubham is also
> interested in working on implementing Roaring+Run compression, then I
> would be happy for the two of you to work together.

Unfortunately, GSoC rules forbid contributors from working together.

> Alternatively, if you each want to focus on different sub-projects, I
> would be happy to work with multiple students on different areas within
> the reachability bitmaps subsystem.

I think this would require creating different independent project ideas.

> > I should note that the best case scenario for me is if we are both selected,
> > probably on different bitmap performance areas under "Reachability bitmap
> > improvements" project, however I don't know if it's possible. It probably
> > depends on the mentors listed for this project and the work load involved.
>
> Yeah. Even though I'd be happy to work with as many students as I have
> time for, I'm not sure whether it's possible within GSoC's own rules,
> much less whether or not it's been done before.
>
> Christian (cc'd) may have more information. Christian: is it possible to
> accept multiple students for the same GSoC project?

Unfortunately, I think there needs to be a different project for each
GSoC contributor and GSoC rules ask for each contributor to work
independently from other GSoC contributors. It's possible to have the
same mentors for different projects though, so if the mentors for a
project are OK with splitting it into different independent projects
and mentoring all the independent projects, I think it could work.

Best,
Christian.
