Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FEDD1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 05:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeJ1OZH (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 10:25:07 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:32846 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeJ1OZH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 10:25:07 -0400
Received: by mail-it1-f178.google.com with SMTP id h6-v6so7735154ith.0
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 22:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=z7GBmpcsddIA6i+EUgj0j9vf6UCXr9TNkl0okS2ybq0=;
        b=RPisjlPOMbx4rbHEYI3HOngcfMH5W3kB+TyX3SjWjlaTeWbt33RU7yZhSH/6tQjrF3
         xigd+pLAdgaSQjAiCcBR3uyn/KOAQ7X1eMYlMxi6Q2K4HzuctFMp0DNSbQtpQp5J6+qL
         HWozSkQvXR/uPopzXXeOuV9Ja44Lm7wcsPFdlPI5faGCsPRptj8VEQAeGywN1AHMIWZL
         aNMpAdonnrHUzEL7AB4lJxhvXgtEcDDfHS2uMDe3pwlgZv6htFhZpGP9V6A4hR3zetYP
         r4UD6ELI9RCzmBbApdcFS1Ymrn0a81GrPJsenZLy0KBcklxgHZ9Jen9mSzHtX9ydzs4+
         UqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z7GBmpcsddIA6i+EUgj0j9vf6UCXr9TNkl0okS2ybq0=;
        b=NFMRwk0VD2lfdpph28ZyELaZ6ZRtaI0mvUGakoBLvUZUwlGM8DJSPRpAD/e/QzrDD0
         MrDttYXrsmjNnejuA1JARafvYjF7rouIVHJOwJ0+WTNWt8sBIrDXwJn4qpNEIc7N95yi
         iIjPDS8hj7+9QEkskqxCmzuA7t1GIvofwBL4/110VKycpf84k2/07Dkob8ZIRxa4JGMV
         vBboUoarYJiK0+9Qq19SIFNGtT+1NPU+TH7y2NmMcpSJIyrCUmShEipDZmXcdm+wmjtx
         4NRQQCw44pKaBvkCRqbYbezxJ06SUD974mRAOecMnJJcJDLVxP+QMNEtinZm3BbJHIeV
         r7iQ==
X-Gm-Message-State: AGRZ1gIViLkvBp1cXtDHzkPChYsga88VoFPTcBs1kk81VSdVu2lMCblc
        8mcsepStmfjBK+RgJ3QcmM47CPk9IFznkIHvUuSTiw==
X-Google-Smtp-Source: AJdET5c0WeS/go/1TuyRScL4MHBGBlS0ufVZ1G6AOZ37kl6bOfR8EuwqYnk4kyf22BCl/AYjiegH+FPsskqjrgpGQoE=
X-Received: by 2002:a02:958a:: with SMTP id b10-v6mr6956533jai.130.1540705293080;
 Sat, 27 Oct 2018 22:41:33 -0700 (PDT)
MIME-Version: 1.0
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 28 Oct 2018 06:41:06 +0100
Message-ID: <CACsJy8B=gxVMrZnr-BNp=VCHea8wpx+GCE4N76=vSGMnX2rSbA@mail.gmail.com>
Subject: t7405.17 breakage vanishes with GETTEXT_POISON=1
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Something fishy is going on but I don't think I'll spend time hunting
it down so I post here in case somebody else is interested. It might
also indicate a problem with poison gettext, not the test case too.
-- 
Duy
