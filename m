Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0151F51C
	for <e@80x24.org>; Sun, 20 May 2018 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeETTAg (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 15:00:36 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51474 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeETTAf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 15:00:35 -0400
Received: by mail-wm0-f52.google.com with SMTP id j4-v6so21867965wme.1
        for <git@vger.kernel.org>; Sun, 20 May 2018 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQDfUWHSihenJIGBOlWzW9uPMGU2dEZTOjArZI494hI=;
        b=XKEvBw4tCmjShJQt7b4Cfde+Masf9qtwEKACWR5i9yvSqy61w7fXk4f0U7SjINx/zk
         J7rglJyU/QBiYvowXQ+ZCA2h/Lvp8EHcPcM2r4kRMxpHrtedXr8+Co36XBOrZL06pa00
         gvVrTkuZji3UDb/Fr9h6/fbA0NKBtXAKoydJTmASJW8l5tj+qNWpcIHbxrjS9NrTLORd
         MyfE5uldmlphykusDcrM3560UaYd/wGUOinPPKEvWbg16xz/7nVOiCNrpVkz+nfPYQqW
         U17wUzmg0UPSw82bBGvsnbF3jWSY/vA9o4uwVtpsvfKRNUea8QTRLZBe58GXDa+JYHE6
         Qh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQDfUWHSihenJIGBOlWzW9uPMGU2dEZTOjArZI494hI=;
        b=fm9BHub93ZtosFV5tslEGOGtcHKaBmnFXZ5m1fFQtzPfmctBHN2o4TbsFAYfzMLIIs
         dEuGe/IkiiklxoauH/suIhBkvLYtwFXFPrhePa+u+aU18L2bqMYgX2XYtKram6EnnMKi
         UUYkUP39SByB+DB0NSjeZr4Rd74+dPVU+Q8j6K3OMcgYrV8FyW7aklLLPS5buNp2HK8R
         LSSXQy/0A+zdqZE3uw8PIUckNIaobTt3XJKcN2lgFWsv9oAX/HHNBmoPctlwsE2ElYQk
         8UYxADU5PPbIBsiiLu6tizSxeFMqHK7VwZvc3Ef9oHzXs2D7EefJFqnF0Is+IrPluZ3t
         SkYQ==
X-Gm-Message-State: ALKqPwfsrG2/EgnI5I7DU7mMEvBesKcSNLOzUNolxfxH8WhjRWijDPTq
        P5zUDgnurLNf/8vIy+gEaMRf8GspiaM=
X-Google-Smtp-Source: AB8JxZq6eChPjN3POcbncW6Fqwb0Gc9tzqqxZpwWWdv/hm5zhALx/hJu7Ys/69OGuJldcDRkmw61qw==
X-Received: by 2002:a1c:e64e:: with SMTP id d75-v6mr8777841wmh.101.1526842834311;
        Sun, 20 May 2018 12:00:34 -0700 (PDT)
Received: from andromeda.localnet (AToulouse-658-1-45-152.w86-221.abo.wanadoo.fr. [86.221.52.152])
        by smtp.gmail.com with ESMTPSA id p35-v6sm20160719wrb.12.2018.05.20.12.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 12:00:33 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [GSoC] GSoC with git, week 3
Date:   Sun, 20 May 2018 21:00:31 +0200
Message-ID: <1693808.sCJRq8xfjS@andromeda>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I published a new post about this week. You can read it here:

https://blog.pa1ch.fr/posts/2018/05/20/en/gsoc2018-week-3.html

Feel free to give me your feedback! :)

Cheers,
Alban




