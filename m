Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298E81F42D
	for <e@80x24.org>; Thu, 10 May 2018 10:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757113AbeEJKls (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 06:41:48 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:32869 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757107AbeEJKlq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 06:41:46 -0400
Received: by mail-wm0-f54.google.com with SMTP id x12-v6so26925141wmc.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RMY+euNEueblOQz8pa0opV5sZiUiS6G5vfhEtHbPvKc=;
        b=coQo2HR8cfNwiX2hfMZd8A+G9zqdrH599ifwhoL1J8Jq5mexmWP98A8xLktBXaACgC
         N2znaGWq46Osb1FmR7cIgLAgpy55nb6fp4u28N3R6nTq9IOFqwlV4JFXGI1F5Jq0qMj9
         ISZ1M+I8m9HTxsYYbcIiC15P5wWcgK+TDU7SpXWhbD0gjOpr6nDTPMC+zMWNwKgql85v
         8FOtAgpZAti48dWPwt7+AjLlSGlxcTGNlrArY3s7D+FIcXz2dopyVQ9OsHMnlodZ88Yx
         Ye01ovNYFSgJ2VuUrFBRYtUDhET7I4cRttUl4GQKGFfnx0QwMYDuEodALnO4p7/verpt
         IqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RMY+euNEueblOQz8pa0opV5sZiUiS6G5vfhEtHbPvKc=;
        b=Dae6hqQ/ZLylMtNMxe8TBc0NAmGWhIUXYM2ec1eclDz3d99JReX8Z7+iusFxGmKZsR
         edVI4dUzzkB8loCmnE1lAYLkwt0oV80lsX2NUeBTgVs/iuFKV2rM/JGF8mSqHIZiwNNO
         j40s6AbSiCWMsY9k680gu2gePM4Y5AuB1JmOAcOeGxmxCNg//JlDE6FSXXZieUQTgunT
         1LE/TIoye5xJ31gCUWFm+HhmE1rcm+OHWsbV0RGvolpqi60pPvQaTNRglXjHSpA0Xeku
         +bMTwjrDNImoolGW0hmFeM2QpKM/+h5n1yYcX8tZzuQFLMNZir4gsyw42oyu1M+pn2bb
         xgmA==
X-Gm-Message-State: ALKqPwfSylsHBbzbmA4TH93QPtOcowV13YXCCGSdMJo6d3Q+iqdBs1mr
        zowO85/2HJ3ZK4yXcYykgag=
X-Google-Smtp-Source: AB8JxZoUf8vKGo95Ds6S5Eu8YCPm8clVt73bWU3eX4ry/AJuDY0r3LcWaUYTpjAT7ZwM6RDaNANiSw==
X-Received: by 2002:a1c:6506:: with SMTP id z6-v6mr831985wmb.86.1525948905585;
        Thu, 10 May 2018 03:41:45 -0700 (PDT)
Received: from localhost.localdomain ([94.10.164.188])
        by smtp.gmail.com with ESMTPSA id h133-v6sm874518wmf.47.2018.05.10.03.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 03:41:43 -0700 (PDT)
From:   Oliver Joseph Ash <oliverjash@gmail.com>
To:     mqudsi@neosmart.net
Cc:     git@vger.kernel.org
Subject: Re: Regression in patch add?
Date:   Thu, 10 May 2018 11:41:36 +0100
Message-Id: <20180510104136.8653-1-oliverjash@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just ran into a similar problem: https://stackoverflow.com/questions/50258565/git-editing-hunks-fails-when-file-has-other-hunks

I can reproduce on 2.17.0. The issue doesn't occur on 2.16.2, however.

Is this a bug?
