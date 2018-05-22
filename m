Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F7F1F51C
	for <e@80x24.org>; Tue, 22 May 2018 22:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeEVWkf (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 18:40:35 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36886 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752698AbeEVWke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 18:40:34 -0400
Received: by mail-yw0-f195.google.com with SMTP id u83-v6so6088507ywc.4
        for <git@vger.kernel.org>; Tue, 22 May 2018 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9cu+uuKSTOTbaxNvtliaFcZJQUBfh+2tgS4B90R9jp4=;
        b=URIwE3gV8bTzMLCxA9//wZQDcZUYuQgchU3qNu2v+w0xf8l4fv8/aFeWOsqxm2GJPm
         taHGxogkrtFEygDXIf6P4HbjEM9PJXBDgGJkPbQ+E3aSNPKByH9c/vAmQc6h9VDdjzLB
         peZ74hsDk490LhcS6j6ORli+yBq6EiNuaN3DwQ5ebeWb4HV7zR8jpNE9dO7WIk8Y2Qfr
         eWaRQSG2iJxwNwtWtJEr82T7nPUUmqlyjkNXlL3YASPAi6L0DlxwTEZsXOnornQX4UJb
         VDmVWR8UxEaxTQhPKUrApF+kfL3XaOdIEfFqPBhQIfFs8M5SMic4Ar2p59FkaxHlsE+9
         3/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9cu+uuKSTOTbaxNvtliaFcZJQUBfh+2tgS4B90R9jp4=;
        b=LckVmtudl6+EwHaLXwKfYeu3yTBA/3ZKEqSw8JRNM4Y5JlbTGLQmNjFqoEfo3o9WAN
         Q9sg51cKkG8MvtvwKuJubkGFaLy9dwS4dEYkRcBLHTnuG6EltDO7gfg+bmmMUtjabfuu
         QLpUsS8EqX7e7T0sCIekLW2TUUlt+uKhfN0E3aeKH1QWrQ64JMGRLTQMj47f6OOvp600
         dnxPo3+g52GTUUgPP2rOzIFv85Tw7qlKc2QTUb/D2hNoa1gw0CDJ8HaJj0ogYxkJV4BQ
         iCdU8c8MSvGgqPqe+OA6lLxvFdBDnA0BXORILYIcKjOvOgnyUMXBV1pCfIUFP42LY/Qz
         Dewg==
X-Gm-Message-State: ALKqPwerti7c0XRoet+V/fanz83Mrp4as0xlt8cMKLp0+w2u7+cYY0hN
        gHM4kM1CqfD6qZGt38CDiyoZuHF4mISa1HNdOVf5wA==
X-Google-Smtp-Source: AB8JxZpa/qDxvOvtGGI/RqFBV1e7agxftsrySEb3b3qrAQzuOEd56I//y2hhtyXE4lPL++Vzg6AT6r4i9yCNHWK+0Jk=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr208123ywa.340.1527028833808;
 Tue, 22 May 2018 15:40:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Tue, 22 May 2018 15:40:33 -0700 (PDT)
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 May 2018 15:40:33 -0700
Message-ID: <CAGZ79kaDnxHG_rZ9Zm8eqm1e6=VFWRxy4S7oz-97X3mVqHS2uw@mail.gmail.com>
Subject: Re: [PATCH 00/12] Die commit->util, die!
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 1:00 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> There's not much to write here. It's basically a copy from 12/12:
>
> This 'util' pointer can be used for many different purposes,
> controlled in different ways. Some are not even contained in a command
> code, but buried deep in common code with no clue who will use it and
> how. For example, if revs.show_source is set, then it's used for
> storing path name, but if you happen to call get_merge_parent() then
> some 'util' may end up storing another thing.

This is cool! It makes life easy when it comes to clearing up commits
in the object store (as it is unclear what the util pointer is used for
we leaked that memory so far in the object store conversion series).

> The move to using commit-slab gives us a much better picture of how
> some piece of data is associated with a commit and what for. Since
> nobody uses 'util' pointer anymore, we can retire it so that nobody will
> abuse it again. commit-slab will be the way forward for associating
> data to a commit.
>
> As a side benefit, this shrinks struct commit by 8 bytes (on 64-bit
> architecture) which should help reduce memory usage for reachability
> test a bit. This is also what commit-slab is invented for [1].

The object store series (called -lookup-final) is at a point where
I have to move one of the slabs (buffer_slab in commit.c) into
the repository or rather into the parsed_object_pool in object.h.

So I think I'll build a series on top of this one first, which allows
for not just defining the slabs all over the place, but actually allows
them to be embedded into other structs.

Then I merge that series with origin/sb/object-store-graft and build
the -final series on top of that.

Stefan
