Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43BF31F404
	for <e@80x24.org>; Wed, 28 Mar 2018 20:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbeC1UxH (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 16:53:07 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33860 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeC1UxG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 16:53:06 -0400
Received: by mail-yw0-f180.google.com with SMTP id e17so1273519ywa.1
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nsRFLODgfJq1M++qOUFnUlYBDWMUtdSwetnMnK1ahac=;
        b=ZxOrHsAHI37iUyMQmU1Bm5a1zrP4O2RE1WBkMuld/b+MggNsmDJ9vDXzUqMb/GP0PE
         izJ9GJCcrcORoEfVGF2bj8ZiCW5lvI7wsrQr7S+elvdi6SwQepPp4IGNw2+UVnKY7wP7
         1xhto36MXZb//5XKxCiKBLqOMF1wqX7EmmeDgh8fSeFomqErwUwKYzT5j1TRStn1w45V
         /4fZnbJrA9AYKdz6LL5W8L8Oq+mndYdAEQkQN4ZqLD9qJ+FuX2QSdH4+zIU0ZB1hsO7S
         xb7TC/CE5FtIz1CWTKq34/PftABpGcpNRyJTPB++f4PrmTLFNV0tOQGNy5jNz9R+7LQ7
         U9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nsRFLODgfJq1M++qOUFnUlYBDWMUtdSwetnMnK1ahac=;
        b=R0ctRS3PBagNKHHroafFOIsPEx0O+sPtY6mcYuzK1ljdO996q7IpV9f3ksnkfM86w4
         BWhE9drItLrxFBUMtKhxXitB6zYC5bTzQE5J5ynL83RFxdgGStJk6hdVfs8Qy7UqmDUw
         kLoFB9UQpG/hlXsnISOoW18NiHz50s+5f4EP5g6UX4MbjhpVo4xyKuLCEZEGgmfDETw+
         ewWYl+0I/t2vbCcEkTmVKntqUKmxX95eMc3kpBTlLN9snmTgPYxXe5Wo0nVhBh0T0R8r
         S3T0gGApmdPEs9eWN5xSkzBLFhVkTvJSouhUdNj5e2OKnhBmMghllz6V7G5k8ir2xOwn
         Tkng==
X-Gm-Message-State: AElRT7HVUCoHy9+GOL3YFf802DiImD7noR75Ri6tI+R5UF08p5vrMj0/
        J6Zhgob7hcvI0eHMXJGZpDW5zkoxar0EHbsTtw2UTaELY6o=
X-Google-Smtp-Source: AIpwx4+NE3sGtdWU45j3hcN4Wm6Zg9gKz6C+3Ym7fpMSJ86CfLaNLR3SgNCRdwOcYDKZnqXflpHqZSDlQSlT81SBcUU=
X-Received: by 10.129.232.5 with SMTP id a5mr3386827ywm.421.1522270385558;
 Wed, 28 Mar 2018 13:53:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 28 Mar 2018 13:53:05
 -0700 (PDT)
In-Reply-To: <xmqqsh8k6khj.fsf@gitster-ct.c.googlers.com>
References: <xmqqsh8k6khj.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Mar 2018 13:53:05 -0700
Message-ID: <CAGZ79kbqG2iG6A=aawiyVsr=NFRtJqt1XHeC3kMaRce27JHCSw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #05; Wed, 28)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 12:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * ab/doc-hash-brokenness (2018-03-27) 2 commits
>  - doc hash-function-transition: clarify what SHAttered means
>  - doc hash-function-transition: clarify how older gits die on NewHash

This looked ready for next to me.

>
> * jk/branch-l-0-deprecation (2018-03-26) 3 commits
>  - branch: deprecate "-l" option
>  - t: switch "branch -l" to "branch --create-reflog"
>  - t3200: unset core.logallrefupdates when testing reflog creation
>  (this branch is used by jk/branch-l-1-removal and jk/branch-l-2-reincarnation.)
>
>
> * jk/branch-l-1-removal (2018-03-26) 1 commit
>  - branch: drop deprecated "-l" option
>  (this branch is used by jk/branch-l-2-reincarnation; uses jk/branch-l-0-deprecation.)
>
>
> * jk/branch-l-2-reincarnation (2018-03-26) 1 commit
>  - branch: make "-l" a synonym for "--list"
>  (this branch uses jk/branch-l-0-deprecation and jk/branch-l-1-removal.)

These three branches are interesting as all the work is done already.
We just have to wait? Anyway the first step looks good to me.

> * sb/blame-color (2018-02-13) 3 commits
>  - builtin/blame: highlight recently changed lines
>  - builtin/blame: add option to color metadata fields separately
>  - builtin/blame: dim uninteresting metadata
>
>  Expecting a reroll.
>  cf. https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/#t
>  error messages are funny, can segfault, ...

I look into that again, I thought I had fixed the segfaults last time.

> * sb/object-store (2018-03-26) 27 commits
...
>  (this branch is used by sb/packfiles-in-repository; uses nd/remove-ignore-env-field.)
>
>  Refactoring the internal global data structure to make it possible
>  to open multiple repositories, work with and then close them.
>
>  Rerolled by Duy on top of a separate preliminary clean-up topic.
>  The resulting structure of the topics looked very sensible.
>
>  Waiting for a follow-up discussion.

I had the impression the discussion had settled and this
would be ready for next.
https://public-inbox.org/git/xmqqy3iebpsw.fsf@gitster-ct.c.googlers.com/

> * sb/packfiles-in-repository (2018-03-26) 12 commits
...
>
>  (this branch uses nd/remove-ignore-env-field and sb/object-store.)
>
>  Refactoring of the internal global data structure continues.
>
>  Waiting for a follow-up discussion.

I'll review this one more closely and start a discussion.

> * bw/protocol-v2 (2018-03-15) 35 commits
>
>  The beginning of the next-gen transfer protocol.
>
>  Is everybody happy with this version?  One design decision with
>  larger consequence "to or not to build in?" has been settled in
>  favor of status quo, IIRC.

I skimmed over it and think it is ok to go.

> * en/rename-directory-detection (2018-02-27) 29 commits
>   (merged to 'next' on 2018-03-06 at d42470f86e)
...
>  Rename detection logic in "diff" family that is used in "merge" has
>  learned to guess when all of x/a, x/b and x/c have moved to z/a,
>  z/b and z/c, it is likely that x/d added in the meantime would also
>  want to move to z/d by taking the hint that the entire directory
>  'x' moved to 'z'.  A bug causing dirty files involved in a rename
>  to be overwritten during merge has also been fixed as part of this
>  work.
>
>  Will cook in 'next'.

I am excited about this one, despite having an issue this week
unrelated to this series, but related to rename detection.

The issue was an apparent rename from a tiny .c to a .java
file (also tiny), the license header was the large common part.

I wonder if we want get away from counting the lines that are
equal and instead want to go for some entropy based approach.
(When the license shows up in many files, they will become boring)

Another approach would be to give a "template" file to Git that knows
about which lines to exclude for the purpose of rename detection
(e.g. license, blank lines, indented braces, or such)

Thanks,
Stefan
