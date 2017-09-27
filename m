Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49CA220281
	for <e@80x24.org>; Wed, 27 Sep 2017 00:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966573AbdI0AND (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 20:13:03 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32918 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdI0ANC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 20:13:02 -0400
Received: by mail-pg0-f66.google.com with SMTP id i130so7646800pgc.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=abQobtkre7KK/ezdEXW9IoJjVk1T1Bv83aaOl0QnTSE=;
        b=NaNF4GPiafKC5P4ZMiIFzJUH3J5LfQ0FycQyYBMzqUu5RepXytEYWKMHZ0emU6NkfW
         Wf2O1nUV+gm1jf8a8end5DtBnN7e6TKMR2mVSh9/PNyHMMrsOZs/XbK35KNJYARO8dzm
         AFxXvOv71j/mNNiQXCl1/hNe3fs59s9jhLg0I50X/gtm3nKOwpSBrpVwFn+PKWY7ggf5
         NO3AC85pvyU3wkTuSfJTBmCXfvaLf2I8jbgdAdiD7jvCYBn7n2irAquxfnBjT5s25/Fr
         5bU3UZQGQBlpwN2YDnO+ADqFLXpTNQkINYACRovXlFQ5jqEeLYP9BRSvMYXjykyhZzCP
         L04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=abQobtkre7KK/ezdEXW9IoJjVk1T1Bv83aaOl0QnTSE=;
        b=CcjeBVu6XHWS5Kxc8vlX/HLGHQQJwsl6OV9gQ7Bp+1qPrInwA/quWKXl9xaiXo5fdh
         2GLbZmqVpwkRv5Xv2o8/soBZ3M78vU2NX3bfjQNoUVo5xKTnUJS3f/YcBGI9wQJ/90l0
         I1YP/6OKKeb2ynazOaZIQxcCVMHCvAi+ec+tLYp/NvzAPB+09rOcBMdJMjmJKlCRxnV+
         VZFK0kKm3SNxATJOIz/pesg3NIlt5lt6F79wB+VgcOWfQo8BnD334UkU/WTyVW+SfGkG
         f7+PD26oQffUznTV9UZm4ZmmL7CNriePiHAQVqWGYqMYg0IWRYZdHk7FCiZZS3DHsnw/
         3XbA==
X-Gm-Message-State: AHPjjUipfcK7qyg/jLOOrzjtqCtXKhVwbS2TnMyAYu2tHN2AaYPs/zPe
        sKZL5wmtEy/kYmgfzQOqPfGGMZQF
X-Google-Smtp-Source: AOwi7QC6Qj2WZM+Fe4CU45bMcdYpPSdy3v6zABXscLYpKcjq32z5aqsy8G7PQlQUMXEp6anEmEO8yQ==
X-Received: by 10.98.103.89 with SMTP id b86mr12008806pfc.319.1506471181800;
        Tue, 26 Sep 2017 17:13:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id e7sm16930844pfi.188.2017.09.26.17.13.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 17:13:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, bmwill@google.com
Subject: Re: [PATCH 0/3] Comment fixes
References: <20170926112150.21850-1-hanwen@google.com>
Date:   Wed, 27 Sep 2017 09:13:00 +0900
In-Reply-To: <20170926112150.21850-1-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Tue, 26 Sep 2017 13:21:47 +0200")
Message-ID: <xmqqshf980dv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> follow more commit log conventions; verified it compiled (yay).

;-)

> (should I send patches that are in 'pu' again as well?)

Because these look more or less independent changes that can be
queued on separate topics, I do not think resending is needed at
all, even though mentioning that these do *not* replace what is
queued like you just did is an excellent way to prevent the
maintainer from making stupid mistakes.  Thanks.

> Han-Wen Nienhuys (3):
>   real_path: clarify return value ownership
>   read_gitfile_gently: clarify return value ownership.
>   string-list.h: move documentation from Documentation/api/ into header
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
