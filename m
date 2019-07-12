Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994E11F461
	for <e@80x24.org>; Fri, 12 Jul 2019 23:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfGLXCK (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 19:02:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40599 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfGLXCK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 19:02:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id e8so11007752otl.7
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=OMzvkrEbOjhacFuFWR5bNiLZEVr1R8eqU8Ldc7iLi1g=;
        b=Q5H8U+7Bbc5vVlN+cWygIogEtvEi5lUTs9rAPI/TU25VlZkO+Tc78Dxz+bY2f7ZXHg
         q4AKAPac0MVJFmPoko+jp1+4/VtTJoquUgQ3Ad2a5TpXtQdqq5H3yLXaTq/5LX04CXUQ
         FpYrNK1SbGCCmQlym8XvmOdIeUnPZIELpsusLJaKmrjpDobUee2fF5TUeXBLMWroHNXn
         IDck+doo257WV00SlgbpSrIaNOuf+5p2RGEENK8hV/+bgJhAEiDQe+q7Od4jfcBQjFBc
         zTaArme/zE12i1kUF3UMmUoyftLiz3VALurYVfK3ZcLgOAWoqEvTL3dQTKuixFgX4UW4
         fnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OMzvkrEbOjhacFuFWR5bNiLZEVr1R8eqU8Ldc7iLi1g=;
        b=DZ1nsAHsF/KfREmH4xRdT15k8JKv2NbcnV5RlDTazMHOTLcwEXoaHhMR6ZBfsHSQD+
         XZDuObo1J45wX2GOCHui0D6YCvm1LEidQmYWg0vK5d2nw57dUMciIgIB0jJIfaun6ay3
         Apj0gb7abTSoF4bEt3yXmm378iFX8y8T+6ONpY4wdlFGykilGwBY8BOkCH6fXJYp7Kza
         ZbeJ1/JSC8zgXkMTIoTLP6jj5Wo8NXaIVtcVppLmJEV+PRPz3Fx8+ODdNIZcwNxei4fq
         VKJWqL8pem9VYstpV+72mCDw6IwIXA0NoQTcnE5nX9wMkvvqg+n8hSKvEwiOBzFqXKYI
         ekpA==
X-Gm-Message-State: APjAAAX9RUIV7M9wD87hcF2J37G2g1fswRURmHyrBUNy2VlKDSf7Xk+1
        cXDst1/N3/Qi4FXH9BIDkpLpMRY8
X-Google-Smtp-Source: APXvYqxX1AeMq/tU+0QUxoGlM9I9ta9GvP6aTQXUph72W0zefn8C2KJDy9JEsoA+UFG1kBfcnuL8CQ==
X-Received: by 2002:a9d:7d92:: with SMTP id j18mr10417103otn.339.1562972529411;
        Fri, 12 Jul 2019 16:02:09 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:c055:b92a:b249:c6a6])
        by smtp.gmail.com with ESMTPSA id i21sm3260066otl.24.2019.07.12.16.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 16:02:08 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v2 0/3] document deprecation of log.mailmap=false default
Date:   Fri, 12 Jul 2019 18:02:01 -0500
Message-Id: <20190712230204.16749-1-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on the discussion of the previous patches, we concluded that
changing the default will require a transitional period.

As such, I have introduced a deprecation warning that is printed when
the log builtin commands are used.

Thanks to Junio and everyone else for providing feedback on how to
proceed.

New in version 2:
- The warning is disabled when `--format` is used.
- The warning is disabled when not called from a controlling terminal.
- Tests which fake a controlling terminal have been defanged.

Ariadne Conill (3):
  log: add warning for unspecified log.mailmap setting
  documentation: mention --no-use-mailmap and log.mailmap false setting
  tests: defang pager tests by explicitly disabling the log.mailmap
    warning

 Documentation/config/log.txt |  3 ++-
 Documentation/git-log.txt    |  2 +-
 builtin/log.c                | 25 ++++++++++++++++++++++++-
 t/t7006-pager.sh             | 10 ++++++++++
 4 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.17.1

