Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E035320248
	for <e@80x24.org>; Sat,  6 Apr 2019 12:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDFMDm (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 08:03:42 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:34259 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDFMDm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 08:03:42 -0400
Received: by mail-it1-f180.google.com with SMTP id z17so12982509itc.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjjIn+/bydiW0zH36urnt96YHHZt7l0tYwq0ydLDB5c=;
        b=hcAFKim7Suooz80l6sA7X740FQeKBlCDFsRsXvS6GZMwee/1dQY0oWI74HKQBRkAuf
         cOodP/exSA9o16e0xfd5ATFeQD+Pci+A0oyxiwkbgNTB+emdHwCtUTJQgCXv5qM+oUEu
         RcfFVQGu10UTACLLcDsdZB7e9cQ12mkKimVTwvKAP+2N/UjUnM/BGstdAre6edDA21Ld
         e+osN9hYdvkF/6uKDjQ69TDc9FdmhrQTyeP4AN2ku8RLhzqjab4OoH1sJUwOc5ct1Ej5
         fYQ7XPHKHqguCl3cd5JymEgLu71xhPjPy0bF7JLFarBw8fSZ/V48mjP4bl/onROsUk3h
         yyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjjIn+/bydiW0zH36urnt96YHHZt7l0tYwq0ydLDB5c=;
        b=VH5i6IFP1gXIJYB//6emcPGQH4Xfaiv9scko7Onbqg3dRomTNEf3cyiG+qBmPLny98
         V7ndasgN+A1sc9jx7zBOtRBjgZpZSJXlOoN4+kVDW3QA7vsjNu+bWRFJiqWWmKGTV4rn
         P4qLeSjeNNu4Nin4Jw0zP7Aji5mInMMUzB6g1si4iH8XqPbL78OG7Sv4iOmrs12+W/4F
         G94Kzq54uiEsXQO76BqUZJurcmsn5e+ut9/exP0XF71OEpPS0nRBoQ2cErBbiif7SfS3
         FCLhqvTbmQjpN5AHrRdp1REsYVidWmjNPgJoOZoJEPG6s1Uc+Btf7IIVKkiui1T5lHA0
         XxWQ==
X-Gm-Message-State: APjAAAXxajXY4N7bPjyMHkoB1a20q0464KJDn19xsyionTSMeki2KQrI
        5DSXh/d0qeqjfNz9aV+vnXtk4kn/Lle7sO6kFhc=
X-Google-Smtp-Source: APXvYqzx+uBzG6gKE1Qb5wcxuHCiu7tJyaG5kmel0Yqg1aHty3mOLNklmSrS8DcIRwgfJUwx1X3rx7LaONQWZtX7ZM4=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr12311371itb.107.1554552221691;
 Sat, 06 Apr 2019 05:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPS68VEkUbNxeKQvVDGjzVpBXKNAi3uA04pLwN9k4ZTfA@mail.gmail.com>
In-Reply-To: <CAMknYEPS68VEkUbNxeKQvVDGjzVpBXKNAi3uA04pLwN9k4ZTfA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 6 Apr 2019 19:03:15 +0700
Message-ID: <CACsJy8AnXawOgC0eWKpSF7iGXAvPdP9=SZX1HePRABVdkiKs8g@mail.gmail.com>
Subject: Re: [RFC] TODO in read-cache.c
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 6, 2019 at 6:42 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
>
> i found some TODO tasks inside `read-cache.c` in `read_index_from()`
> function. which says:
>
> /*
> * TODO trace2: replace "the_repository" with the actual repo instance
> that is associated with the given "istate".
> */
>
> this same TODO occurs at 4 other places in the same file.
>
> Will it be ok, if i complete this TODO by modifying the trace2's
> function signatures to accept `struct repository`
> and change the calls to those functions accordingly ?

trace2 API can already take 'struct repository' (the_repository is a
pointer to 'struct repository'). I'm pretty sure the purpose is to
_not_ pass the_repository (because it implies the default repo, which
is not always true). Which means you read-cache.c's functions need to
take 'struct repository *' as an argument and let the caller decide
what repo they want to use.

In some cases, it will be simple. For example, if you have a look at
repo_read_index(), it already knows what repo it handles, so you can
just extend read_index_from() to take 'struct repository *' and pass
'repo' to it.

Be careful though, repository and istate does not have one-to-one
relationship (I'll leave it to you to find out why). So you cannot
replace

 return read_index_from(repo->index, repo->index_file, repo->gitdir);

in that function with

 return read_index_from(repo);

and make read_index_from() use 'repo->index'. It will have to be

 return read_index_from(repo, repo->index, repo->index_file);
-- 
Duy
