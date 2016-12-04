Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E6A1FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 22:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbcLDWFs (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 17:05:48 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32783 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbcLDWFq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 17:05:46 -0500
Received: by mail-pg0-f67.google.com with SMTP id 3so14308550pgd.0
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 14:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0GVIisO1HS1wlW1oFRF+JMmIEBdCImk6AfydwPNEgpk=;
        b=ud9oceuO+8YmppUdpGg+c0cIlSlWG3IJLv6q+Ef5T57cGiSX4DnUrEg5Ev+cwlp4bC
         ri4voD473se7HTacHOXUB0CXlWQwAyIT1MKRnS4RzR6BpzKavbk2mihnUjUWWntp9rjG
         kEIiULLlkfFm+a697h4+V01IbNkbNUShlQweYeT8Fpvy6FpeXygMgy1UwNJrvGr7HbJs
         GI51g0UEpUUe9bpp9v3yZzzWUjbJjztDWPrBYkLexDN+5Ck7VwcpHzXAfYl3gcWQ1z6A
         zdXjyMqmxxMynM19eahEeeticmzVlkBQExi7fIz/F+GLuJeMG6kPCxMOmTsSEiMFyVH+
         C/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0GVIisO1HS1wlW1oFRF+JMmIEBdCImk6AfydwPNEgpk=;
        b=ZBuYAUBLcXD5Yp0Ju4TtyoAK68Cz8/GQBlPip6MQJuIu9ncLEUysRWAEK/Gtkmiwuc
         T0RMryRc/fWw0JX/lMm3+VKaJpXhn9TajWN7xaGPDJGgtVdbyWbNqfpeMIb55lWlQIuJ
         izoNK7xLLezVFzLOclOMGOlvPuYao1dGSEYm0KiRMRkUqj7jPbOLLIMhvQGBUuROAdV7
         6moFfNkQUwx70XQ6jy1yCKv6SzwhzJHzLKh5FIX0s7+MwdpqfbhxjvzJDPsghd2/nEsJ
         XB6hwMRQYumFTTZxXISsPWJLmz4LRfbIivDVUxD+vWhd6PoabCSQFQoU3ivOzIutqAmy
         XoZw==
X-Gm-Message-State: AKaTC02Agj4IsjunVTgYcIAvZzGGiXjNv9mrudIZlFZMXZCe9Wg436so0IXDRm+ioPLqow==
X-Received: by 10.99.112.13 with SMTP id l13mr97420873pgc.7.1480889071070;
        Sun, 04 Dec 2016 14:04:31 -0800 (PST)
Received: from wolverine.hsd1.ut.comcast.net ([2601:681:4101:1302:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id l11sm22161452pfb.28.2016.12.04.14.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Dec 2016 14:04:30 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] bisect: improve English grammar of not-ancestors message
Date:   Sun,  4 Dec 2016 15:04:23 -0700
Message-Id: <20161204220423.30865-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Multiple revisions cannot be a single ancestor.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 21bc6da..8e63c40 100644
--- a/bisect.c
+++ b/bisect.c
@@ -747,7 +747,7 @@ static void handle_bad_merge_base(void)
 		exit(3);
 	}
 
-	fprintf(stderr, _("Some %s revs are not ancestor of the %s rev.\n"
+	fprintf(stderr, _("Some %s revs are not ancestors of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
 		"Maybe you mistook %s and %s revs?\n"),
 		term_good, term_bad, term_good, term_bad);
-- 
2.10.2

