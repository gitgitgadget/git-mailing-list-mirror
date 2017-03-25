Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA3720966
	for <e@80x24.org>; Sat, 25 Mar 2017 12:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbdCYMFn (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 08:05:43 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33665 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdCYMFn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 08:05:43 -0400
Received: by mail-oi0-f43.google.com with SMTP id l203so6003963oia.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ecWwTtSrg37Ii89NfXQycoo5Yx9F2Uz6uiNFJ++3CxA=;
        b=lfO+trHnp3xKjtPGG3OIFkyRwJpEKG0P2L2ni70cGIWWOLcZIVRQkNTUZ02XzI8bHz
         q2LKGpG3g/NMLZkb8f37CQ1Nck8w4SctqFn01rujHdirQMsvQb7FbGWD6yQ8lcRskraS
         khq9kNFFafE1saEL5qCyQNX3qEGIk2GV+6C7PfZxMIUPg6qptl2soyw2tYTrXmeCR5iz
         UcZrK/hGl77ujNRI+lQ+h09MG+bCLu7aOh7Zf8EJr/WmjtDL65OrbYB8E0cuFQNxEwai
         oW1wpXlkm+sZkxmxlrS4EmnXX7uYnLfF2LtbcbaIHEXqFBl73ZNVEXmCCvHV8vCTkONO
         +EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ecWwTtSrg37Ii89NfXQycoo5Yx9F2Uz6uiNFJ++3CxA=;
        b=DOwiFkWLtgMtuDo09FlwTbx9aXkx4ACL70HBQE1nSuFXiUYN0i8wenPLJL8TGjtP47
         B1LA1w5EAXUZaSD3ZnZx7t7/vysNdDBy/EFB2268JuJ5g0PLoNGitbYbdYDerqLN6WBU
         B4MId4cC8KRFFrt3fu5vincdGHSWfi4aaIR67lXNq6W5qjaGTVSX0Q3EbMK6UCxo1Uu0
         mxax4mU1HlAdfNCC+jTWLjxKq/8ugel99VnBDl6Sa9wLrRABt0IcCC2uva4j1fCKTyiD
         7JAIPnEA2L6DjX5IOjD46lvizCJ3IhDqzGb9MmHV6YJb35EvQF/8HVWk8utb9IrzmkVa
         I46g==
X-Gm-Message-State: AFeK/H0S7qh8LkZ7/eXoTFeXz7qzmJzpMhfeVng7xp0KXkD/S9dydPAi+4hkfFq7J+hJawbF6hKmvUSPi/DwkA==
X-Received: by 10.202.181.135 with SMTP id e129mr7245683oif.124.1490443541627;
 Sat, 25 Mar 2017 05:05:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 25 Mar 2017 05:05:11 -0700 (PDT)
In-Reply-To: <xmqqvar2ska7.fsf@gitster.mtv.corp.google.com>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
 <20170317225110.13417-1-sbeller@google.com> <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
 <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com> <20170320185038.GU26789@aiede.mtv.corp.google.com>
 <CACsJy8CBmfj8wY+LQzEshJT0Ya+nmAGs=K8b1Nyr3qinvCo4kA@mail.gmail.com> <xmqqvar2ska7.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 Mar 2017 19:05:11 +0700
Message-ID: <CACsJy8D-+uO2GabNGLcTvfs7k8NrG1x200j3nOx11u8uUdzZVw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on
 the file system
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 10:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Tue, Mar 21, 2017 at 1:50 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Junio C Hamano wrote:
>>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>>> While it may be true that you can have bare worktrees; I would question
>>>>> why anyone wants to do this, as the only thing it provides is an
>>>>> additional HEAD (plus its reflog).
>>>>
>>>> A more plausible situation is you start with a bare one as the
>>>> primary and used to make local clones to do your work in the world
>>>> before "git worktree".  It would be a natural extension to your
>>>> workflow to instead create worktrees of of that bare one as the
>>>> primary worktree with secondaries with working trees.
>>>
>>> For what it's worth, this conversation makes me think it was a mistake
>>> to call this construct a worktree.
>>
>> For the record, I am totally confused with Junio's last line, with two
>> "with"s, "worktree" and "working trees" in the same phrase :D
>
> In case this wasn't just a tangential note, what I meant was:
>
>  - In the old world, you may have had a single bare repository and
>    then made clones, each of which has a working tree (i.e. non-bare
>    clones), and worked inside these clones.
>
>  - In the "git worktree" world, you can start from that same single
>    bare repository, but instead of cloning it, use "git worktree" to
>    create "worktree"s, each of which has a working tree, and work
>    inside these "worktree"s.
>
> and the latter would be a natural extension to the workflow the
> former wanted to use.

Yes I really want that, and even the ability to convert a normal one
repo (with one working tree) to the latter, moving the repository to
somewhere safe.

>>> It's fine for the command to have one name and the documentation to
>>> use a longer, clearer name to explain it.  What should that longer,
>>> clearer name be?
>>
>> No comments from me. I'll let you know that if Eric (or Junio?) didn't
>> stop me, we would have had $GIT_DIR/repos now instead of
>> $GIT_DIR/worktrees, just some extra confusion toppings.
>
> I forgot about that part of the history, but you are saying you
> wanted to call these "repos", not "worktrees"?

From $GIT_DIR perspective (which points to
$GIT_COMMON_DIR/worktrees/blah) then they do look like a repository
with lots of part borrowed from $GIT_COMMON_DIR. I was simply saying
I'm bad at naming things. "worktrees" is a better name than "repos".

> I can see why
> somebody (or me?) would stop that by fearing "repo" is a bit too
> confusing with a "repository", in the same way that we are now
> realizing that "worktree" is too similar to an old synonym we used
> to call "working tree".
-- 
Duy
