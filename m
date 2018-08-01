Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88AB1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 20:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbeHAWcT (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 18:32:19 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:33123 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbeHAWcT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 18:32:19 -0400
Received: by mail-pf1-f179.google.com with SMTP id d4-v6so8224082pfn.0
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=x5pnd1nyEkQQ7jvL27/7TFsxIbF3FyxwmdAp8gI+TfM=;
        b=BpEk/XgFi+NL2jdHs0QP49wYhUMr8dTVRga8325NNVpHRKWipkWX/O8R4Ot0NEPJYw
         YN8WZepEacAG6ReZq+N0iA8kRseHY/wepzz7vEdrkRePq5N2/Sywxv40BXpTX9ccPJDF
         Id7siW/aBgKwTl2StcQfqLod8WGf+r+SiR62AwaBfoZ9KSGLfeTvsHMohXjDFAcxbzAt
         VAwsUTXKa1d51L1Eo95IPf2ruPIWoyqyOMnPLk7Nu9j3DlxYkqgiMfdQUPKwAl1RR9Zq
         7oh0Qmd8iqEj4VCMsACTRaSYmxMd94tjdELnN7ZAhnIb+bStcJmbhxdFTtzJZxKpRZyW
         Zq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=x5pnd1nyEkQQ7jvL27/7TFsxIbF3FyxwmdAp8gI+TfM=;
        b=N6enPT1i86evm7U0lLtOYcwz8MS8BBzlqtI9Ze+pxH4caLvQn1aUk2E4D5r1U93rlY
         PR9HcqQEl3iulS8B8PrgkhKErnJ9tdGHThkBsbeFzMrNoaU3ysdqw7Ukrpl0AvekJvgF
         BU4hhHBNT1qx66uDtVEn5aKQ8h1wEFHnWiUY7bHb9Q7DxQy4JhSGO2onRTwF0RSHGL7a
         JQ+e5lv3l2nEkFsgKP7FqD680HWYHvyVIwnjReVhBJ3CiLyCTSg7BRQ778Pq1/CW/vaK
         SyMnV/NnHd21ZBUQcz0iBI4c+AJlJfNFLYrLK2vmRGYDkjMkRsJdq2W2rO66vT5PEDhP
         X96w==
X-Gm-Message-State: AOUpUlGeEIGKeJXlhIMtP2i5yyGoGE16LnoKzlMPqfJLhEAqza9Jpkx2
        LiWKUL6pSuXjy1/onlORG8WcPE/k
X-Google-Smtp-Source: AAOMgpdjIFL4389ZqXfAhj218seVTC1N3H6+BnUWbR2KGoiTvwsl12p9aW8V1cF/dewnHKnLTVu/8Q==
X-Received: by 2002:a65:6086:: with SMTP id t6-v6mr26458662pgu.424.1533156283602;
        Wed, 01 Aug 2018 13:44:43 -0700 (PDT)
Received: from [192.168.5.149] (143.120.102.199.static.airbits.net. [199.102.120.143])
        by smtp.gmail.com with ESMTPSA id p66-v6sm34916289pfd.65.2018.08.01.13.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 13:44:42 -0700 (PDT)
Subject: ds/reachable (was Re: What's cooking in git.git (Jul 2018, #03; Wed,
 25))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <24424e55-7fa8-d05b-bc39-e14b4d5abcb6@gmail.com>
Date:   Wed, 1 Aug 2018 16:44:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/25/2018 6:13 PM, Junio C Hamano wrote:
> * ds/reachable (2018-07-20) 18 commits
>   - commit-reach: use can_all_from_reach
>   - commit-reach: make can_all_from_reach... linear
>   - commit-reach: replace ref_newer logic
>   - test-reach: test commit_contains
>   - test-reach: test can_all_from_reach_with_flags
>   - test-reach: test reduce_heads
>   - test-reach: test get_merge_bases_many
>   - test-reach: test is_descendant_of
>   - test-reach: test in_merge_bases
>   - test-reach: create new test tool for ref_newer
>   - commit-reach: move can_all_from_reach_with_flags
>   - upload-pack: generalize commit date cutoff
>   - upload-pack: refactor ok_to_give_up()
>   - upload-pack: make reachable() more generic
>   - commit-reach: move commit_contains from ref-filter
>   - commit-reach: move ref_newer from remote.c
>   - commit.h: remove method declarations
>   - commit-reach: move walk methods from commit.c
>   (this branch uses ds/commit-graph-fsck, jt/commit-graph-per-object-store and sb/object-store-lookup; is tangled with ds/commit-graph-with-grafts.)
>
>   The code for computing history reachability has been shuffled,
>   obtained a bunch of new tests to cover them, and then being
>   improved.
>
>   Stuck in review?
>   cf. <20180723203500.231932-1-jonathantanmy@google.com>

This comments on the initial values of 'struct ref_filter' (that are not 
used). All we need is the diff below squashed into "test-reach: test 
commit_contains".

>   cf. <20180723204112.233274-1-jonathantanmy@google.com>
This comment asks why "parse_commit()" instead of 
"parse_commit_or_die()" but the _or_die() would create a change in 
behavior that is not the purpose of the series.
>   cf. <CAGZ79kb7tWV=cmboA+nsChAUaiC+fVVM-GBCuWfsypC+-wyaVg@mail.gmail.com>

I just responded to Stefan's comment about sorting. I don't believe any 
change is needed. Some tests output multiple results and the order is 
not defined by the method contract, so 'test-tool reach <verb>' will 
always sort the output (by OID).

(Sorry for the delay. I'm on vacation.)

Thanks,
-Stolee

---

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index eb21103998..ca30059117 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -117,6 +117,7 @@ int cmd__reach(int ac, const char **av)
     struct ref_filter filter;
     struct contains_cache cache;
     init_contains_cache(&cache);
+    memset(&filter, 0, sizeof(filter));

     if (ac > 2 && !strcmp(av[2], "--tag"))
         filter.with_commit_tag_algo = 1;




