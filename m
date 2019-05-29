Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C271F462
	for <e@80x24.org>; Wed, 29 May 2019 23:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE2Xhi (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 19:37:38 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:38585 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfE2Xhh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 19:37:37 -0400
Received: by mail-pl1-f177.google.com with SMTP id f97so1728162plb.5
        for <git@vger.kernel.org>; Wed, 29 May 2019 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cQK+0oXk0Lu7JOl4t1Io+acEO+iENnCt7vSbfRKc90=;
        b=dHzgQs3bAS9Vvz6LL50I5IZcL5ZuqyUuRqRshT7KzYz4CvLXRx59AcB0Fbf7GArBC8
         Q8G3iR1q25VLpcjeP79sMMHcl04HhYB9VlwBVku9N3ucXYwfYsT7MR63pA1Sq1FbAJrv
         oOR7Gmc9j6LROLfdcomtG6ewvwZTAKYzD0LMwSYPdBJvmgt7YdNDjN+cEKCXsZgAviRL
         5ZJY9QekINwiStLMb6jT8Trm8MJHV59HgK2h3PLJVZO79l0/L5W8BIo8lyJy/sch4E6W
         0QCqUqwLrydp1UVb/cNxk18hhwiSO0cYRkaCxkROq3Ve0xh4CprMtUWixqH2pbYtNtDU
         ZalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cQK+0oXk0Lu7JOl4t1Io+acEO+iENnCt7vSbfRKc90=;
        b=s5h9xGLdl5gSLelkd04XHYBsAtcDk7r9uQbfBf+j2c0M8dJQe/AP41/Rz2ruwiq0XK
         XH1i6q9hIE7mLEp/crKT++9oQoKrhKIBRW6/dIqRpKQgax3tI7wGRPV43wh5CDFPMPH8
         f5Kg/R2W9TVk1xirAG1X6EG8KBBFNoxGIJtpFNMhBZXfPYYgqcNJIG0FCcw1BqDweRQG
         Sx+8buaWwh7uAzm6AeRv5o5kdTzYnioMDUwrI7GOTycwNfjsVZMUYrBtozqC2OdMSRRs
         NyqYvmuD7+KQz3oQCt6zEtgUXNZKtWRHQwpG0LNXGMM/phAOpbscT0s/gWz+p1/H9JWR
         iZdA==
X-Gm-Message-State: APjAAAVEuQdxxIJoalYiwINIbLW+vvlAv3uY4dFt14aMJiJ2J2HhLQws
        7PwaXWwK9IMlCPeHSCmsM3Y=
X-Google-Smtp-Source: APXvYqxDLZQzczIVGdpZpquCXS5XvKC/h9AiOk6x8wMVrNrnx5pd/fPLlzmSm8l44FokRTQg6CRgBA==
X-Received: by 2002:a17:902:6b:: with SMTP id 98mr696732pla.108.1559173056884;
        Wed, 29 May 2019 16:37:36 -0700 (PDT)
Received: from ar135.iitr.local ([2409:4052:2082:d869:70f5:bbd6:2317:457])
        by smtp.gmail.com with ESMTPSA id s80sm823235pfs.117.2019.05.29.16.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 16:37:35 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: [GSoC] Blogging with Rohit
Date:   Thu, 30 May 2019 05:05:40 +0530
Message-Id: <20190529233540.23077-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Everyone!

Three days have past since the coding period began and I'm almost ready
with my first patch of the GSoC season. Check this blog[1] out to know
about its status.

Thanks!
Rohit

[1]: https://rashiwal.me/2019/leftover-bits/

