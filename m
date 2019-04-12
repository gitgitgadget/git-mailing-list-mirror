Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6394820248
	for <e@80x24.org>; Fri, 12 Apr 2019 02:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDLCfb (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 22:35:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40458 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfDLCfb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 22:35:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so9862802wre.7
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 19:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JLppFgDOojDJGWPLjKq/B+OYaM7JpixRu+JxglBkyZU=;
        b=NpnS4IHI0o/bIDono3wIyAiIDUE9hbE+B4EJ2p8iqgJA17RO4WUYJNNbyGECe6614e
         XoqcO3e6gOfi/w6LX8q+2Ca91OIxfNsTALKFAb19anwxsGXm96mVn+KnSWG0lDyvihjv
         KLm5cYJMYCV0VtPQAdM1CJA+pXFkZRWcT3DgbBoIpcvrpgJAdAoQFeD4uD5vchBw/ybc
         wi6qNdS0u7Uhk8x3xxoiuDNop6op1PUd3Sm6f1TTG5FiPhbItlpYxh8KOecARARxFv67
         qWWtJlyeVapGKR294B0Bu+ufmpmh9WG4KyWXiNevln8CaETAAwoZWS5StGjI3I0Ce+Rg
         HGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JLppFgDOojDJGWPLjKq/B+OYaM7JpixRu+JxglBkyZU=;
        b=P7h1xiuo5Ud/MgaSIArneYyiK6lmHdJk3SCZBfAaEHD1Fo1wj9lJFKflTJKcHmLqRP
         Ie9pcMaSYDALEApXAfRNq1pw90kJlhbSHXI0yuN4YGaROnuN7hQlxyCQwqLHaCXmX80K
         TPgHjOS7ZSrmZFcfOMRbZuILQEp50LAOzmtYHPF9Jj/MajW9fXp3js12riYARED2Fe5H
         4Fve46W0EvCKV2B9HZCNks8tCVEsDRVZOEfe74navWBx2753XcxYGGyJSjObSh9NAsin
         dmTNrx657BeeqiU7u5n8DJ7kyNdzap+cnAsQa83sauWHXiU/8t20D7UUUwCzQmp+/obv
         Hd+Q==
X-Gm-Message-State: APjAAAVwkzaBizzi5uJ24cVVlS92Sv7bHb4bgYJBXVblhH0A2LYVpKdY
        +hIgh91XOr5MqOA5epSTPFvchaQ5usQ=
X-Google-Smtp-Source: APXvYqzL4CRhiJM6LETIb91oadYF0JFg4UXKhwDkmy0ly//3iBlINJfGsbLW1vt6VDDF4RVMulr5hg==
X-Received: by 2002:adf:f344:: with SMTP id e4mr36284765wrp.77.1555036529123;
        Thu, 11 Apr 2019 19:35:29 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g84sm11303200wmf.25.2019.04.11.19.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 19:35:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] documentation: add lab for first contribution
References: <pull.177.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Apr 2019 11:35:28 +0900
In-Reply-To: <pull.177.git.gitgitgadget@gmail.com> (Emily Shaffer via
        GitGitGadget's message of "Thu, 11 Apr 2019 11:32:00 -0700 (PDT)")
Message-ID: <xmqqmukwymq7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> RFC. I am still working on adding a section on handling refs and objects.

Thanks.  Is 'lab' understood widely enough?  I _think_ you are
abbreviating what is known as 'codelab' by your colleagues at work,
but would it make it more in line with what we already have in this
project, perhaps, to call it a "tutorial"?

