Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8FE1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 00:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeH3EWW (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 00:22:22 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:42784 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeH3EWW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 00:22:22 -0400
Received: by mail-vk0-f43.google.com with SMTP id t4-v6so3449631vke.9
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 17:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2inqzy03Sfu0lgPWB7RobHnrvs3bEwlpQa36ub483BY=;
        b=FNFp+cdU8qVs0UzqPmQ1iT6S+fqSj7A2Pg/fy+ElZALUogKbZ2g4TZkXPR0R/R61tJ
         EiCYYUcMABDt+i9GQLQC7z86AeMsdhNM+3otYXnOkdq5wUjJlh+f5z3pei6yPlzE+9eO
         pqUSZEh5sdtNNzHxuZCYNwYyYrBwC/sc6dDPCurJhZh1D7sxL6i/mqdTun2GNUd07Ug3
         RwZdmocoeM5s9FTwF47iR6XWs4FBHQqlkxdTLw43/rWrZ2w8okTjdXLlFnTTXUY7xcXH
         5bk8t/zsZfyhWZKp2m4kh7NnOtUVg/0DoRm9D/ylpUDzGElqezp2RA+FuewvO09sRt9A
         lWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2inqzy03Sfu0lgPWB7RobHnrvs3bEwlpQa36ub483BY=;
        b=oZuwxVPj7Y4HV+/qqksSchf5331tw3U9CFwQ/zkXwfmz2glHkVDUIJG/XT5o2kjs5u
         rG27fT+O43n32BrJg2R/35WEATR//u6JerfZmqyTsoFq0N41Nppc6mWRhWShytBlCmUB
         a/465erpQwe/4cCAt3Od1wc26z7kDQ7wy9+aLzhu5jVjTyyG9hBUYwyjRGmn7Y7ALC5J
         rNJIC/483/WegPk1q839YF/LtoluRHA/A5/UXiqBu2qtPfDTkUzk+G0Uu44cv/0YanvY
         dqD3Vhtafux1xVdDPsx50VmeTeZCffQUzm5kzjmCBI6Q0oqYzD01nxcoKGVMitTzc5cO
         fvtw==
X-Gm-Message-State: APzg51CgrRj0Y5/lUt7q5o71Kz8dhvfNfDQ2PNujR26B7d6ajtwYArLR
        PhbJP4b7kFVQTW0durq9SMYvV8fMiK/hFJ6jhGzJGA==
X-Google-Smtp-Source: ANB0VdbAKHxAKrerzj3vtesZytCUDV9avvgvS1CpMmPZjRlie3x7BdRMFCcWIp8XpFRpBMKKZuCnRNWjZlg8GD6n314=
X-Received: by 2002:a1f:a0d6:: with SMTP id j205-v6mr5366079vke.23.1535588575793;
 Wed, 29 Aug 2018 17:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbm9kajhu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm9kajhu.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Aug 2018 17:22:43 -0700
Message-ID: <CABPp-BG1VCmCMHe=5qayS0G_Z_=e8aVQ121LWuo-OBuiUxiCYg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #06; Wed, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Aug 29, 2018 at 3:38 PM Junio C Hamano <gitster@pobox.com> wrote:

> * en/directory-renames-nothanks (2018-08-29) 4 commits
>  - SQUASH???
>  - am: avoid directory rename detection when calling recursive merge machinery
>  - merge-recursive: add ability to turn off directory rename detection
>  - t3401: add another directory rename testcase for rebase and am
>
>  Recent addition of "directory rename" heuristics to the
>  merge-recursive backend makes the command susceptible to false
>  positives and false negatives, but the risk is even more grave when
>  used in the context of "git am -3", which does not know about any
>  surrounding unmodified paths while inspecting a patch.  The
>  heuristic is disabled to keep the machinery "more stupid but
>  predicable".

I had separate comments about the SQUASH patch in the relevant thread,
but I've got a few comments on the release note itself, which I hope
are helpful:

- Perhaps change the last sentence to '...heuristic is disabled for
"git am -3" to keep...', just to be slightly more clear about where it
is disabled?

- Small spelling error: s/predicable/predictable/

- Do we really want to say "even more" here?  I'd rather we left those
two words off or found another rewording.  Obviously, I'm biased, but
there's more than just my own opinion of and vested interest in the
directory rename detection feature.  I'm afraid users may interpret
this sentence as saying the git project feels we've shipped a
generally bad/unsafe feature, but are only taking corrective action in
the most egregious of cases.  That seems to me like a scary message to
send.  Maybe I'm just mis-reading what you meant, but I wanted to at
least check what you meant here and, if that meaning was not
intentional, ask whether we could improve the wording.

Thanks,
Elijah
