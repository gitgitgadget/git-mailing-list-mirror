Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FF71F453
	for <e@80x24.org>; Thu, 31 Jan 2019 07:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfAaHBf (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 02:01:35 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:38855 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfAaHBf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 02:01:35 -0500
Received: by mail-it1-f182.google.com with SMTP id z20so2412092itc.3
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 23:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Olkj9pk+OMN5z3BOJ5+YVhVh593t5KJsAVqcmjzUddY=;
        b=CubGkKoNgXdw+AuQbI7VKs3TNxsaoSI27h8VFXGMce/9g2dgsY0jFuNU9TVz6r0UDC
         zoiGMAe+A+Bg4gSOG94BjQ82YaLD0ZYKCVTXeauPJxFXL50/PYz8ka8VXqJxNAdK82wL
         nwUNk41FgXA1EN4vSJDZCBqp/FAo9MRe63XEidMVu1Ggi/LmhWqsrldOTOcvEnCXKw47
         z6/w3pCrgy6MwzWgmvjtRCLfJpq6Q0l2glvzKOKFX4NCI+fF5wMcf7RCcEcCx0oFsjIo
         kkFBa47yq8LrFmU84zGerBUHseYiR3lepgbIhfUSUr6B9hSjOMJAEyUcg/I4VOWxfUtA
         xZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Olkj9pk+OMN5z3BOJ5+YVhVh593t5KJsAVqcmjzUddY=;
        b=qSQS0LOL4zFVwTp0lxrcDGxrU34FT015oxUWWMlnOlE80ClelL+4FY138FODByH83n
         fNknnpyP6pHuI0jkdl/cezQtSscuqjOK+AZdEWdhEoaRp9mpj8QWMO0Joi9Y+FWmRaXA
         mPf5RsuHmzR9uFwwG7oXfabZNaUjJ9eSK709grrShvW/Xlgr+oOZQa5JRFIXigJW/QSD
         GuufC1FrVfg9H3mStf+mqtb9plHstlrJCmpaYoMs+xSkFaT76/thf9DAeihYMokZmxFG
         t+3gYaWmUDS0fHR7XOOVlPXigvH8DQMNEwinnZ44nUg2yFAAqnohlYyWuc/RVHvQSs2V
         vtAw==
X-Gm-Message-State: AJcUukcg4zet5G6L88mLbqlSy3xVIAwOVRb6biylxM/ZmGU01DMGDF0I
        aDF1ENNqtnWnZE6nqjf6If5OG8Y1+vvxxnvZZjNd60Oh
X-Google-Smtp-Source: ALg8bN7R+pI+hYcQNwyxblCTPK6WgmJ1jIN7oy6ZsH3NRCFxDz7MH8+pHKrM9iK4u8LyFe9PIrSAbXL52f6S+Gqa0BU=
X-Received: by 2002:a02:9549:: with SMTP id y67mr21345378jah.4.1548918094223;
 Wed, 30 Jan 2019 23:01:34 -0800 (PST)
MIME-Version: 1.0
From:   Angelo Melonas <angelomelonas@gmail.com>
Date:   Thu, 31 Jan 2019 09:01:24 +0200
Message-ID: <CAHYHVP+ty7i7a_abT-th_HR2X-8X6mLmpHPR_3VXv5LpWUsrhQ@mail.gmail.com>
Subject: Possible minor bug in Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day,

I found a potential bug in Git for Windows. The bug can be reproduced
as follows:

1. Modify a file so that it shows up as "untracked" when executing the
"git status" command.
2. Attempt to "git add" the file, but change the case of a single
letter. The command executes but no warning or error is displayed.
3. Execute "git status" again and it still shows the file as "untracked".

Please let me know if I am mistaken. I also have a screenshot
demonstrating the "bug" which I cannot attach to this email, but which
can be requested.

Have a great day.

Kind regards,
Angelo Melonas
