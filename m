Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BE71F516
	for <e@80x24.org>; Tue,  3 Jul 2018 07:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbeGCHSk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 03:18:40 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36479 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeGCHSj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 03:18:39 -0400
Received: by mail-yb0-f193.google.com with SMTP id s1-v6so346022ybk.3
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 00:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+AkpPT2uQ/0ABlMScDZc8ROjZsq/6rlFFRBKpXy02M=;
        b=JwPGQc5FFPdW693sypUOdEP0sbxS5Gj7gehgrsOHZpxpUDwbB+Mr8bAu/mknnxH5/m
         eDiDxA5p+VN7IJ805b7JmTxatatkWXsbkLGxi4jvjukCZ0+rpzzAWLo2iygzL4TqQ2EH
         NN02ibcq4jfMdVDTMN2V5U8QSe4nrXwRpI4vbGHrKwwRz4buuJ0EAf/XM0jBWAbMWnO+
         l18EGSUMKHOsinx3WM1MJ/Lmjb6eTG/EsSYsx8Ovm93Xb3Kw7HVbzy+x0pnowUQKZZ3i
         Ld8JBjiaDNxfKqokXBhSxCTf//aSOblFFyWxjEJvA87zUDf+Av3vve01qCuaNHhD8LSz
         v4mA==
X-Gm-Message-State: APt69E3hmBhWCbLstuteOy3ZyEl1bylEkXkzBVGK3NfltfPdDlRt2xp+
        x7U83FVi6UeKwVd5gnK0QJ4TOGsFnwmnAFUZnOegUg==
X-Google-Smtp-Source: AAOMgpc1NJdhq2XsEwr6GhWR26IVmm2rc0GgT8/AxUTX0wuu7AiFHYBEnmvzXfE4WM52CUhl6d5bwLbkanQANqTz9tM=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr5388315ybf.287.1530602318851;
 Tue, 03 Jul 2018 00:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180703035802.24060-1-jyn514@gmail.com> <20180703035802.24060-2-jyn514@gmail.com>
In-Reply-To: <20180703035802.24060-2-jyn514@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Jul 2018 03:18:27 -0400
Message-ID: <CAPig+cTf3iUSuopwKj_8OC9qf3kpD9=_Aika+_Xb-_kt1TxgPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ls-tree: update usage info
To:     jyn514@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 2, 2018 at 11:58 PM Joshua Nelson <jyn514@gmail.com> wrote:
> show [tree-ish] and [--] as optional
> ---
> diff --git builtin/ls-tree.c builtin/ls-tree.c
> @@ -26,7 +26,7 @@ static int chomp_prefix;
>  static const  char * const ls_tree_usage[] = {
> -       N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
> +       N_("git ls-tree [<options>] [tree-ish] [--] [<path>...]"),

You lost the '<' and '>'. This should be typeset as:

    git ls-tree [<options>] [<tree-ish>] [--] [<path>...]

And, as Elijah noted, Documentation/git-ls-tree.txt needs an update.
