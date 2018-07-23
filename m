Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5E61F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbeGWTYX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:24:23 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:43568 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbeGWTYX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:24:23 -0400
Received: by mail-qk0-f201.google.com with SMTP id u22-v6so1198174qkk.10
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ooeuH8HMf9JjeeBJAMCiw0Qt+FTrIivEARiGRhrfre8=;
        b=ouJvNJmjhyUtwJQtda7NkyzmoPoperWqEhXp4zOd16Jkzls4fwTOk558sJEbfKTMzq
         XEkqOidGzaQEey8tyxHyAc19zUMGrnn/0qDYU5USLl60nDKLq1ieNKkg1/P1l4v615iY
         gPb1XGIohjUmUbds9n95ynAAjGKxXVrwOn3H1l0BvTwRHciR6EYlVd3BUr6u7zmLgkl5
         UzJ6FsjJLgvvdohyjSSEMVC2yEwJBWnjtJOnY7aMCx3NXp+bBt7UKh0/KcgDOfmrlEFR
         W554yACnCx4dxh89gmKGQh5LxjvYsti4JJOwAu3dy59slucCzj6i/pb0Yq/5pMnFP0M9
         yNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ooeuH8HMf9JjeeBJAMCiw0Qt+FTrIivEARiGRhrfre8=;
        b=kwwtkadwFTEYcBfbNo1KhkrHA6/Sh2RCZjVZFFBbRsgEEGuzoa8We/Hs51Gm+twjh8
         U+QN1vUBdDS+pAS/SnHtsDQ7GQY6i+/NBi8t4jMb5DbJ0SRiiIdO27Cmpijw/11Cb6o9
         4gUEaj2UlYhdrLEvRdNDzJ6kz2qDUMXpFmnPV+YB7uHQYBIEqow6E1nCgyY1v3RRQMnS
         P0btrBxdcwBEFGndurjdavo4EVYZp3HFxL/xzvpygTfWMrh4/Y1p9xm+AFaibuqTW6ML
         9vXGQr9f1+GRxqAMLgssptqvg3/UXEtTbYTd/XAtQ8dF2bW9dbKAYt+LTqPn7U0LGO1p
         ZMnQ==
X-Gm-Message-State: AOUpUlEFuK2LPVjkr825VolcK762+GTFC1HM4LYEQuszSvS5TNuCt2v1
        3V8poSImpJixRS6bYSY86XOiqbc9h+MuTUoGS51+
X-Google-Smtp-Source: AAOMgpf+aeVMpcecvVt1UI9s3L3nHfNRi3QbkiciRMm0kQ/m0Oa8CgxZW9QXeErwIs18CG79vjifqKr256lCKyUtvPLn
MIME-Version: 1.0
X-Received: by 2002:a37:64d2:: with SMTP id y201-v6mr8382055qkb.9.1532370115832;
 Mon, 23 Jul 2018 11:21:55 -0700 (PDT)
Date:   Mon, 23 Jul 2018 11:21:49 -0700
In-Reply-To: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180723182149.202859-1-jonathantanmy@google.com>
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: Re: What's cooking in git.git (Jul 2018, #02; Wed, 18)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

What do you think about my fixes to protocol v2 tag following [1]? There
was some discussion about correctness vs the drop in performance, but it
seems to me that there is some consensus that the drop in performance is
OK.

[1] https://public-inbox.org/git/cover.1528234587.git.jonathantanmy@google.com/
