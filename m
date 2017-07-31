Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0AC1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbdGaU24 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:28:56 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:37532 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdGaU2y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:28:54 -0400
Received: by mail-pg0-f52.google.com with SMTP id y129so142563793pgy.4
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q4VtPWheSDM4j1mIOqU6iZgLGmoyswJnlyV2N16z9fY=;
        b=ankdBU0UHTj7Npaa3Of8IPFCWPvrDvSzKRU/Jh3Xv6ZbznFB54kURPG1zL+myOcPR1
         KBXgOyw78PliGW0M6Bh3tFOXSZaYcwZpBT0wCYsyIWHJuhIA0JwNJe1nxxp9B0SC/4Nr
         LGrAlJNNShvAOgvhworm0qy2Nz6Oa+5r5Uf0C5ZE5CqzIy/UlzlC99f9zIcSwwculVJo
         GR/bnwciZAKFqWjC8+0BL4AZZPw9SNBsh42lq8Jt9VSr+8gShr7+ebB52JP/u2ovo+nE
         qOCiTAeSOeiDtLhDvsQFYoKBalcUvskjGmP1WQkI0aLuaHbCh45MID1HYVGcyf+XDxtt
         cKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q4VtPWheSDM4j1mIOqU6iZgLGmoyswJnlyV2N16z9fY=;
        b=d9rYvyrBmES6oP169eU0iIBV+rzRVp6p/eGMT35jL95hkoa+awDxuLlhHoybibkvZr
         bKVcAHrc3HENtaz0oKnqZiYG86U2wXRoZrEgLDcTgp0/dbUM/MiAh7fr9CEAUDv3WkU+
         avE0DQfHRsv01Dg9YDGe7GmXj8uUNiS7d1l2ENTdxyjffKZXkDSZkJm28cz2jNgpoM9O
         36c8uE1CaK/53GoyPGerPBVDUAPXFm+NFG622lO1DKz9YGbfXK0RqJPVjKEIcgYI1z3Q
         GZzlOwClparNrni9MI1nJRKeB4cdBceJehj6QpebkDNyTQ5RZnY/H7Mg7qFZVhutc/59
         lUaQ==
X-Gm-Message-State: AIVw111jT7t9Tne+P9TTaO9fN6s26nsL+aWjs0tD3U1ZdHIl3gJeL2FZ
        YZ27X8CqzRY0JUF9
X-Received: by 10.99.122.20 with SMTP id v20mr16995446pgc.342.1501532933729;
        Mon, 31 Jul 2017 13:28:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:e129:2029:93fa:b589])
        by smtp.gmail.com with ESMTPSA id 79sm54234742pfn.51.2017.07.31.13.28.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:28:52 -0700 (PDT)
Date:   Mon, 31 Jul 2017 13:28:51 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH v2 00/13] Update: Week 10
Message-ID: <20170731202851.GA181489@google.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170729222401.12381-1-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170729222401.12381-1-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/30, Prathamesh Chavan wrote:
> Thank you Brandon Williams <bmwill@google.com> for reviewing the previous
> patch series.
> Also, I'm sorry for repling late to your reviews. The main reason was
> to give sufficient time to prepare the next version of each patch as
> suggested.

No worries, things take time.  That and I was busy most of last week
anyway :)

> The changes made in each patch are enlisted in the patch itself.
> 
> Complete build report of this work is available at: [1]
> Branch: week-10
> Build #142
> 
> Also, I have push the work on github as well and can be checked out at: [2]
> 
> [1]: https://travis-ci.org/pratham-pc/git/builds
> [2]: https://github.com/pratham-pc/git/commits/week-10
> 
> Prathamesh Chavan (13):
>   submodule--helper: introduce get_submodule_displaypath()
>   submodule--helper: introduce for_each_submodule_list()
>   submodule: port set_name_rev() from shell to C
>   submodule: port submodule subcommand 'status' from shell to C
>   submodule: port submodule subcommand 'sync' from shell to C
>   submodule: port submodule subcommand 'deinit' from shell to C
>   diff: change scope of the function count_lines()
>   submodule: port submodule subcommand 'summary' from shell to C
>   submodule foreach: correct '$path' in nested submodules from a
>     subdirectory
>   submodule foreach: document '$sm_path' instead of '$path'
>   submodule foreach: clarify the '$toplevel' variable documentation
>   submodule foreach: document variable '$displaypath'
>   submodule: port submodule subcommand 'foreach' from shell to C
> 
>  Documentation/git-submodule.txt |   15 +-
>  builtin/submodule--helper.c     | 1186 ++++++++++++++++++++++++++++++++++++++-
>  diff.c                          |    2 +-
>  diff.h                          |    1 +
>  git-submodule.sh                |  394 +------------
>  t/t7407-submodule-foreach.sh    |   38 +-
>  6 files changed, 1218 insertions(+), 418 deletions(-)
> 
> -- 
> 2.13.0
> 

-- 
Brandon Williams
