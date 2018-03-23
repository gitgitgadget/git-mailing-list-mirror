Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9762E1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeCWV0H (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:26:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36483 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeCWV0F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:26:05 -0400
Received: by mail-pl0-f68.google.com with SMTP id 91-v6so392242pld.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YnokpKutcrQhwCMZX68OR5xP1iAZTC/ql08Fte5F7wQ=;
        b=kwyR36cqRDDJZPQ0DmIxdwTKFPKj2/PcFNHbtkhnQTSv9XVhexEgx5F13FfoPlrFPd
         DMe+ckH8xeTWWBEDMDaJ88398e/dlrAuqMq+6pHUz1xBmCxC+cVlKRJUr9Zoh/LpxHpQ
         Rb5zdLyXQ5c5iwmsqdFZMfwsuDaMlNdIWDbZeU+214LknJ08X7TNq/5IrMywbUR+hjq6
         9k7GozCtSY09cAVDiAWuEIroXIzpZJ4ycXWSQYToh3Z7/nkqqheDkNJ+TLpZMI8v3ypr
         Qq0qUy1CX/5PW6j00kY/k388yj25a7T/elUj7xEIov1081Y0CvJqwNELFDbF7nIqKXXN
         /hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YnokpKutcrQhwCMZX68OR5xP1iAZTC/ql08Fte5F7wQ=;
        b=RnnBvJl79witMTz9dfmOIeVjzMf5zODv1obe/JQx8lnBYsgpSFP3YLik5F57yrcUck
         nQWZ4hDXz6BWjNFboVOiWn1UH5h1gWtkCcCHXyoM5N0gykJR9zSxE4Rm/GRyjkn+PvCx
         dhpKEIp+25plbhyIDk3oLDW2QEYfiNepZf2P5P/VTkBfFl5WmMClhd7Gi/PpK/EdiWPO
         7km8mfuG13X/01y9cWlAoyPp+hKz6Ckek9oBEhovHVOMcM6ev3Jy9QwFAjTmgPVGONvj
         qDzON9SIkfD54WRQ8LVJw7yzrRDJ+sSxlxeyBDy5fWHnb2LsNYa4gjaLq5PsGPXBjg+s
         ROhQ==
X-Gm-Message-State: AElRT7HhPTNwzlqBL7OB6+PV+HWJhwvHQ9XTs7AUJIQWHv+i0HC/RUyD
        f96pvM6wwAb8hKCw2wYRBe05R696iXs=
X-Google-Smtp-Source: AG47ELtFxKX00121wJPcW73lcvkoAlovfP5hgy4s57TMcUoLyU64/1ikbEVXWs/IBVnOfnjGm2vi1w==
X-Received: by 2002:a17:902:5716:: with SMTP id k22-v6mr30748287pli.229.1521840364692;
        Fri, 23 Mar 2018 14:26:04 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id z28sm15380096pgc.15.2018.03.23.14.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:26:03 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gister@pobox.com,
        sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v5 8/8] Remove merges_option and a blank line
Date:   Fri, 23 Mar 2018 14:25:29 -0700
Message-Id: <56ec4f8edf648917dc5cb11ecdf67b16e78d26ce.1521839546.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521839546.git.wink@saville.com>
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merges_option is unused in git_rebase__interactive and always empty in
git_rebase__interactive__preserve_merges so it can be removed.

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ddbd126f2..50323fc27 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -961,8 +961,6 @@ git_rebase__interactive () {
 	setup_reflog_action
 	init_basic_state
 
-	merges_option="--no-merges --cherry-pick"
-
 	init_revisions_and_shortrevisions
 
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
@@ -996,22 +994,16 @@ git_rebase__interactive__preserve_merges () {
 			die "$(gettext "Could not init rewritten commits")"
 	fi
 
-	# No cherry-pick because our first pass is to determine
-	# parents to rewrite and skipping dropped commits would
-	# prematurely end our probe
-	merges_option=
-
 	init_revisions_and_shortrevisions
 
 	format=$(git config --get rebase.instructionFormat)
 	# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
-	git rev-list $merges_option --format="%m%H ${format:-%s}" \
+	git rev-list --format="%m%H ${format:-%s}" \
 		--reverse --left-right --topo-order \
 		$revisions ${restrict_revision+^$restrict_revision} | \
 		sed -n "s/^>//p" |
 	while read -r sha1 rest
 	do
-
 		if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
 		then
 			comment_out="$comment_char "
-- 
2.16.2

