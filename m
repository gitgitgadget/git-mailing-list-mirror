Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E26F20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdFAVls (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:41:48 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33049 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAVlr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:41:47 -0400
Received: by mail-lf0-f53.google.com with SMTP id a136so19740000lfa.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ngMEsA39iqmTlANUxbVr1ieKIto3GBHoMe9eLiOFAsw=;
        b=ME3PpkjNBLr7c3b8XRF1CBjCXLjY9et0i1lwCpP6wb9iHJFLGe0/df//CAQ1Fg0zp9
         tjQ7RGIR7VZ8uyOq8+eMe1NAcWavnkQDuBHolagyF7IKBmn5s7dhU45V5t3Asnu2cuso
         oN3V5go9D576wx0tEZhZd1Jbl/rDCnzPkU+WWYDfqbbQor/Ci9hKrLYT9b4ir4DLSnn0
         clPad5fgz678kUEs5tiTvYd0Tv9h+zgOP1k+oKTyf01KP/aMyQmCPmP161XnrycCSD0L
         8yTJFDqhm5YbpVsyUb4J6In4encT3OSGm39NorryVOSTHl3bziD+DAbb2qJdO3tscOOq
         bQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ngMEsA39iqmTlANUxbVr1ieKIto3GBHoMe9eLiOFAsw=;
        b=PHW6I8zR02ms32j1MD97loje4tyDRbnr4jHg0au++bmNDvxDuyTgCL7VAkmfP+FW1I
         yxV7OCX15/ydpBfk4XFGinyUVGxxNNi7ualx2Xh2L+9hftbzad/hd2Vivz4vZmeTPQhO
         3z4lQR0p7IraXk1TgMN4/QQy/WVRHxjUONSeM79eptiHVbIttYp3spcrkOZ1TnhQiwfC
         4KWY0oES9EenoOpd1xebjyd4HazDQtaEMs5aIY0+jYTxQr43+LCzhWjDJ3t9CJkItVNV
         xgFl5nkUjQhqhXtWy4vE4REb92mjOYhnSCJ3zj5n4G8IoHTocOWfXw2AGVkmZqzL05X3
         M4qg==
X-Gm-Message-State: AODbwcB7DSheuedleee023FZJZ1Euf5fe6KphXYfUoRlr2psY33OmIUl
        xeijcef+T4oiaSUmaiQ=
X-Received: by 10.46.9.5 with SMTP id 5mr1256386ljj.120.1496353305059;
        Thu, 01 Jun 2017 14:41:45 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-95.na.cust.bahnhof.se. [155.4.133.95])
        by smtp.gmail.com with ESMTPSA id u6sm4482419ljd.42.2017.06.01.14.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 14:41:44 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     git@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/6] Some more git config completions
Date:   Sat, 27 May 2017 08:25:46 +0200
Message-Id: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some more completions (from what I could tell, there are probably more
missing). Please let me know if you prefer them in smaller (or larger)
batches (or if the patches aren't wanted at all).

Patches are based on master. 

Rikard Falkeborn (6):
  completion: Add git config gc completions
  completion: Add git config core completions
  completion: Add git config am.threeWay completion
  completion: Add git config advice completions
  completion: Add git config credential completions
  completion: Add git config credentialCache.ignoreSIGHUP

 contrib/completion/git-completion.bash | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

-- 
2.13.0

