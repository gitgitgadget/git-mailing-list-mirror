Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD4C1F45F
	for <e@80x24.org>; Wed,  8 May 2019 19:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfEHTra (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 15:47:30 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:43886 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfEHTra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 15:47:30 -0400
Received: by mail-pg1-f177.google.com with SMTP id t22so10590966pgi.10
        for <git@vger.kernel.org>; Wed, 08 May 2019 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yy3vJx9eFBVFnTPfr7tYTV6a5NxlV0ri1Jvu9Olxi6I=;
        b=GKfII/CnWyyEIfWHxDld0OEB2cWT3xJYZT2OrvyayptWnufQaLuTUOKF3kHBvE6TU6
         UFQllNMb5gvDdIzXIj5TM6g7sJ20qOmuUrGCsMhO3OSaVJvIGzuxYt6f58IDuaTuScSL
         q7ViJvTWhWjIBX4yhFw8jUbeprLZq/t68ti5aC0CcXb2RmGquSPmBtt8S562+Y50+hXJ
         wdrZBJg+NRhe9JjCNPD2roKuuWKAa+jnN8eWki1dRavLMK/0Epf+BBz00PyQPnbxfZJa
         9JWonC1Nol9gh/YVCsXRwtBvrhMy/TNw1oXbiJlV4BlQgj2+JyhVPG/jgQ7V88i9jkn5
         rsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yy3vJx9eFBVFnTPfr7tYTV6a5NxlV0ri1Jvu9Olxi6I=;
        b=a+mAcOt8cBvmvtj/Bfztxgormgvd9UfrpylyoGYHXVfaR0sojtbbJfMHz+XBi7t14Z
         viEprBGicrSQh42LJKvicS7fl7dzAw+NZGVCf3vyOCt0mlrI6kMTGvd1qQgcBI0gQIhP
         FubR4PLGTs+WIYeT+SnRm/QuR7IYrI30AXnd+OLq+DZbJ16SYC59kS4gsoUUZw90ijSK
         lAS0FAtHQ3NpKqQdL12dP+ps1+FQtX7bhACDuPdBcw+FcBA7MuoLNtE6VBkGirfhqsNq
         RATHyKKLtlL2Ts+yWZNTtus3KTB5+26uSc3ji78JBNOWjmla/BvKfL1Ma28f/73bPfZc
         HW9A==
X-Gm-Message-State: APjAAAXKXDD26adMrJN/voTMtqsdjF9R3yeprUF1+D0KyvCqknlg0aOB
        K03OrFq7MbpmFTfKQaoSSUfKlm+xz9bihw==
X-Google-Smtp-Source: APXvYqx28SNXI8p7Z8su3VrMz6nBKGPJYN8N0GPDh1b7advuLdWUd5/LtM9hMgnJBjMI17dgs9thCQ==
X-Received: by 2002:a63:317:: with SMTP id 23mr29932606pgd.414.1557344848715;
        Wed, 08 May 2019 12:47:28 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id u5sm52523pfb.60.2019.05.08.12.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 12:47:27 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     t.gummerer@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, rohit.ashiwal265@gmail.com
Subject: Re: GSoC students and mentors 2019
Date:   Thu,  9 May 2019 01:15:56 +0530
Message-Id: <20190508194556.6766-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508171941.GC2068@hank.intra.tgummerer.com>
References: <20190508171941.GC2068@hank.intra.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Thomas

Thanks for the heartwarming welcome and cheers Matheus for getting
selected to GSoC '19. May all our code gets merged (in respective
projects ofc :p).

Best
Rohit

