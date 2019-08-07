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
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F071F731
	for <e@80x24.org>; Wed,  7 Aug 2019 01:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfHGBIU (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 21:08:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38171 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfHGBIU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 21:08:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id z14so5280742pga.5
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 18:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ku2XohjEiCPcNDrPmPIQbI8oi5MM+Y6E28yhAw7EIB4=;
        b=dKsZU9H2rPqLVF0XX8BR8OQyMc7I+/i5JVQiSX51EXPogof5K9MI/dhU1P3zXyGxTZ
         Smn8vA17pp/W+aXPovFXYvOxauQd3Z+L2sDwpLELlSPoPbUqau4pC4XHhV18cZ6tGRs6
         MrObs9ZUeRYvd8qaHM0VelBGOnc+zyT4ktxgrmUFg4pSbph4zr/SCXyrkGE86B/T5k2I
         GUgVeDxCroHNuc74K9Med7zN4UqqMyLFeGOwDKf//CeJXJkCDem5wgNmIUZMBRCIh7oN
         p87cEpdWblUG+oJBelbD3OXGDCSoPmY140AIqHTlQ1YlYpliH7ZvFr5yCp1azqPlREv7
         yTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ku2XohjEiCPcNDrPmPIQbI8oi5MM+Y6E28yhAw7EIB4=;
        b=Lq/ClDQO/xSfIv+9VH1vsY8gQXboM0HgspWh02ImxTfpnGtkxzbZp3roMTfYDkDOD7
         dDrAd9XO2T9NvZXStRdGEGC5XM/QIWl4wq2uSHGfQzc0u8o5gqJCsOQs71B/WWA/nk0Y
         mLBlCG6rK8vtBdjwPjlZqKWMnX//GS1fDi6Hj2+wc602D6HjN58+J15Me19ZznxifVmV
         gLcFc2Az5tFmi0Ct6w/vZextGTWbccyMEW4Yjce4Bt88/pIWeNUwLmTuteFWUNvR7yuW
         Dej8FGXvRQcstxVofjtaqh7AVvmH3p4BxBE0ZChDzbM/uEOdXv2VhjlzVumcI3FFiXdq
         iouw==
X-Gm-Message-State: APjAAAW5BC2V8biRXXHL/hYechruGasUUb4X9tds46JVopxx7w7+vHQa
        WNM2q9cmPualJvW0jSqujfY=
X-Google-Smtp-Source: APXvYqy9gfAn9qpRqgbmZHP+bAxRdATwvBmMOUG9XGPYn9LJEOzGWiM8eRKm1X8mo0mM6KgXIl4gSA==
X-Received: by 2002:a63:4a0d:: with SMTP id x13mr5339084pga.75.1565140099382;
        Tue, 06 Aug 2019 18:08:19 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.217])
        by smtp.gmail.com with ESMTPSA id p65sm88292420pfp.58.2019.08.06.18.08.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 18:08:18 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2019, #03; Tue, 6)
Date:   Wed,  7 Aug 2019 06:35:16 +0530
Message-Id: <20190807010516.9667-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqv9vahs6p.fsf@gitster-ct.c.googlers.com>
References: <xmqqv9vahs6p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Tue, 06 Aug 2019 14:58:38 -0700 Junio C Hamano <gitster@pobox.com> wrote:
>
> [...]
> * ra/rebase-i-more-options (2019-07-23) 4 commits
>  - SQUASH???
>  - rebase -i: support --committer-date-is-author-date
>  - sequencer: add NULL checks under read_author_script
>  - rebase -i: add --ignore-whitespace flag
> 
>  "git rebase -i" learned a few options that are known by "git
>  rebase" proper.
> 
>  Needs a bit of fixups, at least.
> [...]

This patch series was re-sent as a new topic, available here[1].
Please, review and re-queue it.

Thanks
Rohit

[1]: https://public-inbox.org/git/20190806173638.17510-1-rohit.ashiwal265@gmail.com/

