Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A560202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 17:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965214AbdKPRJO (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 12:09:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55922 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934929AbdKPRJK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 12:09:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7270B0267;
        Thu, 16 Nov 2017 12:09:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=802/4edx2jDjNjzRIetOVrmH6W4
        =; b=iOmrlg4e7jiCmGlitK03eIIR0KDq8veIQBlX1CWWJguJ6gfMldOReiK7xxX
        Oo2hp/xvp4UYHntGm/X0I18O9zUwtB/5PAcAnkHYMGwe+8IeltrlZswgftOPlV4U
        Nbn+1MH3XUu7K8LPYHWwUzbnB/FgTCivuOcTtftBNFeD9AGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=LcTW1x+IjxZAY7ZA9PYgy
        UU0mFHbXsdfYc4gm0IiWlj7+YSNEcDwD77vJX6WxkVINlZJ8XyLC1ZQnSdg/r+2x
        1LU7xsstzt/irJxQFOt0n0k11a8Fb0Gd3tkXiwd4EiySmfWh19YUghpYMjkGe40E
        Y+nd3Bxbwf6espssMODOzw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF4C3B0266;
        Thu, 16 Nov 2017 12:09:07 -0500 (EST)
Received: from morphine.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A246B0264;
        Thu, 16 Nov 2017 12:09:07 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sahil Dua <sahildua2305@gmail.com>
Subject: [PATCH] completion: add '--copy' option to 'git branch'
Date:   Thu, 16 Nov 2017 12:09:06 -0500
Message-Id: <20171116170906.8155-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0
X-Pobox-Relay-ID: DAF138BA-CAF0-11E7-BEF9-8EF31968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 52d59cc645 (branch: add a --copy (-c) option to go with --move (-m),
2017-06-18), `git branch` learned a `--copy` option.  Include it when
providing command completions.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f07f16b28f..89eb65d280 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1204,7 +1204,7 @@ _git_branch ()
 			--color --no-color --verbose --abbrev= --no-abbrev
 			--track --no-track --contains --no-contains --merged --no-merged
 			--set-upstream-to= --edit-description --list
-			--unset-upstream --delete --move --remotes
+			--unset-upstream --delete --move --copy --remotes
 			--column --no-column --sort= --points-at
 			"
 		;;
-- 
2.15.0

