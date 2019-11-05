Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593BB1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390421AbfKERHs (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:48 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:47070 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390350AbfKERHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:43 -0500
Received: by mail-wr1-f52.google.com with SMTP id b3so16551223wrs.13
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uSqE8szB0Raci8n5nlaOHvIPbPtBf0ae6VIwmS1Hmp8=;
        b=o+B50M/rBqZGu2ThcnXuoynFz9zTh4dXe70G0iUvHSaRIjE2OVZMyw+m0//2cCERUT
         U9kiPxn2tvNPr/bJ8SiR69yDLQsOGhHobDuvtdH460+ve66e0uOYOZLaEJomOgGUFM2q
         6PptXwmti+PRDSocur5ELyssYF9iaeEqlN2vkgvGalaNft53LTCDutWOtczK8aw7UyJb
         oWxZ0qFr5VB1O+lYj66ixNCmaiLng19lklOGf3KlZvt8YTUk5TGalyfSJYo7QYZmPwTP
         sppWxNz0iQzi2kSGS/V+T6RYUEMNg1lS2hnvZxeMBjEzUZUtF3zA8ETxJlOwq2VgMYSc
         l76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uSqE8szB0Raci8n5nlaOHvIPbPtBf0ae6VIwmS1Hmp8=;
        b=BUMFxJ69cK3MnwzCy7MLEq1ddgAS2SLiz9+vX4UWsy1VOcRw1EgrJs7/tR7jjBfk+J
         uTGj3GjB5i3voDsjL8jWPY/R/c+D7GaAnxkoEbF24XMGLcPKtWLjOZVm65TJCkNjzEVb
         HoKKfTfL+qk7kgKX4Flp7jB5q9/EXMUOiIyc96T1GDwfEgAMfP9YN1oG543a53ZfnCEu
         XiF5ftogQRqld0medi3SKD3NL+PsuRHkJlpZlLhV3xW1wjdAYn6m/grmBcTpIRHev3aw
         dXYJwcncMyVvUqY6ywnMkFE1vD6AC+ivWV1jD1PvJQhFjyACUulRYiEwcE1ZrEJXCbwv
         ioQg==
X-Gm-Message-State: APjAAAVUrEB2oHIaqEYwJV6daWIZXez7gyWa/IWDH6Fbpzv6izk12Jjv
        9y8vIIBorETyx2Nqw3S4G4E2yn9C
X-Google-Smtp-Source: APXvYqz+5+hNMYdzro7Z0cXkGEPpCKkbf19R7ladNAU8JjKiLyhHqbwK4vtQWAmAazc06GC7jpMZlg==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr26927644wrv.164.1572973660460;
        Tue, 05 Nov 2019 09:07:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm24230587wrq.52.2019.11.05.09.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:39 -0800 (PST)
Message-Id: <6d8bc116c5fbcb9c6892f8d08e044ec26cfe0e21.1572973653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:26 +0000
Subject: [PATCH v2 07/11] Fix spelling errors in messages shown to users
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/svn-fe/svnrdump_sim.py | 2 +-
 git-cvsimport.perl             | 2 +-
 help.c                         | 2 +-
 t/perf/bisect_regression       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 50c6a4f89d..8a3cee6175 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -54,7 +54,7 @@ def writedump(url, lower, upper):
         print("usage: %s dump URL -rLOWER:UPPER")
         sys.exit(1)
     if not sys.argv[1] == 'dump':
-        raise NotImplementedError('only "dump" is suppported.')
+        raise NotImplementedError('only "dump" is supported.')
     url = sys.argv[2]
     r = ('0', 'HEAD')
     if len(sys.argv) == 4 and sys.argv[3][0:2] == '-r':
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index b31613cb8a..1057f389d3 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -600,7 +600,7 @@ package main;
 sub pdate($) {
 	my ($d) = @_;
 	m#(\d{2,4})/(\d\d)/(\d\d)\s(\d\d):(\d\d)(?::(\d\d))?#
-		or die "Unparseable date: $d\n";
+		or die "Unparsable date: $d\n";
 	my $y=$1;
 	$y+=100 if $y<70;
 	$y+=1900 if $y<1000;
diff --git a/help.c b/help.c
index 9ff2be6b18..cf67624a94 100644
--- a/help.c
+++ b/help.c
@@ -34,7 +34,7 @@ static struct category_description main_categories[] = {
 	{ CAT_foreignscminterface, N_("Interacting with Others") },
 	{ CAT_plumbingmanipulators, N_("Low-level Commands / Manipulators") },
 	{ CAT_plumbinginterrogators, N_("Low-level Commands / Interrogators") },
-	{ CAT_synchingrepositories, N_("Low-level Commands / Synching Repositories") },
+	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
 	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
 	{ 0, NULL }
 };
diff --git a/t/perf/bisect_regression b/t/perf/bisect_regression
index a94d9955d0..ce47e1662a 100755
--- a/t/perf/bisect_regression
+++ b/t/perf/bisect_regression
@@ -51,7 +51,7 @@ oldtime=$(echo "$oldtime" | sed -e 's/^\([0-9]\+\.[0-9]\+\).*$/\1/')
 newtime=$(echo "$newtime" | sed -e 's/^\([0-9]\+\.[0-9]\+\).*$/\1/')
 
 test $(echo "$newtime" "$oldtime" | awk '{ print ($1 > $2) }') = 1 ||
-	die "New time '$newtime' shoud be greater than old time '$oldtime'"
+	die "New time '$newtime' should be greater than old time '$oldtime'"
 
 tmpdir=$(mktemp -d -t bisect_regression_XXXXXX) || die "Failed to create temp directory"
 echo "$oldtime" >"$tmpdir/oldtime" || die "Failed to write to '$tmpdir/oldtime'"
-- 
gitgitgadget

