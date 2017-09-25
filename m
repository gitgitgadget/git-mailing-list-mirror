Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D19202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935687AbdIYSak (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 14:30:40 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:44766 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbdIYSak (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 14:30:40 -0400
Received: by mail-qk0-f176.google.com with SMTP id b23so7645929qkg.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 11:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RCp5UY7D0BUJKZyUsZ4FVCb3v59MeUQCn61TafNBRxk=;
        b=dngFzjR6Uy47Q2C3wmHexjbu6jo9FPhBGDNZKyiFeYrmirMqKXet22blNmVRnLJSKk
         OWFOe142djOO9zl+B1TESMl7b+vVsA9LIxUOp1AfUlijCkZvjNhLdDbnv419pl8TZku8
         pBcRBJpEWhaK8NmP8liQgu7vZRsm1JW3NMnIQQq8yIXAMB/pLF6WpwWO/lSgTjaCcDeg
         sf0v5CjI2E4Pska4YO1aytmtgRkn256NcGsir42qok1BB3yDg5h6w0IKqyVg9HqVZXKV
         fCnGuqfyzMDfs4NV1tMi+5y7csXtG/5ayxTmCY+/VPe7iWTbHNQQrICUKaA3EC5bJoLh
         1qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RCp5UY7D0BUJKZyUsZ4FVCb3v59MeUQCn61TafNBRxk=;
        b=BJuNfYJH0+WdAqjrLaAiOdTAteU5V9cweCW6cN3iNNPYipGAl07pyc3wJO9m0goROp
         zkJkAzEHdur9Adzm2HJpZylSwSjpnJIZMgLobpV/eNJEI9tbvAYO+d5wbCuHP1X9fiAr
         wZCfNewclnvS/fzTKHQ9N+cSEbsiwQISdu+78Ike2gCcfdy8Kn3p5o0ZSoHg9QLDOyZq
         ZvhQZe03YGD+MBM1fPIhFAAIMqeS89Mf0gKLm4hlmh4DrgzcmdOzJqpITl6QOs7oVwQh
         tuy/2d8JAtavAskLImwD/Oft5KfwExVGsw5aVAAydQKhxDi3+bWc08D5n2l7ENJ6Kvy9
         waTg==
X-Gm-Message-State: AHPjjUjzfXwl4eur2HeJ0PGLu1qZoQiHz9jqYdKoQVER8ht5oxSfpnbx
        AH4+YNwFweCX6XRyaWyakoPl4YqtDCVVi0i/GTlSTA==
X-Google-Smtp-Source: AOwi7QAvrT1/EfRFZPALlWZbz0MgwTo130d3LSKjAbA3L4kq8oqdAsbNBEl1wCPUdiRlOomFR+4VXlvCUTusQqQRYxA=
X-Received: by 10.55.90.199 with SMTP id o190mr8798721qkb.180.1506364238813;
 Mon, 25 Sep 2017 11:30:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Mon, 25 Sep 2017 11:30:38 -0700 (PDT)
In-Reply-To: <xmqq7ewndyu1.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ewndyu1.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 25 Sep 2017 11:30:38 -0700
Message-ID: <CAGZ79kaM+PGzFdGVkdLszAuz9kEatzf_ESC+KMjkRnwXS5FaVw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2017, #04; Mon, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sb/parse-options-blank-line-before-option-list (2017-08-25) 1 commit
>  - usage_with_options: omit double new line on empty option list
>
>  "git worktree" with no option and no subcommand showed too many
>  blank lines in its help text, which has been reduced.
>
>  Superseded by bc/rev-parse-parseopt-fix?

yes it is, please retract this one.


> * sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
>  - Documentation/checkout: clarify submodule HEADs to be detached
>  - recursive submodules: detach HEAD from new state
>
>  "git checkout --recursive" may overwrite and rewind the history of
>  the branch that happens to be checked out in submodule
>  repositories, which might not be desirable.  Detach the HEAD but
>  still allow the recursive checkout to succeed in such a case.
>
>  Undecided.
>  This needs justification in a larger picture; it is unclear why
>  this is better than rejecting recursive checkout, for example.

I'll revisit this with fresh eyes, the original plan was to get
jn/per-repo-obj-store done to have more fundamental operations
available to do the right thing, whatever it is, though.

>
> * jn/per-repo-obj-store (2017-09-07) 39 commits

We intend to get this one rolling again.
