Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D22E20248
	for <e@80x24.org>; Fri, 12 Apr 2019 11:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDLLjq (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 07:39:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36195 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfDLLjp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 07:39:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id u57so7412118edm.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 04:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q4W6RUTbEpyt8sOoPj2gEL1SKt0Obj6uSXUTnkdR+Go=;
        b=JRTbzdj6VMHlod1T93jZaqq9QqBq+aMkCRFGRNuHJFo5H7vHlFbRAc9WDzZNyEr6ex
         eQj2lTDh3D/QHYiff9Xve/HMqImRA9xU7tPXrEC3cGk4c3kFsEeTQQdIYJIPim6UYWFq
         1FBUvjFqBg/2uHspX+56kdwfTyPMCFE9eEK2L0KuxIIV+2gTHpI/I0uYTPGXCrPgoEAt
         qSRZkpDe2v0MugQEzlCfkS7MHIqmBL/IwvS0WIBGwxE/xX4JSCztke60FCQx8ijh9588
         ypw6RONtNyw3rhrOmZir9+fWrVq+MyjALXFl5y+CkZedce/ZLHiagPAhV66rKm2/3HBy
         lhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q4W6RUTbEpyt8sOoPj2gEL1SKt0Obj6uSXUTnkdR+Go=;
        b=SAKmuFxI2hmAXjd4I1JXCwx4VPyZQdVidXrimF4fG/efWmcmhNvRrbhitQmLNHOIqz
         2gpxHMeDCw5GFAtuV3R0Yu6zFNfFHEYRedKwZUKGvAyWEwSqRtywT7dP4nJPcdJeoujo
         dp3EGMqpupvmnfWPl0WYW213AMpO4uK37zO0e8rFQvoBb7F8fxM4Yuq9jfZXtOjFYaNp
         s4hB0p8YTyt+2OpFtlySjWfrkFGnUvTZZbqIIFqFGI4eRmX9sQr7ZP5MOXPMwayDT7wQ
         Uziw6+L8WGy12ZNOHrlfVt1Y70XD/rbaKq8QDtx2oEXH1heSaDUTS8ljSZ9qCFiFRJcx
         9mKg==
X-Gm-Message-State: APjAAAWs2Eqldq3a0R5NZuz4alPVvKYdvmViot0VWan2wpmtyh4Sokcx
        bbK3pJ36kQp6qpnWJAFJRtUibluw
X-Google-Smtp-Source: APXvYqwkv6c0mqQsfuZ2H16OvsQ8ql/cUR8jBwtTU6U7IQ+Abfo8t2uYYS66MO8xz1PbQa0dUjzXbg==
X-Received: by 2002:aa7:c991:: with SMTP id c17mr13658008edt.227.1555069183823;
        Fri, 12 Apr 2019 04:39:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 63sm1747448edn.32.2019.04.12.04.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 04:39:43 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:39:43 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 11:39:40 GMT
Message-Id: <52681aee0a9657691521baf13f792bcfb9eeb898.1555069181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.179.git.gitgitgadget@gmail.com>
References: <pull.179.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] t9822: skip tests if file names cannot be ISO-8895-1
 encoded
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Most notably, it seems that macOS' APFS does not allow that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9822-git-p4-path-encoding.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index c78477c19b..de0b46581d 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -7,6 +7,13 @@ test_description='Clone repositories with non ASCII paths'
 UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
 ISO8859_ESCAPED="a-\344_o-\366_u-\374.txt"
 
+ISO8859="$(printf "$ISO8859_ESCAPED")" &&
+echo content123 >"$ISO8859" &&
+rm "$ISO8859" || {
+	skip_all="fs does not accept ISO-8859-1 filenames"
+	test_done
+}
+
 test_expect_success 'start p4d' '
 	start_p4d
 '
-- 
gitgitgadget

