Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737C51F404
	for <e@80x24.org>; Tue,  3 Apr 2018 17:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeDCRf4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 13:35:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54373 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbeDCRf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 13:35:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id r191so4570876wmg.4
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cf+fiukjnMa6Upe2qyoG3egfoaekbp9cw70wSSMkamg=;
        b=OWmm+mAc7Dz4HYzir5L/KX3jAoMLw5EkqGp+85wMKZPD+j1EjGSU3JBVEeqRKDmsBS
         eK3AKIJA2sx0Ueci9LjCFHFd432J0TK0IIcVn6bNZkEC3Pknox5qDVenIIcrEhaL2JmI
         AuU2Rkrq2TO338sTOqtucQ77I+1IOWxa+8mfKMCSY8mlxzsDtjCieeXwenoZmE8MrrUC
         UEj70NjtH3FkaCNNTBORHoptOabLO0zJbzFQ0LNVYX/3UwKJ3+MlNd87wrzspg8kqspw
         BCk9gR5wjCD7tnGhrc7UvAb+K2jTPULRzrqEeNZx61cx5OoxdFcuZpG+3oRzcTDcqgBo
         2mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cf+fiukjnMa6Upe2qyoG3egfoaekbp9cw70wSSMkamg=;
        b=HBy5MSK00C+YRRdxo1X7sSgrhFD3cTl9UGnmsTpO5WMVcmaet3xaKrKOuDweVmD4ZZ
         Zis81+sxGcpoa7s/Jp8itOfZefJBfMbp00r3A68rcp132tpi+zwy63aIuT0lpGE92tW/
         xKtxQfY0skhkktGgAbotjyLlvN3b65nqtUyz1bmmK9ofXplC9ZDkVSFlFn2uZ2XRxHsC
         EDXVPskDSb0DZ5eXcCdRbgKpR/+9jhvtJCiwvwCglJUuq1vpJHuVjOztZnI6jspRUls/
         WWtEimXofARggKG4MHrNgNe6cShg4Ko7uNgHIS3pkpN/elE5EzcYuSPXa9/m3LDf9vrK
         TKGg==
X-Gm-Message-State: AElRT7GoU5oO4UbaUN6j+PqqdgxQDiylzDZVQatBl/Ahsi5S1Cf6rCD+
        UxvAqgU71rlpozac6gQ5vEYswByS
X-Google-Smtp-Source: AIpwx4/vnIZH7p+10I4N0jFZ5ydOUkKNjzpPlMnv4YQG7B++Dws51PXO+SuzMrJmcfTcHJXNcVSn8A==
X-Received: by 10.80.165.218 with SMTP id b26mr17602951edc.147.1522776954596;
        Tue, 03 Apr 2018 10:35:54 -0700 (PDT)
Received: from localhost (cable-94-139-5-172.cust.telecolumbus.net. [94.139.5.172])
        by smtp.gmail.com with ESMTPSA id b8sm1998460edi.14.2018.04.03.10.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 10:35:53 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>
Cc:     Phillip Szelat <phillip.szelat@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix a 'add --interactive' message
Date:   Tue,  3 Apr 2018 19:35:51 +0200
Message-Id: <20180403173551.5057-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noticed-by: Matthias Rüster <matthias.ruester@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 793bd2a80..257f527d6 100644
--- a/po/de.po
+++ b/po/de.po
@@ -16991,7 +16991,7 @@ msgstr "Löschung im Arbeitsverzeichnis verwerfen [y,n,q,a,d%s,?]? "
 #: git-add--interactive.perl:1405
 #, perl-format
 msgid "Discard this hunk from worktree [y,n,q,a,d%s,?]? "
-msgstr "diesen Patch-Block im Arbeitsverzeichnis verwerfen [y,n,q,a,d%s,?]? "
+msgstr "Diesen Patch-Block im Arbeitsverzeichnis verwerfen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1408
 #, perl-format
-- 
2.17.0.484.g0c8726318

