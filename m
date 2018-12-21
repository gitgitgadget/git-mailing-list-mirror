Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900771F405
	for <e@80x24.org>; Fri, 21 Dec 2018 02:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbeLUC2B (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 21:28:01 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40427 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731068AbeLUC2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 21:28:01 -0500
Received: by mail-wm1-f47.google.com with SMTP id f188so4178033wmf.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 18:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YpxYe4xDqSWmjUAGdsiO2xNs/ZQ5PgVMO/R5hTnT2gM=;
        b=Gqg5YbdQNO4oAXdHElJLSPD0P/Ohg8FQo0eVzFWkEdAhQ0CEPp3uDaDP6AD2AgKMnL
         IpZzJnHtUaosOkgV6KWVz05mGnxnEYxPhyIJ9eJemy9Mnos1gSjrJIoR6MzKTwMlSTF4
         wjDwcJePXjV4UokhzPr8iAp8Fqoc7yOoHgUCU6u9neYu2KIwWADNyg2AoNeC4ih+JIig
         odILeIniOBHl6AHIa1atx0iMrWFek5xK2vG3W6QWwtEwaRvzwQbGwTzowIULvDZCudUP
         ark93ay5zEcjuLojefpUhhrgY3V64TbFF04S0DGvwoRAA25KC5ItIK1DIXJ56nwx18uB
         YQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YpxYe4xDqSWmjUAGdsiO2xNs/ZQ5PgVMO/R5hTnT2gM=;
        b=qgnWBY+NRQiUVyKNY/J/KBgy+MOT7OYst8XkF3ZoGUPW4xCPNWkBFlVQrnXfNSeBgk
         4Ow5rZeaE0Ole43mEMHNFrSMNeOvtzmzhL4B6r7QUNW4RF25Td0R9cxSO8P90Ahb4vRy
         kRTgVTKRRGJmJZi96gzPmX8mmuuACaNZbCJP/R2urYGs8YK7+wqTIJfzZq2aeQ7nO5GS
         S/jKrSoYzKblt2dAATh6evZ8zTyxp2CcQIYdaA3yZ0Lh3jICIs+pKTszTW0e4bd3yt+q
         Cr/KeRmH0sYQVoa46/flo6qbRCP7sLoQFekYb8Q3Uo7r159EudRjK/UHRJktXJzUUyA3
         /pGQ==
X-Gm-Message-State: AJcUukcH2k1N08/PruMdxMV8+4lE6ipJT5RwFPBpqrFO7CylWMl0OXWX
        6eCs/5vY0ABcbgnjgqY2R1jiFQ+xpz/xIB0LjbZ0BT4E
X-Google-Smtp-Source: AFSGD/XcxK3RbD1x+aF/jrXApnkZHfZarVxYB8UzKQ/JhNqxWq4CkPqCk031jvqZ48sqFVdQmlLk/15MkbZqQSyGPQ0=
X-Received: by 2002:a1c:81ca:: with SMTP id c193mr922896wmd.66.1545359279318;
 Thu, 20 Dec 2018 18:27:59 -0800 (PST)
MIME-Version: 1.0
From:   Nicholas Hsiang <xianghongai@gmail.com>
Date:   Fri, 21 Dec 2018 10:27:49 +0800
Message-ID: <CAEcaDLk_vid3Y2z-kX17d5_LWEQTF4CYiztqrUFmOpN-YW-3yQ@mail.gmail.com>
Subject: "git show --usage" no "usage" displayed
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git:

When I type `git remote --usage`, The command panel will prompt
'error: unknown option `usage', Then there will be `git remote`
related instructions.
But I type `git show --usage`, just display 'fatal: unrecognized
argument: --usage'.

![git-show-command-no-display-usage.png](https://i.loli.net/2018/12/21/5c1c4d34075c4.png)

Sorry, the previou email forgot to write the title. The previou
previou email did not remove the HTML format.

Yours sincerely,
Xiang HongAi.
--
Live Long and Prosper.
