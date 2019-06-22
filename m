Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C811F461
	for <e@80x24.org>; Sat, 22 Jun 2019 20:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFVUzO (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 16:55:14 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:34451 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFVUzO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 16:55:14 -0400
Received: by mail-pg1-f178.google.com with SMTP id p10so5028190pgn.1
        for <git@vger.kernel.org>; Sat, 22 Jun 2019 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+Bak3dFTSpOV6HKhz0L0TsxWrQwSBvBnoEFyWQxF+w=;
        b=FcHvuwnYDL+4pGy0/DBiKqwXVokP+HPN9Dltu1APcEnQ+n/H2/xCIeC1IOXYGu7vEH
         gUomwWnZSLYmB53CDo0/pyeyRRFrHIIoVEU+Zp1HY05cGJfooSlcC0tO0lOZGPbn2EA3
         5FsPW8Rj7WZJrYOnGAOO69dk8edEX+k4ORHvxEIz/bohk81U/HbVZJzY898B3pBqY1k/
         58g8mHHM8n+nHTiSgl+jHazAcfEvg7QFDVd3+U0KyEi1sFtM8zYFfrvoqopAevAOQxkX
         vYbcOSYnyIV9HU8NJIPbaJibSt6g+3SwlA29SN6ei7B/K1xXnsORVkjOmT3OhpS1GFa5
         0+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+Bak3dFTSpOV6HKhz0L0TsxWrQwSBvBnoEFyWQxF+w=;
        b=FsGszbX2NvtnoSdF53/BtvK07qXYO6ptNBf+t3w5qyjI/jI7eWDavefQXxJWu9kBpc
         V6YdPG0oPwwHg/z+u2/uiLRX3xWrRQshqPo2G/cSJYVPiDu7ahFeOWu2byv7ItIbDE7L
         9hbvtwjXG5gnJksy/5225ek04vrTV6pN+jCugTwcc8WQ4PA8MhxtXvAbR1dbc32BQx9f
         NuvLl7YO1CCzOkAYlYIg/V1RplZZdkTyaQAR3rxzFdhcDhtch+VZQSUlKcBYUEWbva8G
         vtkGks1bh0qSQ62bHl5NffC9wL9Shz4kP6RfWY3wYJOOv9q6SExAUkoGmeM5i1x6Ckia
         cm/g==
X-Gm-Message-State: APjAAAVFc9DL8wQB33/6AhS0myjy8FVE74KqA7h+c/js529CGKl9lM+L
        vmr5B2KlCbVlpAJKPFyai+BzcXJ3UE0=
X-Google-Smtp-Source: APXvYqwhWtTbN32wyEK4JNda1/JWSOKTdHg/AAOpmORfrEYjoMRHdQkQSgF3l1MHg7qtsde7wWVYEQ==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr14435210pjt.108.1561236913108;
        Sat, 22 Jun 2019 13:55:13 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.221])
        by smtp.gmail.com with ESMTPSA id g8sm7350907pfi.8.2019.06.22.13.55.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 22 Jun 2019 13:55:12 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: [GSoC] Blogging with Rohit
Date:   Sun, 23 Jun 2019 02:22:53 +0530
Message-Id: <20190622205253.13360-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone!

Last week was not so productive so, this post is a bit shorter.

Thanks
Rohit

[1]: https://rashiwal.me/2019/unproductive-week/

