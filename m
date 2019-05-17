Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775631F461
	for <e@80x24.org>; Fri, 17 May 2019 19:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfEQTE5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 15:04:57 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:57097 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfEQTE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 15:04:57 -0400
Received: by mail-yb1-f202.google.com with SMTP id d10so6955139ybn.23
        for <git@vger.kernel.org>; Fri, 17 May 2019 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=9QTcH635wKbZckKo0064Zo+YiYjMEIIzTcjJ4DmX6rU=;
        b=XpNlEPThFGsllrNzn3igAADBN0DVSR5bKkvZeVelS2evEzUuW7uJGVXu48CqxZeuu7
         GsuOZxseIQzv6bPlICi5H5aBfegWvORjLAzCZOqVR28nTEjdNBH1IbwsUfhbvMuVSHEm
         VQvBvZPAfhNfG4DmLhkvzpSb6p6XTEr/+IQkT+mnNiPRTTNz/ioESz6vxlNlh/kVPvSG
         zFGPuu6IPz8ISCJJ4hN/mSKIULPCmTURkhgQzKgjAyyVRU6l1LB4t+S3ysk7zJjatw71
         MHZG9XIDChCcyl4wifDFwCAE8Ch+racBZtmRtId+tzidQgiOyvqJZ85t3KVT3f1TzapJ
         ln/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=9QTcH635wKbZckKo0064Zo+YiYjMEIIzTcjJ4DmX6rU=;
        b=tECNNUiW8DTF7rr9OqmhvmIFXO1IJ9YwwXSgEX3QBXy+kGy5f3U3Bu2XvfmB/wpaJf
         aCfI+id3B4sFJ8UewZx/XzK9Fwc+8OOvaGmt5kj04cz+SYgPPWaC+ipMnzW4/O8YC5ce
         g519A67rNVTf7Ouqbe6eJztQZIk58xGU/bum+RWXy1pATbGVggph00CntAYN4qAsboFC
         S1PVE4KSjndtuWjj3/a78Uv0cIIwtbxOj3MlAIp5MPgraNMQiVUiDLkI2L13Z/uJvkIy
         zJ9Dx1kGShJdDBEheR2Bf7aj8JCSPB9evoNIziQuOtT47KoIcU5DhFxj5Odrz05nDMo5
         KtJw==
X-Gm-Message-State: APjAAAVbBy+GEr8z4PmTy/9hgN92RK1dueGEoMHaE4MgaGg0PTysvnGK
        ceUco1gedd3y8l+gE7JwYi7AsjbQM08Ndx6ODCB/9hNw/KYZqoBYn1arhbSFNj2Uew/IjTH8iKw
        huR80PvkmU7+KPNCm73+V+a54EF+MfBsbMWb1Iq67E+QSm0VfkKkSDIt9lGbXN9w21kxZrHF4zQ
        ==
X-Google-Smtp-Source: APXvYqzy4RIojbglad20Y1+CMlPdTxWARgAKV4xXjEaDoB3O811USR4g0A3k0HbYjkT0T0Lv9QcLUP5xyorYhs7blOw=
X-Received: by 2002:a25:7a41:: with SMTP id v62mr6021746ybc.14.1558119896387;
 Fri, 17 May 2019 12:04:56 -0700 (PDT)
Date:   Fri, 17 May 2019 12:03:57 -0700
In-Reply-To: <20190507213040.151799-1-emilyshaffer@google.com>
Message-Id: <20190517190359.21676-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v6 0/2] documentation: add tutorial for first contribution
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phil Hord <phil.hord@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only minor changes since v5. Removed 'official' from the blurb about the
Github mirror, and removed some spurious braces around oneline code
branches.

Emily Shaffer (2):
  documentation: add tutorial for first contribution
  documentation: add anchors to MyFirstContribution

 Documentation/Makefile                |    1 +
 Documentation/MyFirstContribution.txt | 1109 +++++++++++++++++++++++++
 2 files changed, 1110 insertions(+)
 create mode 100644 Documentation/MyFirstContribution.txt

-- 
2.21.0.1020.gf2820cf01a-goog

