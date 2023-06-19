Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7508EB64DA
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 14:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjFSOyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSOyM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 10:54:12 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88E310D0
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 07:54:06 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77e2a18ae50so152796239f.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687186445; x=1689778445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMEiwNVcjfzemq8elNaF4nQvBY0uV+Z+FkJx1fC326c=;
        b=O4oH5xfegXK0RGmoXfMk01YBlkmdV7fq2R8F7/IJFTvobmTxwVQB8zqzRvnOUiSM9t
         2Z1g7pcZEYBsqDxqpX8PGpOGXwG015F78pRNKSE+YnZw6Z8pxfOt0smp+LnbGDfCDeDa
         WbjV9dD3B6f95V1VqOLIpUOFERd2DpST0LJGbrhzNNdTfKbRC5G0HXLo8hc9DwSTjGJh
         nEI/eumZeEhtPSlyKdompvc9f+bJMspKwwNo/kqMVEIHPN6/k4aYfsRFliSKLzAtU5qu
         J8ZLHZomknyPFhRPwxP3Iv6VEuQwrey9wCuvieTN2y/Xi7gd59k2vvZkPVxPM815H4ge
         QXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687186445; x=1689778445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMEiwNVcjfzemq8elNaF4nQvBY0uV+Z+FkJx1fC326c=;
        b=TCFQsPMUYMlkV+Yv9ekzYaOd6excNmSBvuuehxBjAOLyrTTSXILZ2N8iRyDopoVnhm
         vGKuEuLt7VREbhK1PZNmwsHJT0KA2pXNTy8F1pFF4azZFXgnqGLpznJlkmHWc3BC0EpF
         VL7uo5qESv50790LuRFWHP3h1zpqXXQEFRauzo1l9YVkbImzKUkQpSgpxLzarYAzB6ny
         oqFkM36B/rxL2GjnB1Fi1SSEV606tCBWwxh6E+s1oigMGkT5zILN0T/gtvUdd4pkD9tp
         nRyMaw5hOOvfS4vKZFgzWbqwMB7LimrHQLCEzJTONmgsz/gxHj1h8vKxJVUAwK7WiOcu
         rcMg==
X-Gm-Message-State: AC+VfDxN+5TmdR5c2QwPbTw5XcE5+W6PRAA2MhmMtkJh3OCAHKoMNu18
        CUYRNwrOfbwKodiwClQsRBd7thHCoI5JwA==
X-Google-Smtp-Source: ACHHUZ78YN2BvVTeEq98TbP0vmzzTYs5F7nK8UQRF+1oylnIRTh2pbuiyFZGnEXJyJdyRay3vngsbQ==
X-Received: by 2002:a05:6602:2995:b0:76c:4ce7:e37c with SMTP id o21-20020a056602299500b0076c4ce7e37cmr7803882ior.16.1687186445545;
        Mon, 19 Jun 2023 07:54:05 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-13-67-68-60-130.dsl.bell.ca. [67.68.60.130])
        by smtp.googlemail.com with ESMTPSA id l15-20020a02cd8f000000b004231a0cca08sm28477jap.43.2023.06.19.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:54:05 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com
Subject: [GSoC] Blog
Date:   Mon, 19 Jun 2023 10:53:42 -0400
Message-Id: <20230619145342.5830-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,

Here is Shuqi Liang. I'm this year's GSoC student for the project
"More Sparse Index Integration". My mentor Victoria and I
are already in touch for a while on the Discord, and I'm writing
to let the community know that things are going well.

Week1-2: https://cheskaqiqi.github.io/2023/06/19/Week1-2/

Week3-4: https://cheskaqiqi.github.io/2023/06/19/Week3-4/

You can read them when you are free, and generously give me some
advice if possible!
