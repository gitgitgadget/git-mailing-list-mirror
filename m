Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F221F424
	for <e@80x24.org>; Sat, 21 Apr 2018 06:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbeDUG3d (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 02:29:33 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:41825 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeDUG3c (ORCPT <rfc822;Git@vger.kernel.org>);
        Sat, 21 Apr 2018 02:29:32 -0400
Received: by mail-wr0-f175.google.com with SMTP id g21-v6so542605wrb.8
        for <Git@vger.kernel.org>; Fri, 20 Apr 2018 23:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=s0/KhDEA/xltWa7CK3d+AWQvdl5sAXgy+hiRf0R2NZ4=;
        b=rxAEAKW8RW0NC9IEY8NKN55m905YyZMTDqDDYfLqQRbmgqu7lPVVfc4lGsuI1IR2g8
         6TSOL3xM2k4rlWMtH+Flg6Bs3LnYVja1M4P4kWd0rWKKSy+Uz+bf779TPasUFIVP/ZUz
         Dsgq3/SzsG8aCtvNxuG+pY5pps+vncqcamdHaMrw0aZHAd+pkc8jCg8Vj5apob2me3DK
         8MQDGt4TapS5KkwUCKy72YJNXRGBJlea74T+4mWU3PazTMaQ0Z8eCQH3TEl0uECPGF0T
         d7AnmZu+ep5r34tdnMnltFcSmxMp3aI/JbsqDdfRw1vytCC8aPfm7/ZzTgAOVRXCRPIO
         1IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=s0/KhDEA/xltWa7CK3d+AWQvdl5sAXgy+hiRf0R2NZ4=;
        b=sjkW0APzCdAh07aTgiJSxGT+/wiXpZbHXgLyOgBqgxrr0FWcVtvmP3voMxpArASFza
         NwFOZJlSN06MwcJ/nVkFXHVWGCej1RkYzFM4JQpVzyhDFN2e8HC0idAplWhz0jusEhBG
         DalFZwrvB8ZY48YmlAkJIbM6LdJX6z5CC22MRNgaekzht3cmt1uxG+lbb28n2i8fkFfP
         JdzkqS9JO7zTHUY49f23xym82AWZIlXo2VLl6HKoTnl3gH6Tg/yOd1aWV0OAMNrpPKLK
         fYCfS6Nl4Vb6H6C8em6D7fxGkZSAUTDWY0VV+N50iMT3VJMyQpcVk90tOdfH/OHhB8ly
         yQ/A==
X-Gm-Message-State: ALQs6tD+RFQrGu4LIsbkHS3bD9BY9ZupUmj+99XtclujpSR+Y3a+p+Ww
        Om37ex5AfJnpxBYnx1aXflY=
X-Google-Smtp-Source: AIpwx495vW1QnjKVTglVw2YDcI6Nr3QRscKmcn9oCsXPlnvLfYfwY7lTgiUBI3ppqI/TWWL9hVGKhA==
X-Received: by 2002:adf:9d0d:: with SMTP id k13-v6mr10309784wre.179.1524292171248;
        Fri, 20 Apr 2018 23:29:31 -0700 (PDT)
Received: from localhost.localdomain (x4db03a65.dyn.telefonica.de. [77.176.58.101])
        by smtp.gmail.com with ESMTPSA id k30-v6sm17990436wrf.1.2018.04.20.23.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Apr 2018 23:29:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Vladimir Gorshenin <gorshenin.vladimir@googlemail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git@vger.kernel.org
Subject: Re: Git archeology
Date:   Sat, 21 Apr 2018 08:29:23 +0200
Message-Id: <20180421062923.4467-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.geecde6d7e
In-Reply-To: <CAEbJ=SN0h_eO+0CJQGEnEafhzgAYdgXByUqb_vsC1rgGw7jNAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> And there is a problem, which I believe is fundamental for Git (please
> prove me wrong): how to find all overlapping commits, e.g. touching
> the same lines of code?

You might be looking for 'git log -L'.

