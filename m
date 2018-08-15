Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13CB11F404
	for <e@80x24.org>; Wed, 15 Aug 2018 05:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeHOIWE (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 04:22:04 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:45919 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeHOIWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 04:22:04 -0400
Received: by mail-pl0-f47.google.com with SMTP id j8-v6so60942pll.12
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 22:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVyy15sE361TOnER8VXrJ46paDz+u1ZmUl5yDJCwAEY=;
        b=H9cOgKIFZEQnQM3M4aUb+OFgz6YeJi/WgSoHYZs0aaA1nk9UYFmA28td2wqIZREH9w
         v8xqFGQsam3x+GjBOkVugnlu2Ek8pYzhZOxnW/IVfLiIEYhQf50FQOLxZHwVGuPxIvB9
         +bMtlwXZMJTKXNGAuHHeBDgA/FsQBF64K7RhtNwUSUmojqe2Fm2qQCCNnn1uL2Amdthv
         r7yG5ifnCQw5K/awP62uxnuH491pRWrk1jc4XUQcGUqCvCA3lZV6u099Cn5AcHcxlU3p
         dpuWJYyJhpdhoLgjWZ+JC4k+QBxlveL3wXRPiF9wNtJddR2VGBTTmDjumyraGwEvbdk+
         PQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVyy15sE361TOnER8VXrJ46paDz+u1ZmUl5yDJCwAEY=;
        b=IQlYCCohHokxZosChXx7H6q74OvmYqmnCp2ATid3zvB1W3T22HXgwzfEniIduKP5Uj
         MK9CkHZi9Cm8Wg5IkR2TA8zIq1bPlksRGAKyV3hC8kdbRE79Yrg3wuGtE0MWNL7nq16P
         6B5cV7qQ4AzgugzjkQi8n4mDUl5eM8Ym5eOcqSsHmFVdbkNDiLyjs17LHTy0ZPE20vZi
         VXjJL8iRSoKCWdM//4ZTq1Z0hG1DkhOBBOI6QN91CR1jdidcdczzdQr3qucUD2coGiCP
         LoLAwmcwhdbxJ6bE+Knfkx8RoPd62MLl+aIy72ud/h01c7jyjbHw2Qm2qdEixQdckDM4
         U+2Q==
X-Gm-Message-State: AOUpUlFjW+vXPkpbdkHDu5WeqsxZ2h+V9rpay9ginpuDX/iI3O3KaHjW
        JWsTPFioD0hvhOYkmsnslio=
X-Google-Smtp-Source: AA+uWPxdeIOc+yEH6xXGaeWXeDTeXWKcG8Ks4aj3SIMgnpg17p1pMOk6/W3RYRsUVa/VrQYJI5QK2Q==
X-Received: by 2002:a17:902:8697:: with SMTP id g23-v6mr23000124plo.292.1534311084523;
        Tue, 14 Aug 2018 22:31:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y72-v6sm24515872pfg.10.2018.08.14.22.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 22:31:24 -0700 (PDT)
Date:   Tue, 14 Aug 2018 22:31:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCHv3 6/6] Add missing includes and forward declares
Message-ID: <20180815053122.GH32543@aiede.svl.corp.google.com>
References: <20180811205024.11291-1-newren@gmail.com>
 <20180813171749.10481-1-newren@gmail.com>
 <20180813171749.10481-7-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813171749.10481-7-newren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  bisect.h       | 2 ++
>  pack-objects.h | 1 +
>  2 files changed, 3 insertions(+)

Do you have more context about why these are in a separate commit?

For pack-objects.h, I think you might be making a fix to the
cc/delta-islands topic.  But for bisect.h, I don't see any recent
relevant changes.

Curious,
Jonathan
