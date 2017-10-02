Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2556120281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbdJBXun (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:50:43 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:54831 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdJBXum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:50:42 -0400
Received: by mail-pg0-f48.google.com with SMTP id c137so3786801pga.11
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tSiCjKrGKtLDyLyBb/0meNvwVWXdwu1McbWISi++MJQ=;
        b=nt7xstDNxPpJvIVcCTvfrPN+QxQe8/6WAH9JEK+ygV36wlfMrf8QmMB0Zx9i6lN0Fe
         2VkEbC2RDzDnJxhCTjxNwjv39RkYg4cmNxaWkUhZonMVxAPqVEZO0WU/Qh7FiumbcJf5
         GHWl3HO5jZpZUj/bElqa2aELJsjAajGH22u9g11S1UFs+UlUDe3LTgZoiB3c7JN0JODU
         XJxQiUV7HAGqe9rNhYd1dUfnkKHplCWp0Bn6yF6Y7AbTgXEnVTURlqPoahqrJ7PDnPLL
         DOoA0hsBv8zdhhI8cg+cX7jQ/ZnFSL9KbKaTT0u32WTOaWmUnjsyjH1ttRSphJ1DHpFf
         0szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tSiCjKrGKtLDyLyBb/0meNvwVWXdwu1McbWISi++MJQ=;
        b=oxmay12fJWeky6MueP8W5I9CRaeQLGAM+Yav/m3MmRwvhvl5yC1n0VHUuhDcPzAqzs
         FInKqIjM1E2+mlOQqi1bYoEhlxY46yqG4QcjEu0Us7rW92Ui9cCMasO1DzJfPjBK+G82
         vcWKqNWFgQqsq/yyBgeXBIcZBkkggbe0aIpJha61TsKp03FVtDbpAIM51Cz9LtaZXpWa
         ehlxI/LELRdQ3DAnI/wrCo8BfEC0n4WnFuEBRN6PLqLrF4cqWDFPELGegKV5TqdgFcL9
         qNfL9N0RjlUhWJdbFWNFwdTfqRoGsdkSIvuk0d8fodqEqKU8/mZMzQG8rFaW+vDgYylR
         X4XQ==
X-Gm-Message-State: AHPjjUj2rmt16gSAIS2zstJVObWRwmHx/VkMpb1iTi6WQRipOuM6V9OY
        Xwuwfdxr5sxmxFrLVIKOBDRbCA==
X-Google-Smtp-Source: AOwi7QBPD4T0clvUL53PbHIq2VeHsGuRyL3Xs//qcE5MwIUTgGaCNPxGPlTjkRVdG2OVXauMEHqXQA==
X-Received: by 10.84.235.129 with SMTP id p1mr15181753plk.153.1506988242170;
        Mon, 02 Oct 2017 16:50:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:585e:6aa2:d831:b9e9])
        by smtp.gmail.com with ESMTPSA id l12sm17129483pgr.10.2017.10.02.16.50.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 16:50:40 -0700 (PDT)
Date:   Mon, 2 Oct 2017 16:50:39 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 0/3] Comment fixes
Message-ID: <20171002235039.GH5189@google.com>
References: <20170926112150.21850-1-hanwen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926112150.21850-1-hanwen@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/26, Han-Wen Nienhuys wrote:
> follow more commit log conventions; verified it compiled (yay).
> 
> (should I send patches that are in 'pu' again as well?)
> 
> Han-Wen Nienhuys (3):
>   real_path: clarify return value ownership
>   read_gitfile_gently: clarify return value ownership.
>   string-list.h: move documentation from Documentation/api/ into header

This version looks good to me.

> 
>  Documentation/technical/api-string-list.txt | 209 ----------------------------
>  abspath.c                                   |   4 +
>  setup.c                                     |   3 +-
>  string-list.h                               | 192 +++++++++++++++++++++----
>  4 files changed, 168 insertions(+), 240 deletions(-)
>  delete mode 100644 Documentation/technical/api-string-list.txt
> 
> --
> 2.14.1.821.g8fa685d3b7-goog

-- 
Brandon Williams
