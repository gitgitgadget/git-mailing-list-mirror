Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774771F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758562AbeD0RFM (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:05:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35815 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758271AbeD0RFL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:05:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id w3-v6so2438726wrg.2
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RMb353kU8wqx3Ipp0sXi4futVIlpEW9crXA627SfJV4=;
        b=Qa9pHaO7e43R+X/4/j7vG78HuSBvo84vVG/rxFn5mHCC9W1pJpx+sv4jQvai2oaZaf
         BxPBY3Ku9WJNFls60zZIZtPRtt70ZiGNdfqfiO2zw+l/hX1quCk3tD1YEuTnSS2eVMPH
         m7TVsByXJNgq1vngWNgr+fZJlgy2/9vdw9O0GssTEQzJjWeBKnZzKyKS5xJeY5ekKZk9
         wlbjGbH1D0upZxr12y+o8dQ3051T1E9URsQVeBP2sZ5lzUT4CWJFPTeLu/VFKQcYtMAC
         tYBTOxE4FYONM6/6zv7mRV+0uvJZkx+sObbxofViC3WW8BmVq145gK+kAkeqD7i4XZBK
         2LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMb353kU8wqx3Ipp0sXi4futVIlpEW9crXA627SfJV4=;
        b=Sc2JIWsaYazqooKH5CHIfIouCk/5Ed83uTN9w1cIyklRdptPTxL020Inb4QTomSibn
         XYK+8BJlC6m/S91ibuKY3R7oRWPNxHYpqrD/soskSWjbi3AyZtkznerB4t2whdi9mZYe
         0sbovmysIMtHaU+prR20D3u7qc7YR7AhM64JtsDvdpXH1ilvphUNo7UTmXR1KQI61y7F
         WWrDQD3ne2jSyVo0UC9BpkPqGNVqRynKPDkM7JDCr1ALlWWfLZfQ6EJScVqFERKtj62k
         DLiIuswbm1cWkfcj3Ehgjnnpubt0st+8FNfUfQxOpS7su0SSUTR3uQ8z3ePeQ7mCvstW
         dF6w==
X-Gm-Message-State: ALQs6tBsFIlMyEjgmixWgCQ3kGUz0imXi0kJNjBP56lquwICT9j/yQvb
        LlZq4/xRW2QJi3vZ3WhhWWYDuxfV
X-Google-Smtp-Source: AB8JxZobLaNC5x7VRcTDfxUkqYElq43tStzwixmHZDBB+perdIhLczyzNzcVQU2f1HTFD3ebQs3dsQ==
X-Received: by 2002:adf:ea90:: with SMTP id s16-v6mr2360712wrm.17.1524848709949;
        Fri, 27 Apr 2018 10:05:09 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274])
        by smtp.gmail.com with ESMTPSA id o10-v6sm1765745wrg.90.2018.04.27.10.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 10:05:08 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 0/6] Some doc-fixes
Date:   Fri, 27 Apr 2018 19:04:34 +0200
Message-Id: <20180427170440.30418-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reroll incorporates the comments of the first version, including a
"large scale" rewrtie of githooks.txt. I'v added "Reviewed-by" and
"Signed-off-by" as appropriate.

Andreas Heiduk (6):
  doc: improve formatting in githooks.txt
  doc: align 'diff --no-index' in text with synopsis
  doc: clarify ignore rules for git ls-files
  doc: add '-d' and '-o' for 'git push'
  git-svn: remove ''--add-author-from' for 'commit-diff'
  doc: add note about shell quoting to revision.txt

 Documentation/git-diff.txt     |   4 +-
 Documentation/git-ls-files.txt |   3 +-
 Documentation/git-push.txt     |   3 +-
 Documentation/git-svn.txt      |   2 +-
 Documentation/githooks.txt     | 115 +++++++++++++++++++++--------------------
 Documentation/revisions.txt    |   6 +++
 6 files changed, 71 insertions(+), 62 deletions(-)

-- 
2.16.2

