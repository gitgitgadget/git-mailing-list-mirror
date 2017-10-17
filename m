Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D72202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 03:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755265AbdJQDrw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 23:47:52 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:56930 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754722AbdJQDrv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 23:47:51 -0400
Received: by mail-qt0-f194.google.com with SMTP id z28so768299qtz.13
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 20:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MN8ceoxEI+Y0UVx74OWRvtSBlT2wRE76XNmGe+2Mkko=;
        b=nf1XR0FwVY9fFvGN1hsA8NiPh36KxQ5EC5N2pP/AplAtzPLVL3K2BUO7+Fw/3LSmE5
         /uFVJnh1A1iqaZwMQNDungrZFcN0ZGTbJa/deXOdfNskZ/YKgPGxE67O1whJeLxj5ORC
         3BoUfkKYVSToIHaJEEz/aJriI3328ZLJSt6Q9gTge6KfaUx9ACu0GLdr/PyrinqFMmSd
         qxxz6s6R53E3AdK0ITYksl8b87viB2y8URswNRy1SR5BYr3XkC741BZQdZg5XczTRmDw
         yYyd3n73VhRXa5okod0FTWS7j0k3LzYOPg1LvV/RFG1Y486v8TkFfvygTN5+4rg6Evyl
         1VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MN8ceoxEI+Y0UVx74OWRvtSBlT2wRE76XNmGe+2Mkko=;
        b=AQqJ0HnO8CkbqO4+24UPPhXs0KODq8Jj8Kim6Di/LSXqwROF0Z7UlgMscL5CLeKWAA
         C1By89y6DUFmgNYvUaUSSECKrqZKNhShsomdGqTHZDdo/Q9JtwhAxWLgdGTl2k9tjGZQ
         KTSx1aG1Gp+HZ1+41FU+zu0PBLq5+t4fA/f2iFzwHv0AZAJiM58Fl5sVgmvoBjR+EsYB
         Fqg34pJJu6Owlm5KZ7cUCu1YIUzP0NrOB5z5ZZT3kA8i5JuA6t/gd4gcYf9mKcpMeHy9
         LyHTMy4QegONMyEHQP/CmgFwuJQkbsi0COQBEVA4DKdzfKigayHFg7SWCvCR3M2iNzlU
         OyOw==
X-Gm-Message-State: AMCzsaWIUgc5qRAFP3NsmDnkuT2/t2BCU/XpqpvDgaZUt4cvAOsXuL6U
        NcZwSIfXQW2S6yJWwHYNkvo=
X-Google-Smtp-Source: ABhQp+QrhCP6qQmBTsgW0XplXdelilzw8Akww26LMssk52I9pGGJ5psTj4J7l0eGRdbEkjQEEe6lSg==
X-Received: by 10.200.46.109 with SMTP id s42mr16532056qta.94.1508212070641;
        Mon, 16 Oct 2017 20:47:50 -0700 (PDT)
Received: from localhost.localdomain ([187.59.221.64])
        by smtp.gmail.com with ESMTPSA id f38sm1206550qtf.17.2017.10.16.20.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 20:47:50 -0700 (PDT)
From:   Thais Diniz <thais.dinizbraz@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        marius.paliga@gmail.com, peff@peff.net, sbeller@google.com,
        thais.dinizbraz@gmail.com
Subject: [PATCH] patch reply
Date:   Tue, 17 Oct 2017 01:47:43 -0200
Message-Id: <20171017034743.8418-1-thais.dinizbraz@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.39.g2f0e14e.dirty
In-Reply-To: <xmqqmv4x11y9.fsf@gitster.mtv.corp.google.com>
References: <xmqqmv4x11y9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thais Diniz Braz <thais.dinizbraz@gmail.com>

---
 emailReply | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 emailReply

diff --git a/emailReply b/emailReply
new file mode 100644
index 000000000..2d591b55b
--- /dev/null
+++ b/emailReply
@@ -0,0 +1,4 @@
+Just to clarify I did not see Marius patch.
+Did see Marius' comment saying he would look it in the leftoverbits list,
+but since i didn't see any patch i thought i could work on it and did so based on Stephan's comment 
+(which i suppose Mario also did and that is why the code resulted to be similar).
-- 
2.15.0.rc0.39.g2f0e14e.dirty

