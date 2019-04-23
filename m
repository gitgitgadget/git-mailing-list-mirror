Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877781F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 20:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDWUOE (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 16:14:04 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:37931 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDWUOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 16:14:04 -0400
Received: by mail-wm1-f50.google.com with SMTP id w15so1665724wmc.3
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=dyEW6iY8bQtnIb1u4N3ijQb0yCN6IaLBUa5Xw85v5qE=;
        b=b+TOfXTiio4DdA1dlXdWBP/HtX6FAnMnFW568RAFObVlDOyGZx2Lf0+5spzPs+xaVY
         SRfanUKEooEDLO/MN/+p6KgdNs7GpfCrL0q2dSxHmIKOVMr258uSnKDssJVzbiNEDkpU
         tK9mgRm3FYqFxxqwXyBbopMtT7zC0os5yF5YVc2UnD/6o4oOItHbL1IE8QZKgOO559zg
         CliEOmGTgd5alZT4905aBqhCP1H2DeX3VgBe/mcujXug46qiaAH7ivCJ356nHtvxuD+s
         noKmRxs4pzeTqKVLHDA7k6AcWjdsIwdYfrq7kucPr0LhrmSrrh5idGw5ux0StU5eOOcY
         998A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=dyEW6iY8bQtnIb1u4N3ijQb0yCN6IaLBUa5Xw85v5qE=;
        b=qRD2Eo9nvN058e4WdcXjfyrRG6GltRBXYCfvfCDjWZxT0zL8fuA79iEH4J1yQnOGf+
         F7t84lgjRqDV2hfrB6hkOxX4HbCp8TtdTnlwD4nQI3KQBeL0LBUyPNJ1i5xFAlISfzT2
         C4YiDh1nljKmFxRCI95WSylzdCbaj+R9k2u6Js2k/4ilXnsJO9mvE80hMgGB1i09dAB6
         r1F3gT4qDhP0vYRrpL52T4KvOPefoZfNf98kvn6gFh1Fl+wiJMGrSIajblQwd4u7Ikjn
         mNHDM8te4l8nY8Pv2TilBHBzVItVQG3UQYCntQSbw1l6eL9qRFJUvFi/R520RUiVIWpZ
         DJrw==
X-Gm-Message-State: APjAAAUYhzlFBmJ+3/ru4VDSzUTAKy0wD4XorYSsYiJ+sfsEb0wb8qbq
        O+NsR3xe/q3YqF/hg2Y8yEmP0NgMGWw=
X-Google-Smtp-Source: APXvYqzkCILvb7fL5vHnDFQP9GsDpRmSR03gqKf+c3PImUf1IY+0NcCV8UpOIdRLbHjdJG1rzvHbqg==
X-Received: by 2002:a1c:a103:: with SMTP id k3mr3816455wme.8.1556050442064;
        Tue, 23 Apr 2019 13:14:02 -0700 (PDT)
Received: from DESKTOPBJI8UAE (84-114-123-71.cable.dynamic.surfer.at. [84.114.123.71])
        by smtp.gmail.com with ESMTPSA id b3sm14340447wrx.57.2019.04.23.13.14.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:14:01 -0700 (PDT)
From:   "Eva Doppelbauer" <doppelbauer.eva@gmail.com>
To:     <git@vger.kernel.org>
Subject: Special crafted pull requests
Date:   Tue, 23 Apr 2019 22:14:00 +0200
Message-ID: <002e01d4fa11$1752aff0$45f80fd0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdT6ERSkx5/eIRaCRia8o0dIC9/kMw==
Content-Language: de-at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Could you check this github issue:
https://github.com/libssh2/libssh2/issues/360

There are two strange commits from 'fullermd':
https://github.com/libssh2/libssh2/commits?author=fullermd

Both pretend to change a typo - but they inject a huge amount of code.

Best wishes
Eva

