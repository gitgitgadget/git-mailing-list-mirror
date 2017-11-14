Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B3F201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 03:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbdKND01 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 22:26:27 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:46834 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbdKND00 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 22:26:26 -0500
Received: by mail-qk0-f175.google.com with SMTP id o6so22474670qkh.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 19:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tmfMJ05u8dFGjbZ8+iOseBa6mpHSNF007rtg4KGRRbI=;
        b=rrjJhf3LZdTGbkxknM4vqyv0Cl+t9Hk8woopjZaDEAIDPvd5ECjH/rsrAGRfArj8Jh
         bC6S/cWAsoPQs6Mi4Nza8+rQke8cEEbj4dfo9Jl6g7geOsI3LCgzfeFeMAxzHADj52M5
         RrUva9tMGy1T0rK4YJhqxK84GMmvILgmwL0b8FTVJf75Up/1v+ChiBoSbW8vcWuUFa+3
         ahCBcqClZX9RdPphotdw9JZKFGnwH0YcKmhk5/womJ36xhwabcyJWlMCXVsbleBmZ4x4
         aulQllYKwTfIrz2zbQ2ZCmVHKMMM5IP9lWWpflq/FcayAQqYjtBX+B3ngIDD9bcNZkxa
         ZSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tmfMJ05u8dFGjbZ8+iOseBa6mpHSNF007rtg4KGRRbI=;
        b=QgAuQru0qE8jHfgY87n7GIPbmfLGFxNzz7PTPYyYXPKltPzVtrW5rznGiH+/3wUjCf
         e0fvTooG5TvoZY/W9DNEA22f3zdRIfKnooma5XgbxJxkQzA1XMNZhg/7G8FqYEB9CtGd
         4EGC31YYgt74d+qR+bYEfTZndgCjpZ8y789lW8hV0aHeFOfmnRs62ZMC9uAvCLF3V26I
         p2vqzJftkT16mSF1EV8/WMpsAXqDyp/7hy23uLw+tElU/ia5wnb+Qkb4Of/lx+iiyMWv
         pv1PTGBT0weMe6aQpgh6PbqFI9I9/PjCNJpJm2/YaYJJAb0laHm454eo/rUaKSlRHGHx
         8H7Q==
X-Gm-Message-State: AJaThX5qnph0m8QOE6jwSQC9mt7oVD8imFffN1/FfyQDZYQrmATEfRct
        0iwbNOMQXbulPH9rdjLr/Uofp6Bsj2iutA1teLI=
X-Google-Smtp-Source: AGs4zMYHzG3nuGjxV6T8qk0dQSbeXMUPVLe78nwq9FUA2nNMtvy654QEaIzOoMfOnlANXCOLE1UuoISrTfX6M+qfZO0=
X-Received: by 10.55.42.75 with SMTP id q72mr17367555qkh.57.1510629985536;
 Mon, 13 Nov 2017 19:26:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Mon, 13 Nov 2017 19:26:25 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711131603340.6299@localhost.localdomain>
References: <alpine.LFD.2.21.1711130938080.5262@DESKTOP-1GPMCEJ>
 <CAPig+cRLcJ2a=QKyKAkaNiewoWMQvKr_AWePKYVpGS5S9g-i1Q@mail.gmail.com> <alpine.LFD.2.21.1711131603340.6299@localhost.localdomain>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Nov 2017 22:26:25 -0500
X-Google-Sender-Auth: ENlt__qB52unJXPcNtDmdrgRHio
Message-ID: <CAPig+cR2W2zKcjLYjd1E4jhMkad3O2ioncCZhkExGopxa_0_xg@mail.gmail.com>
Subject: Re: man page for "git-worktree" is a bit confusing WRT "prune"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc:Duy]

On Mon, Nov 13, 2017 at 4:06 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Mon, 13 Nov 2017, Eric Sunshine wrote:
>> On Mon, Nov 13, 2017 at 9:48 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>> >   finally, the prune "--expire" option is truly confusing:
>> >
>> >     --expire <time>
>> >         With prune, only expire unused working trees older than <time>.
>> >
>> > suddenly, we encounter the verb "expire", which means ... what?
>> > how does "expiring" a worktree differ from "pruning" a worktree?
>> > and what makes a worktree "unused"? the normal meaning of "unused"
>> > is that you haven't, you know, *used* it lately. in this context,
>> > though, does it mean deleted? and if it means deleted, what does
>> > it mean for it to be older than some time if it's already gone?
>>
>> This dates back to the original behavior of automatically pruning
>> administrative information for deleted worktrees. As discussed
>> elsewhere in the document, a worktree may be placed on some
>> removable device (USB drive, memory stick, etc.) or network share
>> which isn't always mounted. The "expire time" provides such
>> not-necessarily-mounted worktrees a grace period before being pruned
>> automatically.
>
>   how is this "expire time" measured? relative to what? i've looked
> under .git/worktrees/<wtname>, and i see a bunch of files defining
> that worktree, but it's not clear how a worktree stores the relevant
> time to be used for the determination of when a worktree "expires".

According to Documentation/gitrepository-layout.txt:

    worktrees/<id>/gitdir::
        A text file containing the absolute path back to the .git file
        that points to here. This is used to check if the linked
        repository has been manually removed and there is no need to
        keep this directory any more. The mtime of this file should be
        updated every time the linked repository is accessed.

So, the expire time is relative to the mtime of the 'gitdir' file for
that worktree. Presumably (according to the documentation excerpt),
mtime of  'gitdir' is supposed to be updated each time the linked
repository is accessed, however, I haven't found the code which does
that (and it's been too long since I dealt which this code to remember
where/if it is being done); in practice, I don't actually see the
timestamp on 'gitdir' being updated, so that may be a bug/problem.

>   oh, and is it fair to assume that if a worktree is temporaily
> missing, and is subsequently restored, the expire time counter is
> reset? otherwise, it would get kind of weird.

If we believe the documentation, then, as long as you've invoked some
Git command recently enough in the restored worktree, it should be
safe from pruning.
