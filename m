Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1FA1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeDQSGC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:06:02 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36450 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDQSGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:06:01 -0400
Received: by mail-yw0-f178.google.com with SMTP id c9so5597457ywb.3
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m/xcmfb/DcdqmQz8aHn9v9n0IPaOd6Vqrcd/+/3vWsc=;
        b=CmcTxaRK6RBDz9h0jkzjZwC2gKMrWC7BcfktwvrTm8j0ESlNs6bMvo8JsmsdoHRwEY
         zYxzX3m8CRPnQdcIma92QYsRkUNgXJJEO2KTp+9q6rWnSQQ0HbXJz4Nrab/U1YGKae1I
         jvp3gfJ9XbLkCwijTv5eIozxhcus3ybzoruAEgZosI/aekQhS9YVlv+Yo8A68eANOZ9K
         Gmwq54x2Th+DQrMJQxOU4Oxcib7maw/tn9ttIYUT7JGGIdk9jUS/timwbEwg4yV/j1GA
         A2rambrx/8JW6P5wDi4YFI9hh9Rt3pGNMV8X/2vAM8mIfyNJ3OwuPcwDAUpgWeshEPMZ
         k8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m/xcmfb/DcdqmQz8aHn9v9n0IPaOd6Vqrcd/+/3vWsc=;
        b=eMKR8dF0d6+YrVETuQVBu56Y5AQNrn8ZFAz3k26tDxMp1vWTFoNZo3dihVx7tYPguN
         cqiqIxhvvzsA5uf4Lb3hPJ/9HPm6uWlicoWQZYjrbPJ0aDsgRzlmzA2t85k4BLg34TyY
         fHS48DIPGb+csydTqqsCI/OzNgOglbJreMXBXeTcnrZ/zpqLiuliuYcCe2Om8RGjG5k2
         L75qsLtOVYyAf6aZeQX19/a+GPf1EjvuHa8fUwuQ6E0pAbDA8JxLZK2XLMXDGb8sZsog
         YP35pDO0semQswElissIVgN8gXayiDwE964BnONO1pcF/cJMxjQB5kwjbAosEBi0cuk6
         QUYQ==
X-Gm-Message-State: ALQs6tBFoWzRV7Gh9VbZr0oaKEWNADymweZa9QgUqZr+EZ+OW3aUkzI+
        qKnyhq3d277mFNA48J2TNMf5EdEQBUxKG6qb+nkX0eOdp9Q=
X-Google-Smtp-Source: AIpwx48YV4l2t9lMjBRmBuNQ1c1gW89+nP+yVFxn9OsO9bBFT/YrEd1EMPgxHS690QqvT2RMME1d/DLI/AsHTF/DnvU=
X-Received: by 10.129.86.5 with SMTP id k5mr2144515ywb.345.1523988360138; Tue,
 17 Apr 2018 11:06:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 17 Apr 2018 11:05:59
 -0700 (PDT)
In-Reply-To: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Apr 2018 11:05:59 -0700
Message-ID: <CAGZ79kb=A6BsdrtH=2F0634+r5ejG9Ce9U0mry65jkNnscu1nA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> --------------------------------------------------
> [New Topics]

> * sb/object-store-replace (2018-04-12) 15 commits
...
>  The effort to pass the repository in-core structure throughout the
>  API continues.  This round deals with the code that implements the
>  refs/replace/ mechanism.
>
>  What's the doneness of this thing?  I didn't recall seeing any
>  response, especially ones that demonstrated the reviewer carefully
>  read and thought about the issues surrounding the code.  Not that I
>  spotted any problems in these patches myself, though.

Stolee and Brandon provided a "quick LGTM" type of review
https://public-inbox.org/git/20180409232536.GB102627@google.com/
https://public-inbox.org/git/9ddfee7e-025a-79c9-8d6b-700c65a14067@gmail.com/

I do not recall an in depth review, though Rene had some design guidance
in form of a patch, which is also the first commit of the series
https://public-inbox.org/git/38962a15-1081-bbdb-b4c4-6b46222b5f64@web.de/

My plan was to build the next series on top this week while waiting for
further review, though I wonder how much review will happen this week.
(Brandon, Jonathan Tan and Jonathan Nieder are all OOO,
Peff is on vacation, too)

I do not recall any discussion worthy design discussions left over, so
I'd lean on "cook in next for a while".

>
> --------------------------------------------------
> [Cooking]
>
> * sb/blame-color (2018-04-17) 2 commits
>  - builtin/blame: highlight recently changed lines
>  - builtin/blame: dim uninteresting metadata lines
>
>  "git blame" learns to unhighlight uninteresting metadata from the
>  originating commit on lines that are the same as the previous one,
>  and also paint lines in different colors depending on the age of
>  the commit.
>
>  The code to handle interaction between the config and command line
>  option smelled fishy.  Reviews and discussions are welcomed (not
>  just to this topic but others too ;-).

I'll look at the replies in thread there.


> * sb/submodule-move-nested (2018-03-29) 6 commits
>  - submodule: fixup nested submodules after moving the submodule
>  - submodule-config: remove submodule_from_cache
>  - submodule-config: add repository argument to submodule_from_{name, path}
>  - submodule-config: allow submodule_free to handle arbitrary repositories
>  - grep: remove "repo" arg from non-supporting funcs
>  - submodule.h: drop declaration of connect_work_tree_and_git_dir
>
>  Moving a submodule that itself has submodule in it with "git mv"
>  forgot to make necessary adjustment to the nested sub-submodules;
>  now the codepath learned to recurse into the submodules.
>
>  What's the doneness of this thing?

I considered this done a long time ago,

    "All 6 patches look good to me, thanks.
     Reviewed-by: Jonathan Tan <jonathantanmy@google.com>"

https://public-inbox.org/git/20180328161727.af10f596dffc8e01205c41dd@google.com/


Thanks,
Stefan
