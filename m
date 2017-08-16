Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D66B1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbdHPSYm (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:24:42 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:32871 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdHPSYl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:24:41 -0400
Received: by mail-pg0-f49.google.com with SMTP id u5so26288861pgn.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=/n3G80NKc5zQUOH0mX/IshzvJFqFL0OyA22cLzgqQjM=;
        b=APobGjZ6EHTe1DaL9FoabSqLZL6nIjKmwlg6FMJ1nzfzvYEEFa2HcTwZoH5YiECAkh
         wR6KS3c1w0w+KZlz/w2NzNTorGNioyjt8a8B2+cLoM3yWuTwKf/ZWEFKm3ci3Z8mIO9W
         Ywbh3/8GSi0u19RzYA6rR5HAwdmnlRZo6DiVx+YhO7OlLYULEz6pH5t+9PrIrrWjySFt
         MEugD4u2RDYr5k1kMwzucgI3AN3JQqQyVtF0O3HqqjqLOG+6IRCWLJIDOoQCkL/jeGAJ
         u1yuBtWV9VVHSX9fDmw4oKiCz5J7jUNpHdBeZ0g8neTLAc2BoTakH0cAzd3iZERQaltV
         Avdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/n3G80NKc5zQUOH0mX/IshzvJFqFL0OyA22cLzgqQjM=;
        b=OibFPjhXU+71yF7gJ05gCtxvdvL+Id7b8h9REQaMv5HzGkvenl+0iQNJh7KKTmHZad
         PEUS8i6lJpUdUHSYFDfcnyCUkxcglW6vWjhYexlP0eaYO0u7XKsHiGlYzPx3xyaMOTuB
         tfH2AuOWN9r6I95VZcS+SCxSbKcfWhhN+INzCfoUqCez/swWnQfE90ENs/dRY+KrDNjK
         ZoM10IBVpgxScG1Y+g4Ir9SA7E4Ko9aHxwkAqk/xmn/UN2Jx5kr9o80W6Bprq9dootwk
         PCxVV3Vchu0NmtSa5pOb2zlpEB3YoEAxov8ClEJkH2hgosYImQVqbrr8iPr0eDJVsNig
         VH0Q==
X-Gm-Message-State: AHYfb5gBHxu9GUi0mNgZ1ihb5Zj5ne6Y+R/Wo143OYmyO5hzu3w3vvKJ
        PGVm5QdPwz5NkJuCrvE=
X-Received: by 10.84.217.208 with SMTP id d16mr2770492plj.208.1502907880191;
        Wed, 16 Aug 2017 11:24:40 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id 86sm3102555pfm.105.2017.08.16.11.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 11:24:39 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2017, #03; Mon, 14)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr2wdso3k.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <943ad6c6-a5fb-cbb0-9eca-ac1c3e51fa15@gmail.com>
Date:   Wed, 16 Aug 2017 23:55:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqr2wdso3k.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been around 4 or 5 issues of 'What's cooking in git.git' and I haven't
heard about the patches found at,

http://public-inbox.org/git/<20170730111705.12444-1-kaarticsivaraam91196@gmail.com>

and

https://public-inbox.org/git/<20170730115908.13841-1-kaarticsivaraam91196@gmail.com>

What has happened to them?

---
Kaartic
