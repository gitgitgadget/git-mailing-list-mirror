Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1AA1F462
	for <e@80x24.org>; Wed, 24 Jul 2019 23:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfGXXc6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 19:32:58 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48448 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbfGXXc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 19:32:58 -0400
Received: by mail-pf1-f201.google.com with SMTP id u21so29569511pfn.15
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YhGYs3DXWq4zIhtc/jtiupG381LyCYoqOk9Ukdf9S9A=;
        b=s4in41SY3gDrjpWqg9hwuDxVKtNzvK3dTKic2LibnVMhKqnNl61OwAaJxDpTB6UV/k
         +zvhkPQay3PBsbCuS0qp8U1c6z7J/RWhQdds7SerXOpNE23yVA9qWQl53SX4VhGswniT
         RbFu1Xvc7jG/5bUzk9u65ETvXwngoyH3EXq3oad0WKmgu7bybZ9O+aninNjqTrapxEwm
         RDln9U5HLXnHH9L2PxvmtanCzITe1DtBb+ebwPPY9z6mDLJnPuYN9JjY/RZgOAfhBGZX
         MEkfeG7XZcS+enUD0DlrTtkJkW+gWdKBdzN7HBfOfH7POuceuYcdoVd9FDHZ0LevlRGT
         KSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YhGYs3DXWq4zIhtc/jtiupG381LyCYoqOk9Ukdf9S9A=;
        b=nw1ZLn+jL8JQDN8c0nLEFNC7iTh2MdtUyFgbVPfjFOIJygNiES6gp2NB/OmK5wtzp2
         aiGbHJVdL4rkJrK/3q8PlLcE+drh54SvQO1nT9YmXf+2FJ26a8qxIPpeVRnVXcWB1nng
         oCghwV1b3Gv4rYMvP3n7yuFD7+ECxKIVDLeWvdkv68BOKcjckQx7qJzkFlyE9DxO6TQG
         1cZs18m/qKVFfq1xVKLXuePYoioKKFI2oCybsxRaEOs8rl3IvjC7Xnszt8JQTBg6jeT+
         1SmP52dMR3+UognyXdgjKHYBu/p6yOQLfecSWNs1kZFZDMQd7ocVIwjq4BTExhQcTQ99
         zFtQ==
X-Gm-Message-State: APjAAAVgzDv+TxpXGMFHIXrDix+Q/j6sjWXUTQl21AGfW82YVPEFjI3n
        O3EMDYx+CPrmW7JtiMIuHxENydeeeTroNmZ5Clet
X-Google-Smtp-Source: APXvYqw1eSwbXMK2yx5q20+5r0qybb2+2GNZDZbdUK8PpPNComwujzOhEqAq8FpgtIWt4hZ5sOGWEgCQDmb3sXxm5q1A
X-Received: by 2002:a63:c03:: with SMTP id b3mr19395327pgl.23.1564011177037;
 Wed, 24 Jul 2019 16:32:57 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:32:53 -0700
In-Reply-To: <20190701201934.30321-1-emilyshaffer@google.com>
Message-Id: <20190724233253.208318-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: Re: [PATCH v3] documentation: add tutorial for revision walking
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks - I think this is a useful guide to what can be a complicated
topic. It looks good overall; I just have some minor comments below.

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 76f2ecfc1b..91e5da67c4 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -78,6 +78,7 @@ SP_ARTICLES += $(API_DOCS)
>  
>  TECH_DOCS += MyFirstContribution
>  TECH_DOCS += SubmittingPatches
> +TECH_DOCS += MyFirstRevWalk

Any reason why this is not in alphabetical order?

> +Also add the relevant line in `builtin.h` near `cmd_whatchanged()`:
> +
> +----
> +extern int cmd_walken(int argc, const char **argv, const char *prefix);
> +----

builtin.h no longer has "extern", so we can delete it.

> +Add it to the `Makefile` near the line for `builtin\worktree.o`:
> +
> +----
> +BUILTIN_OBJS += builtin/walken.o
> +----

In the first line, change the backslash to a slash. (The line in
Makefile for "builtin/worktree.o" uses a forward slash as expected.)

> +NOTE: For a more exhaustive overview of the new command process, take a look at
> +`Documentation/MyFirstContribution.txt`.
> +
> +NOTE: A reference implementation can be found at TODO LINK.

I think you have a reference implementation at
https://github.com/nasamuffin/git/tree/revwalk?

> +We'll start by enabling all types of objects in the `struct rev_info`. Unless
> +you cloned or fetched your repository earlier with a filter,
> +`exclude_promisor_objects` is unlikely to make a difference, but we'll turn it
> +on just to make sure our lives are simple. We'll also turn on
> +`tree_blobs_in_commit_order`, which means that we will walk a commit's tree and
> +everything it points to immediately after we find each commit, as opposed to
> +waiting for the end and walking through all trees after the commit history has
> +been discovered. With the appropriate settings configured, we are ready to call
> +`prepare_revision_walk()`.
> +
> +----
> +static void walken_object_walk(struct rev_info *rev)
> +{
> +	rev->tree_objects = 1;
> +	rev->blob_objects = 1;
> +	rev->tag_objects = 1;
> +	rev->tree_blobs_in_commit_order = 1;
> +	rev->exclude_promisor_objects = 1;

Optional: I think we should not bother with exclude_promisor_objects. If
the user really cloned with a filter, then every object would be a
promisor object and the revision walk should output nothing, which is
very confusing.
