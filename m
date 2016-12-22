Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7734F1FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 22:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939457AbcLVWeU (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 17:34:20 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36101 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbcLVWeT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 17:34:19 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so38498662wma.3
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 14:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=RyyYcZUf1s1mahJPzQe+I1n8/4IZwKu/cC02mmtLVLk=;
        b=Bx5iV4R+1Hf8qhmNRDtOpy8o5quFyF1NJtDq14pP27u9Vj/6o3WfrH8HJZSGvKjA51
         gieWBFDqqruE+hsI480sN4lthxBTmvZB6luKwzyzF60IVA+nxVDrFzWMSgcguD1mZuIh
         xecNUoCqIQ6wfwGT2gVZKoCqFBZCDd0Uw3S7TguSm0w9XgnUrMu0Zk6MgDNJbAk5kryZ
         +cPFDpjgkTtwq/VxweXEU1P2VzkQ+G5KyGCKHu1ru3WpP5EktFdboXGv20GoCbjohd+m
         QWeCbHPAMsiTZsvXN1NDR9FNKstXUSANxa5PVe77A0u1gyO75+MDBpcoZ6wDrWBOt8HL
         NzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=RyyYcZUf1s1mahJPzQe+I1n8/4IZwKu/cC02mmtLVLk=;
        b=kQBkrBAIDp1qdhAVFy9ay5bwJsUNMQqx45IgREGCgPGjeDwFmbtgxRnRQ9DaQnPEPL
         Fu9mCLuL1/v3EHAsZeVJubyfe17vqX7vgGcv47VH3A/by9PaBj8Qoryqsh/UdnwodySd
         mr39VnYDdBJRQt+CJaPYUXT7NAOINH9Dcvld4k6mn2l8o2FmGxfMQevSerpnq7YBBlZB
         hwnNSIonUYLMA9+AAJfUIDTMihEAWY7OyauVItRjm6yI90V6+u+ibVsmmAwoiS1GcJCS
         cJdkim0K0TgXOdmuLABuxOD1p6fL8niwQurQn1ZbpabwwFQHDQfOnSY7KAW105oQUPH1
         uvNQ==
X-Gm-Message-State: AIkVDXKuPVTpMYMrMMGcdXbVUZzyEusXdf6JzI3Hv54VObD2ur224cXpkYOzAVJ+j9w3/Q==
X-Received: by 10.28.68.137 with SMTP id r131mr12887117wma.72.1482446057882;
        Thu, 22 Dec 2016 14:34:17 -0800 (PST)
Received: from [192.168.178.20] (p508BFAB0.dip0.t-ipconnect.de. [80.139.250.176])
        by smtp.gmail.com with ESMTPSA id xu5sm37583770wjc.49.2016.12.22.14.34.16
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2016 14:34:17 -0800 (PST)
To:     git@vger.kernel.org
From:   Daniel Chumak <chumak.daniel.dev@gmail.com>
Subject: Feature request: git rebase --no-edit --continue
Message-ID: <6ff2c5a3-fe81-0bec-ad9a-d62bdb4a176f@gmail.com>
Date:   Thu, 22 Dec 2016 23:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a reason why there is no '--no-edit' option for git rebase? I 
would like to use this option after editing a commit and continuing the 
current interactive rebase without having to change the commit message.

