Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1841B1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 14:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933037AbeFKO1N (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 10:27:13 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:53076 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934570AbeFKOZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 10:25:42 -0400
Received: by mail-wm0-f52.google.com with SMTP id p126-v6so15070832wmb.2
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1Wl4vUQ+9JNYjGwzcYugfqKvGvplpvWytr+oITEAVMg=;
        b=duK0UjbAeTgd+/fEbNkpdpB2wY6/WH88mOLz9ZynnI7mwbPifQtM4/9ffv9yymxIAr
         FA8ikRGmeY9xlVMbDrMEJmsKTtnenlxVDYzzqoOytkhcdsdhe9v15bUpzIxrC4IV86ij
         Tu+QD6g62g6Eh+dN2AEK4OoixFvGCM2C9FcY40kqn0OZk0JUlcfgF4NV5e5y1DMNKsYW
         QDK1nb/9uR+oGu74M0AaSl4noQX/qQ8JMto/Fwf3RkIXFz1+PFUfFMDz1rOqxCqX61dy
         CwftXFjOoVgEiIcvU/rxYFoZlKE4ZiRgLWSmkYE2VhI6C9JoMYMlS5alNDjPLc0fm+oC
         d8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=1Wl4vUQ+9JNYjGwzcYugfqKvGvplpvWytr+oITEAVMg=;
        b=uaP6a4x7GSNR/QXNw6yUM9nL/e28h7cKJggNiyTloqyC77WqyaW791rlYbxBLGacen
         gXww4Pg/r241hCI/3Mf4LgsWteIy6jajM1cRjYXaIUVAy4SKpyYQBQXlvLKxH2b3+nVP
         JVul+6QvvSqzsjjcqhrTY1YwA8Xbga3saOUgmP3+5vAbFpcc3uK5TjHjeXnh+kjpuWpg
         0+boa5f9rQ8pWO1hrG4MMc0q7ZUOJvTWvKRAordB0CE4aaD2xc/B14e9xZsFg1NiZUK4
         3HzIun7Zyrh6FFSpwNh283pD7GCnxHzzeZZtrC2O0HKr9H1825r8tqbjXyfWY0KTpMbp
         uBRg==
X-Gm-Message-State: APt69E2miqGOd1cBNt2HSlaqWbVVAXrKKI9yxd0NeKCD8JBQjSnqoMvO
        +kLVmyMoU/+QTbiLLulp258=
X-Google-Smtp-Source: ADUXVKLRxzczfaRIAbkHUhlDByOgoCTZOGpR6SLR+H7wFUunqMT6+zYlt0M6lWf/fuF80H922Ca5tA==
X-Received: by 2002:a1c:448b:: with SMTP id r133-v6mr7829145wma.55.1528727140728;
        Mon, 11 Jun 2018 07:25:40 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-25-147.w86-222.abo.wanadoo.fr. [86.222.24.147])
        by smtp.gmail.com with ESMTPSA id e81-v6sm10972016wmi.28.2018.06.11.07.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 07:25:39 -0700 (PDT)
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 6
Openpgp: preference=signencrypt
Message-ID: <bcb4a1e3-3e72-749e-dfb3-09acbd049b87@gmail.com>
Date:   Mon, 11 Jun 2018 16:25:30 +0200
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

  https://blog.pa1ch.fr/posts/2018/06/11/en/gsoc2018-week-6.html

Any feedback is welcome! :)

Cheers,
Alban

