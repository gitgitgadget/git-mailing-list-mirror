Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68541F454
	for <e@80x24.org>; Fri,  8 Nov 2019 15:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKHPBF (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 10:01:05 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:35301 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHPBF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 10:01:05 -0500
Received: by mail-il1-f181.google.com with SMTP id z12so5399335ilp.2
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 07:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvPGjhdZR2TPsVRfh7qctJ8/uur903ww3hY5Ffbw520=;
        b=auypJtnon0ss5/RDob93FDsxC8I705JvLbg/B+Vn2Aodsql44hgEUponFK1hJHoQlf
         eNKYCIW0WTpBuNfeACUQ9XbxYW2hDXTyLidi/lGEzSqpEVwxtIlXqEsOZWwVmF+hXGsQ
         4VOaTigYo+3NmJUrqmEVTDV4qQ2pKU9Z0zh0xfjwuPZOU+2AMnPvY8QcfZCBqCIF1XQt
         h6kENXraLOBmsqileXCcHIEytmNDzqrvjyKHZT4IDOUV0VUJyi7GVpGyWQd/5IaLb0t8
         w/KKAS7cbJi/ZnA9RtCGCIx4PxBcpHUA4l1Ve0y7Rh67nAgSCsQtxl92tTVD5kJXkhwR
         ukxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvPGjhdZR2TPsVRfh7qctJ8/uur903ww3hY5Ffbw520=;
        b=ctI+6UtyagfxDxwzF0I1R3Ss/y03yZb3LrJiY73IqccIaPCU7hfppeC234cK1h9Of6
         pTT0C/J2rvldXjwiWott2BVepfLUXVASOPmSBqilGJ1t1UQlUxPogdKDR1L+EqMZSmFa
         jdGDMcixKUPiZniZFmvAZOvAxD01c0fFNw9oZ3ZhtbGE2IQHvh9jr59mt7MXBSBOz4AW
         +Pokmpm4jItcsWOC968Hkxip0w/dvLAUueGDD4K6byCapBtkQcVOgJEkeu4/xKZDn2+d
         brPt/PIHHXBTX2VkHkJ98wsEQCoRkSiB+HvwHNTFrSZRbE0VVvMwQsoE97TC4GrOiNUT
         bqEA==
X-Gm-Message-State: APjAAAVsSKxaHkChondozmL8RJO2C2jArxMu/tk85EyFb9oll6zQN/J6
        InjV5aIZ+x43F12GHg8v7OMvVaP2Z4bH4g33iiU67g==
X-Google-Smtp-Source: APXvYqzRod5e1xwkwUJYujb1eMGPFNXXIaG36E99xKfvc8ZI7W0Vm2tbQYME/IVKiyAQkCnjmNkx1WpmmHOBglcsOPU=
X-Received: by 2002:a92:4899:: with SMTP id j25mr12524730ilg.127.1573225263965;
 Fri, 08 Nov 2019 07:01:03 -0800 (PST)
MIME-Version: 1.0
References: <xmqqeeyin4kx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeeyin4kx.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 8 Nov 2019 12:00:52 -0300
Message-ID: <CAHd-oW6vBm6JnN8aSeryC716+7xzV-LBZujeRgZgF6RbP0LLHg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2019, #02; Fri, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

On Fri, Nov 8, 2019 at 5:41 AM Junio C Hamano <gitster@pobox.com> wrote:
[...]
>
> * mt/threaded-grep-in-object-store (2019-10-02) 11 commits
>  - grep: move driver pre-load out of critical section
>  - grep: re-enable threads in non-worktree case
>  - grep: protect packed_git [re-]initialization
>  - grep: allow submodule functions to run in parallel
>  - submodule-config: add skip_if_read option to repo_read_gitmodules()
>  - grep: replace grep_read_mutex by internal obj read lock
>  - object-store: allow threaded access to object reading
>  - replace-object: make replace operations thread-safe
>  - grep: fix racy calls in grep_objects()
>  - grep: fix race conditions at grep_submodule()
>  - grep: fix race conditions on userdiff calls
>
>  Traditionally, we avoided threaded grep while searching in objects
>  (as opposed to files in the working tree) as accesses to the object
>  layer is not thread-safe.  This limitation is getting lifted.
>
>  What's the current status of this one?

This was the last round of improvements I had in mind for this topic.
So for my part, I think this is ready.

Thanks,
Matheus
