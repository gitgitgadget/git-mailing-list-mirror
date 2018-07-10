Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83CF1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934513AbeGJQUy (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:20:54 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41445 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934422AbeGJQUx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:20:53 -0400
Received: by mail-wr1-f47.google.com with SMTP id j5-v6so8725583wrr.8
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vCbxPQvy+UL0i9QP0DVForVSeHub4D9jzTn/vKxUKgs=;
        b=vZTikYy2LHAbiKA8pROk5QHYTr7FubO06wJSmmX3U+Q1bR/11+/cRo1vpzSvLnx6JV
         8MNAGOgPV46lYSvDNcSXxd11S+EhFT88ZYx1j0/JZf0ulc08WPsz3GqC2LeGizkLP10X
         kl21OY4pBW4yxd6yLD3s9C9hbq+b5bdmRtVMrygX9GIvwpqB7N3Tl8XQ9moedh0fKvmV
         iZ3Fdnv6woOS9dDn1hSXlqUlOnbgx+LtsJRW7oi/OYhaDYShbSYWyWgZw5+wb36de45g
         iaD5UvNtc+kdAlmGT8dno1d1Nfv7ddX2hAJmGv/iXT6/J1KXEnN6iZlsfioiHuWyvSXW
         p3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=vCbxPQvy+UL0i9QP0DVForVSeHub4D9jzTn/vKxUKgs=;
        b=bGQ1nrgPiKqooL4SaQKTqazEHCiJ5A5h0dSdeHzk2mYEzkh8OzNOwMOqxAguoZZm9F
         1xoYOn21EGEMsVYlSs6HtcxP89v5lQraFlAjv5XUdQx8lP02IRzzbaWR4UEr6sD4Jn8h
         9lcwE7B/5G5bzhDBqNJcX9TyNvOoJTsOlFbvl8cUODgztyRX5F0Ak1HE2e1MwIXD8u98
         X06oIIMKmeHPZ4oYjZ0rwqhhoJdCvKPI/D9M//8aNLPfU6fh90Fw1pEwDbw22pKj2qqv
         5iGnxFARYhne27PXNxj7MEkzw3yLh+K//CjuOh6AYnPKurcOg8Ydqo2b+Ckwio2Kp92G
         osyw==
X-Gm-Message-State: APt69E0zf8QyCpleu71OGd/PxToKJan/2bAXFXGk/9eBnTKanoW++41k
        JsU7h8hgGB/tEDDvOl621iZAddcX
X-Google-Smtp-Source: AAOMgpc6Vt+lt3c9qAbCQfnLPWwW6f1coRjPjQLwb2t4XKlV9Xi6JJJ/WnBCetFFyQcZ+Dj30zAPMg==
X-Received: by 2002:adf:ebc3:: with SMTP id v3-v6mr17633655wrn.33.1531239652189;
        Tue, 10 Jul 2018 09:20:52 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.gmail.com with ESMTPSA id a2-v6sm13463907wmb.6.2018.07.10.09.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 09:20:51 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 10
Openpgp: preference=signencrypt
Message-ID: <d6b9e84b-4d9e-ff1d-e726-56aa58a6b358@gmail.com>
Date:   Tue, 10 Jul 2018 18:20:50 +0200
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

I published a new blog post:

    https://blog.pa1ch.fr/posts/2018/07/10/en/gsoc2018-week-10.html

Cheers,
Alban

