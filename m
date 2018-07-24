Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993721F597
	for <e@80x24.org>; Tue, 24 Jul 2018 15:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeGXQkn (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 12:40:43 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53966 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeGXQkn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 12:40:43 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so4304286itw.3
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdcP8w3HidGRYw5J0IxXezASDKrQdiObXeklbhKRHto=;
        b=dkhJWIp+2YmRoaMGWxpqW3rQpCo+LUzcKHQetwhKhWUVCPA4MQPU73BOH4xg2oEeKP
         vAk960o291ZUWXf4E+tepoTiEaxBOP+1DPgF5KDfikNnCboVOeZqSNprwgBJUbqBzk3U
         QEaX5uTBye1BkK/SALXleaNQelGOQI5MZshIDShVd46rxCv1CuSLKFrfRC1tqG57VflU
         Bl+Ik1Ag744e/wrAn+WDXHuJ++4sNYhxTTfq5u6LygiLL8t1qkRsi+e66do0W+CafJ36
         ZZuVDYdluA+/UpT3BDcJvtZD99QSsJzuS7eFjWIrBq2ibSKGLqN9b3d3e3CaYeT1SQRG
         ynqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdcP8w3HidGRYw5J0IxXezASDKrQdiObXeklbhKRHto=;
        b=X274P1xeu8PS3wI0R4Vgo9zMsE/Wib1WvWw+3U01qd2Q/qQTmDlygY/glnHF22FabE
         25sBlh2uwiJK4XDceYJr/q6kdbN6pWD+A41XYK9ffvqnH19ET0kUv7Ut2RALemxr83cA
         1j0e6tpbRwbYi3IGg0oEv1I2YUORoKA2NYvP76unh1ZXBdsLq842qll+zVO3NXqfOwQ9
         ChZ+6ZDmCvIIQFPSPNKRcwY4olDqEO0nKhqbSTl5pkP1TlhOwMaSVGvFDRaScvNNvC1s
         dJg6rhEO6y2fHuELcfPc5EtdhWiCg/Qj+Oya+Ir5XnVSSs6mRrDo7VuwoifUmxjK1lo9
         kN2A==
X-Gm-Message-State: AOUpUlEOz3ePVhBaFAcokxX9JFs8SDgqRb1x5CY6WKN7FeUs3s1KAERM
        w36GDus51UjpoqTg5y9QxECNfgUQ+mwfUHd5cqA=
X-Google-Smtp-Source: AAOMgpcUCBq1n/JUFr+2oor++SZVE1exmgNoVJD1fTlhau04sohHVeJmR2JzOtdS31fERF9DIQeX+pf6+9NDO2/s6Ow=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr2975530itf.121.1532446421288;
 Tue, 24 Jul 2018 08:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net> <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com> <20180724042017.GA13248@sigill.intra.peff.net>
In-Reply-To: <20180724042017.GA13248@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 24 Jul 2018 17:33:15 +0200
Message-ID: <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase, etc)
To:     Jeff King <peff@peff.net>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 6:20 AM Jeff King <peff@peff.net> wrote:
> At least that's my view of it. unpack_trees() has always been a
> terrifying beast that I've avoided looking too closely at.

/me nods on the terrifying part.

> > After a quick look at the code, the only place I can find that tries to use
> > cache_tree_matches_traversal() is in unpack_callback() and that only happens
> > if n == 1 and in the "git checkout" case, n == 2. Am I missing something?

So we do not actually use cache-tree? Big optimization opportunity (if
we can make it!).

> Looks like it's trying to special-case "diff-index --cached". Which
> kind-of makes sense. In the non-cached case, we're thinking not only
> about the relationship between the index and the tree, but also whether
> the on-disk files are up to date.
>
> And that would be the same for checkout. We want to know not only
> whether there are changes to make to the index, but also whether the
> on-disk files need to be updated from the index.
>
> But I assume in your case that we've just refreshed the index quickly
> using fsmonitor. So I think in the long run what you want is:
>
>   1. fsmonitor tells us which index entries are not clean
>
>   2. based on the unclean list, we invalidate cache-tree entries for
>      those paths
>
>   3. if we have a valid cache-tree entry, we should be able to skip
>      digging into that tree; if not, then we walk the index and tree as
>      normal, adding/deleting index entries and updating (or complaining
>      about) modified on-disk files

If you tie this optimization to twoway_merge specifically (by checking
"fn" field), then I think we can do it even better. Since
cache_tree_matches_traversal() is one (hopefully not too costly)
lookup, we can do it without checking with fsmonitor or whatever and
only do so when we have found a cache tree.

Then if we write this new special code just for twoway_merge, we need
to tighten the checks a bit. I think in this case twoway_merge() will
be called with "oldtree" as same as "newtree" (and "current" may
contains dirty stuff from the index). Then

 - o->df_conflict_entry should be NULL (because we handle it slightly
differently in twoway_merge)
 - "current" should not have CE_CONFLICTED

then I believe we will fall into case /* 20 or 21 */ where
merged_entry() is suppoed to be called on all entries and it would
change nothing in the index since newtree is the same as oldtree, and
we could just jump over the whole tree in traverse_trees().

> I think the "n" adds an extra layer of complexity. n==2 means we're
> doing a "2-way" merge. Moving from tree X to tree Y, and dealing with
> the index as we go. Naively I _think_ we'd be OK to just extend the rule
> to "if both subtrees match each other _and_ match the valid cache-tree,
> then we can skip".
>
> Again, I'm a little out of my area of expertise here, but cargo-culting
> like this:
>
> diff --git a/sha1-file.c b/sha1-file.c
> index de4839e634..c105af70ce 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -1375,6 +1375,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
>
>         if (oid_object_info_extended(the_repository, &oid, &oi, 0) < 0)
>                 return NULL;
> +       trace_printf("reading %s %s", type_name(*type), sha1_to_hex(sha1));
>         return content;
>  }
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 66741130ae..cfdad4133d 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1075,6 +1075,23 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                                 o->cache_bottom += matches;
>                                 return mask;
>                         }
> +               } else if (n == 2 && S_ISDIR(names->mode) &&
> +                          names[0].mode == names[1].mode &&
> +                          !strcmp(names[0].path, names[1].path) &&
> +                          !oidcmp(names[0].oid, names[1].oid)
> +                          /* && somehow account for modified on-disk files */) {
> +                       int matches;
> +
> +                       /*
> +                        * we know that the two trees have the same oid, so we
> +                        * only need to look at one of them
> +                        */
> +                       matches = cache_tree_matches_traversal(o->src_index->cache_tree,
> +                                                              names, info);
> +                       if (matches) {
> +                               o->cache_bottom += matches;
> +                               return mask;
> +                       }
>                 }
>
>                 if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>
> seems to avoid the tree reads when running "GIT_TRACE=1 git checkout".
> It also totally empties the index. ;) So clearly we have to do a bit
> more there. Probably rather than just bumping o->cache_bottom forward,
> we'd need to actually move those entries into the new index. Or maybe
> it's something else entirely (I did say cargo-culting, right?).

Ah this cache_bottom magic. I think this is Junio's alley ;-)

> -Peff
-- 
Duy
