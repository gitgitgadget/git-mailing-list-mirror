Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C821F453
	for <e@80x24.org>; Thu,  1 Nov 2018 10:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeKATWu (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 15:22:50 -0400
Received: from smtpoutz27.laposte.net ([194.117.213.102]:41687 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726320AbeKATWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 15:22:50 -0400
X-Greylist: delayed 1232 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Nov 2018 15:22:48 EDT
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout015 (Postfix) with ESMTP id 75B9127612E
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 10:59:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1541066395; bh=n73ASIzTnGTEcYzdbIAw0D+4/eNMXLO42/uXK6LarrQ=;
        h=Subject:From:To:Date;
        b=KBhv/oOdHaWuYy2pCNXUvbRyAUhPlQw6QGJg80MAeVnbElwkmM92e7kDZWq7bL4NM
         8osvrwK+LhxiVIq8dtPiaEhIuvTCBSjyLg1RD/2xWwjyRvm8Bh22KqJO91ar3AHHKG
         E+QCftNp1Rbka7Tc7AxwmokmGfbKkp5MjbiN14OgUsF3kKxSXlV1Kcn3jP61iGfXKv
         5zBXfQM+DH56JWDjm0JegD9GnRmUta8NTib03t1xxWIZ1ozKZa4PZLlobd6MB0ms2I
         0olNQe9p3sK/jRnbBFi4qbtwEE/isMPwfEgZUDyzr7E8ubKx+JcewbK2EFjYfZiJHT
         cI6QLxHDoEqYA==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout015 (Postfix) with ESMTP id 6617E27759A
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 10:59:55 +0100 (CET)
Received: from lpn-prd-vrin002 (lpn-prd-vrin002.laposte [10.128.63.3])
        by lpn-prd-vrout015 (Postfix) with ESMTP id 6152727612E
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 10:59:55 +0100 (CET)
Received: from lpn-prd-vrin002 (localhost [127.0.0.1])
        by lpn-prd-vrin002 (Postfix) with ESMTP id 51CC15E82CA
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 10:59:55 +0100 (CET)
Received: from arekh.ddns.net (unknown [82.64.49.105])
        by lpn-prd-vrin002 (Postfix) with ESMTPA id 3EB195E8272
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 10:59:55 +0100 (CET)
Received: from cerebro.okg (box.okg [192.168.0.1])
        by arekh.ddns.net (Postfix) with ESMTPSA id 04AF722040B
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 10:59:54 +0100 (CET)
Message-ID: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
Subject: [RFE] Please add name and email to git credentials
From:   Nicolas Mailhot <nicolas.mailhot@laposte.net>
To:     git@vger.kernel.org
Date:   Thu, 01 Nov 2018 10:59:54 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.31.1 (3.31.1-2.fc30) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-VR-FullState: 0
X-VR-Score: 0
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedtkedrieehgddtlecutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkffuhffvffgt
X-VR-Cause-3: fggggfesthejredttderjeenucfhrhhomheppfhitgholhgrshcuofgrihhlhhhothcuoehnihgtohhl
X-VR-Cause-4: rghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtqeenucfkphepkedvrdeigedrgeelrddutdeh
X-VR-Cause-5: necurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhinhgvthepkedvrdeigedrgeelrddutdehpdhh
X-VR-Cause-6: vghloheprghrvghkhhdruggunhhsrdhnvghtpdhmrghilhhfrhhomhepnhhitgholhgrshdrmhgrihhl
X-VR-Cause-7: hhhotheslhgrphhoshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
X-VR-Cause-8: rhhgnecuvehluhhsthgvrhfuihiivgeptd
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A dev persona is not just a username, please add email (and probably
also name) support to git credentials so the correct set for a repo url
is automatically picked up by git

Regards,

-- 
Nicolas Mailhot

