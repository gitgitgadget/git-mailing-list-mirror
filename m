Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00095C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 03:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJ3DJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 23:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ3DJS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 23:09:18 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5127495DB
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 20:09:16 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id e15so7532142iof.2
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 20:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wEgQEvTx9acm4eJk5p7oMCQM7zQfWma49GY3CgtnFE=;
        b=0gafItCSrttJBxkRVryfTxOaQa1T3muQ/M7evbE2BF+96BCn6Jvz4Gf3RTZnlE89iH
         KPIPcHf8Et9pBslu27QDFJ0FlWlBBV1o3jKPclYuQ5MCJIKTN5hyaZxPBcMEDAShwlDW
         hyUAKPvYl199dl9FbUwvM12FYXspfwz83MdFxapoNMfeJ/6zP6bgoZjIDXFS6GGMPQOx
         L+QXERODsk7F/onqwZznOy3N8mJMJEDM7/ScJ3X1HushW4lceGz/VDlYUsT0SHKnIUFB
         eHTNNNQg9+8K+1UiWcqZ1G2JSFILEH5hzXHuOgcvLW9orTgrPH6E9eFhvL45StPER6t2
         yf4w==
X-Gm-Message-State: ACrzQf1TGPLDaKrsTwoW53k5mAlpuyFPk/4DJA5H4jSlGrWn4MJV86CL
        IOCt5GWGSY3t+Hg5pSM+OTEG7sg9lj5CfXX9Zyb6aVFZ
X-Google-Smtp-Source: AMsMyM5UaYhrs5L6zYx/CC2l6AgZiIZCiP2vB4A+IeJRH0WjLah7kkyR4nFAh8XZSlAsp2HueHS9phbJyMverD5SPs8=
X-Received: by 2002:a05:6638:408a:b0:363:e307:8433 with SMTP id
 m10-20020a056638408a00b00363e3078433mr3517760jam.221.1667099355864; Sat, 29
 Oct 2022 20:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjZQXRsMaRYrskmpn5zBCrOt3xNOZ5shoVG82kjS7A3MZQtUQ@mail.gmail.com>
 <CAEjZQXRB47GirGP53njjGMS1gm6ydUUuxOEaj_XQGkkE8wfo5g@mail.gmail.com>
In-Reply-To: <CAEjZQXRB47GirGP53njjGMS1gm6ydUUuxOEaj_XQGkkE8wfo5g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 29 Oct 2022 23:09:05 -0400
Message-ID: <CAPig+cS5psokHgzV0Ri69Wi_Ba-iE9XW8uFeVybwnQuvLWomQw@mail.gmail.com>
Subject: Re: Soft bug: No chance to sign synthetic commits when using git
 subtree External
To:     Adam Ryczkowski <adam.ryczkowski@statystyka.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2022 at 3:32 AM Adam Ryczkowski
<adam.ryczkowski@statystyka.net> wrote:
> A week passed and my last message did not get any follow ups
> (https://lore.kernel.org/git/CAEjZQXRsMaRYrskmpn5zBCrOt3xNOZ5shoVG82kjS7A3MZQtUQ@mail.gmail.com/T/#u).
> Since it is my first post to the vger.kernel.org and I am using gmail
> (which feels awkward in the context of this list), it lets me to
> believe that the message was filtered out from human eyes somehow.
>
> I would appreciate it if someone responds to this email, just to let
> me know that the initial message was delivered successfully. Thank
> you.

Presence of your initial message in the archive is indicative that it
made it to the list itself. That nobody responded is likely due to
there being very few git-subtree users on the list rather than any
intentional lack of regard for your report. I have, myself, never used
or looked at git-subtree, hence am of no help on the subject.
