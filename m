Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E291F462
	for <e@80x24.org>; Thu, 25 Jul 2019 13:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbfGYNmv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 09:42:51 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:46753 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389989AbfGYNmv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 09:42:51 -0400
Received: by mail-lj1-f182.google.com with SMTP id v24so48137981ljg.13
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=kDNuWmJIofdxJwUcDc3YrLJQ3xtgscwQXsOQFgIokvY=;
        b=PX4Z31XGIbtKCoVnuWHsNP50ySHuark6R8ylkLX9NuDXwsqZPvBdaKnIrLDkO82JfU
         fNodYparVRfH0Coe23G0iRVkisHubDu5yO8/v3X0cpkEzY77+DfwpBTx3hVqTLYX08kU
         TFnjgqdaqMn1aWl+QbspKqFkgzdiD2DOGb93ycuqEDmJ2iL+aXN2TWlbP+zHQLG9vhRo
         J754/S0lFRaqVQ+w20jrrrz13o53+2z3PdVY39OyxHoRqurtIOqF/g7WO/aHrGXeHLQV
         yLm0YtxAowrXYJNxQoaItHaA6Xntie+FIy/SuEYAVHY+GCxt6Wv4hrPaBaTfiGAnP6Lz
         aYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=kDNuWmJIofdxJwUcDc3YrLJQ3xtgscwQXsOQFgIokvY=;
        b=EAWBnHX/vJvLnMNGW+onieRgYGAB7QodsmQA15Kv5j7dZv5z0jPpenWnObVJ+/rGm/
         b/6ulgAj5TabVKOh5i525x82CS85wzzPgE054vpiWPG56l1isQN+XAyohgLJU/tkBl0S
         cvlI7h3wMc/CyxNJdM0oGb28rYzxhzQUexit0l5WcQJYbWFxjYFuJBbI2PdUQIdag57p
         nLttuDYcRFAeI8hSoLpKfUykIeNO8whb53x5mdJWHx9LkWZ9mEGUgF3gW2KyE2vAW2wK
         T+1R0OeG5FGj9XvXalkKZ7dzym8KGYR3f7L+wvRKG/zMp0orKMlOV9VOwTzAK7wnVEh6
         CHng==
X-Gm-Message-State: APjAAAUSnsM3LEkGx1pNPs9Z6OqqUJMBTQZ52dNixqWlVUnXqmtYXnSW
        6bGAI9VlAsixskd/zy+/BNlg5UFq2YmBZQ==
X-Google-Smtp-Source: APXvYqxtDq8zl+HJXUD5/CPQBPWCUbIL+3cu8R2NWcMMRjg9NcV88MG22DkpH6JelPLLkPsqe8srww==
X-Received: by 2002:a2e:7614:: with SMTP id r20mr46945207ljc.42.1564062169289;
        Thu, 25 Jul 2019 06:42:49 -0700 (PDT)
Received: from [192.168.2.33] ([109.197.31.38])
        by smtp.gmail.com with ESMTPSA id p76sm9061824ljb.49.2019.07.25.06.42.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 06:42:48 -0700 (PDT)
From:   Ilya Kantor <iliakan@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [git for translators] How to always generate conflicts for merges?  
Message-Id: <C9A27ED4-CBD9-4FCD-B78F-8A1010D24D06@gmail.com>
Date:   Thu, 25 Jul 2019 16:42:48 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We're using Git to manage translations of an open-source book, and most =
of time it works well. But there's also a problem.

When we pull changes from upstream (English) to translation (e.g. =
Japanese), git auto-merges them.

Sometimes there conflicts, but not all the time.

For example, when a new file is added to English, it just gets =
auto-merged into Japanese.
But all new changes must be human-controlled, translated.=20

Is there a way to force git always generate a conflict, even if changes =
could be auto-merged?

----
Ilya
https://javascript.info=
