Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC9E20441
	for <e@80x24.org>; Wed, 28 Dec 2016 18:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbcL1SS2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 13:18:28 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34656 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbcL1SS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 13:18:27 -0500
Received: by mail-pg0-f41.google.com with SMTP id y62so105962476pgy.1
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 10:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T5z9azbHur9YeeOdGfi3dWrlbqXlG0aTwKZd+5Lo/oo=;
        b=S7OmnKEHr38+S+f5q/9L+N7d2fW/5EVu3afn4Wf26PpbfWdJjacKDezrKGyTrW3sHU
         llDY+TLJUxRDzRvtFLTV2CygrGsE0FJZ9tojpa8Yx4i8L6kOocss+gv4X5c1CCxjoWHo
         TAv+2vK9pZ08exewURMHsSO6bMLbKW7NRuKKg+KPQoflEoWDPjS4LLWnzIiDTrt9OSPk
         2/2U6xzoJNtY6eNnJrJcLmBY14+U0I9xs2cvwkEzv4gAmA7cuuz6+hLu2E+W/W+Geqo3
         fXNtNOarAvAVS8Gfltt0HoY8nTljqPJ9gM+02MgdzZGyfw4Ly72uFeSw80Pt92Pfq5hr
         89wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T5z9azbHur9YeeOdGfi3dWrlbqXlG0aTwKZd+5Lo/oo=;
        b=a0TLGBzxjXRrCDQf2tEnxxL/rB8t54O0pYFR4+4kgFfokgpGw8Xe91n0cIbVK2nGQ8
         U34p7+Seg5hk03TMP9BL6JUZtqO0TNN58bU0Ih9irVP3C2gUZt0ndV0aqzXq5vn7W/4b
         59+MMRUPUR6NZ+F5xddVs8BFo5X7ZhGrJCB0gFWwvZ68PNG1DBuwDmYFKz+TZALyFc/u
         +dX4rZUV8BT9HwSd22+ClG03HIxXtjxfniVHBMXmRzqhg+FI/tiz8k0kkq3gLuAXeUHb
         WujJv64JVUzfLwS3ABNuyTR5++Ly/jEFE6HPQRO/Gl+X7/sV1x8v9ZT1balvM+wqUcnj
         x4vw==
X-Gm-Message-State: AIkVDXJLLGV2Yimplj4shXxWbGhO3mSuOyev54bhtMjC0R24K4zTm8FhVYW0vO/1h/sD/YY+
X-Received: by 10.99.153.26 with SMTP id d26mr70958123pge.44.1482949090851;
        Wed, 28 Dec 2016 10:18:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5916:abad:d441:dac4])
        by smtp.gmail.com with ESMTPSA id k5sm34184083pfb.81.2016.12.28.10.18.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Dec 2016 10:18:09 -0800 (PST)
Date:   Wed, 28 Dec 2016 10:18:08 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2016, #08; Tue, 27)
Message-ID: <20161228181808.GC33595@google.com>
References: <xmqqy3z155o1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3z155o1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/27, Junio C Hamano wrote:
> * bw/pathspec-cleanup (2016-12-14) 16 commits
>  - pathspec: rename prefix_pathspec to init_pathspec_item
>  - pathspec: small readability changes
>  - pathspec: create strip submodule slash helpers
>  - pathspec: create parse_element_magic helper
>  - pathspec: create parse_long_magic function
>  - pathspec: create parse_short_magic function
>  - pathspec: factor global magic into its own function
>  - pathspec: simpler logic to prefix original pathspec elements
>  - pathspec: always show mnemonic and name in unsupported_magic
>  - pathspec: remove unused variable from unsupported_magic
>  - pathspec: copy and free owned memory
>  - pathspec: remove the deprecated get_pathspec function
>  - ls-tree: convert show_recursive to use the pathspec struct interface
>  - dir: convert fill_directory to use the pathspec struct interface
>  - dir: remove struct path_simplify
>  - mv: remove use of deprecated 'get_pathspec()'
> 
>  Code clean-up in the pathspec API.
> 
>  Waiting for the (hopefully) final round of review before 'next'.

What more needs to be reviewed for this series?

-- 
Brandon Williams
