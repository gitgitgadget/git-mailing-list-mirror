Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566571F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfJRWHM (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:07:12 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42431 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbfJRWHL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:07:11 -0400
Received: by mail-pf1-f201.google.com with SMTP id w16so5665866pfj.9
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CqoEtDdZ3FaR07mhU2u9LlUGLLwWhccNS8PYh2EHu/8=;
        b=P34tqhAGYldATBg9eeTm5Oe1Oi7VNS1xOdeczn2+vUOkaLUWpZ5rKQXCBNQQPDlj+E
         zd+PVxanY3B6se0QJNfRvkBIXzOEUNlWxywGVjiL8g9pyeG/v1u4PL5zuFKV2WPm9NNk
         4/pFKqDpyzefYuhvL7wb+BpuDZj2hFAfpEknRw0rtMETaThqPNa7Ly7wLv43BvfCoxzI
         DyVeXvRXSCy1H2T/3VFjf7jH4YHoi1uIqrySNaow4JDAkmcNzqmtM+I5w90nJVltbTjN
         3PfoR4zM5mmohFbVN04v7mJk5PVDpibRtloGd36K6NrBYE9xbZH81G47wrFfJb0XRY2B
         djKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CqoEtDdZ3FaR07mhU2u9LlUGLLwWhccNS8PYh2EHu/8=;
        b=i/K637k5rYOVFWtGBllMWxm3k3umbAA2vuWt3cSamisB0/SiMjN7KfxCuRKQcE2n8S
         VpFGxaTiNMNW4pjJRC7xyvwLXPkd9aA243yMKTHsCbjrjKTzPATvSfuCJwTsFXID+m3c
         0SyUvCzjtqSs7QjEyOaB8HdcOF5dKcQMSHjewqWHg9ixGdoNnY2PenuTVBdUhyLWXF1u
         7gpumBOHNrsX6QZOGeNRuQVnLJ+F8E6pdEoj5OB5ZDuphLwFgnHM3O8HvTimKbcCzqYi
         gPHLGwZJzm31hADxXECcTNicuBy+VHUEXQ1uXE/bQmXSqgSM687bnufbc16YzLntDbA+
         gTpw==
X-Gm-Message-State: APjAAAWX0ZHFrHufh+GhIPppFQb6XGsSV34pbmd+xQMk10t4164czQt/
        7HZHnultJ76yPk6jl9ysF1HghKnMXhpq0yUStFki
X-Google-Smtp-Source: APXvYqyMms6s1t9y5hw1Pibc1ONG09pkBPs/9MnlMt0MSY6X7wDT2RX9kmLqp36W7PMPXEp3+1veH7QYN5oG2R+HueHf
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr12028311pgt.38.1571436429007;
 Fri, 18 Oct 2019 15:07:09 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:07:05 -0700
In-Reply-To: <2e42eafb5db6192829e9e206e9e9905b31f8e8a6.1571357219.git.gitgitgadget@gmail.com>
Message-Id: <20191018220705.241778-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <2e42eafb5db6192829e9e206e9e9905b31f8e8a6.1571357219.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: Re: [PATCH 1/1] config: add documentation to config.h
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, heba.waly@gmail.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Heba Waly <heba.waly@gmail.com>
> 
> This commit is copying and summarizing the documentation from
> documentation/technical/api-config.txt to comments in config.h

Thanks for this commit!

As for your commit message, as far as I know, the idea is to move the
documentation, not to copy it. Also, write this in imperative form,
e.g.:

  Move the documentation from Documentation/technical/api-config.txt
  into config.h.

Also change the title of the commit message accordingly, e.g.:

  config: move documentation to header file

Also, include the deletion of api-config.txt in this commit.

If you are doing any summarizing, describe what summarizing you are
doing in the commit message too.

> + * A config callback function takes three parameters:
> + *
> + * - the name of the parsed variable. This is in canonical "flat" form: the
> + *   section, subsection, and variable segments will be separated by dots,
> + *   and the section and variable segments will be all lowercase. E.g.,
> + *   `core.ignorecase`, `diff.SomeType.textconv`.
> + *
> + * - the value of the found variable, as a string. If the variable had no
> + *   value specified, the value will be NULL (typically this means it
> + *   should be interpreted as boolean true).
> + *
> + * - a void pointer passed in by the caller of the config API; this can
> + *   contain callback-specific data
> + *
> + * A config callback should return 0 for success, or -1 if the variable
> + * could not be parsed properly.
> + */
> +
>  struct object_id;
>  
>  /* git_config_parse_key() returns these negated: */
> @@ -73,6 +107,11 @@ struct config_options {
>  
>  typedef int (*config_fn_t)(const char *, const char *, void *);
>  int git_default_config(const char *, const char *, void *);

The config callback is config_fn_t so that documentation should be
placed above that typedef.

Other than that, this looks good to me. The result is perhaps not as
tidy as we would like (especially with some functions being documented
and others not) but I think, anyway, that a verbatim movement should be
done in one commit (this one) and improvements, in a subsequent commit.
