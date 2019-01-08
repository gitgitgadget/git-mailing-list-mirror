Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD3D1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfAHQwW (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 11:52:22 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33056 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHQwW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 11:52:22 -0500
Received: by mail-wr1-f48.google.com with SMTP id c14so4801498wrr.0
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 08:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LlJlFKYn/afmqHraeUTELZ/YDVFIP7+4myLAz0Xewio=;
        b=Q4I0njcX103/8WJLXng3vSivn/GgH5SLkeHm5uqOw4nCJtnggvBBlZjfVgh8lHbh7e
         xt6JJa+ve7cKdU45byiW6+ht5v+UG1V8yIBpfgXzSd9UyB9qTu2D49PJgQSgrnAscT8b
         FEH5/GXckB6NvNHYJq8akrESNrsOxg1Tr/FEz2gY+mzoTNE+udeBIfG2KkX8BTaA+CNk
         XwOpOvdaZ1t9wG6dCMrwZdOPHe0JrnRw3wHfwOfEQs3WC3sObgBOLHWQTUrHKBlT/QSe
         NB0xVL+bWIUIZMZduhVwH/MvakMwUtO8hx8phzRKFGyvYIGj9RvqD1xEe4zjGJ6At7V0
         /GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LlJlFKYn/afmqHraeUTELZ/YDVFIP7+4myLAz0Xewio=;
        b=J35+gm21OLEtmn2FvA0JIltBYBMu0O/7y7R+URJEbG3j9MjaRqVeF2QcUinappDsol
         rqNx5yebOAw+Xc2QeWTg5MMtnYJrSu9Aa3OZQ7Fov9yugBiPFj0gXTHH2DF5jB1aCVM0
         5zQ5lRmpN7obzXvSADMn+aqU4rDwQtF/r/aHuhgYu0m/9x3nx2OwOSEbACY2zYIZ1FS8
         j3YapNciyNyYqWRFCBl4+BzRm5e760z/F+UEV49D+PYOxjAtevyLIItbDL2nCkFbEfVg
         +W4ZizVYxtiWenJVYjesa/htnGr3xDdXwqQmNWX0Fu2NieLjp7qfYjkJZB7mEKiX5Nk7
         c2RQ==
X-Gm-Message-State: AJcUukfTTL9SViima4I+xfrieiB72+CFQVqQx/mHjP1OZl5OKF5dpHxP
        IN2vE0xC4StMJLI657lAzrt2XKyJ
X-Google-Smtp-Source: ALg8bN45rMzu+ZF3cfW+5Ai+zH84UkcH8RzxR9dfwWWvIO4Sd4xvPggHAXnj2fAyapIV7gE1Y3AZ+Q==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr2124762wrm.239.1546966340481;
        Tue, 08 Jan 2019 08:52:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g198sm15667546wmd.23.2019.01.08.08.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:52:20 -0800 (PST)
Date:   Tue, 08 Jan 2019 08:52:20 -0800 (PST)
X-Google-Original-Date: Tue, 08 Jan 2019 16:52:18 GMT
Message-Id: <pull.105.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] git-gc.txt: fix typo about gc.writeCommitGraph
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

Thanks to Stefan Haller for sending me a private message about this typo.

Derrick Stolee (1):
  git-gc.txt: fix typo about gc.writeCommitGraph

 Documentation/git-gc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: c7e8ce6d1dd02f6569ea785eebc8692e8e2edf72
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-105%2Fderrickstolee%2Fgc-doc%2Fupstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-105/derrickstolee/gc-doc/upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/105
-- 
gitgitgadget
