Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FCA20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750932AbdK0Ezk (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:55:40 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:42002 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdK0Ezi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:55:38 -0500
Received: by mail-io0-f194.google.com with SMTP id u42so34915594ioi.9
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 20:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kJLtiwx06fqiPSN0xBXnSvUo8jRtZvaW7wkVaUZNIBQ=;
        b=Yi3w12zpP3V9YhPfXiLdxNT3gpBnGMjDAkWgC9gG2w6lt1Zj6D6xc43pkk0QVQ0pL4
         TTLzFhbao/XC1hN6E4hexUA4j4AFNxC5WscbAjl8D1hyPTyU2QyiiLsbjw1R/WA6your
         nSrv7m00dVixip4PUpEfPs9ancS0bWtmKpxhndhMgI3yFjgn/8/nrj/FbJkSH76k/fzN
         nuw8VUu8GOr6QV+u7mjKyDdPnwO9UtGLI2sykPwVOABEjeg3dabVtyKs+a0WGhlps9f0
         MY/CxG8OvlzCcii8aNLuBk25ZVsADS2pHW2hdK1dOfgVtnxrirKqIVPj82sVl4TvZqeH
         PlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kJLtiwx06fqiPSN0xBXnSvUo8jRtZvaW7wkVaUZNIBQ=;
        b=ML/qKMDWAFN+NB8bpRDvQDxOnoU8I7rMH7zJmQhlHl8bPC6z5OBwELL7uFkoktL2VY
         gzM0X3NhtpM/Z0XTXcpzL20ySurhewR12FrvIOrp1+9xB0vR5tAcjmleuOjUKU3Dwtgt
         HhIK6EGDTP4O4OY5GkLQxjncwmk4Rlcih+IA8hCiFdrW/ZeDfjpVbkixKGSYNRsqJaoa
         uo+3OKXdz+yYc0WZe831hmnHv59Om9i0egBOAtjlaAGN5LRVGebuwjgJJUc0aN4Ei6Wo
         /YJVYiGTcZzI7ztNoKOFup0Cs69WSaxeYrHgsaiB61MavP+2h6CWyRdypBYUaX/l7ugi
         QBew==
X-Gm-Message-State: AJaThX7dUbGlFN2tZkJGFpeG9GwCTOgcTMRio3/LmKNu20rrx7QOaPtP
        fZremkSnDoW4Nj7Ykua7kpLzDZ3N
X-Google-Smtp-Source: AGs4zMZk0uwjjWCB6gicXXLL5bkZbeIbbiQ1kZm16iFuKG/jl7X9agNKh7sfsqT2cA3Kvf4dgiYPxg==
X-Received: by 10.107.18.168 with SMTP id 40mr41721483ios.55.1511758537766;
        Sun, 26 Nov 2017 20:55:37 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm4606305ioe.13.2017.11.26.20.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 20:55:37 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, avarab@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 2/5] Documentation: use preferred name for the 'todo list' script
Date:   Sun, 26 Nov 2017 23:55:11 -0500
Message-Id: <20171127045514.25647-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.0.321.g19bf2bb99cee.dirty
In-Reply-To: <20171127045514.25647-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use "todo list" instead of "instruction list" or "todo-list" to
reduce further confusion regarding the name of this script.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/rebase-config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
index dba088d7c68f..30ae08cb5a4b 100644
--- a/Documentation/rebase-config.txt
+++ b/Documentation/rebase-config.txt
@@ -23,10 +23,10 @@ rebase.missingCommitsCheck::
 	--edit-todo' can then be used to correct the error. If set to
 	"ignore", no checking is done.
 	To drop a commit without warning or error, use the `drop`
-	command in the todo-list.
+	command in the todo list.
 	Defaults to "ignore".
 
 rebase.instructionFormat::
 	A format string, as specified in linkgit:git-log[1], to be used for the
-	instruction list during an interactive rebase.  The format will
+	todo list during an interactive rebase.  The format will
 	automatically have the long commit hash prepended to the format.
-- 
2.15.0.321.g19bf2bb99cee.dirty

