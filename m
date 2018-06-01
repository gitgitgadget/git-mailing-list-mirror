Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3863D1F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 11:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeFALjt (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 07:39:49 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:38171 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeFALjs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 07:39:48 -0400
Received: by mail-qk0-f182.google.com with SMTP id y4-v6so1429113qka.5
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=8c/XDkbng6s3GM2kazUUuVjOBM7ntdpAAAPabos/EMk=;
        b=Qv3+3EIrN2jL30UCY/3EmO3NmEAsqRtRII1KcXDmsJMhf/eqpvUNXjCW3W+rMmwwl0
         Jnpsa8YzcbODYXeDM1Tinik7GHdmas4XPuY8P4P8Gg/CdytGWNvHBuWtvbVJ/tHX1MkR
         EJrtPnn0hIRNL4taJ3RjjrYQCxBKjVgfSdflD74c5V9bRCooY5gtwjBrnBo6klermFJV
         VKzNLl/U3wM1638ec0XjOriplFskyRXbzFRd6AzJzB/9eP9pexrskLuNcRx/kpTSruf6
         91JhjqU0OiPWJ46FeF+HDc+1azbd/gBahNa9WqDLRjuMlWz5UOnEXvfq8VQrD/SH4m0h
         iYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8c/XDkbng6s3GM2kazUUuVjOBM7ntdpAAAPabos/EMk=;
        b=uFdk8iiecJWij2hw8R4v+1Bkf+B2c5xRPnLr6T8HzgpagHv2vCqphzx92FEC8ESCB6
         eiyLRrgKOoKug+0Y8h74RQd/z+jgCYIy/OH+59PQo5fFY54O18bOmdS8b5SWm9Cbzyqn
         mMKZ6zfQ13+vXeRrTD/vGhJuupu0GKyqWwxXvJlReaslAqDyLTpiRrsPYAyhxI/J5oLo
         ADvDqJACP1qr55dlQlbptxVc6U2SAcXpre/AbJHOLRiY+6JhgNPq5jfo19GbvZptp9+o
         6+O7vXLfrLLCr4K65f9VM/irw2KLXYAfF0mT8Ft0u4643BCfAcb3UhxaiRVbXaLzcroB
         GmeQ==
X-Gm-Message-State: APt69E18miccOJm98fey4dSyR6Xdr84dTen1K/XlBgFujyyEdW9c+KuY
        eKYbfy1FveMl/zbDtRumqr3m6IAZ
X-Google-Smtp-Source: ADUXVKJ4Q42yRKdHCP2YplMQZnmEAzs6kaXV/fQltvZ9QAKyP4uoNw7s495TP+5RyOXp54paxfgogA==
X-Received: by 2002:a37:5445:: with SMTP id i66-v6mr9238780qkb.392.1527853187357;
        Fri, 01 Jun 2018 04:39:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2cb8:1b85:8d36:d4f1? ([2001:4898:8010:0:15ee:1b85:8d36:d4f1])
        by smtp.gmail.com with ESMTPSA id t14-v6sm9565080qtp.65.2018.06.01.04.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 04:39:46 -0700 (PDT)
Subject: ds/generation-numbers (was Re: What's cooking in git.git (Jun 2018,
 #01; Fri, 1))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqa7sf7yzs.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4a7c6695-52cf-46a1-5a21-bf2e03a85f6b@gmail.com>
Date:   Fri, 1 Jun 2018 07:39:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7sf7yzs.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2018 3:21 AM, Junio C Hamano wrote:
>
> * ds/commit-graph-lockfile-fix (2018-05-22) 1 commit
>    (merged to 'next' on 2018-05-24 at 3d12a02b0c)
>   + commit-graph: fix UX issue when .lock file exists
>   (this branch is used by ds/commit-graph-fsck; uses ds/generation-numbers.)
>
>   Update to ds/generation-numbers topic.
>
>   Wait for ds/generation-numbers
>
>
> * ds/generation-numbers (2018-05-22) 11 commits
>    (merged to 'next' on 2018-05-24 at 56fc38a1b6)
>   + commit-graph.txt: update design document
>   + merge: check config before loading commits
>   + commit: use generation number in remove_redundant()
>   + commit: add short-circuit to paint_down_to_common()
>   + commit: use generation numbers for in_merge_bases()
>   + ref-filter: use generation number for --contains
>   + commit-graph: always load commit-graph information
>   + commit: use generations in paint_down_to_common()
>   + commit-graph: compute generation numbers
>   + commit: add generation number to struct commit
>   + ref-filter: fix outdated comment on in_commit_list
>   (this branch is used by ds/commit-graph-fsck and ds/commit-graph-lockfile-fix.)
>
>   A recently added "commit-graph" datafile has learned to store
>   pre-computed generation numbers to speed up the decisions to stop
>   history traversal.
>
>   Will cook in 'next'.

On Wednesday, these were marked as "Will merge to 'master'" What changed?

Thanks,
-Stolee
