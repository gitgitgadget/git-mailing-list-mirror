Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108BB1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeDJSco (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:32:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41139 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeDJScm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:32:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id s12so13761405wrc.8
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I8kthwJfSozbZgBoXkMS6WDzsOGbux+mrjDPB0dGKIg=;
        b=QlENxAzVhyjh3V8UpRlCRz+pUucn7RtQ/UPa0CQ/Gis3r+bykfeuko0GDaT/gcEUwE
         rGIy7ChkSTaiJHACfbOPbpHnLY6HfrlEvDRigmU4jb2ISlTOF+LaQ+M6DKeXx327PXQf
         gVnI7wZdiFrgusmXAmnSB0lPEXwQGvoO0gCaeBkwlo5gLKEqEI+qXdLOkZ0F/YdNxupJ
         JexOnSb+RDjrHQjbogjqTc7imOAwF9AndSp9KH9cav1FfwOQ3Cf2bR61OCJRys7YsRfv
         b/kshZtGK4aT/aPSc19UwRdMlI6hPopzHwk/gPodIe1X2ijTJ+FKZR2qO6AgMUW+GGSc
         lqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I8kthwJfSozbZgBoXkMS6WDzsOGbux+mrjDPB0dGKIg=;
        b=TwGDwvv4ISd3wXWwzIa2JqWTzA1VEtdOvcXDUhhUzZJgLRrmkEVpjV3pmcpAo3JexX
         uGu1V128V/1db95f16jjjuvsCJAtdJ2iieVarGMSKhByrFY1+b2MaAUgLXMMqZOiiT1E
         jEPdHCqaz8w1Qq+8jBLyL4Rg+sTcCvG5yxHDSstQtOR2xn5yE1SLJ037R3I8X+K/B00D
         7RHix+kaY6d1N09bFcFs31AkexUBc6nXdK8MzpEKpHI5S7Yk/nawyleRV5WRlL4zv9wW
         sg+ws1P8xHA4OXZPOghpbt1sqaAMYqgEPQFq8D1SNY+6PrCRjoFF8ilzq75e5KJUoNuE
         AmAw==
X-Gm-Message-State: ALQs6tCsHzl3RwtdkNYQzTH8BTweaqScmZIlKvcoUA796py0VFvD2174
        vRPu+UBTXqeDRY53Q3yju+wsXg==
X-Google-Smtp-Source: AIpwx48c0GUYxzu7rwIj3Ic7K+INE5pt/8qTDPlwcVqeqJnt7HJoNo0RMhAXY2xBmZ5EK/n3U4xj4g==
X-Received: by 10.223.151.156 with SMTP id s28mr1120098wrb.16.1523385160079;
        Tue, 10 Apr 2018 11:32:40 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:91e0:5390:d305:a939])
        by smtp.gmail.com with ESMTPSA id j21sm4426354wrb.49.2018.04.10.11.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Apr 2018 11:32:38 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 0/6] Some doc-fixes
Date:   Tue, 10 Apr 2018 20:32:18 +0200
Message-Id: <20180410183224.10780-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm flushing a queue of small fixes to the docs. Handling these
indiviually is just to much hassle - at least I hope so :-)

Andreas Heiduk (6):
  doc: fix formatting inconsistency in githooks.txt
  doc: align 'diff --no-index' in text with synopsis
  doc: clarify ignore rules for git ls-files
  doc: added '-d' and '-q' for 'git push'
  git-svn: commit-diff does not support --add-author-from
  doc: add note about shell quoting to revision.txt

 Documentation/git-diff.txt     | 2 +-
 Documentation/git-ls-files.txt | 3 ++-
 Documentation/git-push.txt     | 3 ++-
 Documentation/git-svn.txt      | 2 +-
 Documentation/githooks.txt     | 4 ++--
 Documentation/revisions.txt    | 6 ++++++
 6 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.16.2

