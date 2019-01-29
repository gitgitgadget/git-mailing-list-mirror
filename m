Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4041F453
	for <e@80x24.org>; Tue, 29 Jan 2019 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfA2K4E (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 05:56:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36813 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfA2K4D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 05:56:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so15608821edb.3
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 02:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=oSnfTk/6bWXCp7+vLNFQNGIOHIwcJCBiNyzzaikJMsc=;
        b=jLU5lFMEYjX1aQU5kkg9Wnf7fBmM48HsHeQ0h4ak7U/ocWDPgzSbWEuDGt+JsDG+P8
         qgT3UatKoch0a76g2PRviHz3liaPSrQodtWCwvGwEC2C+ItPkm0ydoBvNlIUMqRKw/Uj
         O2w1sz9CBjlGtl1LAo8BJ42nII2kQTx00w8Aw+Ms7XmqEYoMTfbNG0GsjD/rz1WtA9qs
         tKtzbS/pIqZeMVlB1reWh0Ic7VoSytXIg8ORk9Kzc5QjTO9GTNjRlYCC4WT+MkvnATJQ
         NmexVug97TKeIc9zEkxg45YJM2JzUVhAX5+tcKmo+wYFd9Xug0KvDZywoz9BahSH8O6M
         m7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oSnfTk/6bWXCp7+vLNFQNGIOHIwcJCBiNyzzaikJMsc=;
        b=gcR1LN1l/tzT3rkw7zmsgzlDsbea0kNj1+GiLWhQYTjQq0/fkZQIS4M1V+O4ifp0hE
         n0eJXu86BR9pPv7XeStX+kNpaCtxkNv4XCjvS7EY0quxOydmrhDu41adQK+jlQSZHBLQ
         C+iV1f/q9IJ7em/hkvE3abXxbWgDwzMxVsyjrF//JCxhH30ApWySAH2+L+j+C/XGLsFf
         +Xzu8KxTcSN5AD0e6lDPs7NAO6Q4sDUVUlBk2lhKtNVmibWaxgtU5KePtBrkAQcgMUBA
         K9/ZMzqMuc4N+C5N+PWWg8uNvBb/WTDKn6E9iET4RK3+LLdCJ/9r6+Gsq1atd7mxJxJC
         EKkw==
X-Gm-Message-State: AJcUukeNiaPPja9ZeUXYCUDQng/RKQhGGJ3auZTbmOvVWjxbQ4Gt/N7C
        +HZgM5qgDWefJUePFY1ZTJkqSW+n
X-Google-Smtp-Source: ALg8bN6xwKppBz5DweEWPpvpo+3z/Zc5FPdX7MuCPlPiAWoSZhFt2XbgEI10eNri+XvbSe4UUPxeLg==
X-Received: by 2002:a17:906:e096:: with SMTP id gh22mr10184388ejb.30.1548759361816;
        Tue, 29 Jan 2019 02:56:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm14149557edc.56.2019.01.29.02.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 02:56:01 -0800 (PST)
Date:   Tue, 29 Jan 2019 02:56:01 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 10:55:59 GMT
Message-Id: <pull.113.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Provide a fix for the semantic merge conflict between 'js/vsts-ci' and
 'sg/travis-specific-cc'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are merge conflicts that do not result in merge conflict markers: e.g.
when one branch extends a function's signature, and another branch adds a
caller.

In this instance, sg/travis-specific-cc wants to use gcc-8 in the osx-gcc 
job (which is already installed, but not linked, on Travis' macOS agents),
and js/vsts-ci wants to run the tests on Azure Pipelines (where gcc-8 is not
installed by default).

So this fixup is necessary to fix that conflict.

To see that this is necessary, I kicked off a public build and you can see
the symptom of the problem here
[https://dev.azure.com/git/git/_build/results?buildId=318&view=logs&jobId=51041795-01c5-57f3-5561-107b6b9e51a6&taskId=fadc714a-a906-5cf2-cc7a-335e443ad2f8&lineStart=326&lineEnd=327&colStart=1&colEnd=71]
.

Johannes Schindelin (1):
  fixup! Merge branch 'js/vsts-ci' into pu

 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: c7baf85843ec1dc8272483baa2f84d0ec66ad882
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-113%2Fdscho%2Fosx-gcc%408-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-113/dscho/osx-gcc@8-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/113
-- 
gitgitgadget
