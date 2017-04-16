Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4502D1FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 03:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754931AbdDPDKp (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 23:10:45 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36699 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbdDPDKo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 23:10:44 -0400
Received: by mail-pg0-f46.google.com with SMTP id g2so57880336pge.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 20:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=/ux+4fwjS/JzH+3MqIhGetji6bxmSROqcjBJvd8ttWs=;
        b=A6mJ50QOkMspqPApI+zw3213E7HhEvEPSNphsNSQDtoIZnTjtNJCQ5hz++PTc0zb92
         VRCVCdLqKsFOO8Tp2Ru7+O+0L486WAp4/7gj4mDCkaI2pvzNeViw7P0n04TvGWeA5SQW
         gGtiOW54LG0/40oRWEA+bjwUHFBSl40N2RbQKPcaSEeMYHkEYwIkcBcm3POxvHNH+JDL
         aF5FAsgnPV3booPTWpJPhGtaSr+NKDrVV5EKqCeEypi8yjGjDnHbAkHDAIrMwmeZcl/j
         fVNeWTuUhHUv+vdZgd8XhpLdBWL85OQSDCW16T2l1wc8z/zQGLSrt05MiH7lwkpWtLtt
         0qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=/ux+4fwjS/JzH+3MqIhGetji6bxmSROqcjBJvd8ttWs=;
        b=ET1nNEC8eiMCdNXJ5ZotB2F7ba77hFViSch/1uxDLNbBJ+N1dm95OWT+jqXqHqXg5f
         UVRk0BwwgirCREF7C1ykjz+QrtiXp7Ls2htD6H/93Q03IdyXMC0MKGpdwceJIoGAIdLw
         63o/pB9HpScA1P5LiUvZ6/UYk/PV8BaskALY3lWUPCsAmh9Q1Hu5Ga/oRkdLXY//QmM1
         83trmcCp73RkaENeFKn2P1/VSV5s5g9V2EelYPUr4LB2tkD7+kWui4xdRqXpRFi3cepT
         ET1nETy5Lsuxn9ybLEDF6S/7twaZffTOKjB8dUnK1H60Z0eBc2/Z60e9b7N/qHdZ0rMy
         zq8g==
X-Gm-Message-State: AN3rC/4VmWv3ZqDJwsk1TWyw7l7GY477saDC7QplIJTGcZbqb/8xYL5E
        C97tQ4/QAqm6dkC/704=
X-Received: by 10.98.55.197 with SMTP id e188mr5308875pfa.116.1492312243252;
        Sat, 15 Apr 2017 20:10:43 -0700 (PDT)
Received: from ?IPv6:2001:569:fa80:8100:8067:33fa:4f3f:bf10? (node-1w7jr9ulriemkbefjpb9dduz4.ipv6.telus.net. [2001:569:fa80:8100:8067:33fa:4f3f:bf10])
        by smtp.gmail.com with ESMTPSA id g22sm10565276pfd.22.2017.04.15.20.10.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Apr 2017 20:10:42 -0700 (PDT)
To:     git@vger.kernel.org
From:   Nathan McSween <nwmcsween@gmail.com>
Subject: [REQ] Allow alternatives to gpg
Message-ID: <9727e699-d97b-e8f2-ca48-574fc4f014af@gmail.com>
Date:   Sat, 15 Apr 2017 20:10:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would like to try to make git signing pluggable, this would allow for 
using tools such as signify[1].
Now I'm wondering if this endeavor is worth taking and what would need 
to be changed besides
gpg-interface?

[1] http://man.openbsd.org/signify
