Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DAE22023D
	for <e@80x24.org>; Mon, 22 May 2017 19:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757805AbdEVTpp (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:45:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35831 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758778AbdEVTpo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:45:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id j27so1520774wre.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oxd9yaNfiWuRoV/c6X+s7sbcoZBBg22lqpU0FAl0JBI=;
        b=FWEdgg5vy6E8LGtYmkSX89P2mkaTxwHXkNCSZujwXxa0ouhri9Qi8rA0GJzkoDb8v0
         6d9GmBAx2GMTB4Q7oa+IwuEMMOTYsokJPiCI9S8BwNuQnUO048sMqgHy3Sp5evXl4jUZ
         Td7SKKIi5UAjmPIKJLbsGhHEpGD1J/IUnXkQPdbH6U+SMjynMlcFbo0jZDXDAeXUQrFz
         tIQuX8AKsvaXpGvXBOq0XTfnT7DZD7DfNNDmNjy+dcv5OEivnupZYGOzYiWwzYrXdgPj
         UElC1zKyGp3esB+/W9uPRvc+TM3ELB1eyXs4ltMH0hpN4HclAE4pukLdBdJUiaOpIWIg
         gmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oxd9yaNfiWuRoV/c6X+s7sbcoZBBg22lqpU0FAl0JBI=;
        b=GrS/tP6WV9AoxCCk1bhhLFR5HOQHR/AR8wrwgwvM/wyhLwjX1/wbfWM7t8pIsRLyBZ
         3eG3KIKzUDJXPTq+PuIwFE9GPYVuamMVwiTXgP53W2dWKdoqbEuHwLL/lSUGPodGhIeJ
         AqKYkj41BFU2DllsmkYqnPIg9UbqevT+3cg2TLEhyox+MNKOchtsKRn/vgtni0Iq66Rp
         ObdMpQ7mEtd4+M+10puCMEU+z/4DTLhGu31jdNDW8fDnIXfAIs3nGCSTBZOkQzyD55Dk
         ayXCWn0DHNUben0ln08tQDhgJXWrbby6AkbN4dkN9Ylb/4II6nlrDQsL9g9RG6obP8ka
         Xvbg==
X-Gm-Message-State: AODbwcD2oUjzPm6AXg9IrH0iPnTMJtlYkol0neN9bjTj33yn+Qpif1pF
        0iQ0uEblm2xmMQ==
X-Received: by 10.223.170.67 with SMTP id q3mr15133319wrd.19.1495482343181;
        Mon, 22 May 2017 12:45:43 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3439:1100:e402:251d:acbb:6317])
        by smtp.gmail.com with ESMTPSA id o97sm18655351wrc.48.2017.05.22.12.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 May 2017 12:45:41 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] Documentation: Fix reference to isExists for interpret-trailers
Date:   Mon, 22 May 2017 21:45:33 +0200
Message-Id: <20170522194533.6394-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The manual for "git interpret-trailers" mentioned a non-existing
literal `overwrite` for its config option `trailer.ifexists`. Fixed
by using `replace` instead.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 09074c75a..31cdeaecd 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -123,7 +123,7 @@ trailer.ifexists::
 	same <token> in the message.
 +
 The valid values for this option are: `addIfDifferentNeighbor` (this
-is the default), `addIfDifferent`, `add`, `overwrite` or `doNothing`.
+is the default), `addIfDifferent`, `add`, `replace` or `doNothing`.
 +
 With `addIfDifferentNeighbor`, a new trailer will be added only if no
 trailer with the same (<token>, <value>) pair is above or below the line
-- 
2.13.0

