Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994681FD4F
	for <e@80x24.org>; Wed, 30 May 2018 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753691AbeE3Q17 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 12:27:59 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34635 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbeE3Q16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 12:27:58 -0400
Received: by mail-oi0-f46.google.com with SMTP id i205-v6so2319187oib.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pte8KxEAV6VftTgcJqA9AUjT7insiT974TxOcYu0i68=;
        b=uvWBtq4bWO8HoKj4CZQEfythFgqc2KVClyxEEALA+8Sq47bIe1A14zJsHubLj/sjso
         Hd6/MSILHbNfjRGqRW7w6JaQZ+LQvpqYZJXd2LJ3qP9Mbo/9momuA8+EIIuH2TmiWiIz
         BGQ2UyU4k8BrxSHLYelCYdpiU4LVMQxKD5IDMT7pchCSf3qdH0CBzif9bhGfM8w8vRt+
         mIaUHg2XNVnPYxrD7s6xxXCOg6kswC8KIzzkyblQ6Y0WLHJ7oNIbSEpSlApyZXJc/35u
         SCU6B0yHBrGL5AqdePPKJsSwo4Z6e7h0SeVBntx/EbbXelviizcjH6yInIRmrzWCldtQ
         gxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pte8KxEAV6VftTgcJqA9AUjT7insiT974TxOcYu0i68=;
        b=C+iRyi5CivSkAd/KkliQmySJYVshW2zQPbwZgCEin8X+lNv8V9QK9zX6ZvsrOjcEN1
         N2ZKXk4TUlgWwnFZivEAeHnI/+I23mrupgUCfEYWAwmccCR5a3tqwlHsBf6A3ouAPecS
         n7jXgTgmYXDD0H2RvaHhyh5bCQ/cx0cY3OAjT9k1NQA8DLs2RTHakLO1bQI0Ha7B+6Oa
         4yhtp/HsAXv5RsOXln0RSCs/K+wNs4KFSRZERPwxQOIt9e3S3wNJw0AyHN1sp2wKtWDg
         U5jCsVYp6O1JITNAXVyjatDgzAj2Bgbv/fXZAKqexmID+zriakDQdJvZAKwmD/RgiOBo
         ZHZg==
X-Gm-Message-State: APt69E0uXtDhXMcbRZpeKI4J7Xvule1WEISUgdti5oJL72/bdrEcFRT5
        U7l/SnGkYEDj3K0zBATKeby25E5m8HhsntxA3Jc=
X-Google-Smtp-Source: ADUXVKIfN51fG8lhLhfWwQ4Ncf0EZ3mFOjANsUjUs1QIB3W0oQVQf+xT6R2r/VyMtxe3ZJv+o6we5qEEpK90WvBml/E=
X-Received: by 2002:aca:2813:: with SMTP id 19-v6mr2051928oix.281.1527697677881;
 Wed, 30 May 2018 09:27:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Wed, 30 May 2018 09:27:27
 -0700 (PDT)
In-Reply-To: <xmqqy3g1d4xa.fsf@gitster-ct.c.googlers.com>
References: <xmqqy3g1d4xa.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 30 May 2018 18:27:27 +0200
Message-ID: <CACsJy8DW8e4rFWzzc4WxLRtK-WTAcG_BwFSxAya_fLfXOk9p8A@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #04; Wed, 30)
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 8:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * sb/object-store-alloc (2018-05-16) 13 commits
>  - alloc: allow arbitrary repositories for alloc functions
>  - object: allow create_object to handle arbitrary repositories
>  - object: allow grow_object_hash to handle arbitrary repositories
>  - alloc: add repository argument to alloc_commit_index
>  - alloc: add repository argument to alloc_report
>  - alloc: add repository argument to alloc_object_node
>  - alloc: add repository argument to alloc_tag_node
>  - alloc: add repository argument to alloc_commit_node
>  - alloc: add repository argument to alloc_tree_node
>  - alloc: add repository argument to alloc_blob_node
>  - object: add repository argument to grow_object_hash
>  - object: add repository argument to create_object
>  - repository: introduce parsed objects field
>  (this branch is used by sb/object-store-grafts.)
>
>  The conversion to pass "the_repository" and then "a_repository"
>  throughout the object access API continues.
>
>  Is this ready for 'next'?

I think so. Stefan could remove the comment "/* TODO: what about
commit->util? */" if he wants since nd/commit-util-to-slab is already
in next. But this is really minor and does not need fixing to land on
'next'.
-- 
Duy
