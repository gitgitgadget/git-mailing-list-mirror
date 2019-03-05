Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB8F820248
	for <e@80x24.org>; Tue,  5 Mar 2019 18:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfCESy1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 13:54:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32774 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfCESy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 13:54:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id h11so6255434pgl.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 10:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wp/oQrfKhi8PoF3sH3AlG3UuCGT4CKPPwhM3rb/MErQ=;
        b=TU6AXrGBllY0LxKxT5CuHFcmFJI0UT2dGJWp1zi2E3HWWCbUnMqQzObF7cRHcyo9nX
         OOxbktHhgMuPxYIEB3X4Un3xIpm2MIadkxYc48mXP0vt8Ku2YyR7JYG0bBY/xQQZGFMr
         x06IacNi7mJkrfkTlz0RIKlX5BHxRGOAG2TGUB2uHfCpH+k3IF6EibJcETaJY1WbkxSb
         Gl7ABfXytKUye0F0jZZecUwsEErYJNHgx3WYRu4gfonlz9okp3UwdnUMr9H0AhVypHGm
         8XIiyk1bdNPZMddmze+Z9Wa34V9ixXKjQaYXJlCIG9gvy6y4mC9/y4ImL+V8NaQFnbtE
         JuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wp/oQrfKhi8PoF3sH3AlG3UuCGT4CKPPwhM3rb/MErQ=;
        b=MjH03TeVcW9pZ5jGwk/KERrrWzmaz8Sy3jDbTlnvfgOk2Sq9HyU4IXvLnLYDdVZ/PR
         kdKInq4mcESGcJ/LHNWbD7DuBAYj07fYYJQn0FgqWHDJtbp5o2yeCF3K0Zodpi3Fkn3I
         TJhv5J1t7p6EI9ChnEejWYueBMVSDy2WgbhvDi5dSIij4dc+j3SfV46eElKR0gF9YiTi
         0Y9cszsVkwANIifcdsAYgnxBFR50ZRKzvBdtPFnrrUJaiNzQxG/upKSzlQLHeI2LmKH5
         62Gnf8EwKNxRPLmDv1hhyAQvR/zV+erR5QD7Qu/S53ywUAHlVEsaTd/3cvb/ADkj256C
         tqMg==
X-Gm-Message-State: APjAAAVvvDSGKGjoIIz/dPh1w7kjOK21FfdN/a/3F0A7ShRkLQTnuAWR
        /2v7f6shOXjQ6aAK+NsDJindBu5P
X-Google-Smtp-Source: APXvYqzOekZljCgYGsCgZJ+trrF6nDVFqzvcCB9fR0qpDVxXogasGRwXJbSIWBt6BX8vMNCZ7HTcwQ==
X-Received: by 2002:a63:cc05:: with SMTP id x5mr2663493pgf.31.1551812065482;
        Tue, 05 Mar 2019 10:54:25 -0800 (PST)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id z18sm27067311pfl.164.2019.03.05.10.54.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 10:54:24 -0800 (PST)
Date:   Tue, 5 Mar 2019 10:54:23 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] git-reset.txt: clarify documentation
Message-ID: <20190305185423.GA22260@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-reset.txt contained a missing "a" and "wrt". Fix the missing "a" for
correctness and replace "wrt" with "with respect to" so that the
documentation is not so cryptic.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-reset.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 132f8e55f6..dbf4e567a2 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -428,11 +428,11 @@ working index HEAD target         working index HEAD
 
 `reset --merge` is meant to be used when resetting out of a conflicted
 merge. Any mergy operation guarantees that the working tree file that is
-involved in the merge does not have local change wrt the index before
-it starts, and that it writes the result out to the working tree. So if
-we see some difference between the index and the target and also
-between the index and the working tree, then it means that we are not
-resetting out from a state that a mergy operation left after failing
+involved in the merge does not have a local change with respect to the
+index before it starts, and that it writes the result out to the working
+tree. So if we see some difference between the index and the target and
+also between the index and the working tree, then it means that we are
+not resetting out from a state that a mergy operation left after failing
 with a conflict. That is why we disallow `--merge` option in this case.
 
 `reset --keep` is meant to be used when removing some of the last
-- 
2.21.0.260.g8f7229c82f

