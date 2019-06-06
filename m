Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10D91F462
	for <e@80x24.org>; Thu,  6 Jun 2019 12:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfFFMrs (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 08:47:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44883 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFMrs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 08:47:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id e189so1432202oib.11
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bq1HShuR0aK2zg06d3LmYRtanIoDyy3ZWyBSWsi/qLY=;
        b=hjO0m5tXikxfeSzMmoNS0UCKzB9nRkspnrnILLw3htQGjR3fohbK3oqzBxbhqkv+SZ
         REQLzaNBsVw3QKVhDPNOPn/GGwjfq46w0luoGWOadNhUfdADoCqG+f7qkWpXOJhiCCdb
         gppXv9t0bBR5krN6RFTMj2K2i2oMyhI2hwdAh7uOpyLbI/tGOTi396bDBORrTpTKNtAG
         NCQLhV1mpB9ZKkaoCrVYZYDIfS2LfhB1b7/cUDixkdwGWLDaW8vG54KU2a/n5PlXBSLH
         JSOMp2EhmEJWw14MhfdAzYtBwcchulsASWaQzrGYZcwjMAR/S9akRZhyiEKBbflcMNY8
         kguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bq1HShuR0aK2zg06d3LmYRtanIoDyy3ZWyBSWsi/qLY=;
        b=mgWKTO97jgYTA5b7UWqg8GF6OicdaDomiEQeA4y2nJqDGtMhJbs/3o4wuAm8lhEFFa
         KRjzErCm/wvHjRl0rCQAPqoRnGGsLOzzN9+mk5T3yx7UfixDX144ybGzLrIhD7ftRScH
         cIxcuPr7AhdIrj5WK2ZuvzpPA8UliIL7RcQiPhrJG+PMT2NPY3BQgxFac0iADman2NxI
         OBB6PPxgXfpvwFYcoODNtFzwrmc2CmA19FPF+n1z/od6QEzFjiLQw1tLEQw2pJqrz6T5
         5YevdP8hNuLik+4phEwz74aqcvobJFlY5xh87uIBfclLwOymu5LRkuAmbTaXsUj29ntF
         Qg/g==
X-Gm-Message-State: APjAAAWj66M7YzlC6DUgwh156WIypqNS7kosyecAoHOTgT3MpbulVBSi
        6sHIza3trsX3VeCEhA/B/dKGiE/tKHY=
X-Google-Smtp-Source: APXvYqzqCV0rRyWgGmr658Jlwns4CEBQ3/kinpPTg5Qv3XAAtTwfLL6/kKgAjT9YTl3RoeAC0LuNrw==
X-Received: by 2002:aca:4404:: with SMTP id r4mr11885703oia.130.1559825267344;
        Thu, 06 Jun 2019 05:47:47 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id l31sm630013otc.30.2019.06.06.05.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 05:47:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Peter van der Does <peter@avirtualhome.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: zsh: update installation instructions
Date:   Thu,  6 Jun 2019 07:47:45 -0500
Message-Id: <20190606124745.11227-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0e5ed7cca3 wrongly changed the extension of the bash script
to .zsh. The extension doesn't really matter, but it confuses people.

I've changed the text to make it clear that your zsh script goes to
~/.zsh/_git, and the bash script to ~/.git-completion.bash (or wherever
you want).

Also, update the default locations of the system bash-completion.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 886bf95d1f..b3c4588515 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -4,17 +4,19 @@
 #
 # Copyright (c) 2012-2013 Felipe Contreras <felipe.contreras@gmail.com>
 #
-# You need git's bash completion script installed somewhere, by default it
-# would be the location bash-completion uses.
-#
-# If your script is somewhere else, you can configure it on your ~/.zshrc:
-#
-#  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
-#
 # The recommended way to install this script is to copy to '~/.zsh/_git', and
 # then add the following to your ~/.zshrc file:
 #
 #  fpath=(~/.zsh $fpath)
+#
+# You need git's bash completion script installed. By default bash-completion
+# uses /usr/share/bash-completion.
+#
+# If your bash completion script is somewhere else, you can configure it on
+# your ~/.zshrc:
+#
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
+#
 
 complete ()
 {
@@ -31,9 +33,8 @@ if [ -z "$script" ]; then
 	local e
 	locations=(
 		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
-		'/etc/bash_completion.d/git' # fedora, old debian
-		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
-		'/usr/share/bash-completion/git' # gentoo
+		'/usr/share/bash-completion/completions/git'
+		'/etc/bash_completion.d/git' # old debian
 		)
 	for e in $locations; do
 		test -f $e && script="$e" && break
-- 
2.21.0

