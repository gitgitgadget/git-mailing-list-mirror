Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3431A1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 07:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfJDHTt (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 03:19:49 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39765 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfJDHTs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 03:19:48 -0400
Received: by mail-wm1-f49.google.com with SMTP id v17so4668117wml.4
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 00:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=sHr0f4q8W3t8TEQi798GUhYzlm93igEDmBo+7r/e6p4=;
        b=b2d8BauWnQCiJb3VCTddvbEyKLRqhiQhhPB9DyQH4feQLprybFEkHk0ez+7GDixq+o
         tdSKbOFw/9G5mjRppF1qI8p6j15w/2aPXLx4oQT6w7hHC8i5k8Ow++aks39kGFSbspH1
         wBp5/qrPX6FjKwYOhSUnYxvVftkjNhX/j3bEGWuw5le0N0wq11/Z+AOk/67BLgiY0+YQ
         rav7O5HPq/llrjt4xaebjsu2zV6QI21dC3Zff1frZcUj6V6CQOlzi7ZanxFtvSkBr0Qd
         vSQ7BpARnrD0DntTx6ffxLUW52xP473LAmejhpaGZoMIkJWzxsfkKTfz6sQ/Cr5uaJ+0
         v0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=sHr0f4q8W3t8TEQi798GUhYzlm93igEDmBo+7r/e6p4=;
        b=U86Tjjt4HzjQfy1P7OUiVMw/S29Vmlsv/bbWAY/64jlEilD+XUhLPtW3n4wwc3yUXO
         73buP2T1m0U7XxZMwxj+oZb3vZQasPXLWQQPsM9krnCqCZxeOn1+IlmEgRHO5S+Dsqhv
         JN6RyjrpV3AxHIkfDni+AA81tjg4Q+HOId55DPAsEFeBqErOPAAlJLYKh5GDibGLDQ7T
         2ms0h1OkBxd5ywLF4tktJyQyERItoULyCK8FW38vBICIm9syn8SJ8KRNPfLSfVeV4w3E
         qstXMzDKCH4m4AEmlDNH63Ru1FYuuahO9XLYexduNy7WZlMClS86iLEDd25/+5dGunHR
         xVKQ==
X-Gm-Message-State: APjAAAWjMZ/f3MkGZn/qVaO9mv/ug8XPewJd7XRuxzrTV/cEgrb3jcxS
        pLH4eJ32EWco4c9rvdectv3txcc+
X-Google-Smtp-Source: APXvYqyXeocMxiKwNyc7AV7ppO6wTWoZ8p91+fE2+iy/7OEmGPgi/GXlHdYBqParOXv0kUzCFki/ug==
X-Received: by 2002:a05:600c:2052:: with SMTP id p18mr9602718wmg.13.1570173587393;
        Fri, 04 Oct 2019 00:19:47 -0700 (PDT)
Received: from colins-imac-2.home (host31-53-1-137.range31-53.btcentralplus.com. [31.53.1.137])
        by smtp.gmail.com with ESMTPSA id e18sm6725208wrv.63.2019.10.04.00.19.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 00:19:47 -0700 (PDT)
From:   Colin Agnew <colinagnew@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Git Basics Episode 1 GUI
Message-Id: <763118BC-2142-419D-A48F-9CD48865CB06@gmail.com>
Date:   Fri, 4 Oct 2019 08:19:31 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Could you confirm which GUI is featured in the first video?
Please advise - thanks
