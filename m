Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD4D202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 18:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdCOSNC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 14:13:02 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36659 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdCOSNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 14:13:00 -0400
Received: by mail-pg0-f50.google.com with SMTP id g2so12603803pge.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uxh8YUWT1HM4WfGyajc30ehF79xkm5mmxALhm20lLsk=;
        b=hbftxsFn8w/Ggvz+fsuc0g93bKMGaYAXpORRUflJbr9B72sryJT5AqwIQ56Q/giEuZ
         FtEofRzzVWuZwTyWdDgHjHx5JiChLJP498zRE5pVe5bCtmqv+ZSVY5HW1q2MFhMV90tv
         N0f5zEQWUsQ72x27r2xOA2SjnWwIpkAo3XBpluZjjgEnI6ECgLBYEEIzLF0gEffSSadR
         8l+yVPjTpXX9rjHpjP0dUm/lR5R58l1ueiWhlJ8GwqUsHRWj9CdeoplpRuNbYlXhTf1+
         0LCt2KWxWjA4HLXxhsGNU5nt37w6nHwzXDVcKrYDDnPNDksdqhkyL9ArYHRzoeRCKJKx
         ZgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uxh8YUWT1HM4WfGyajc30ehF79xkm5mmxALhm20lLsk=;
        b=BsAHGviuOb2Ymhx2+Orjt11g68VZ0jUwCGgFGNcAVEXxIX268k8Zky95GFu/SGXxHD
         5uTf5ven3eTEHy3hZHheaZm0MyO3JMu9QDGP70bCZ+KjctqDjQI3rCcbInaMSIozR4S5
         9AwY4i7fG7/hftXIo6ePwUZlrH5vRGW2tnbjIyCuowYK2Y87u7uZEXW+Ju0vpJLFFfzO
         MBHN20j7JgZ3xTZfEaf6Rv04FXtfsG3BMIOqpc6wCS79JlFWbqiQySBN7UneVJBmZtwX
         sownnpyPDFgZSYvtBEqmlevLSRDBpZAifQOJSomIiQZCre6zvsln2O5nXWuZ8zPg8SqP
         5uvg==
X-Gm-Message-State: AFeK/H39VOeqyFmTMjmXQMfTcAxE5LiAH8VN5vnCxtCJ84avVoeDRABOunaZDWoOM3Dfp/QzFaQ2GqyZZQa6HhWZ
X-Received: by 10.98.20.8 with SMTP id 8mr5287460pfu.10.1489601578852; Wed, 15
 Mar 2017 11:12:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 15 Mar 2017 11:12:58 -0700 (PDT)
In-Reply-To: <CAME+mvW1x6fnGKt1_auGOp+wFYFR=Y_Qhxfd50E7KFe6t+X4kw@mail.gmail.com>
References: <CAME+mvW1x6fnGKt1_auGOp+wFYFR=Y_Qhxfd50E7KFe6t+X4kw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Mar 2017 11:12:58 -0700
Message-ID: <CAGZ79kbfNBbHgc4FrGoNNc54p65-xkQUQ6X3Ef9Ew9pioMzz7w@mail.gmail.com>
Subject: Re: GSoC Project | Submodules related work
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Valery Tolstov <me@vtolstov.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 2:33 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Hey everyone,
>
> I am Prathamesh. I am studying Computer Science and Engineering at IIT
> Kharagpur. I am interested to participate in Google Summer of Code 2017
> under Git organization. I attempted "Avoid pipes in git related commands
> for test suite" as my microproject[1].
>
> As a part of GSoC, I would like to work on git submodules. The projects I
> have looked up are:
>         1. "git -C sub add ." might behave just like "git add sub"
>         2. Teach "git -C <submodule-path> status" in an unpopulated
>            submodule to report the submodule being unpopulated, do not
>            fall back to the superproject.
>         3. Teach "git log -- <path/into/submodule/and/further>" to behave
>            like "git -C <path/into/submodule> log -- <and/further>"
>
> I went through the series of mail (related to projects 1 and 2)[2] for
> getting a better picture of the projects. I think as the projects are
> quite interrelated together, these may make a complete GSoC project.

Sounds reasonable.

> Also the conclusions which I was able to make from the mails[2] are:
>
> 1. We are catching commands typed by the user in an unpopulated or
>    even an uninitialized submodule.

What do you mean by catch here?

What happens is that Git is summoned in e.g. path/super/sub/ and when
Git wakes up, it has to find out what is going on, e.g. where the repo
is that it should work on.

(0) it checks if it is inside the .git dir by looking for files like
HEAD, config
    objects/.)
1) It looks if there is a ".git" file or directory in the current directory.
2) if that is not the case go up one directory and check again.
    repeat this step until either the repo is found or a filesystem boundary
    is reached.

And as uninitialized submodules do not have a .git, we'll find the
superproject repository. Once the superproject is found, the
subcommand itself is invoked. (e.g. cmd_add for "git add", in
builtin/add.c; the function signature is just like main() except that
it has an additional prefix parameter, which indicates the path
from where we ended up at to the original invokation point,
i.e. when invoked in  path/super/sub/, and the superproject
was found at path/super/, the prefix is sub/.

> 2. We first check if we are present in the superproject's root dir.

After the repo discovery as described above we're in a root of
*a* repository, and we have a prefix, which may or may not be
an uninitialized submodule.

>     we check for the presence of .gitmodules file,

We have an API for that. :)
See submodule-config.h#submodule_from_path that
either returns a struct submodule or NULL if there is no
submodule.

However to detect if there is a submodule, we can to check two
things: if there is a .gitmodules entry and if there is a gitlink entry
recorded in the tree. Depending on the command we'd want to
do one before the other. e.g. git-add most likely doesn't need to
load .gitmodules, but may have the objects already loaded.
So checking if a given path is a submodule is cheap compared
to loading the .gitmodules file, so we'd probably want to do the
cheap thing first.

>    from which we can check the path give is inside some submodule.
>    *When .git file containing just a .gitlink is present then, I am not
>    sure but even in this case the root folder contains .gitmodules
>    file in the case of submodules(Please correct me here, if I'm going
>    wrong), then we may still carry the same procedure as above.

I think even when the .gitmodules file is missing, we want to have
some sort of warning here, as it is a confusing state to run git
from an uninitialized gitlink'd repository. The user may assume they
run the command in the gitlink'd repo, so it may be better to bail out.

>
> 3. Once we can detect whether the $cwd is in a submodule, we can output
>    "The submodule 'sub' is not initialized. To init ..." for all the
>    commands which doesn't initialize and populate the submodule.

It depends on the command what we want to do; for most commands
this seems to be the right choice. For git-log we need to do a different
thing, as you mention in 4)

> 4. As similar detection could be used in the third project listed above,
>    hence I even wished to include it.
>
> What are your suggestions about these projects? Also, will it be
> rational to consider it as one complete project for GSoC?

I think it is sensible to consider enhancing multiple commands, as
one command is a very small bite for a GSoC project.
And once you have the first command done, you'd generally know
the vibe and the next commands ought to be easier. (though we'd
still need to figure out different outcomes, e.g. step 3 or 4 as above).

> I think this might interfere with Valery's proposal[3] of shell to C
> conversion of submodule related codes. What do you all think?

I do not think there is interference with Valery's proposal, as this
proposal would mostly work in builtin/{add,log,commit}.c
(cmd_status is in builtin/commit.c for whatever reason)
whereas Valery's proposal would mostly revolve around working
in git-submodule.sh (deleting lines there) and
builtin/submodule--helper.c (adding the deleted lines back here;
in another language)

> If it does interfere, then can we both work out on something common?

I really do not see a lot of interference of these 2 proposals.

Thanks,
Stefan
