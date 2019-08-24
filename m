Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5271F461
	for <e@80x24.org>; Sat, 24 Aug 2019 22:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfHXWAH (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:00:07 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45066 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfHXWAG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:00:06 -0400
Received: by mail-ot1-f44.google.com with SMTP id m24so11910929otp.12
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=q0L9FE3BFbktMJxhvuWlfIvEX2Hir9peJyv55PVPy2k=;
        b=Clu0mzM9DKBcyHDMKbdOXfUxoJfrJPUlZyhwWn7Yj9U8kNhwKOwNQLK9Wwca9CrkEW
         7DzQmWz5w7Q97HwS+PODT9nGTyu3dObm1di9wECm+Y5j/L+m8L3h3EXnCRtdrDYsa/W6
         p3qdcYay0FvkfWjLKs35ejpg0ABLblmLT9f/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=q0L9FE3BFbktMJxhvuWlfIvEX2Hir9peJyv55PVPy2k=;
        b=YUbPM3QGPF+4087qoE/elW837gyXSz6s8v7ZfUmf5wBSVcwmcWZR/TI2sQHuvrKhNH
         0THzdby/SaqhG+Yjotol6KvR0Fofnunf5q5o4ozT5/80yGCRoeKVxWteWHvhbHcc4s2x
         khfrUJCOiurysD+rAdSrOycteunHxI7//4jXOnVThecXpTuik9pa86FtwLxsh1BLPqLd
         hhI7Huqt5sYL5YwwL9bEkGTcyxcSlnr12P1Ne5ekn9arouHKpREG6d8c3qfoYxeF9LFV
         FejRCDejbHrMb9XSxeSJlj855YivhNqwawx6KY1SIO5XisJMhT5lRWT+udFh2s279Uvq
         gkGQ==
X-Gm-Message-State: APjAAAUIMtBEBBwdHYjiqGQ9ulQeQ+m0tsFiaVw6qQ0zKyUYtuLnHEiX
        l7tg5Jqy5sKDOxI87f1nEXs67YwonJKv2BuwKAxQbuzCBf+93Q==
X-Google-Smtp-Source: APXvYqwdHbxMoi+Kgl79aXXsvsTxLYAp+DFA61Mqr900pE1ccNOb40/dT4XQAD769Z/R+7fDUKJkFKgbzIf16ZWOUag=
X-Received: by 2002:a9d:5789:: with SMTP id q9mr1101401oth.18.1566684005739;
 Sat, 24 Aug 2019 15:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnyXxScGO6Eex_AEbgH=YFQ2yzY1hnXavyNMkiXbrccVUA=Ug@mail.gmail.com>
In-Reply-To: <CAHnyXxScGO6Eex_AEbgH=YFQ2yzY1hnXavyNMkiXbrccVUA=Ug@mail.gmail.com>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Sat, 24 Aug 2019 17:59:53 -0400
Message-ID: <CAHnyXxRTrx+7djrbGJ7uwyRTLkCmtet-t-dn=beeyWkdLGFx4Q@mail.gmail.com>
Subject: Re: [RFC] Add config option corresponding to --rebase-merges
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think it would also be prudent to add the following:

# Auto-config option values for new branches
branch.autoSetupRebase=
+   localCousins
+   remoteCousins
+   alwaysCousins
