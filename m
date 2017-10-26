Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DB12055E
	for <e@80x24.org>; Thu, 26 Oct 2017 01:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbdJZBbb (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 21:31:31 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:55646 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbdJZBba (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 21:31:30 -0400
Received: by mail-pf0-f181.google.com with SMTP id 17so1292721pfn.12
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 18:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id;
        bh=/FgaOTKfGTY/qTCe/BUDPT4yC2h7tXc+9g9Phkwn00M=;
        b=LckrY39GRx7SGcy/9sgQheVeGMzUfG8Bz1HNMgydSvuGEpuOGk3b7JfBor8rvpTeLK
         4PGEYPIGH8rnZhD8ZosRglojpy46DSjPn4rU9bnKLSZL9xWsPpBC7paeGRI1n58bCGr0
         q6XEps5LBfFFKxnBQ1T0p8b0khQw72c6q6x8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/FgaOTKfGTY/qTCe/BUDPT4yC2h7tXc+9g9Phkwn00M=;
        b=RAEC0Zemc7osdFUkCMmOq4ckbqOnHTVulriODiyKOkU017Nmh6aIGkO8hH+2iJfy0d
         zuavWpIAFbyA49Oi+kR6KZxh1OCYSWnLG91frY+v1nVTQxSfh99Z62LjGHegfKOMuwgL
         LjQFLB6ip1xTWN0Irgs2o+wVXN2ZMj1CqpsQOjr6WmQm4gUFHmB+Woz6v7LgsWrhV6YV
         6jwWxgCWP3LWLgKOmRwwZJ1rjYpqT9WBtEgboucha4429HvRnvx/rP1ou4zoMLqHdZmO
         Xw9NmB7yGYfheeUYpVYtcqLsU1lmmuY1rRHbtHvO/dxdrLhte/6RVUGhr4L0DQ/mhw09
         p9Ng==
X-Gm-Message-State: AMCzsaWANKjAm91uY5qBKnRBGdtRPrL9BrxF21qKpQ59shXLU5p+qlKL
        O8h4rm16aiXlG1hmtqsEF5Ij5k3yV28=
X-Google-Smtp-Source: ABhQp+TDKuB0OpEZ689VMChStmJ3Wka33dsonikl9LRNd+I2AhFJVkmrIcZ8xVH13MVqSSKrkI0r9A==
X-Received: by 10.98.78.202 with SMTP id c193mr3840881pfb.295.1508981489131;
        Wed, 25 Oct 2017 18:31:29 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id s3sm8159206pfk.7.2017.10.25.18.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 18:31:28 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v2 0/4] fsmonitor fixes
Date:   Wed, 25 Oct 2017 18:31:13 -0700
Message-Id: <20171026013117.30034-1-alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated based on comments from Dscho and Ben.  Thanks for those!
 - Alex

