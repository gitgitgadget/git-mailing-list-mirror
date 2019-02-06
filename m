Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C94D71F453
	for <e@80x24.org>; Wed,  6 Feb 2019 15:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfBFPM5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 10:12:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51719 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfBFPM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 10:12:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2866789wmj.1
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsXVeoi18sTTn8410AJWx2IheUBe0zbdoUWNImuhD1Y=;
        b=O3YiBTDUHWKdd5e8kPKlVIkROQGVL4tpI8hhb5U9OIGK6icoFMsbgUt1KeX+et9IEz
         zfkXU0dTm+iA0YdfIEZsXBkzxyvI14oKLtK1vx1WFYBVLGZ3p0r/UKF1RYYTEJqO19rb
         fOwpEZWy6Pcv3hmPEZ//zduU9+Vq3p0rHVFHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsXVeoi18sTTn8410AJWx2IheUBe0zbdoUWNImuhD1Y=;
        b=kYzhdrAohgrygdQX140G4OXhNt51phPNL0QNaWSgSJcPmAR/Vq9sz5mBQDrUXcIJPI
         GX3y62PWnDcpe4IRoHutuRFb9K7bkp28CgZosINJLivNjEdDW2Gz7GLzfZ/Pp23RHfOd
         ubDIx2MAAXoYRyUrXIViwx2iRl2XAklcMpUeEhrui6OHs7mc5JSAta4v7NfNAE8aM1iW
         7ZA6tucPthTL+BbbkuuASMXbj5YJfNpSsDK3SB93PMHbIa5v6YFKRtuzNP01sUxymirV
         p69P2STrz/sw/WfkdlpliY+4etrs80EeObplJtUGz9E32pFAYyv1g4PQv8u8mONa2cZr
         YNJQ==
X-Gm-Message-State: AHQUAuahKUm3qyq4MQ8eEnK5REXfRM565ifJ35Nwhi0oD09wcwOoDkzT
        QyQ/uxVq4A4yuI+4unNPqdaQiA==
X-Google-Smtp-Source: AHgI3IZRlv/zhWqGbC4+stbKObjlFkJ9/+X89rcZ8U1OXf2ZOmJWXtT3wls8EaP1BE/+kLBOKHJP0Q==
X-Received: by 2002:a1c:2e0c:: with SMTP id u12mr3544708wmu.81.1549465975208;
        Wed, 06 Feb 2019 07:12:55 -0800 (PST)
Received: from barracuda.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id f187sm18429932wma.4.2019.02.06.07.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 07:12:54 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/1] git-p4: remove ticket expiration test
Date:   Wed,  6 Feb 2019 15:11:52 +0000
Message-Id: <20190206151153.20813-1-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As per thread here, this removes the git-p4 ticket expiration
test, since it isn't really that useful.

https://marc.info/?l=git&m=154946136416003&w=2

Luke Diamand (1):
  git-p4: remove ticket expiry test

 t/t9833-errors.sh | 27 ---------------------------
 1 file changed, 27 deletions(-)

-- 
2.20.1.611.gfbb209baf1

