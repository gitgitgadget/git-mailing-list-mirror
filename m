Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2523E1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437641AbfFLNTk (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:19:40 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:40175 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437469AbfFLNTk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:19:40 -0400
Received: by mail-qt1-f174.google.com with SMTP id a15so18448625qtn.7
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=go7JKSj8mIV3Sbce2ewSLVeBRix/Pup3id4fIti/0cY=;
        b=Z08laeOcFCDhn+0nehz959FC1vq/KjSeJqZGM+2Hqi4DJKa8pLOLu20W0WRCUhedID
         JFt0fhdrUMx1MiG6TG7BYnvRFR7FxukkdL8PEV2qcPNa1UTHd5jdO2TrNmqI0XksXHuO
         YDybA/KP7p0TfS1KUMA7yyiM7iLoscxD6AuGVZxHXQ/Xg1JD01awH2mjQ8LlHujZkSix
         pIee2dq/Z/j1sK2usdc8L+eZNOoqewoFEP4FTdOqt5bEBINGCv4Xp38pfAeZ12UdCHo9
         ccEemAUNoVHemuRGJw3gN+UEp07FD84dzj+pMMil7xgJyrnZoykPcGdmhvy6Ci8sNf26
         hm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=go7JKSj8mIV3Sbce2ewSLVeBRix/Pup3id4fIti/0cY=;
        b=SAGNrhpKcccd6lPGQkoEOB4KlO96ty07EskIcbKQ0nmFF5/e8dlKWWWDJWLRgrXbrY
         2xTTv8czrEyvjyzMHodAJO9uMloKd49LFrWwsfDk7vqzLrjkJIJHa7g9gYcZYq6WKOaK
         UyvFjN95y2X9/nikt5J0+K66z5ewEmrYfduCvVO4jkfi4u/DPq9FjDeEqL6t9+CrGOun
         tbEsZhfp/PiujFzdEvS8gn/yfV5oWZ8v9U7FiQyfDHueoBKtsg/CYaddNiZ0yopPmhbp
         pvxzqsl6CJP+0UBhlfBqVj0gtMkgtkiongniXgBE5ZNAzrNlcy0xY1f659wjGfGaaZJl
         ovKA==
X-Gm-Message-State: APjAAAV7ZraJ3ghEIk6CiIR//ym8moUr7cS8OiTN1f0edw9LQT6zxXzb
        qPkd9UnIsdTSeWC/zTTC9Ea5DuBj
X-Google-Smtp-Source: APXvYqyzxo2fAHh4LOEFUPMJvR8YDdBu6EwINpOuYX24/ECgdf5rUC/Rs5ne6jRZ+L4dHO8HiCytAg==
X-Received: by 2002:ac8:2646:: with SMTP id v6mr50594038qtv.205.1560345577756;
        Wed, 12 Jun 2019 06:19:37 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id e8sm7942263qkn.95.2019.06.12.06.19.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:19:36 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jun 2019, #02; Thu, 6)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqimtiqyey.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a958e78b-523a-5578-24dc-77597a77c724@gmail.com>
Date:   Wed, 12 Jun 2019 09:19:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqimtiqyey.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2019 3:57 PM, Junio C Hamano wrote:
> * ds/commit-graph-incremental (2019-06-06) 15 commits
>  - SQUASH??? 5323 is already taken
>  - commit-graph: clean up chains after flattened write
>  - commit-graph: verify chains with --shallow mode
>  - commit-graph: create options for split files
>  - commit-graph: expire commit-graph files
>  - commit-graph: allow cross-alternate chains
>  - commit-graph: merge commit-graph chains
>  - commit-graph: add --split option to builtin
>  - commit-graph: write commit-graph chains
>  - commit-graph: rearrange chunk count logic
>  - commit-graph: add base graphs chunk
>  - commit-graph: load commit-graph chains
>  - commit-graph: rename commit_compare to oid_compare
>  - commit-graph: prepare for commit-graph chains
>  - commit-graph: document commit-graph chains
>  (this branch uses ds/commit-graph-write-refactor; is tangled with ds/close-object-store.)

Sorry for the tangle here. I'll place the proper use of
close_commit_graph(struct raw_object_store *) into my changes
in the next version.

> * ds/commit-graph-write-refactor (2019-05-13) 11 commits
>  - commit-graph: extract write_commit_graph_file()
>  - commit-graph: extract copy_oids_to_commits()
>  - commit-graph: extract count_distinct_commits()
>  - commit-graph: extract fill_oids_from_all_packs()
>  - commit-graph: extract fill_oids_from_commit_hex()
>  - commit-graph: extract fill_oids_from_packs()
>  - commit-graph: create write_commit_graph_context
>  - commit-graph: remove Future Work section
>  - commit-graph: collapse parameters into flags
>  - commit-graph: return with errors during write
>  - commit-graph: fix the_repository reference
>  (this branch is used by ds/close-object-store and ds/commit-graph-incremental.)
> 
>  Renamed from commit-graph-format-v2 and changed scope.
> 
>  Expecting a reroll.
>  I think it is almost there, modulo a few internal API details..

You are correct! Sorry for dropping the ball on this, I thought I had
sent an updated version. I will make sure to send an updated series today.

Thanks,
-Stolee
