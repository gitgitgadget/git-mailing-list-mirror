Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 796EB1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 20:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeB0USL (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 15:18:11 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37352 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbeB0USK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 15:18:10 -0500
Received: by mail-lf0-f67.google.com with SMTP id y19so149240lfd.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 12:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEQxgW9SD2hARFFej2bxlVgMqGtbhTCCPsFzMapVNcw=;
        b=AJG5Fy11hP349Y5phSyZwCooYlhbCyH+yCmSNEo1IchtNsb9GQLgfMyBlZTGAKdYAL
         tWyDOiCp6DLU6RGebOHkR/14k6D4liDnh/IpZiFAo6WLEPBD+1BS0xNokjwor+OG8QwE
         PM6rfWzynMyhG9YHruBE92+IHFv0w3+z+5VWcMuv4sM9MZN6F/csbuiQNSn5tOAK6Qmp
         EZIQdzW5FukUgTA8M342i/+5G6Gyq2UHub4zmjYG1VuH0RPtBktHIq0lnwEs7vHHNLew
         6BQcW79R1jN4f2e8AlUaxxhVXQlWurIbNiGVdtFgNc/ZwrgQAzg8VPi3HPz8nHQHnscu
         xRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEQxgW9SD2hARFFej2bxlVgMqGtbhTCCPsFzMapVNcw=;
        b=chvxhxdqQDQ9hrhVXwk6Yg6twCS0y5TnQTtq5DW7FFeDSmVnvVvTmUIi44zdNDJmyp
         RxK0964/HE4vl182y5dPu9M+AmeFiUOekKNcXpidbH/LwXjQYsj+tl0scMkFrz8aTZoD
         ofFlhlkj1JCdPokec4PUrzdPzL+UULb+wifNmcrupt4GpYNex/VajDq6wkTSn5BE/jL7
         OR1GAGRwdO5OJPsrzltYLMs7O/4oxu8fQufyC7IUtHykV2m8njwjKD1V/YjlEmUF9gOM
         v3f/n7IlD+OHn29NZG6xh8VqI7tSm2XT0mpSzmltFysZaSLYoD/VidXLurl+q94SqVRR
         0rng==
X-Gm-Message-State: APf1xPCq5j8hWiiU7G5rYodJbQXkqxHX0sgn4+HRlT+WeYhCfBLR/bD/
        7HtQ7Om+R0PWow2QGzkM1EUxpFHM
X-Google-Smtp-Source: AG47ELt6e4mFNIhmxw1Xuso9OqMsl9N4hXcfem5/BVfCJNgUb32xI+IacnqKokPKvZ9WqQIfBD8uNA==
X-Received: by 10.25.226.3 with SMTP id z3mr9912228lfg.118.1519762688834;
        Tue, 27 Feb 2018 12:18:08 -0800 (PST)
Received: from localhost.localdomain (c83-254-123-234.bredband.comhem.se. [83.254.123.234])
        by smtp.gmail.com with ESMTPSA id 5sm2729626lfp.17.2018.02.27.12.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 12:18:08 -0800 (PST)
From:   =?UTF-8?q?M=C3=A5rten=20Kongstad?= <marten.kongstad@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?M=C3=A5rten=20Kongstad?= <marten.kongstad@gmail.com>
Subject: [PATCH] docs/pretty-formats: fix typo '% <(<N>)' -> '%<|(<N>)'
Date:   Tue, 27 Feb 2018 21:17:44 +0100
Message-Id: <1519762664-16889-1-git-send-email-marten.kongstad@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove erroneous space between % and < in '% <(<N>)'.

Signed-off-by: Mårten Kongstad <marten.kongstad@gmail.com>
---
 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index e664c08..6109ef0 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -202,7 +202,7 @@ endif::git-rev-list[]
 - '%>>(<N>)', '%>>|(<N>)': similar to '%>(<N>)', '%>|(<N>)'
   respectively, except that if the next placeholder takes more spaces
   than given and there are spaces on its left, use those spaces
-- '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
+- '%><(<N>)', '%><|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
   respectively, but padding both sides (i.e. the text is centered)
 - %(trailers[:options]): display the trailers of the body as interpreted
   by linkgit:git-interpret-trailers[1]. The `trailers` string may be
-- 
1.9.1

