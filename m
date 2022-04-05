Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9964C4321E
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 05:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353610AbiDFFFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 01:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354206AbiDEXOl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 19:14:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93B107803
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 14:44:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m3so729755lfj.11
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZApnDznKQ2uSuPnW4nqLo0qZXc6MpAezgwAh4TGNrVg=;
        b=QvD7LVo2MV0KEBAvk7+OD9CH0hBQH3wfljWOtex77rzDuHm/SBGaVgONsARynXZ4KC
         IYAZF5XyuVoCZYdLTjaGSTlshGwwZSGFQeoEpntbO7x3Mn3WdVyJesIMVueiYSB7X8u5
         g6BeYlsFr06GvIrvmC7Na2t2qyOmKo/rJgrSkzufoYPz8CzccxSEzfM6ve4mZJ/HsaTx
         tiYh75SeuwXqdboVoc8h15ZJUU97YYIXZayZoca3hoHtGi6JWaD8TzPBobqnlz02+4bp
         YVsQE3JIuJFG2/Kr/eh1nZY5nwbqgiU0rA1MBh7A1jIJaiJnCwkDVFjL2WZPpD1CV5VB
         KSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZApnDznKQ2uSuPnW4nqLo0qZXc6MpAezgwAh4TGNrVg=;
        b=YntEgQ2Dfh3OVarr6JmmJ8aDzIgKhCRT39eXwcOBj9XD36Ix/J1+Y0Ycnex/bxVBgA
         qyDd8T+PwcgafRs23xhM9MYu4h3qDMO8qmkUd8aGpyy4Ejbm5ZUgn2Wi1p9iQWN+pYeV
         IfRtAxQSQ5w8+GLAbTeMk+WCmBtneYz7A8/jKSAGG35WUIXSbY1B6/aFJlFUTsFqPeNu
         nRgoM6vaMBwh3JxZZTgi4K/3N/0FSfBGmRq6FkxMD/KRxZPHOyZKcE23QScXCqwLumx5
         f5K8o3MY82Wg4VGlbKwM+up1V4M2CJ/hsjPu6JQNdIi/nr6TgLFeY729HCKftyK9knMS
         GwiA==
X-Gm-Message-State: AOAM532VWR50AB6zFHZ/MITUUdoZZFq4d7hza6OziTucAWhpZhG2eCaP
        d0zylN2HOvnTei4KVmisLGxqn9zUbt8z0eNXNEIK0gkj
X-Google-Smtp-Source: ABdhPJwhJ0qyCn73WEFxi9xPDgH3GcugOwPNHF633k3VhHAs6qij8VlrBztGgVRjoKbaXTBkKXFhlGXCWq/r3Xi0E90=
X-Received: by 2002:a05:6512:3403:b0:448:5f92:7b0c with SMTP id
 i3-20020a056512340300b004485f927b0cmr3796795lfr.237.1649195065509; Tue, 05
 Apr 2022 14:44:25 -0700 (PDT)
MIME-Version: 1.0
From:   Plato Kiorpelidis <kioplato@gmail.com>
Date:   Wed, 6 Apr 2022 00:43:59 +0300
Message-ID: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
Subject: [GSoC] Contributor candidate introduction
To:     git@vger.kernel.org
Cc:     shivam828787@gmail.com, kaartic.sivaraam@gmail.com,
        Taylor Blau <me@ttaylorr.com>
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
