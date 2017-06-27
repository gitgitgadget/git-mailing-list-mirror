Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B52D20401
	for <e@80x24.org>; Tue, 27 Jun 2017 20:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753527AbdF0Ue3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 16:34:29 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36694 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbdF0Ue1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 16:34:27 -0400
Received: by mail-wr0-f178.google.com with SMTP id c11so164898671wrc.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bSRDPyEju8KbjlS+oZrEA6KJ2dC6FXDG9kL73qxhXQs=;
        b=sEjBAKsSfdqfiTB+09g0gYy2H9oVG4o9WAyAW94yIBja0CgANuzbwXT2iJvDjYKT7R
         UzPpYInRx5duHQdL2Q6aCYa55DctrU9U6xkcUw298dxxPFc04oPZzSyQc2EHSxuVgXTY
         pQMMNNO0nmaUhnDz2Dml96b/12xnnIBYoSVy9W0SRKpKejBTogT2s7sARxPrfEbeTV4R
         M+ehfAm1tMrZ7q8cmvmKRSGA5IWLv7pOo101kwzipCPBRnco4+PeemPVKHcICEB3G4Zo
         ZTKRfvXA3TPHnS+EwcUZR30K42iNkP7WH5m9R6wcmVZyyU4UZXCT59iU2XDqByTfROOZ
         VvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bSRDPyEju8KbjlS+oZrEA6KJ2dC6FXDG9kL73qxhXQs=;
        b=UQ6Yu2czNSxQZp5YvCUlgxRfSMzFSCtElnCs2i9URCeaR7sc73b2a+9LRftc3f2HIv
         wtK70rnbiTAkOQC0PuZrebsUxzuH8DNrE2+01+hpmf7LDnZOkdk5FdXQvjK4BeQ+97bh
         9DNhrktnMVvXdlTABFRXU9RPIP9unCxSTlPWnzRuPHVvzt/CVrCHI2wQ1msFcASPIC3k
         AB4DHbkuz1PnjMkCo1SCCLSRdsh/AtCEh7/IG5VAOSzIa/xZe8N0Jh4XhJQkccuDaxFB
         Hs1DM11UZ51iS0L+utZQ8ZJojFfY5roTdHFZx6l003C0E2cd3VsoRdXxzdcKzR7WE3dh
         XlfQ==
X-Gm-Message-State: AKS2vOw+AV33cV2S008gQLRE99SN4tlLWujlUvDezv8nLM1SyoCKac/2
        riNSzPiTQvHIDUiF
X-Received: by 10.223.179.67 with SMTP id k3mr19070852wrd.198.1498595660963;
        Tue, 27 Jun 2017 13:34:20 -0700 (PDT)
Received: from zwielicht.port1024.net (ip92341f15.dynamic.kabel-deutschland.de. [146.52.31.21])
        by smtp.gmail.com with ESMTPSA id l20sm194665wre.25.2017.06.27.13.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 13:34:20 -0700 (PDT)
From:   Silvio Fricke <silvio.fricke@gmail.com>
To:     git@vger.kernel.org
Cc:     Silvio Fricke <silvio.fricke@gmail.com>
Subject: [PATCH 0/1] fix ls-remote help message
Date:   Tue, 27 Jun 2017 22:34:10 +0200
Message-Id: <cover.1498591103.git.silvio.fricke@gmail.com>
X-Mailer: git-send-email 2.13.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

a small patch about a wrong help text. Please include when okay.


Best Regards,
Silvio

Silvio Fricke (1):
  ls-remote: remove "-h" from help text

 builtin/ls-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.13.2

