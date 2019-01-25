Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A351F453
	for <e@80x24.org>; Fri, 25 Jan 2019 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfAYWAq (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 17:00:46 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:41509 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYWAq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 17:00:46 -0500
Received: by mail-qk1-f178.google.com with SMTP id 189so6297803qkj.8
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 14:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zgPYQWN5qRZktXCB0lg2Du/ZhGhe/JDh/EMa3uxXjqo=;
        b=b/+CkckHxtnruw+WUPgS8lkE0scZkFgBZvmjwmJt5p8DZjrvZ6RABWRxZDmRC3MnHi
         85uKjed7aiqLcGvFLk9dBjgc8hzDN7KmBD9Pkccx9wptUmESyNv+7/q+6TyPovGecSHb
         aWZ36zy1zUEoplzdjHWXHjkmMDCcmIjSw5mJ1+hT3/qlOUVj/J25fYF0WflbSeiPrZPC
         xfpKnaeDnkzth5JeTc7mQ03ozP3O6HoEyHGDoiD30MbglFn/3QjOuc+CQncpJ+jU5Jq7
         A46zQ3NCyE8uEkGdiqcLogMAWFIiblJ3IkrbXnebsgIMpgPKY3jfh1tH3gGgG1dUauVq
         Cxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=zgPYQWN5qRZktXCB0lg2Du/ZhGhe/JDh/EMa3uxXjqo=;
        b=T165muWKXuuuCUDGTTOrzjg9QhdnLIU9U75vIYEdT/XPDnPF1EKFPeUIRg/OiCCVNk
         PmzBbu0s9UxulZnIkYGSSc7vU8iDfIrsicknbc90HR9S/QIHNmkRZIHjurhTJPKW/COS
         UvGg5IHttLNhxLCpGVEmp2nekOL0yWxLA0ZHIl9eSv5A8WhhuleQ+0fRSfFERxOcgzla
         B0IqqTVAxNjMtob/rkgvwsRZJm4+netpoeigWlFkeAGTJC4OOimMPtyDTeQqhnSptILh
         z0add3GrJH5v4R7t/K/+wE52CDZR14RaHAg0xZ7YmUylKF2QYgGV8JYEMYZm8iYKkE13
         Lqvg==
X-Gm-Message-State: AJcUukfIelE9UetwW7/NE/roxERXQ/Bp7wjU9D8zkh0Uvr0HqA/OpbO1
        XnIW3nGEsqGhAcFYFhVoP+KpiVJ2
X-Google-Smtp-Source: ALg8bN4vXY0dtrP3RkkrQKae2Mr92UzVtj2HRuYF8O0mwy5Pxd+9CgFeXQzEo7XphwaQNuzDrcQf5g==
X-Received: by 2002:a37:8006:: with SMTP id b6mr10815314qkd.19.1548453644929;
        Fri, 25 Jan 2019 14:00:44 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id x11sm51456652qkh.25.2019.01.25.14.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 14:00:44 -0800 (PST)
Received: (nullmailer pid 30173 invoked by uid 1000);
        Fri, 25 Jan 2019 22:00:42 -0000
From:   William Hubbs <williamh@gentoo.org>
To:     git@vger.kernel.org
Cc:     williamh@gentoo.org, chutzpah@gentoo.org
Subject: Add author and committer configuration settings
Date:   Fri, 25 Jan 2019 15:59:53 -0600
Message-Id: <20190125215955.30032-1-williamh@gentoo.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All,

this is a re-roll of my previous patch to add separate author and
committer settings.:s/committer/committer configuration/
A

I attempted to encorporate everything from the last iteration, and all
tests still pass.

This applies to master. Please review.

[PATCH v2 1/2] config: allow giving separate author and committer
[PATCH v2 2/2] tests: add test for separate author and committer

Thanks,

William


