Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208891F406
	for <e@80x24.org>; Fri, 29 Dec 2017 02:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbdL2CBZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 21:01:25 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:44262
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754236AbdL2CBC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Dec 2017 21:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1514512860;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ngi6ebCpmE9P+qWousHLml0l0naA1MP4oF0zVxU9y0k=;
        b=HxlQ2cISB8MODHHsafjExzUmgVqil0NdWd4jERnbR1WbJCbUrw8ipN1209/o6D9v
        crpWzldVBwG2XkB/mq5309KNS1yeF9q6K3mouG9fe5Gx//izM6UqZDj7isnENq664k3
        G4JaGT7rYtwJJ6v8KQkm4VUdH/3ImdgOJZBhmm7A=
From:   Keith Smiley <k@keith.so>
To:     git@vger.kernel.org
Message-ID: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Add shell completion for git remote rm
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Dec 2017 02:01:00 +0000
X-SES-Outgoing: 2017.12.29-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Keith Smiley <keithbsmiley@gmail.com>

Previously git remote rm did not complete your list of removes as remove
does.
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5586..3e9044087e6ba 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2665,7 +2665,7 @@ _git_config ()
 _git_remote ()
 {
 	local subcommands="
-		add rename remove set-head set-branches
+		add rename remove rm set-head set-branches
 		get-url set-url show prune update
 		"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"

--
https://github.com/git/git/pull/448
