Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDB991F597
	for <e@80x24.org>; Tue, 17 Jul 2018 18:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbeGQTPS (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 15:15:18 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38944 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbeGQTPS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 15:15:18 -0400
Received: by mail-wm0-f44.google.com with SMTP id h20-v6so358439wmb.4
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3t1jPOUZBGv0O7BywrQsqnsfz6aA6u0o8ArDYlqdjgA=;
        b=qZVxh/7MhP3q2Dv1npNnO1Uc3D1BIoTtawWlb8H28m8qaip1ATjat076BSqX2GtVuH
         MOGDxqSPDc95hj9+iUjLyrwWpJQT+bLpDvnBWuaHgmtWt8vD2ea9LSZtscn9SOuddgX4
         z9hGn34Xkutx0qfyBbG0asgQ6mIhVoH38yLC/gKtKT9CoxNyHU7Cr6iXILeL6az6LVQ/
         ipX1pQLwltNkQjqzUpplie7jF7I+9bd1j4/yudWqPsE0JPmYdjb30fwZeubc/PW18k+j
         CUSGbbJoSQnjt90HQoZCprTV8PFmMbKAI+1THBaqMiU7eWCprrhzu5ZEO1MDTnAH8DIk
         04vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=3t1jPOUZBGv0O7BywrQsqnsfz6aA6u0o8ArDYlqdjgA=;
        b=bD8xg4SYt9hFJYU5F0eSNyNLHD2Wz8Y+4+Df4oxzSN64CakcdrXDj3VlDpSwM6eipw
         op8EFVFzGRe3IuqL5lXhLbJmCBFSoezyzwC1/dHEbkWcinSQmt1KvCmDV9iUS0lvaD3D
         cN15QlKcKkwHphFi0WXa0ZxzeDSLgLRsUsBhKECa8ijFSCdD/SnbPQ0vfzo6WFbH7DCw
         q6pONl3lk8dJGT+oUArtUEykEVz04PQvfqMiMUC7GMjSHIyLLRUIVEf5m/CujQbc7IQ8
         lCSaPLwxjqH56q0c1I+HvXM+ht1So3eNQpgQyBlQHT8erpUlNrAVPmPdPcdu1DXSG7Dd
         Hx0A==
X-Gm-Message-State: AOUpUlFUfBy+KvFTMk1CRfhFr/w5yLxFQfOo7ODipxfPCtoBcN0Ds5Y4
        QzuFjo7AF2fs96DCBWu5rCU=
X-Google-Smtp-Source: AAOMgpfnfc1qJ+YCOxnqE2IK1cYb9KerjRnU6C4riUjNWCo7FEMTI4u2lwWcYeqaa/uew2fCQ7DkIg==
X-Received: by 2002:a1c:6bd5:: with SMTP id a82-v6mr1984627wmi.108.1531852882966;
        Tue, 17 Jul 2018 11:41:22 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-20-79.w86-222.abo.wanadoo.fr. [86.222.19.79])
        by smtp.gmail.com with ESMTPSA id k7-v6sm446277wmb.13.2018.07.17.11.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 11:41:21 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 11
Openpgp: preference=signencrypt
Message-ID: <866fb524-6fef-ca6c-da79-b63405b5e578@gmail.com>
Date:   Tue, 17 Jul 2018 20:41:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I published a new blog post about last week:

    https://blog.pa1ch.fr/posts/2018/07/17/en/gsoc2018-week11.html

Cheers,
Alban

