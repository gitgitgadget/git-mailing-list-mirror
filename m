Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B36C4167B
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 05:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347251AbiDFFFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 01:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455610AbiDEWky (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 18:40:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E102B1FCD4
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 14:30:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b17so756208lfv.3
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZApnDznKQ2uSuPnW4nqLo0qZXc6MpAezgwAh4TGNrVg=;
        b=URLTGbGRphorZyIf4sdGRmsSjhjVHndWyxo5iXUBtTxSZawxSCdpT9ewr87EODEF5L
         it/LEtSAs36C0tFzZ/9Np/sZdZFKJC9TzwZb2sSWE3QEpkgKW4ywnotNFAaoFau2mrg8
         GRLp17eRC49jpLvDxjAszGx/EvGwJKuIvXw/Rufw4SJ4eQs7eAT9A4qbPuUyhE7kjMf6
         BawRpRvkZXwf+Ktl2YDYYDPd7PYFlv4Q7HF9RATD7httq2nFMkJX93t//RhNmq4ppTBW
         zuAXNju37gDCjomRpZrFDkXGf4U9rmmQqTj/y+i9UxJRH0wKQmRD8mE1oPeUzFStxniU
         yI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZApnDznKQ2uSuPnW4nqLo0qZXc6MpAezgwAh4TGNrVg=;
        b=TCVxNN+vHTPQmLG7OOlsV9HCdNBDBCu4DrM7mD17ia470xZGH5ZmLNso6TFj22GYGu
         wCuF9XQyVzmdiohP8grpHQDfHnT/xYtuwB7K09ooKEvBhzVjSSsd5XZ/sp+xLqnKWZnU
         tXye4IzPRmIaeGQmuQwVBlqDV+F1ltN/cFtUf4dhsh/s1cQE6khlClkKzMWFDEz9X+mO
         rGIAN4jyNjNQKw0UEz79VV84eZvvkX4mHCv51TS7t8KS8cinJWffLSzUtQhi/QLmUsO3
         BkWDmrKgzMNEhM/PujnXRdO+28J4CnyDyyq28rThbc7Dsl4ywnHk0ZY5p4aBccdY0oxM
         Beig==
X-Gm-Message-State: AOAM5328VXh9cW4i3W0SfFw4zO4v/sNR/PBY3Du5Kteb3khstzG7K4qv
        dSgbhfqbWo6rBsV21HKgSm2dvB82ATH1h6UvpOn1qJ5RgOA=
X-Google-Smtp-Source: ABdhPJzoYyLWcqp6yqhVKpJkSV3QNG8JCmRtdLziOIHPSfyTmpe4WUxOboyliTrkO5kJEnYIPOz98VVtweOuIoRdrhA=
X-Received: by 2002:a05:6512:15a4:b0:44a:96c:b7c0 with SMTP id
 bp36-20020a05651215a400b0044a096cb7c0mr3909555lfb.366.1649194252523; Tue, 05
 Apr 2022 14:30:52 -0700 (PDT)
MIME-Version: 1.0
From:   Plato Kiorpelidis <kioplato@gmail.com>
Date:   Wed, 6 Apr 2022 00:30:26 +0300
Message-ID: <CAO2gv83m_WuWVAzomT-cBcuXoB=inf-oQORgP1o-yY4Ei0Lcvg@mail.gmail.com>
Subject: [GSoC] Contributor candidate introduction
To:     git@vger.kernel.org, shivam828787@gmail.com, me@ttaylorr.com,
        kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm interested in participating as contributor for the project
"Reachability bitmap improvements".
The area I'm interested in, the most, is the alternate compression scheme
e.g. Roaring+Run, however I'm ecstatic about any bitmap performance improvement.
Expected project size I'm targeting for is large (350 hours).
I've already completed my micro-project and I will submit it in a few hours.
I wanted to be sure I could submit v1 of it before committing to
introducing myself.

I'm Plato Kiorpelidis, undergraduate student from Greece, studying
Computer Science.
I've been developing software systems for academic purposes and Greek
universities
for the previous 1.5 year inside my university department as full time job.

The idea of reading and implementing ideas proposed in academic papers, then
running performance tests to compare and evaluate them, thrills me and peaks my
interest. I've been browsing the git source code on and off for two years as an
undergraduate, thinking it would be awesome if I could contribute, influence and
become actively involved in a widely used tool such as git. The opportunity
given by GSoC provides the environment and support for it to actually happen.

I've gone through the mailing list and looked for other candidates that could
also be interested in this project. Shubham Mishra is also interested.
- Could we collaborate on this project considering how broad it is or only one
can be selected?
He/she already has experience in open source and has participated in
GSoC before.
- Does that make me a better fit considering GSoC is for introducing someone to
open source and their communities or should I strive for a different
project instead?
I should note that the best case scenario for me is if we are both selected,
probably on different bitmap performance areas under "Reachability bitmap
improvements" project, however I don't know if it's possible. It probably
depends on the mentors listed for this project and the work load involved.
- Has this happened in a previous GSoC? Did it work?

Thanks,
Plato Kiorpelidis
