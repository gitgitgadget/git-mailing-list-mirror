Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01ED3208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbdHORTw (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:19:52 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:32946 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbdHORTv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:19:51 -0400
Received: by mail-yw0-f177.google.com with SMTP id p68so8607941ywg.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5CyfY4nN4PDhzOgkIuB0XSAfRzHe458+nH2Ed6WfhMk=;
        b=bWTH8A0X2lcX2Fi66zF69YbxVoI+PVbQLdjaf1+2B8H2zpF9hotcs3j0W0QZKN2vER
         jQ/h2iVjyurL+GTnn46I1u/CgFn/LUqq27vLdlYRArXhUX23sn8119Fe1vhf9txJAjBm
         tapxMFuH1WnfHvlfS8K0zTly1TnCMh6M2pDW6fyqRE3Vi9xettwUHSV1CrKap+ZGetr9
         2cqbNf4Otoeew/k+pLKROVgcCL+2GC8vD/LKzFaVz+wBLfH4hk60lTGMUajmTecHUbMG
         Nnyn4l/yq4ZHRCKXpjEZqYeAe8QAtgYXOYUAPpXLdNY82DomkPGK3XY05WCd/22z2uMd
         WtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5CyfY4nN4PDhzOgkIuB0XSAfRzHe458+nH2Ed6WfhMk=;
        b=hP+D2dZjKsWNhu7+BBpcW6X2VOrfwxkrKCVV2RUPn3XznvEA56ScDIHc/ghEgwq7Ti
         ug6Vi/yhNjNyneRk8cPhdA2zxF5Lx3tRsXurtY5hvMKZadB4WuJ/h0BB8ZqrMBoU8kDV
         +bno//yZXBLjMWrdj6d9RmBJeevfC8sJrMlPUqDwwgf89etwHaZx3l3DsWGrvKE6wPKs
         fTXrlhWBlyp3NeLvM0q7CUJoPYAHj9Zv4cRRSC7Z1bdt3qxJoKU9wA6KCqxM7LwEAqJe
         GQFYV2wh27OdEL+VOMn5wbYSEr73IshUgWMeltymQ5yXS5jiNNLDA56l+6AGNJ/FfSY7
         lnGw==
X-Gm-Message-State: AHYfb5hhTTPYnEXwI2Z4J55HIX/WUYyj1jLiW+avXOTGDpp3+36fpZWQ
        PaKa1QYMdIuaiPeLiCn03yAN4tgb8fO/
X-Received: by 10.129.93.194 with SMTP id r185mr16904107ywb.33.1502817590726;
 Tue, 15 Aug 2017 10:19:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 10:19:50 -0700 (PDT)
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 10:19:50 -0700
Message-ID: <CAGZ79kbGNMHVjfzZBiEAkUV+WVY=a5aQsV3Da=1yKcCkFR-ewA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Modernize read_graft_line implementation
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 4:49 AM, Patryk Obara <patryk.obara@gmail.com> wrote:

Welcome (back?) to the git mailing list!

> I experimented with using a different hash algorithm (I am aware of
> existing "Git hash function transition plan", I just want to push
> things forward a bit) - and immediately hit a small issue - changing
> the size of object_id hash buffer leads to compilation issues and
> breaks graft-related tests.

Thanks for advancing this frontier. :)

>
> I am sending patch 1 only to show a modification, that I did to
> increase buffer size - it's not intended to be merged.
>
> Patch 2 fixes trivial compilation issue.
>
> Patches 3, 4, and 5 touch graft implementation to remove calculations
> using GIT_SHA1_*, that lead to broken tests. I replaced FLEX_ARRAY of
> object_id's representing parents with oid_array. New implementation
> should be more future-proof, I think.

I would think so, too.

parse_oid_hex currently only reads sha1, but once it can read a new
hash (or both old and new hash), it would solve the graft problems.

> New implementation has tiny behaviour change: previously parents in
> graft line needed to be separated with single space - now any number
> of whitespace characters will do.

Yeah that is because of parse_next_oid_hex in patch 5 is pretty smart
(and if we'd want to preserve behavior we'd need to just skip one SP
and in case of more SP "goto bad_graft_data" that is in the
caller function.

>
> Alternative implementation approaches
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Strbuf could be replaced with string_list with
> string_list_split_in_place instead of while loop in read_graft_line.
> I didn't implement it this way because I learned
> about string_list_split_in_place after finishing this implementation
> draft. Right now I'm not sure which approach is better.
>
> Another possibility is dropping graft feature altogether - that would
> mean removing code for parsing grafts and 'parent' field in the struct,
> but preserving the struct itself as a shallow clone marker. Grafts are
> a little-known feature with modern replacement, but this seems like
> bigger task and rather out of the scope of transition to the new
> hashing algorithm.
>
> I considered making function read_graft_line a static one and
> read_graft_file non-static, but read_graft_line is used in
> 'builtin/blame.c' in function read_ancestry, which is almost a copy of
> read_graft_file (difference of single boolean flag passed to
> register_commit_graft). Removal of this duplication may be worthwhile,
> but I think it's out of scope.

I think the grafts may be still in use in Linux, to fault in the
history before git was used, which cannot be replaced by the
shallow mechanism.

Thanks for the patches 2-5!

Stefan
