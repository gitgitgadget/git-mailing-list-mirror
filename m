Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB7D1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 01:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeKEKjW (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 05:39:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36546 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeKEKjW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 05:39:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so6425552wmf.1
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 17:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=m5kGwcwosQNB7ms3V9oKbgitoHGp4wxowJUbcFTG0Ig=;
        b=Tc2/MQfyvLi8o67s0bJjlMp37CeMQNgRdSJymCgLz8PT5j/opQHo7QcKEcNCQoInea
         e3pJ5apCpBLORbxEsQi7oW6opqzdNmjQBnCWs+WKXDF3eyEJT58kYsSeZT/DdlkGHzYE
         3gPXLv6IZj0uo1L3WcRndlGCyLr8XEfFPVYH9k2mENBOHnka4A+KSvMj/yJuFoH4e8vC
         +T+gjJp934mmX+Zc4HCIlrtmVhZnwNFGaKtkAKE+s3blgByjgN+YmbO/vaQ8emKYQYGa
         pE01hXQazaIdC7cSUgrucG6jpiIq7v4T+g7av0poa0JohiWi/QYIvh5Uedl792mcTEno
         oWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=m5kGwcwosQNB7ms3V9oKbgitoHGp4wxowJUbcFTG0Ig=;
        b=nVqKmQNNUkLXGQFQXebUJ+IdM6Lvbf7YT5KhNB5sI5dpLlENhzpazpcG9CRQHM5L8T
         6asGNZIKSEtHOMEUQWXlLdwGF93ZPsas2rPTM0NoQ1uz1MKhl2Zf08bAXap37AOKF80r
         wo0Nd65/mIuREyrnA/jwnVG+HSip87xuJSdq2TtwzJ04GOoZn619RkI7XsH6kU1zyP+3
         AZIsh4xJ0ZgasiMujyPfm10P5ZragxtPgucHV3YLl9EzxafgA39OZs5+5+h+l7ZGlhE/
         bIETYz0e9LNtWbumMgXayiX/UYWQRE6ac9RpMG0BSQEAN/MTvAGPrXOZWscsqSm6qeVZ
         xVTQ==
X-Gm-Message-State: AGRZ1gJ+GNSCKNZzkyuveS+RpOQue6PQnT3CQw8/Cluj0cZBJ1zp/tek
        Eya+g+aCUlx8L8m8ou6lbi4=
X-Google-Smtp-Source: AJdET5ep4oQ/0UN0ebzKpHIIfNWLnT2JYInNXE2x9yanRpE43dtCWwNT8kie5WASPhkv/A9hWkSZFA==
X-Received: by 2002:a1c:154a:: with SMTP id 71-v6mr4202088wmv.83.1541380935953;
        Sun, 04 Nov 2018 17:22:15 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t198-v6sm50694484wmd.9.2018.11.04.17.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 17:22:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] git-worktree.txt: correct linkgit command name
References: <20181103051418.13697-1-pclouds@gmail.com>
Date:   Mon, 05 Nov 2018 10:22:13 +0900
In-Reply-To: <20181103051418.13697-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 3 Nov 2018 06:14:18 +0100")
Message-ID: <xmqqftwgl3ne.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Noticed-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  On top of nd/per-worktree-ref-iteration

Thanks.

>
>  Documentation/git-worktree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 9117e4fb50..69d55f1350 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -230,7 +230,7 @@ GIT_COMMON_DIR/worktrees/foo/HEAD and
>  GIT_COMMON_DIR/worktrees/bar/refs/bisect/bad.
>  
>  To access refs, it's best not to look inside GIT_DIR directly. Instead
> -use commands such as linkgit:git-revparse[1] or linkgit:git-update-ref[1]
> +use commands such as linkgit:git-rev-parse[1] or linkgit:git-update-ref[1]
>  which will handle refs correctly.
>  
>  DETAILS
