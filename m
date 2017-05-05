Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655D3207FF
	for <e@80x24.org>; Fri,  5 May 2017 17:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbdEERmT (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:42:19 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35497 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdEERmS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:42:18 -0400
Received: by mail-pg0-f65.google.com with SMTP id i63so1621836pgd.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=raMnMLzGNrpsev1GesndyoF6ymrn4j3BgfSCj/HfWrQ=;
        b=kdTgFbRy0hS5/+bQEetv1O7EVLX/iwh/fm64D2iXAN1vksh1JM+o32/2jCvuD29cET
         h5ZUmQzQdzs9ZOlMzhsPQYiueMfl06ILvLJ9tCZ7vZH0FweiPx6ooDZmJD2TyhKVVYv0
         8QVEIQ9XZJwIuRYi4hll5A4gmEqV7cNZoIBR4HwaYQT4YOKD/k9uIj4YQR5+8qvEJx2T
         JBTpJP/VzDMnpIn0l7ICgRvB+D5rCbyOK/ndIMYiess8kx68s+sHX4URrgozebENh4XI
         XNwxONzoX2NuQa073pkyLzDmOATCt1Wv26+bX2ZGKjn8l1aaiRyoXYNY7GXo0xRNa6OJ
         BOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=raMnMLzGNrpsev1GesndyoF6ymrn4j3BgfSCj/HfWrQ=;
        b=QZqyKzadP3SvSKBeGD0leJDx80op2r5hLCEkg1A1LOSQijTjZxVyCGysPwQi9bThM3
         r5mgsPBoke2xgRh+6G6TdWTB+k3HWjRXC1jEuTFlrl9PE5nBHP9Av84wLlNyTBCIWWle
         bpkVjLBh7KxtVmuf8NPAZQKePaKM1oUDo/8N0TRCFOH8lxF1iFlLCJtVlPew3LnE+6wS
         FNQIxN1WJLWZfV4UuPMZRhdKbp4KLv5Il55oHaWH6/bUfICbWZe7QPZuc1b23jHyc9af
         xYw/9lTO1jpi9nHPQjhOaD6ZiZf7JH0nbjD1RESSarwbzMo+plumRtNfuZQTHwpdpsNS
         lCQw==
X-Gm-Message-State: AN3rC/7LSXnSArzHr0UdrKII5uGpwFwx2QKeCwkG87tIjmC1oLAxKjdk
        g7U6DosdKU0BnTezgFQ=
X-Received: by 10.98.201.15 with SMTP id k15mr11132122pfg.14.1494006137562;
        Fri, 05 May 2017 10:42:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:aca8:b828:d7c5:8258])
        by smtp.gmail.com with ESMTPSA id o5sm13934414pfk.126.2017.05.05.10.42.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 10:42:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 03/10] Add some missing definitions to header files
References: <20170505052729.7576-1-whydoubt@gmail.com>
        <20170505052729.7576-4-whydoubt@gmail.com>
Date:   Fri, 05 May 2017 10:42:15 -0700
In-Reply-To: <20170505052729.7576-4-whydoubt@gmail.com> (Jeff Smith's message
        of "Fri, 5 May 2017 00:27:22 -0500")
Message-ID: <xmqq1ss38ako.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
> ---
>  object.h    | 2 ++
>  pathspec.h  | 4 ++++
>  refs.h      | 3 +++
>  tree-walk.h | 2 ++
>  4 files changed, 11 insertions(+)

As the coding rule of this codebase is not to include system headers
in anything other than git-compat-util.h which should be the first
thing to be included in the *.c files (cache.h and other selected
and well-known header files can be the first one in place of
git-compat-util, as they include it as the first thing), all changes
in this patch, except possibly the one to tree-walk.h, are wrong.

>
> diff --git a/object.h b/object.h
> index f52957d..9737582 100644
> --- a/object.h
> +++ b/object.h
> @@ -1,6 +1,8 @@
>  #ifndef OBJECT_H
>  #define OBJECT_H
>  
> +#include "cache.h"
> +
>  struct object_list {
>  	struct object *item;
>  	struct object_list *next;
> diff --git a/pathspec.h b/pathspec.h
> index 55e9769..ea18e24 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -1,6 +1,10 @@
>  #ifndef PATHSPEC_H
>  #define PATHSPEC_H
>  
> +#include <stddef.h>
> +#include <string.h>
> +#include <strings.h>
> +
>  /* Pathspec magic */
>  #define PATHSPEC_FROMTOP	(1<<0)
>  #define PATHSPEC_MAXDEPTH	(1<<1)
> diff --git a/refs.h b/refs.h
> index 07cf4cd..e9d19fd 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -1,6 +1,9 @@
>  #ifndef REFS_H
>  #define REFS_H
>  
> +#include <stdio.h>
> +#include <string.h>
> +
>  struct object_id;
>  struct ref_store;
>  struct strbuf;
> diff --git a/tree-walk.h b/tree-walk.h
> index 68bb78b..8b0fccd 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -1,6 +1,8 @@
>  #ifndef TREE_WALK_H
>  #define TREE_WALK_H
>  
> +struct strbuf;
> +
>  struct name_entry {
>  	const struct object_id *oid;
>  	const char *path;
