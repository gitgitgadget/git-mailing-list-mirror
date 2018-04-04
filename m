Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92521F404
	for <e@80x24.org>; Wed,  4 Apr 2018 20:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeDDUFj (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 16:05:39 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:41790
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751399AbeDDUFj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Apr 2018 16:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1522872337;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=r7wdloFG+Dt+6Nu3S+PTzNhyZ4L+Vvk6k4r2kiZbS3U=;
        b=fDh7vWoPEBE5LrhWVMNoVmjCDGs743b6mdc4ARhuay7fS/dAAHG+fh7OImcpgCtv
        /558Lcy+jI8cO1C/pscupGpSxAqHZ9/nLKtIvKqiZEt7LOK/uJBEt8E+XX6ybt0hJB4
        ws6eRF0iepqtDk85THI5W3B+S8OaDkJxy899VNMo=
From:   Stephon Harris <theonestep4@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201629243c44a-4a158009-aa68-4e05-ab54-f15a49ffb606-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Change permissions on git-completion.bash
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 4 Apr 2018 20:05:37 +0000
X-SES-Outgoing: 2018.04.04-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updating  git-completion.bash to include instructions to change the permissions on the file when sourcing it in your .bashrc or .zshrc file.
---
 contrib/completion/git-completion.bash | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b09c8a23626b4..fcd76cf169559 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -18,9 +18,10 @@
 # To use these routines:
 #
 #    1) Copy this file to somewhere (e.g. ~/.git-completion.bash).
-#    2) Add the following line to your .bashrc/.zshrc:
+#    2) Change the permissions of the file to be executable (e.g. chmod u+x  ~/.git-completion.bash)
+#    3) Add the following line to your .bashrc/.zshrc:
 #        source ~/.git-completion.bash
-#    3) Consider changing your PS1 to also show the current branch,
+#    4) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.
 #
 # If you use complex aliases of form '!f() { ... }; f', you can use the null

--
https://github.com/git/git/pull/480
