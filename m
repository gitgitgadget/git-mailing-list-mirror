Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1841F4C1
	for <e@80x24.org>; Mon, 28 Oct 2019 23:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfJ1Xmd (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 19:42:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38387 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJ1Xmd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 19:42:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so645133wms.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 16:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lpMfY52LqY8VWMJtCIRwpEdJomziA3/bP05x/to6KJw=;
        b=dwc+qu180c8pqe7MNwTRF1K70SZV+pPNLW3Ajv1Xyk90S7yoFc/MHKFn+D19gCoEmM
         3OYe8AjUCE7Vl5As/SsVuHMy9g3PnQXd3M71RUS0FND1yzvT/QWF2jEaj7UPLhntB1OE
         EN1RHvNWnoRwJQs6qz79E+4cLHTBCa+RNhTRKtpx7fc9SY/TsBwxl8ofeZ/no0z+Dh9c
         YXvWbS8IqDb+Sgc7xAge7619m+8jVGwKWpH8xJQQX8cqp05GFLi9YBtB4ETabjm5Uk+/
         Y0imu/lII+vzxbBvZ+Ltz/8JNAqU14kpn/HXFdNfhb0AIPMMbKNE/xuzCX3yUx62AJw3
         cHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lpMfY52LqY8VWMJtCIRwpEdJomziA3/bP05x/to6KJw=;
        b=Py9tHCYTaDtOyOPMvJXKyPyKYM53bYrggsAtvfbaEKOshiM2JohKvKSPzez79WZS09
         oWreQ9R49HcwQkbVpVJ4/5f+hypuiWG4wqaYhqWOSpleqi++1ay0AA0rXWMa1Meb7FDM
         Fc/QTU0URoTEscKsISXOHYpyghmBm2PZMMWcCheyIbDkVaHwsgAC5b8Y6HutV7thClES
         waVq1CzWJ+xPeKA5UhlZA0dsoHNMw7N8+rp1CGZWLkglelDsVHlUIQfkcz+Kl7JXkTdz
         Nwe09jVQt4GIkrEaU4k9voc61P3D0YLdHiD9ghscbXzyidqQ6SKmljbNodE+TWqgzeuj
         Wp9Q==
X-Gm-Message-State: APjAAAX8nKHGe1SUwNlJ13/W+row3U1r7JRRH4TMjidkIEf0z9TbdK50
        m/IS2NpXbB/K9opiX/z7UfDxWNJn
X-Google-Smtp-Source: APXvYqxHqCz3Tt7lmRjIsMXYMbMi2g1Fe3vrY9a7h2gh6xRfAaL2vEbKlYKAFinRVOWtLVhfkft81g==
X-Received: by 2002:a1c:9894:: with SMTP id a142mr1397512wme.135.1572306150160;
        Mon, 28 Oct 2019 16:42:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9sm96055wro.66.2019.10.28.16.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 16:42:29 -0700 (PDT)
Message-Id: <pull.425.git.1572306149.gitgitgadget@gmail.com>
From:   "George Espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 23:42:28 +0000
Subject: [PATCH 0/1] [Outreachy] merge-ours: include a parse-option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     George Espinoza <gespinoz2019@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach this command which currently handles its own argv to use parse-options
instead because parse-options helps make sure we handle user input like -h
in a standardized way across the project. Also deleted the NO_PARSEOPT flag
from git.c to coincide with the conversion of the structure in this command
since merge-ours now uses parse-options and needed to update git.c
accordingly.

Outreachy Micro-Project #3 

Signed-off-by: george espinoza gespinoz2019@gmail.com
[gespinoz2019@gmail.com]

george espinoza (1):
  [Outreachy] merge-ours: include parse-options

 builtin/merge-ours.c | 14 ++++++++++----
 git.c                |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-425%2FGeorgecanfly%2Fmerge-ours-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-425/Georgecanfly/merge-ours-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/425
-- 
gitgitgadget
