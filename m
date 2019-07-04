Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA3F31F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfGDJUf (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:20:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40184 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfGDJUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:20:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so4755420eds.7
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MYd/DZBiH1W4AfYONfD0OWk1sSUL5tSSlatSzxagg2s=;
        b=mLqV7l8dzAZtHThxWpHk7XlMpTuDgGtbRcfXadyW2gs9pdzoNv6/lgnN0DkfWGa2p/
         usmfvrWUiS0hAqxQ1wK/3Gl6kHL6GmFNA6UoPdEKR7Y0WIjb7IF+DtQK/x7hO6i2Idlb
         mR8bH/oiDmeAyQTUZ6BV8+gsXPG6O1GGZWbuKHJiNZ+NQfG9xgaSoeq2EqEjjjIdRBQQ
         2IZKmTaUg1aAVRvy687ur2YDhLNzVUWSDDZxyYuwJqraTwvHUwwKvQDEZdu6Qjmw5y5u
         Q6ASq5Yf1eYeFox5CAZqh7Xdo2xU1dMB1gYW27NY3BYHbwoMOWiYi0Q9hm7UBZbFbk6d
         iMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MYd/DZBiH1W4AfYONfD0OWk1sSUL5tSSlatSzxagg2s=;
        b=NQ8V44SnJ4tI0wfpVoy8M8uNJHC1XRVf6Qnj43qeGk4qGIpCOkK9zx8io8QRk4O2Gc
         Fy+rMg15im2MUYsncqFHr/vnPsUcg+dh5ZWmV8sgNlZth+py6dElQBikrt9+JkCIVj05
         7ZWhLWknJ1wYc9sLUOBLnn7BpjVSJB7e9SR9AhoRlZ1+1nyxl562EVdwfvkEv5pCSWlG
         NcSdoj7QvrtwD1gea8KePdFyuVnXTj9Mq7Zg6ssNiVDGGyJRjWUzJN/1rJjzK0SAhkj0
         893Ab4pozfbF1Slxa2pe+rq1IYBgp2yI8+nMeVmJZrBIq0VbhBC35tSiGp8DnfFA5oLR
         8FRA==
X-Gm-Message-State: APjAAAUgOFr7s85tXzGYNM3Af2tMUib63hIiD1SzuwOQWmaY1ZvCYkCM
        IXcETmaLdxVIV9DFwexrjkrngA7o
X-Google-Smtp-Source: APXvYqymYB4CRFca3G8mhDkgOotbWCDtDd5Yb0TeaWDgc76ihSyHHen0F/N2EQ0kEYX/I0YAg+k8pg==
X-Received: by 2002:a50:fd0c:: with SMTP id i12mr4850952eds.55.1562232033670;
        Thu, 04 Jul 2019 02:20:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w24sm1490660edb.90.2019.07.04.02.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:20:33 -0700 (PDT)
Date:   Thu, 04 Jul 2019 02:20:33 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jul 2019 09:20:31 GMT
Message-Id: <fd6df1795048ebebc54502ef8d2ddd7728a08085.1562232032.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.218.git.gitgitgadget@gmail.com>
References: <pull.218.git.gitgitgadget@gmail.com>
From:   "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: initialize HOME on startup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Karsten Blees <blees@dcon.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karsten Blees <blees@dcon.de>

HOME initialization was historically duplicated in many different places,
including /etc/profile, launch scripts such as git-bash.vbs and gitk.cmd,
and (although slightly broken) in the git-wrapper.

Even unrelated projects such as GitExtensions and TortoiseGit need to
implement the same logic to be able to call git directly.

Initialize HOME in git's own startup code so that we can eventually retire
all the duplicate initialization code.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9b6d2400e1..1047427cb5 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2299,6 +2299,30 @@ static void setup_windows_environment(void)
 	/* simulate TERM to enable auto-color (see color.c) */
 	if (!getenv("TERM"))
 		setenv("TERM", "cygwin", 1);
+
+	/* calculate HOME if not set */
+	if (!getenv("HOME")) {
+		/*
+		 * try $HOMEDRIVE$HOMEPATH - the home share may be a network
+		 * location, thus also check if the path exists (i.e. is not
+		 * disconnected)
+		 */
+		if ((tmp = getenv("HOMEDRIVE"))) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addstr(&buf, tmp);
+			if ((tmp = getenv("HOMEPATH"))) {
+				strbuf_addstr(&buf, tmp);
+				if (is_directory(buf.buf))
+					setenv("HOME", buf.buf, 1);
+				else
+					tmp = NULL; /* use $USERPROFILE */
+			}
+			strbuf_release(&buf);
+		}
+		/* use $USERPROFILE if the home share is not available */
+		if (!tmp && (tmp = getenv("USERPROFILE")))
+			setenv("HOME", tmp, 1);
+	}
 }
 
 /*
-- 
gitgitgadget
