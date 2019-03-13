Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C8B20248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfCMMIO (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:08:14 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38658 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfCMMIO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:08:14 -0400
Received: by mail-ed1-f54.google.com with SMTP id h58so1278300edb.5
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdWC7IVILm/kISHVEu8jqypBEj1VZyLRC5wvsHh0kps=;
        b=h56UxCf14jTzwGgNF7EbqMZR6lYSC8lNnfJYC3ODPESTFdTdQzgOdMZH3d+CL3cY+w
         0GM/NwAAAJpPNM458eIw0yip89miZSprkdFUDCFtDPBBFDsvtsLWcPLuqmg82CYZQLes
         ORVf1I2dNDgn0E4MFAhUQvSXlPuIAGkg4MYm9LxX2fFAhXMAF9/fiAY7+iJzSjKzlvdX
         rLoLPPpJJsO7yJtXnvzyFpjyQHGVYUkFyxBkMaTHdOL0Sy/fZZtObE1kI74Gw/yyzQtH
         qQlroooKuhRbaAbktvpPohgZ1jNjpHh7LYAKoaN3w33th5a/t6ZOMViBkMyHO/ylVn1d
         oRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdWC7IVILm/kISHVEu8jqypBEj1VZyLRC5wvsHh0kps=;
        b=VtjYpB8hwlr6LLxZ5WDnJv4aKyBNVsRkrcK//upfUKOxmCBg6UGWEKiAW39HZi2box
         yqQhbtmWZY8jKJArxk2U4cCCOJusbcpMKa5y4mWD0aMiXpmO2DChMKo1wetJ89zsQP/H
         sCwvt8+AoaMnVHK0MzK/BkpLZBCyDxg/1GyeLTxl/ndbOxmZn3B4HDR9vvwGhmsWFKUw
         1JAQ3RQP9qpFwZycJeDlYkEOzRv5cpG1+rE+Zc9XHZQcRNwKYIKtkz2iD/Y/HkiBTf88
         +UHAfmj4dnMilpvE757v6QmAaMygUrgui2y6GgiR2oLqCsbkn2723pmPn/OsiudM3Vos
         Kv8g==
X-Gm-Message-State: APjAAAUPYsMYMZYdojAXhcF2mfpktcK0opF7vkAl8+itofocZGlQ7wz7
        s7VZazguxUyKSRhks24962iPCVgFFxmMbw==
X-Google-Smtp-Source: APXvYqx5lR+naZKpvrNl+zSsHDxIH2xT58uwpb8T0u7AZJLTzaekfANbnPGEq+3Ttj/UGPlRd1D6QA==
X-Received: by 2002:a50:8a8a:: with SMTP id j10mr7648265edj.45.1552478892166;
        Wed, 13 Mar 2019 05:08:12 -0700 (PDT)
Received: from ashopov-C02X544YJHD3.corp.uber.com ([213.208.239.148])
        by smtp.gmail.com with ESMTPSA id i9sm405983ejc.67.2019.03.13.05.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:08:11 -0700 (PDT)
From:   Alexander Shopov <ash@kambanaria.org>
To:     paulus@ozlabs.org
Cc:     git@vger.kernel.org
Subject: Update of Bulgarian translation of gitk
Date:   Wed, 13 Mar 2019 13:06:32 +0100
Message-Id: <20190313120646.14248-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Hello all,
I am resending the update of Bulgarina translation of Gitk that I last sent here:
on 4 of March: https://marc.info/?l=git&m=155169580131311&w=2
Any idea why it is not getting merged? Perhaps I missed something or Paul Mackerras,
maintaining gitk, is busy?
Anything that I should improve?

Kind regards:
al_shopov


