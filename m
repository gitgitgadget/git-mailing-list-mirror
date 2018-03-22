Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385491F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeCVQ6B (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:58:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33946 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeCVQ56 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:57:58 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so5696505plq.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YnokpKutcrQhwCMZX68OR5xP1iAZTC/ql08Fte5F7wQ=;
        b=l+sVqqq0LUclsCr2dwzk5kOyJWAxLuHMyNkqTfLF1rY4UoTa4q0sBwpycdfiKMBpH8
         C1atE1xIcTqID8roKNrDIS94xbhEC6ceYgCovKE9AuFke/sw8Fc/jI1WdkpMb1/pufEk
         bJ7BgByhNGaQJXUpSKNlTrMCkbQ4TIAbKFK0AF/vF9mYSqQQ7i1Y4rtGaKD8ntFvjsAI
         gRu6+lS+CO5mT3dfkKydIZokjxjz15jyyhluc62bWO9IUgCWFFFOfJxAQ7ckUftlydvX
         xnFd9dD8bGorL2CaWvsXdFh8y3o+waNSi0jVxHQiB7xduLothAf/KX75YpO2j/hSHdcy
         dNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YnokpKutcrQhwCMZX68OR5xP1iAZTC/ql08Fte5F7wQ=;
        b=p4n7+L29PsBH7aWB4iFIWpDx+X0rzykqplbe0bvjrSTADiOB1Ec/2bsrBG52Wlxaur
         4fCXWXA+XGpgiDLofowxbm6aRGzm6wHX1lih7dauy1fErSf8IQQCM60BGiSDizKMc392
         bvA70KosjHXSImTENT3DO8JF2rKJ0BjpG9SJqMfJem86Xa09Uisx7/q02cybYP4MA8De
         DNZSM+bOP2ONchh6Fb5RpZo3li6gOhFt+4WZS/350/koeFslee4af7GWcHSQM/QjufiC
         yu2wT0a4wO4h8fXfo8GgFPRF5d6UeuuIeQtFhTsubjcqZvhynVlwC4fu0adX9+cYeWgz
         RE2Q==
X-Gm-Message-State: AElRT7E8CS6q5lgImzCEZ5FbzwfSDZ5nUvrVHbfSCE2WcePUz3+mNK6b
        Uw/4FoYo3NLCSPKAkp6kPuyZJJ45dWM=
X-Google-Smtp-Source: AG47ELvd8Ha5Jye9qCI0bzBTedhRIl+fbP6hbYGCSTDpu1nmMDyxN47cKAly/osrfr2hPNWC5YZipQ==
X-Received: by 2002:a17:902:66e6:: with SMTP id e93-v6mr26084091plk.312.1521737876412;
        Thu, 22 Mar 2018 09:57:56 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id 2sm15043830pfo.70.2018.03.22.09.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:57:55 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [RFC PATCH v3 9/9] Remove merges_option and a blank line
Date:   Thu, 22 Mar 2018 09:57:29 -0700
Message-Id: <ab8794c766349f5aab1746797817ffa1d576a04f.1521690197.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
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

