Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1F21F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 22:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeKPIWg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 03:22:36 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:53834 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeKPIWg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 03:22:36 -0500
Received: by mail-it1-f202.google.com with SMTP id i12so1288655ita.3
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 14:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pr4/JGNnUu+kVtOTF8jA7FuB/UkB4kmauQ8/zeVOP3Y=;
        b=XAm41+64okRJkHZsXJs39c1RI/2KREKHoEvcFQ1cY0gjZy0gFXs36jNIEcuxDjXmPB
         0ykjLALWjfQV1v1aMZ8oBOD0FUMdFf1DS33An+/+Pd7IGqIupK/OlPr/HhuufiED9sI1
         tDmzQWo+dAsH3/wEzqE0mxLW2SHoiQqHs46tfNx/QC7WFIoMgQJC9rZ4ew6bFW51Do/O
         vr7ZtvTrQH+m4BYgPy33ALnaCCuwr15rvMaBBav2zSFm3vPsEf5+YQAGAGZA6ZqWBxhB
         NdS+2MVZR/s9YzGjYC96l31sjE991V7nyfae0obAX28v9cb6iRlMdRuiIoetMmWs5EvD
         OgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pr4/JGNnUu+kVtOTF8jA7FuB/UkB4kmauQ8/zeVOP3Y=;
        b=PP/JaTOOUVI3p2vrHA1Xt87Km9ssmBrQsJLC0wOqaXwMNG2F7wZY8aJX2zI5zlFe0X
         6O03j+OJebHrwgwH+Jfpa4ULnc33iCt+7gP8lPUUjVjr6Hm087MWxXLri4A6moQyJsV2
         XwWaX8YLehcZWQZf55lArHmeHCNmV4NdD9Yk1u3vvdtQhkAjlXUA8oP0JYqOwC1uEtwr
         4ZvCt5fQefylp3WgKLSQHbPfceYY+9i8/rMYzCZC6N+aFqrLU0XHlxiwRrsFI3OPTpoY
         88rW/Ep8V9sKppR7sYPNX0ccdQ/4dThO/2OB0osiP6RbyHNWQ/gBp1FlsAsr9SP/H72Y
         zldA==
X-Gm-Message-State: AGRZ1gLXDDLRZci6GUAxwuLS9T0FkYgPDaQH5/L6SlkDujd+OK4rzwaU
        goNBcu6RFCzSLtZvgdbucrKYPlhCuctLHOOl283V
X-Google-Smtp-Source: AJdET5dMXZDTAjh/G4GsS8KVIj6qIZXT/BiGyMzpyOsJVHOQ8lteOiCakUnG94kmtF85Qdl8LOPbAadlSbpEG39s6kMZ
X-Received: by 2002:a05:660c:b0c:: with SMTP id f12mr1788060itk.22.1542319977414;
 Thu, 15 Nov 2018 14:12:57 -0800 (PST)
Date:   Thu, 15 Nov 2018 14:12:54 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181115221254.45373-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCHv3 00/23] Bring more repository handles into our code base
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Please have a look at the last 4 patches specifically as they were new in
> the last iteration (but did not receive any comment), as they demonstrate
> and fix a problem that is only exposed when using GIT_TEST_COMMIT_GRAPH=1
> for the test suite.

Thanks. I only reviewed patches 18 and 20-23, as only those are
different from the previous iteration according to the range-diff.

I've written my comments about patch 18 already [1], and the other
patches look good to me.

In patch 21, I could go either way about whether it's more desirable to
pass the pool or the repository to the freeing functions.

Thanks for discovering the issue that patch 23 illustrates. I thought
that the tests were written carefully enough in that the_repository
didn't have any relevant objects or configurations (all relevant data
was in a path that is not the default repository), but apparently some
still slipped through.

[1] https://public-inbox.org/git/20181115195416.21890-1-jonathantanmy@google.com/
