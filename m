Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14372C7EE2D
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 08:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBYIrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 03:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYIrG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 03:47:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4331A945
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 00:47:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l1so1455478wry.10
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 00:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIRaVD0tlpjvEmAzwEgO32ZLQt8DrnNEMX1GYovcqf4=;
        b=Slam0UWFMApo4lQ0UAzom/92dojiQ75CE3xRq1GBzNf1ESYZS8fwFT7ybHBJxtrpym
         /Oo2fpAoZC+eBX4kMmLwzVFWI7/DovDbWnFS9cQqyJWjLEiO1Wl09C1JP7bMNOosghTn
         yrXzC+SciJq4VEU5oEriQx6BWIz+X1SbxtHoUO3NT88+8OJJZM+j1HX01o9z4G82fDf2
         d1bchlSEuZ33saaGcJQvibh4ntTwkXJM3824VZwj06lWy2mLLHAVe1gvX5AgTZEXHE3L
         s6xFOxqscqvOf4mH4Pm98KVlTIihvULh6eVPoBG6nZnXPgBpZdspf3lekwVFkaJEoZXd
         +geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LIRaVD0tlpjvEmAzwEgO32ZLQt8DrnNEMX1GYovcqf4=;
        b=Dn9qidL/DvXUYY82nyY3/mBZM/uYmiIT2gJAm50afRX3WEIk2jkMsN138OmXRUU+lU
         uKXBPdanyL+tcZLxillZoEPhdcdJkO2VdmILnowwQ+A0WxKAB6EUsOiKp1uuENhQBABX
         oFh2jsypn1z4eMOGI1p11GrkshlhDANmmpc9Fx0+XGXZo5D3fGSlFcjWAMA8frnLfJ3A
         amArMLd14BcYsyn3uRkeCJzviQBKU1yKAF/2f3LF1njY7IR8HicLxvSgqVXgOQ47SSgk
         nTSu846i0xVPiedgo2guimX+MTutBMSI3WQPTk5CeBp3sI+ybL2AvSeHzGTVMDcGvPFR
         7Q0w==
X-Gm-Message-State: AO0yUKXqwUAWOc+mzeoVIwInrvcs5QuOMqIb6/s0D4TQztl2gxI+yaJx
        bdj/buJpoZTD6c7ctNkc4vQZLEJZP8X+lQ==
X-Google-Smtp-Source: AK7set/1680ZtbuzxdlV+m18VLe1iY+vBtE3KOpA+0iWWoSg4hDpBrKkbXJdYs0BOKxrvVEIXCIEcg==
X-Received: by 2002:adf:ce0b:0:b0:2c6:e827:21c1 with SMTP id p11-20020adfce0b000000b002c6e82721c1mr14073591wrn.50.1677314820841;
        Sat, 25 Feb 2023 00:47:00 -0800 (PST)
Received: from smtpclient.apple ([2a00:23c5:7d13:4701:84c:6654:4326:8535])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5309000000b002c70d269b4esm1127986wrv.91.2023.02.25.00.47.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 00:47:00 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Evaldas Kazlauskas <muncikas112@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 25 Feb 2023 08:46:59 +0000
Subject: =?utf-8?Q?Do_you_want_to_get_free_shares_worth_up_to_=C2=A3100=3F?=
Message-Id: <89E59949-E060-46B6-ACEC-CDB614A99BE0@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (19H307)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Join Trading 212 Invest with my link, and we will both get free shares.

https://www.trading212.com/invite/12ih0NOChe
