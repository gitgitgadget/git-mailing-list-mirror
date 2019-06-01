Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38BB1F462
	for <e@80x24.org>; Sat,  1 Jun 2019 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfFAUM3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jun 2019 16:12:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36941 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfFAUM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jun 2019 16:12:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id h1so8672061wro.4
        for <git@vger.kernel.org>; Sat, 01 Jun 2019 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EoMhk2HdXFVUfQeoYufLheN3WlKjWOBfLII9Znw+4+c=;
        b=swIGrThd/LHRw8vFdsfzjo3oQ6QjTORv76FG1kpbEBs/pCyZmOaImKw0vNOyVma78s
         TQqCGepkiFwS8oAE6nx4V211ejNNtCPZuYijWWW834V7a7N9FqN63pK1E/w0QE/MBGth
         AcRJWwcswPevO31zl11SaBLbruOFtGnfvUG50gwVivYZBWgqIr/aKKaNcjymoNWCN5U3
         oTuBAZpuZbGLRvwvh2RlNvNdt9csHQJGPNjqUG4YQWxOWG0sAdk6VKOLOY8gUNe6n34v
         3wNTe+xqOuHY5yLrHiwh2CEwWW+24UFDIESrG697i/29wVPVStW/65Rw6J2lUzzQS9lc
         VKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EoMhk2HdXFVUfQeoYufLheN3WlKjWOBfLII9Znw+4+c=;
        b=ojksjTFMZvGZxElv5jihaDJiIlcCXnJDJ8uGvF+QvN6J6AvQDgYfUKehxqPIdhasW4
         D1HsHox6A91vdGRY5uB3UhjdlVonlmaQMcOYBFCs3o6VtbFa/V3SA/7g2gKo5h+AQuAt
         TT4QFW4xj679Kjigbb3+fZDUJa8tiadhj/U0KBzTcguZfcAJNXywN5IUZ87om09/UneU
         /4bA0Pl2RXrH94GIchw6uwJzEhPdrDh0kI+fbpC0fruR38ZlCOBqBS7P0rgI3tNcrPH5
         Y5z7YGdabWB8O2Yn3I9n7SAnBAZEceKdJPE+10o+cJAwiWAs8NldyIuX2FLBA+D/3Qun
         Sx+g==
X-Gm-Message-State: APjAAAUbJ2uDliN5trVUqe7L/CrugU5Mad6Rdve779ywMMcIp7EuKadm
        VrWgb+STt66BhJVUS6XFDaQmthGm4wY=
X-Google-Smtp-Source: APXvYqx4/QGC6Nx5sczrZZzJ3KO/lkALG/C/ePKffsRVmSssifru6LecYR0NYLioQ/weKlUb/tgOvA==
X-Received: by 2002:adf:a38d:: with SMTP id l13mr4145337wrb.187.1559419947166;
        Sat, 01 Jun 2019 13:12:27 -0700 (PDT)
Received: from localhost.localdomain ([105.112.120.203])
        by smtp.gmail.com with ESMTPSA id r9sm10048813wrq.0.2019.06.01.13.12.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 01 Jun 2019 13:12:26 -0700 (PDT)
From:   Victory Osikwemhe <zombieleetnca@gmail.com>
To:     git@vger.kernel.org
Cc:     Victory Osikwemhe <zombieleetnca@gmail.com>
Subject: [RFC PATCH] doc: change 'The standard email format' to 'The standard date format'
Date:   Sat,  1 Jun 2019 21:12:12 +0100
Message-Id: <20190601201212.19165-1-zombieleetnca@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current content of date-formats.txt under the RFC 2822 section
specifies 'The standard email format' whereas the format specified
is a date format

Signed-off-by: Victory Osikwemhe <zombieleetnca@gmail.com>
---
 Documentation/date-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 6926e0a4c8..1e1acb3826 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -14,7 +14,7 @@ Git internal format::
 	For example CET (which is 1 hour ahead of UTC) is `+0100`.
 
 RFC 2822::
-	The standard email format as described by RFC 2822, for example
+	The standard date format as described by RFC 2822, for example
 	`Thu, 07 Apr 2005 22:13:13 +0200`.
 
 ISO 8601::
-- 
2.20.1

