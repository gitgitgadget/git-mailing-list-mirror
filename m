Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9434620282
	for <e@80x24.org>; Sat, 17 Jun 2017 16:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdFQQav (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 12:30:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35998 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdFQQau (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 12:30:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id d17so9973009wme.3
        for <git@vger.kernel.org>; Sat, 17 Jun 2017 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=P625rlpoc1228KreztaLqOg/E9M2S/rbidoR9xBDkvA=;
        b=qpCq5/k2sd5cbcjMt9CRwcmuJvMv5K4yLE15p81GHBNAM1bKewGup+MsKjUeGxYuMW
         /i6QsBuNhvMmsVgCIWq0lNk+Y4JBSa/WEdVgYGan3LkQaObo+FxUoxnTb5Xg0hXKi4gG
         EBipFwJB3VfLfOgvszOupXKWdyV9D4UJXrsJt32U5zaUfLKNhqe45GyGCv1i0ngDi6On
         8ioIYyedrDJFF8QqXeFrP6Q7yWZOs/2L6I2DK0r5MS8FiIBllz667GKizaEVx0hPtqif
         BFum7im8WpVZE7S8Wq6d+Rvgf1JX83yq4ebr3MGz7av7fR4AZy1SAqD8qlFGTwav9cSq
         kwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=P625rlpoc1228KreztaLqOg/E9M2S/rbidoR9xBDkvA=;
        b=YWooQEu/iNvgAv5neYRdlqhweVHygCA907Xv1c0deJPieVCAahIMPewyhJlRi4CwAO
         o6/h4FbdYriF49cLrSjeH5X9rlXMp8jTSB8eyhjQkz3g8G2WKAsr2XdFo/jmUctpcPpc
         EhgBh0MmxBMgV8hVIpPjtGilf2prDGioMukgNI5QuVFFXV6p+0iSgZtugfXyi6zxFuPm
         PazquEqy8KjQxl5pBzzgUYLz51SNSN7OwR3R9GK5y3cmdY0+VC9bpyH7Ux5yBa6NL8uv
         FI00FLfoq1Z6acb5WiJEFjZyAohyvawk/9JjHR/bH0z3wlhhY1vOgkN091s3T4VgXGws
         PUKQ==
X-Gm-Message-State: AKS2vOxFXJDGFwOvmrxrwnXehf0QC6bUORPOIWaZZbOOlTpwYKOvnPdr
        bRuUBg0tpr8BdsGJ6Mc=
X-Received: by 10.28.187.139 with SMTP id l133mr10726520wmf.116.1497717048806;
        Sat, 17 Jun 2017 09:30:48 -0700 (PDT)
Received: from [192.168.0.66] ([62.178.56.62])
        by smtp.gmail.com with ESMTPSA id t22sm4531967wmt.19.2017.06.17.09.30.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2017 09:30:48 -0700 (PDT)
To:     git@vger.kernel.org
From:   Gernot Pokorny <gernot.pokorny.git@gmail.com>
Subject: git merge workflow save changes
Message-ID: <f62e3003-8c7b-9548-f431-f368cf5851a5@gmail.com>
Date:   Sat, 17 Jun 2017 18:30:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://stackoverflow.com/questions/44606858/git-merge-workflow-save-changes

