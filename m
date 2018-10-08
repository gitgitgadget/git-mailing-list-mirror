Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DDF81F981
	for <e@80x24.org>; Mon,  8 Oct 2018 22:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJIFfO (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:35:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46445 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeJIFfO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 01:35:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id v5-v6so10654875plz.13
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/UmmR4AliGJpO1kCC5QCxV0OSgNljiF9KIsgMarL0o=;
        b=IzdO477BZl/U++iR6GW+Lqglhy6svoTpB0Upz1fU2iCFbtOJwWK8xzydVlo3b1sfWW
         XCwnrU2QDu3VZd0r+wL8+hmIAZpxSgTjkUgN+kH/nSDjouTNQkLi+6YurH1lP4pbw/ye
         hCcF7/9FZ7YE+b72rhHpc8wufxfZ7tNvRPa7m1+8/QIsUEvPilO5Wp1UzFMLh+P3SPBM
         YdpiuYnhiUYuUuTxllYTPJH5sh+4yATIMpourIswO+JGsZamZsRnycZ1Fj4yOuhPDb92
         q4NuK5TF5ksjUNYjhTKgN2FwUjG6MARTJLUAwqDPUUO+nvzf7pPU8KwRyVqXIzHlb2xe
         gvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/UmmR4AliGJpO1kCC5QCxV0OSgNljiF9KIsgMarL0o=;
        b=pT5VLiA5JAap4oLZO0C/Hp/x00y0pUuN8i0vnC24DogLUxFuWfB97UNjXgsN+xC8S8
         e844x6wDYPQPO6WPGortTULjQeB7cjvPlLt6TQlofwcj7Fn2vw8YLxdBhRirXtTopgSw
         q2FA07B5BrJoUupXNZ/lxxyyhue6Ne5+U+2AtRGaP9CuH4KLCyyT3+l8RobDnFq9PH24
         3XsabJmbKlltd7rYxEeFeLTHlTjD+g83s/eRRwFivV2WmIee0gS8Qc+ATPFhGjKZNznW
         GNSQ1fusf2R1Q3eB5JWyaU1ES1nmkWDTltaF/xVo7a9Px+MZctaVBgp45MNQlodZfhdC
         y6vA==
X-Gm-Message-State: ABuFfogbJdDDDJ74h33oUTqXGxfhjnCY0vMN0QV6opqVZjf4MBiQHX02
        k42SyPcIU5tzWy6RLyAg0qqo1w==
X-Google-Smtp-Source: ACcGV60gpch6uQmxgF8s4mFd5fZyMF9GAoH5fGgX9fGdCvwE/JNkCzM//FskQYIQx6vtJyuCd+jF2w==
X-Received: by 2002:a17:902:722:: with SMTP id 31-v6mr25387789pli.207.1539037280359;
        Mon, 08 Oct 2018 15:21:20 -0700 (PDT)
Received: from localhost ([205.175.107.112])
        by smtp.gmail.com with ESMTPSA id r22-v6sm51858777pfd.174.2018.10.08.15.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 15:21:19 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 8 Oct 2018 15:21:18 -0700
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] EditorConfig file
Message-ID: <20181008222118.GA26078@syl>
References: <20181008220353.780301-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008220353.780301-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 08, 2018 at 10:03:51PM +0000, brian m. carlson wrote:
> This series introduces an EditorConfig file to help developers using any
> editor set their editor's settings in conformance with the Git Project's
> settings.  This is helpful for developers who work on different projects
> with different indentation standards to keep their work in sync.
>
> Changes since v2:
> * Add .pl and .pm files.
>
> Changes since v1:
> * Add notes to both .editorconfig and .clang-format that they should be
>   kept in sync.
> * Add commit message line length.

Thanks for both of these. I think that v3 is ready for queueing, if
other folks find it OK to have an .editorconfig in the repository.

Therefore:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
