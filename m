Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976521FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 21:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbdFSVdI (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 17:33:08 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35857 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdFSVdH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 17:33:07 -0400
Received: by mail-wr0-f178.google.com with SMTP id c11so26000089wrc.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=5T7iDu5qk78RtrOIabSe+0JK15uX6Zn+/w14ifzbqvE=;
        b=TRXpHkbTiyOnXtLdH0aJheiLiGdSPfNMVGigIW09J7V3pqnwftDHFEmN3ftmqCcRf9
         1myzcqlnIPnQEDOuNC4EokSI9ViAakx3AbqKGh5+3E6HKaXMDd7z7xRgqrJAmCp1z8pS
         28pHJCzTBJx37AfqY1t+7owz1fOg0jMMW1yOuJ9X0semEz9/PvhQbTvoq284bZq48mT6
         lpWLktqb5x0KJPtdofnwDnFQmNA3F7GM22++QN2qcysbuYw/7p+hpdSmg35D5wF89b7H
         /7tkIHuPaCEjI8AUOCunjfacWdPdO1suqFUlNvxfTZ4ufCFZClUWQMTHvgTceUnSvQwr
         TF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=5T7iDu5qk78RtrOIabSe+0JK15uX6Zn+/w14ifzbqvE=;
        b=InXHtujyhOC85lysFjaIiHpmOW+g9tyJJrsKd2zerjT71wqZUM2vHMNuXRJ5VUV4ll
         QrezvVFiuujmFkEInemI8TeoOKLXt4uILk4/RMj9K8l/tRTR52SF8m9SprI4X4Z/XtBE
         9DqqJPbU+GdxM9NasrsE7Oi1XXQ4WuLEr/kMBPNjX4oc1Y9GDCntMGFufu+ytTYbNlXU
         3D8y8hjwulXl7WaNswuweCtZa37DjjOk8bjpCtfvnDexk/LcfNpSnjPMeaIszY1KA18B
         C0ezkP+X+E/Ou0l2B3oW3Eg5VNYey+txM6LFqJjRwDlUCLRIWOiaWQ1DOA6pXT78jVqd
         kJzQ==
X-Gm-Message-State: AKS2vOyA4ez/CD/6m4MRPHXdh/5r0raUu4g4Wz7LODNVc1LsBUOLd/kD
        9XPQoQfq7Fo5vWEVst4=
X-Received: by 10.223.132.225 with SMTP id 88mr3076551wrg.80.1497907985857;
        Mon, 19 Jun 2017 14:33:05 -0700 (PDT)
Received: from localhost.localdomain (148.152.82.79.rev.sfr.net. [79.82.152.148])
        by smtp.gmail.com with ESMTPSA id m187sm11823938wmb.10.2017.06.19.14.33.04
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 14:33:05 -0700 (PDT)
To:     git@vger.kernel.org
From:   Reda Lyazidi <reda.lyazidiprojet@gmail.com>
Subject: Git Strange behaviour with remote deleted branch
Message-ID: <39331ce5-dbf9-170e-e550-784db10b966f@gmail.com>
Date:   Mon, 19 Jun 2017 23:33:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

with git I noticed when I removed a remote branch with git push origin 
--delete <the branch>
in my clone when I used git branch -a I don't the deleted branch
but my colleagues still see it.

I tried with two clones in my PC, with the first one delete branch and 
the other still sees it
despite git pull .

I use git version 2.9.4

Kind regards.

