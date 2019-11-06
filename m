Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFCCA1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfKFPja (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:39:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36011 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfKFPja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:39:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id c22so3918369wmd.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 07:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYZXQCuDKfOsn8LnjEbYCC00fQ0Zhy1ycVYvZGdTk2E=;
        b=eSaoscW6NPPUxGz94q53IYkdtzCGo5B2v5rdB19A5X94EURFFvfVcbu4jp0zU5k39U
         rISc4cbuEXydi0YTE2dgmdpjSBWCnYkdP83UUWGjQlGVPSV8cOy/m4y4T90kqy7bu/JW
         7yaUa3XXmC9WhFpb3PAhQgJkgnRmsVWBZJkrwCDoJL3SP2WcqE2ZRl2drSvXcXytS5WH
         rqTMXCWxG/bV2fZp3HGUq55oTNCtrt1pSF+btfJEqEQx5mrRQ1lNmhrmajyDFX3wngTX
         kydllom4UH6Rm7OV8vGfBYdxY4iqccTnD97roNd5hvMHs7wqbeNzawyeNvn/ZHyaAiZh
         O5CA==
X-Gm-Message-State: APjAAAUIc6u0TAYKhcsNlUh+OjDNy8r3f3wsIy4QaFrQSEz2Lvo1Mn59
        JlS+GCBX64hjbAQ0X/zx1CFeoA7ZTr8V87vitDg=
X-Google-Smtp-Source: APXvYqw5IvXMBEgVCPEDdD0W5VpYeYf3P2tEGKLfwZRrL3tYWB2fX40z1kW6dNyxixuik0KPwOtEQvRo4r00ZLj09jQ=
X-Received: by 2002:a05:600c:2191:: with SMTP id e17mr3180835wme.101.1573054768812;
 Wed, 06 Nov 2019 07:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573031848.git.congdanhqx@gmail.com>
 <7f0df0f685544ab828a7f6569d5e50a975c423d3.1573031848.git.congdanhqx@gmail.com>
In-Reply-To: <7f0df0f685544ab828a7f6569d5e50a975c423d3.1573031848.git.congdanhqx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Nov 2019 10:39:18 -0500
Message-ID: <CAPig+cRA04oOO_NpcBqabwL6F4Aa37Nst-xzC3xQ3aZA2GuL5Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] sequencer: reencode old merge-commit message
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 6, 2019 at 4:21 AM Doan Tran Cong Danh <congdanhqx@gmail.com> wrote:
> During rebasing, old merge's message (encoded in old encoding)
> will be used as message for new merge commit (created by rebase).
>
> In case of the value of i18n.commitencoding has been changed after the
> old merge time. We will receive an usable message for this new merge.

Did you mean s/usable/unusable/ ?
