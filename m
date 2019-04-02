Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20FED20248
	for <e@80x24.org>; Tue,  2 Apr 2019 15:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfDBPj6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 11:39:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33689 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfDBPj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 11:39:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so17283011wrp.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dOV/oOfHB7AU234C/k5hyZF5nFh98y+bJLGBoKD91H4=;
        b=REMSDRUX+Gz8RMWQrmcEjwQQM1IFZdwx0llY4G0YOVbAqR6RpIWQD0AE5+pOMAZ4Kb
         xd6CasRA5Jd9gCznT9xPC8bRlQB/6TwhNQrgCrpNi/2ya1rhK7ctmXivZY42OyNG24UB
         7urgR2tUn7EmbzjPzxqhkfecN3tilHeGvZt5zGgVG6xYP/CTRmJk7I0/kcPTD+3TXwF1
         b0KIMKwOo4r2dB9TBWcW+hIFFDhDDmGtKLJmtcOSnQaPQ86lVlwXuX9P5ermqGexGu3L
         ffvml3vqIj4aR+EFYifo4n9BfeRHY4O8FG4Tdi1poRuQCNpd/QS9rWFpFW4uIrGv0GX2
         WrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dOV/oOfHB7AU234C/k5hyZF5nFh98y+bJLGBoKD91H4=;
        b=Rv3TuFCu1L5M5/IZAhxutMRMwcMSUVaHuPpsv4z6i8NuY+tO/zNTXqDVYhFyhKYNro
         suN1ov7j+hEaUUk6HkAUjWDg5ydOCHNIgEEqEKhEgWwBbnVFk0pKtoSm+/c/1HC//nz0
         RzIKzA0/SsamDQuc10XhQit0gW3vYjWoxhhD6+/Fy8p3oL1mW/uELEQShBOx5eBV96Es
         IzO1oq+GmM1e0L8ONGR/lzMLOaDkoiu920++L7ZmmH44+tbI0Hv37jTbVC5jDWFrZVrs
         D3zns6xctpjMJCy94kqmhnxOuZo5I4yQ7GTaQ6KayYwbIL98KNQItm4HJqMpqS8Xy8y3
         2BDA==
X-Gm-Message-State: APjAAAUXTajJyl8CkI2MZ+pG2YLC7+FTvTt2JV74vBXzKAf5CYY6RWtd
        UiavtvpLeysZMkSLHxt06zw=
X-Google-Smtp-Source: APXvYqzPF+AnkZ31cgwQ3a1a9StmlVXiQG0qroBWABmrd42HnL80gSyHIoze0twXQjpDtCaB6LVliw==
X-Received: by 2002:adf:f984:: with SMTP id f4mr42538477wrr.97.1554219596546;
        Tue, 02 Apr 2019 08:39:56 -0700 (PDT)
Received: from szeder.dev (x4dbe364d.dyn.telefonica.de. [77.190.54.77])
        by smtp.gmail.com with ESMTPSA id l23sm13078096wmj.10.2019.04.02.08.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 08:39:55 -0700 (PDT)
Date:   Tue, 2 Apr 2019 17:39:53 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/31] commit.c: add repo_get_commit_tree()
Message-ID: <20190402153953.GL32732@szeder.dev>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190330111927.18645-10-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190330111927.18645-10-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 30, 2019 at 06:19:05PM +0700, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  commit.c | 5 +++--
>  commit.h | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index a5333c7ac6..f0a5506f04 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -340,7 +340,8 @@ void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
>  	}
>  }
>  
> -struct tree *get_commit_tree(const struct commit *commit)
> +struct tree *repo_get_commit_tree(struct repository *r,
> +				  const struct commit *commit)
>  {
>  	if (commit->maybe_tree || !commit->object.parsed)
>  		return commit->maybe_tree;

By renaming this function this patch triggers Coccinelle and
'commit.cocci', as it specifically whitelists get_commit_tree() as one
of the few functions that can legitimately access commit->maybe_tree;
for detail see 279ffad17d (coccinelle: avoid wrong transformation
suggestions from commit.cocci, 2018-04-30).

Please update 'commit.cocci' accordingly:


diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index c49aa558f0..55679cbbed 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -12,7 +12,7 @@ expression c;
 
 // These excluded functions must access c->maybe_tree direcly.
 @@
-identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
+identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
 expression c;
 @@
   f(...) {<...

