Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249191F406
	for <e@80x24.org>; Mon, 11 Dec 2017 10:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbdLKKXv (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 05:23:51 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33646 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdLKKXv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 05:23:51 -0500
Received: by mail-wr0-f178.google.com with SMTP id v22so16984713wrb.0
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 02:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=RWPvJ3GpgCQsoV0C9CtevW+n8mkWwVHNETeoxxPUpGc=;
        b=T9mLkbt9mv7kZboY3iBhQfIq9u7W4q9oFNsm97j2rjD9VXxQ6lkHh/6jpcbUWLHloM
         oK+nuo/1Y4xj0B4nAXUSb8L3l5VEqoPMlILEgcp+tTVtGN7YIORG65Pb0v47ADF67MqW
         xbGWE4FFeqIZnrXwsGjXCB6dF2GL3m9FC5K4xsUzg7Q2M5q4qsIqVe0vhshGYJ+Hlu0u
         r4g4XN113MTyHkMshnGBzZSnuyPZiOC5CE2IxW8u0gj+TwXREqmaP8seL1nptG5IuzZK
         Ix50IWX2+PLPa+m7xh9Ac/ruisL2NRGJy2dxNeq+xmsR4JDc9ybsx4am4QHGPb8xYzBT
         QZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=RWPvJ3GpgCQsoV0C9CtevW+n8mkWwVHNETeoxxPUpGc=;
        b=Ryoul8x/Tb/n7kJH0jnYQGnYpykD0cwdEzuaEMmXSGDDgf2T31yPp2r6BLApb0/wnn
         Rir88zFYdx4xHbCiFpOC8mWWYS5IXA9xCgasZRcBybb46Qz9twvkCEAhLP0L1v5kK3ta
         lg5msj4+Uemg+/sQ4DhvrIyDekd+24saV4PYTI5+xXgxWRfrl9Z/kXVht+d/ZvCBbokt
         TJFO/LOuNjbtcZ/Mb/Pp6EOWFMQvovyLTuj1UM3ZC0ZQAWGr73VPHTLltWBW8hu42uUp
         0ZXvgawMB/CosVDfIiML8iqLVvPX84EuHB5dYA+llTb/ZQyduoTMNoljVnDfc4mrPfiG
         Wspg==
X-Gm-Message-State: AJaThX6gtQVeVunYNvVa9pkuWEAwyZFGPWQnqW4wAk5lkIZ7sPCXmlNj
        i/P2tYgdGhhkbLAZZ3Mc8bKOYiUS
X-Google-Smtp-Source: AGs4zMaqufJQhmNLAwsbqD1Nn96fKzyKh6MIJuWvydBKWVWF3tH3XJgDYb6jQ4CCBzkcgUrtRc7DMw==
X-Received: by 10.223.186.81 with SMTP id t17mr33093542wrg.275.1512987829555;
        Mon, 11 Dec 2017 02:23:49 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 67sm3478688wmq.38.2017.12.11.02.23.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 02:23:48 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: How to begin an error/die string? Upper- or lower-case letter?
Date:   Mon, 11 Dec 2017 11:23:45 +0100
Message-Id: <0ABBA110-59E9-423C-9A8E-9CF4BE2C4CA9@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

error() and die() messages seems to begin with upper-case and 
lower-case letters in the Git code base:

  git grep 'error(_' | perl -nE 'say /.*error\(_\("(.).*/' | sort | uniq -c
  git grep 'die(_' | perl -nE 'say /.*die\(_\("(.).*/' | sort | uniq -c

Do we prefer one way over the other?

Thanks,
Lars

