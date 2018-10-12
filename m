Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162EE1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 19:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeJMDSj (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 23:18:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40062 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeJMDSj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 23:18:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so12491846edd.7
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZE4yyHe39BQ/LYyc26I9EX0MXKVVg988d9MsVflWfWw=;
        b=mql39avOFdfnu3BxWeptbvFGc0VbzWZ/nWtzrpN5ZQm7kUVDjioy6KqhvD2x+kAPct
         Yrlsejtr+htGUcHfdIJhH04i8BuC5/c8yNUT85w2nB8inMXj5d37G5XdAYdXL7RH8qC2
         s2wUz8YMntk6NtkQz4K3j3KCkZnApaAHRaulnD+JBDDIMmr/PeXPch5ym3+9aWIOOlAE
         FKCFomTawu/GUjhUpipQOEY549cE8pYIHNH5+CrwPcUTXnJROIldKN+NTIP+ygTiz8nA
         WS1vt6gpMBKXkDCOcz8AtF904q5t9G4R7hffoudBZnFMmIpMh/EiCwT8ZCWzMxoBYvH3
         JttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZE4yyHe39BQ/LYyc26I9EX0MXKVVg988d9MsVflWfWw=;
        b=HgiStgGht8U9dS+yPwsKVyltpZi0TfuyZtQKHx3h9mm7O/RLKf31j9KJss9FOlvlOL
         DypqiEPkIr/SOs51O31kjGqiDktuk1/eHO4UJlLaxQTpH0j8gf9JCSA/DmFEK2PzG/mR
         w6jY181vszz1qb7BfRVBnczyfwjDmg//SYly709NkIl09lRXwxQLQFKojRlc8HCnDJz3
         tDgHEcZa0o24KeoPqKC4MMjJ2VftML38pU0iHWymgEOt2lpB1TGmdyJC43LuArPc+8fp
         9hHdrfWrqEoimphp4IXaLplxPan8Mu+vW022Eout7gPiqgo/t6w2Yv7rMQw3qUGxXJJj
         pPRQ==
X-Gm-Message-State: ABuFfohl6Yg8UKdmBXRB7+fUooJ4iBbaOE/Qi22F9EeIj+0yAeEjwgVZ
        Kiw1K70N/B9DLxMyYOyMeydw/j7Lp1Y+wc05d6P++V650/eL9Q==
X-Google-Smtp-Source: ACcGV6175M6VT7MDuSPinik4yy867jiuf/7/YKYfM4a0uMhR9Q8ZUWCIhInNT+SGupdvDfmS++Bbu1FlAqVjsjQZMqk=
X-Received: by 2002:a17:906:9a1:: with SMTP id q1-v6mr8506919eje.126.1539373474577;
 Fri, 12 Oct 2018 12:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh8hr9pxb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8hr9pxb.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 12 Oct 2018 12:44:23 -0700
Message-ID: <CAGZ79kZGEMWpr7aqeqXbC4bkmsCCiW+1pxbEV4T0vfsYG+_3iA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #02; Sat, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sb/strbuf-h-update (2018-09-29) 1 commit
>  - strbuf.h: format according to coding guidelines
>
>  Code clean-up to serve as a BCP example.
>
>  What's the status of this one after the discussion thread stopped here?
>  cf. <CAGZ79kbV6QjsFKcD2uG_P9j1AvzSNQSi-_jXGQ9w0YU9fjhEGg@mail.gmail.com>

I started rewriting the documentation according to your proposal of having
parameters with name, then referred to as NAME in the docs.

After a few examples, I must admit I do not like that style,
so I would just want to do the minimal part that would get this patch landed,
i.e.
(a) convince you that the patch is good as-is or
(b) resend with fewer parameters made explicit if
    we desire to be concise instead.

> * nd/the-index (2018-09-21) 23 commits
>   (merged to 'next' on 2018-10-10 at 16e2e2e947)
[...]
>  (this branch is used by sb/more-repo-in-api.)
>
>  Various codepaths in the core-ish part learn to work on an
>  arbitrary in-core index structure, not necessarily the default
>  instance "the_index".
>
>  Will merge to 'master'.

Cool!

sb/more-repo-in-api is not part of this message,
but it requires at least one resend, so I'll do that.


> * sb/submodule-recursive-fetch-gets-the-tip (2018-10-11) 9 commits
>  . builtin/fetch: check for submodule updates for non branch fetches
>  . fetch: retry fetching submodules if needed objects were not fetched
>  . submodule: fetch in submodules git directory instead of in worktree
>  . repository: repo_submodule_init to take a submodule struct
>  . submodule.c: do not copy around submodule list
>  . submodule.c: move global changed_submodule_names into fetch submodule struct
>  . submodule.c: sort changed_submodule_names before searching it
>  . submodule.c: fix indentation
>  . sha1-array: provide oid_array_filter
>
>  "git fetch --recurse-submodules" may not fetch the necessary commit
>  that is bound to the superproject, which is getting corrected.
>
>  Ejected for now, as it has fallouts in places like t/helper/.

This is the first time I hear about that, I'll look into that.
The tipmost commit there is also shoddy, I'll redo that.
