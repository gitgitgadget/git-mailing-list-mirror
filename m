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
	by dcvr.yhbt.net (Postfix) with ESMTP id C369E1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 06:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfFNGu4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 02:50:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44851 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNGu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 02:50:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so1169549oib.11
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 23:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fk9aLvVQHAFkNY4pQ10lysZ0ef1pgtvygdqIpFsKJU8=;
        b=QmrJYR+YD45doTqrR/z8knbtkBJlOmBaugnLSHiPfSPIFpxmQzq5J4WjfkfdM/UhGz
         yCWhTZEGijvRKYIfcc1fkpYQstZo0SXrhTeejhYM7SjXpfEtqBF3E6SHy7cmZn3mrkPy
         lirmPCp3PP2V7L4dGRhNGs5krceHsCBGX7tKQTt08WFnU/XJxlZMwTHZqDtKsRmswHHa
         69VOpOYgmdfd9T1OvBKRMlp+J+0jIYpfrxXzeJzrrfOMX7IS2fyP4hWq5jCYSxvW7hR5
         FAcTwI6b8eBN3NwCCW254NyftZJ1+QQ9wYZRbfF7SS+Ik2QkVNDk01MKjOfKGmQg6Cf+
         GZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fk9aLvVQHAFkNY4pQ10lysZ0ef1pgtvygdqIpFsKJU8=;
        b=dpGMwwWz1MojOvBZsgQ/rNxpx2ouJIbdIxCMU9ymDdKNQOaOIn/Vo38szleC3demV0
         uPHTkDFYXxqzNNK4AUOULZw1kwOMhSdpI+zB+FbjhIS5h+5G48kW/uUGcbXMjN9HQyqq
         76zbIcP2gMDfEAJrtStEBsckgBY24F+Kz0Kg8QF0TWpiSMpYVo4erRn+VgBWgUP5vii2
         S08HeoEBxTf5X1SsahWHnqCJWNYIqATQo/QSn1uOGqh5EORlEND97eKkyGVbr+YOffi1
         ilty98wy+89/RLXdUT6wOHPYDVZG4RA0G/t1CSICJT5p3x1s96GTrHOU7m6wLtE1YwC7
         NPmg==
X-Gm-Message-State: APjAAAVGnGz7exWgOm9hLdsbHRmouS0Eg+X024ec6MRlMiRLd1u5Vo/I
        vcPLkvypeXD18cVSQ+lfrWQTcSP7HGo=
X-Google-Smtp-Source: APXvYqwLydAhih5qY21krcCY47Awk1YJaPY5i86DfeXueCIlI3C4hj4P/fuSmCt2YfkOr00rPbPllA==
X-Received: by 2002:aca:d415:: with SMTP id l21mr921345oig.96.1560495055052;
        Thu, 13 Jun 2019 23:50:55 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id h60sm967654otb.29.2019.06.13.23.50.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 23:50:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/5] completion: zsh: update installation instructions
Date:   Fri, 14 Jun 2019 01:50:47 -0500
Message-Id: <20190614065051.17774-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.dirty
In-Reply-To: <20190614065051.17774-1-felipe.contreras@gmail.com>
References: <20190614065051.17774-1-felipe.contreras@gmail.com>
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
2.22.0.rc2.dirty

