Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,EMPTY_MESSAGE,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_EMPTY_SUBJ,PYZOR_CHECK,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04CCB20248
	for <e@80x24.org>; Mon, 15 Apr 2019 21:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfDOVtj (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 17:49:39 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:36341 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfDOVtj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 17:49:39 -0400
Received: by mail-pl1-f174.google.com with SMTP id ck15so9244592plb.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=aYIo+qqHAAKg7SKmIoDXutvW1lhlJhYqpuwu3Ed7r7nXEAdIJM+snPYt/5zrylAqPm
         57T+TUOeoaIflRtaYKjEp4nJQZTY0iFf2TmlwtHGRfcUOerk9GnYdNjxZHse/SxgCZv5
         qRl95HkKiJYGsBEvlETEaYovkxj8wA0cpfTsl0dCJBKpbiLJPma0VJEXVGeTg9A0nU4N
         DgQ7ILdhvuXOqPhDbaYYbtt/9pYIGA+L0zB9FiJsF+pDouwGnvRa7fg5/KA/sgo56gsN
         kDi+HdX0uNzqxclXy9puw3bBMCm4X/qyYaUOdUzHgvIFHC+ulsYzugFGFzZVVIOGPOPW
         n5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=fzcieCQpKTdu2QJsth+/ix4P3y0n6NNootfQJRa7BbbhAlT1E1e0MG2Wkii3831bZ2
         8e4SIPqQKNEGJlIDnMU8mJdtN+FclMT8EPO5oBIhtuXrLW/wmIUEF5kBEuSQ6wXAYjN+
         ZVE8PspBkKoKATS+eiKEwWnIqPfjy15UoDO3whGrQKGBVpFo8CCrPznELWji/w90OcZM
         IWjqBP47hdODmOksfglclzObtWEeluei0d/tduc3gPIUJaoEgtw9ERUGeKL7a4i/eqat
         sVQ7eKmtoQm6n57xmGyy7OVF3tY6HgJT49e8qmEoydMsXRZz4K6jtvVXtRDBm7FY/NOG
         8wlQ==
X-Gm-Message-State: APjAAAWVrwrkMLM1MZ6yUjRZBaxmrhj1oEGDXZzxvSaQVSfkVufYsQrU
        UoJcrbRu6ogMgw0N7aAsgkXWAMpUH4Q=
X-Google-Smtp-Source: APXvYqwQMlqge8NcDK1xFgXbos+Vdmg69t7JkTgowRO1uVt4zg0Vx0TE1SG/mWo1MvLwY+HO6zrO+Q==
X-Received: by 2002:a17:902:280a:: with SMTP id e10mr59841204plb.244.1555364978642;
        Mon, 15 Apr 2019 14:49:38 -0700 (PDT)
Received: from [192.168.1.7] ([103.215.99.84])
        by smtp.gmail.com with ESMTPSA id k10sm41387516pgo.82.2019.04.15.14.49.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 14:49:38 -0700 (PDT)
From:   Jivesh Singh <jiveshsingh.js@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: 
Message-Id: <8DBF3485-3C07-4EE4-A0E4-4D9D7091A820@gmail.com>
Date:   Tue, 16 Apr 2019 03:19:34 +0530
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

