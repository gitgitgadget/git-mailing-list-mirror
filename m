Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0211F406
	for <e@80x24.org>; Tue, 12 Dec 2017 16:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbdLLQRI (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 11:17:08 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34917 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbdLLQRH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 11:17:07 -0500
Received: by mail-qt0-f180.google.com with SMTP id u10so48621678qtg.2
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 08:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6iYJwGr/PqSts0XoIyedwlyMdGBf765XEBAqfPTr30A=;
        b=auqEfhuzO2RGU9UoLbLcw40nRax1p+yVxcBMKxqDdj7nW2NenQ3dTVqgJqVxqf69d2
         Gyoz6UgF7hkgwYXoaBr8OdrT3UHhPHLrzZCSQKoWnXqLSKV35geuk9l5yyfKJjtvUTA/
         QozAc2aM3e6ZToDOgvljn+f0ZQHniyQT1Kp7h90xsZzaR1daDOs6DhTBZ1vBgxeRMKy1
         HFDeL7+dnay0Be4NoXPwSBAnYXw2UMrEgkq+lP6sL5tyXpD/eyeSCsgH2dxCvgwpHvn7
         aX2P2aq2xhc3h/NjzR9ifHiAHsH4/4PpQiV2Isgu30K9HOZSTpu4xBbb+XMp3/eGMLQo
         DNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6iYJwGr/PqSts0XoIyedwlyMdGBf765XEBAqfPTr30A=;
        b=RVPs7bt/XoBJ4DPakUH40zJ7ctdAv2fw5FplOVP6r314LEzM/RTxU3fTbL2CrKcQY8
         VfyyrVMPZw+IXfzP6JgcgS4qiRAsPf90eUMhjcmhLjqudomJGsEL4T/t5YeaPUNgXpsh
         FZKwV9JnoXCmfbZoLRWei0cS2lDwk4Uf/xFW1Zp9VfEB6xDIter9U5yrldhv1l6idR+N
         axvXHV8UprBmdiHvB2d3RB8K8n0qCjxsYQHx7XNVwR3fehPQVrBTrAeuoc6eM9n4cl0r
         P0rVH38FXpnTdrZpsU553LeAHgBBVjDwR3hP1vIVtWvqWHGC+R4U9Cp7IUdyqjMlPO04
         n+0g==
X-Gm-Message-State: AKGB3mLq49LqJNN39jhJfMqcXfWlMSsSiQ2AXAZfZC1bm7m/L1FQbf8p
        gTy9ozHrmT3gYtC41DtS5bMHxCfXsDk=
X-Google-Smtp-Source: ACJfBovVJgnCATzWXzRogeY7x3hg0IWUylXzTd7ESg6R4OLGPpLatDOS0tH0Q9ynJRgUftq68jRd2A==
X-Received: by 10.200.44.251 with SMTP id 56mr6198093qtx.87.1513095426780;
        Tue, 12 Dec 2017 08:17:06 -0800 (PST)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.103])
        by smtp.gmail.com with ESMTPSA id v82sm5846853qka.44.2017.12.12.08.17.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 08:17:06 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, judge.packham@gmail.com, kostix+git@007spb.ru,
        manschwetus@cs-software-gmbh.de, max@max630.net, peff@peff.net,
        sunshine@sunshineco.com
Subject: Need to add test artifacts to .gitignore
Date:   Tue, 12 Dec 2017 11:17:01 -0500
Message-Id: <20171212161701.4272-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <xmqqy3mkljq3.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3mkljq3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FYI, I've noticed when building from "pu" that neither the
"t/helper/test-print-values" or "t/helper/test-print-larger-than-ssize"
testing artifacts added to Makefile in this patch series are not added to
"t/helper/.gitignore" like other helpers, resulting in the testing artifact
being recognized as an untracked file.
