Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78A7C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BA1214D8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgI2Do7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 23:44:59 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:36821 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgI2Do7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 23:44:59 -0400
Received: by mail-pf1-f171.google.com with SMTP id d9so3213446pfd.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGXrX3hCwQIXvxepzXrb/ESV1Pq+UPVUqD81xzeIVYA=;
        b=azzgmKsrNZhaqEp0htjUZjltj68+0++jY4G5/+aV5y/j4748LzcJOaWhszAAcOaigF
         ShuTz2xaNnXTtIowQwWN49JYUQEJOBkJDOvcR6NV0+SKZBMgTsyY610ysbZn7CP/9rSt
         ruFJ3LCQkXLOr0ly7ZzCDx+oigyodQ3GDxOWoB1JY3Wo2dJal4pPMfRkt4ISnRbUiWKD
         ivCR+vIenITzfbsgkVCJoq96Kz0dysyD+Iv+r/5H6ZYfYvhs2HdYJq2a/hFNj9zeHfvh
         t0AVzW4CS8jtGIbnuNeIBPjMOR3K2twVjLofl/5N0/IIRwzf3Ot1eC2Ol69yNkaz/ddW
         iKqQ==
X-Gm-Message-State: AOAM533u0WnqFP/Rm10Ej7N8wpXvTMsXxOslCiSldBuGg7UX9Iz9Vg9i
        Ml7Ll6mnYhhucXN9cGYW9Ps=
X-Google-Smtp-Source: ABdhPJxv9KSABpfnAwJlcU11qjZX49XnuKp6eyh+hfmIwKabZLmguJHbounQKgEBU4v/Y27TCia5hw==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr1681219pgg.135.1601351098680;
        Mon, 28 Sep 2020 20:44:58 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id q15sm2650384pje.29.2020.09.28.20.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:44:58 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        me@ttaylorr.com, peff@peff.net, rybak.a.v@gmail.com,
        sean@barag.org, stolee@gmail.com, sunshine@sunshineco.com
Subject: [PATCH v2 0/7] clone: allow configurable default for -o/--origin
Date:   Mon, 28 Sep 2020 20:44:17 -0700
Message-Id: <20200929034417.874963-1-sean@barag.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
References: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Self reply, but I wanted to thank you *all* for being so supportive and
helpful through my first contribution.  This is a great experience :)

Sean
