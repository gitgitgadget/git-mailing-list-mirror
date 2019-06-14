Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0311F462
	for <e@80x24.org>; Fri, 14 Jun 2019 18:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfFNStc (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 14:49:32 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:40483 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNStc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 14:49:32 -0400
Received: by mail-pf1-f181.google.com with SMTP id p184so1957709pfp.7
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfSIqgNhQQlk2m2snflueKaRym87wbcQCA4TsLwcXH8=;
        b=vE3FgXEoGC6m+xMn9cOB21/V8ruWCOUpCHmnFGUv0HfBMkgDaM5yJrjPl/MxbJKUnk
         Y9k6LcwjwffHWfZjjkglGuMNd0DK7cPyEFmiBf17ZcjVJpzoYa2OVSCG9eU8XEEIkEJF
         A0sD9rl+iHvWh4MwX2M3SV5IAeMOq3pgD/tb21fpeoRHoY2tOE86UvXfr/c4V4l6w2lH
         Jpa/oAgTKgJZN+PH3+yzdFgzF00QsftobKFGQaPp4aku8/6o15xHhgu1kZ/lpOdmKsZp
         cbHlfMD6xI8aEL3r/wvhvhqiY+I0wt2H7xf/ZULQMigJvrq0U46CQL/iQXcfdVTuHWcK
         D1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfSIqgNhQQlk2m2snflueKaRym87wbcQCA4TsLwcXH8=;
        b=LZl6SrWinSpP8CNVv+TAPcNTeZ5eSg145YrXVhACa39ECZruwnaQ0lh0WsS1i4E9R4
         r803ABClIGZ7W9GupkZBdgg48KLFYI18t5Rs9mJGOndAcsFcaOq4yOZMHKXN/ihqLQfG
         nB2PH0e1sv4sS80ZaPrZ97ZjaWppUszAdcOjZm8dfzL1CZTBdOl4GBYUb2X4rJRWHMYd
         CA50CDFTZ0wp8qsgnseY4QuVIfiU5PAVuJ/0APZT4q3SSEJTx9IDQ/V3lSl+P0YseIrp
         1vBzMqAslPnaIDrXGIkN9t0nKxcnY+NvVAuny9SKM8GLGCbpE1nHtHJNHNKJBzQC5/oC
         b3/Q==
X-Gm-Message-State: APjAAAUTlLEmOpdwDnGSlkgvp+XplniYMZcqt6J4glFTvqQs5tIOVHu2
        4bb+Ob1h/PVL/HVoQiOyClI=
X-Google-Smtp-Source: APXvYqykuAIIZrcnNn7o+JGufi05ZFqBoyXRCJ3XRXNlgMS2usN7oKRaD3ij3k6aNv98UG7SPFsVOQ==
X-Received: by 2002:a17:90a:22c6:: with SMTP id s64mr12757754pjc.5.1560538171571;
        Fri, 14 Jun 2019 11:49:31 -0700 (PDT)
Received: from ar135.iitr.local ([223.189.161.205])
        by smtp.gmail.com with ESMTPSA id w36sm7891858pgl.62.2019.06.14.11.49.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 11:49:30 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: Bloggin with Rohit
Date:   Sat, 15 Jun 2019 00:17:18 +0530
Message-Id: <20190614184718.28412-1-rohit.ashiwal265@gmail.com>
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

I sent my first patch[1] to the mailing list this week and received
very nice feedback. The blog about my week is hosted here[2]. Hope
you'll find it interesting.

Thanks
Rohit

[1]: https://public-inbox.org/git/20190608191958.4593-1-rohit.ashiwal265@gmail.com/
[2]: https://rashiwal.me/2019/review-time/

