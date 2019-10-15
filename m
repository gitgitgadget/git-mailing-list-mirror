Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559671F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfJORcF (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 13:32:05 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36296 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfJORcE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 13:32:04 -0400
Received: by mail-wm1-f52.google.com with SMTP id m18so21132515wmc.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=URq6Ev9CoB3Aj9+UUN+Ll95ySuOg5/SEBf0WdJX654g=;
        b=FFaPWI3po3aSXEf+mzyPjFcagvrDoWjIzPU9VfOZqvNd+R+YBHZZSAMa0aJDObI8/l
         AUe6pIOOduN/2JvKfwbRKgV2dI9Ab1Or+8VM+kqcVU+H+upiCV6rFyVp0rzZi+IfkuFb
         tQlt2to8QKXm4437q87PeXc6JP2IGe1WtL4xTYLYUBfzlTdCkWQ6Rm1qejAInye//GIq
         rIUhPFv81B3Ac6KMEsrCailfrmaAwKk5+9AWNBPzM559jlEp15rxFpF3vmrN3PE/Rgas
         Uycpo5C2xgL5JHU1rAzMIVlWuJi+JRBaWMrEEKdnLkNV2/sWOZ8fWd93qW3hGJ0eaFN8
         ur7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=URq6Ev9CoB3Aj9+UUN+Ll95ySuOg5/SEBf0WdJX654g=;
        b=VbzIOo4eKpIW4g8vhbmSuKDCbBLmjYFmwCT6jrU/JErYKDwQL6hDOIEyGU9jyZB/iu
         ysHAhw7w4drstJjs4sbsrKJHrqM0tKvnn33PiWDjRxeoOs25X5OY9IXwbbCwmf6l/J41
         xkLdaSoamrHNOGE9sMtlmn5qXSst4YR4vsOysKueNHr1Od845JZZZdAb/7/662/BpNCx
         EMEsTj59BAwqzORO4hJxGmykzK3Z73qPYElbCY7m4PdHjy0Rwjzkaw/tfMa+yZnCW0jZ
         df+TDOI+xB+vb5XF5gD6zmZFTEPrbeaJ4KvkRrKhkTYH+bQ5wrCIII4TTc9uqZWrmajF
         +xhw==
X-Gm-Message-State: APjAAAUENN4o0XjGMFoRR60L5avkVdwYrlcypDYbnMhWmtViJhqQ7Wt0
        2PMnmAq4TIB5EuoSeh7nSKzcCv0u
X-Google-Smtp-Source: APXvYqwprCf9SQjIHjbQG1UrxhhZYD7MyJbCGyJASQ2uDZ9PD/tnNpNZh3+PAoPqCG7613FizspfcA==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr17672678wmi.143.1571160722654;
        Tue, 15 Oct 2019 10:32:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 74sm16889018wrm.92.2019.10.15.10.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 10:32:02 -0700 (PDT)
Message-Id: <pull.400.git.1571160721.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 17:32:00 +0000
Subject: [PATCH 0/1] ci: update caskroom/cask/perforce to new location
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running CI on Mac OS X in Azure Pipelines is currently broken due to a moved
homebrew package.

Thanks, -Stolee

Johannes Schindelin (1):
  ci(osx): use new location of the `perforce` cask

 ci/install-dependencies.sh | 1 +
 1 file changed, 1 insertion(+)


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-400%2Fderrickstolee%2Fci-caskroom-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-400/derrickstolee/ci-caskroom-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/400
-- 
gitgitgadget
