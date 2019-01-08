Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23FE1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 16:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfAHQ4z (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 11:56:55 -0500
Received: from m12-13.163.com ([220.181.12.13]:54934 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729061AbfAHQ4y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 11:56:54 -0500
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 11:56:53 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ox1La
        bFBSDbLX4tELglHAC2r6GkttoOLwEYGHyu5IUg=; b=RQvrSJ71bFisymHBjCBwN
        TBuriZ9xMSByVn6+oAOdd3vF0RNqR7qlGnhmSDg+YPtliJALh7y1cRXH54PobgPd
        8HPfFouFEQbSCVT0JQT6fX5T73/xEiTdEBVlRpjOSovoPM/uHvggKpTQcX0d+X/Q
        /52pfxFt1AmbhLTw328bo4=
Received: from localhost.localdomain (unknown [122.235.191.23])
        by smtp9 (Coremail) with SMTP id DcCowABXOga30jRcLIeGAQ--.3520S3;
        Wed, 09 Jan 2019 00:41:30 +0800 (CST)
From:   16657101987@163.com
To:     worldhello.net@gmail.com, git@vger.kernel.org
Cc:     gitster@pobox.com, sunchao9@huawei.com
Subject: [PATCH v4 0/1] pack-redundant: remove unused functions
Date:   Wed,  9 Jan 2019 00:40:59 +0800
Message-Id: <20190108164100.73219-1-16657101987@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190102043456.15652-4-worldhello.net@gmail.com>
References: <20190102043456.15652-4-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABXOga30jRcLIeGAQ--.3520S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUyiF4DUUUU
X-Originating-IP: [122.235.191.23]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiQxo2glc7F9XkQQAAsm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

I'm particularly grateful to Junio and JiangXin for fixing the patches,
and I noticed Junio send a new commit to remove more unused codes and
suggest to SQUASH it.

So I create this new version of patches to do this work, I also have
checked the left codes and remove a unused struct based on Junio's
last commit of `https://github.com/gitster/git/commits/sc/pack-redundant`.

--

Sun Chao (1):
  pack-redundant: remove unused functions

 builtin/pack-redundant.c | 86 ------------------------------------------------
 1 file changed, 86 deletions(-)

-- 
2.8.1


