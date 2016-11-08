Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDE82022A
	for <e@80x24.org>; Tue,  8 Nov 2016 12:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbcKHMLz (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 07:11:55 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:55467 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933225AbcKHMLu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 07:11:50 -0500
Received: (qmail 16569 invoked from network); 8 Nov 2016 12:11:49 -0000
Received: (qmail 9469 invoked from network); 8 Nov 2016 12:11:49 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Nov 2016 12:11:49 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 10/16] i18n: add--interactive: remove %patch_modes entries
Date:   Tue,  8 Nov 2016 11:08:17 -0100
Message-Id: <20161108120823.11204-11-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.rc0.23.g8236252
In-Reply-To: <20161108120823.11204-1-vascomalmeida@sapo.pt>
References: <20161108120823.11204-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove unnecessary entries from %patch_modes. After the i18n conversion,
these entries are not used anymore.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 45653e094..93cc6f557 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -106,9 +106,6 @@ my %patch_modes = (
 		DIFF => 'diff-files -p',
 		APPLY => sub { apply_patch 'apply --cached', @_; },
 		APPLY_CHECK => 'apply --cached',
-		VERB => 'Stage',
-		TARGET => '',
-		PARTICIPLE => 'staging',
 		FILTER => 'file-only',
 		IS_REVERSE => 0,
 	},
@@ -116,9 +113,6 @@ my %patch_modes = (
 		DIFF => 'diff-index -p HEAD',
 		APPLY => sub { apply_patch 'apply --cached', @_; },
 		APPLY_CHECK => 'apply --cached',
-		VERB => 'Stash',
-		TARGET => '',
-		PARTICIPLE => 'stashing',
 		FILTER => undef,
 		IS_REVERSE => 0,
 	},
@@ -126,9 +120,6 @@ my %patch_modes = (
 		DIFF => 'diff-index -p --cached',
 		APPLY => sub { apply_patch 'apply -R --cached', @_; },
 		APPLY_CHECK => 'apply -R --cached',
-		VERB => 'Unstage',
-		TARGET => '',
-		PARTICIPLE => 'unstaging',
 		FILTER => 'index-only',
 		IS_REVERSE => 1,
 	},
@@ -136,9 +127,6 @@ my %patch_modes = (
 		DIFF => 'diff-index -R -p --cached',
 		APPLY => sub { apply_patch 'apply --cached', @_; },
 		APPLY_CHECK => 'apply --cached',
-		VERB => 'Apply',
-		TARGET => ' to index',
-		PARTICIPLE => 'applying',
 		FILTER => 'index-only',
 		IS_REVERSE => 0,
 	},
@@ -146,9 +134,6 @@ my %patch_modes = (
 		DIFF => 'diff-files -p',
 		APPLY => sub { apply_patch 'apply -R', @_; },
 		APPLY_CHECK => 'apply -R',
-		VERB => 'Discard',
-		TARGET => ' from worktree',
-		PARTICIPLE => 'discarding',
 		FILTER => 'file-only',
 		IS_REVERSE => 1,
 	},
@@ -156,9 +141,6 @@ my %patch_modes = (
 		DIFF => 'diff-index -p',
 		APPLY => sub { apply_patch_for_checkout_commit '-R', @_ },
 		APPLY_CHECK => 'apply -R',
-		VERB => 'Discard',
-		TARGET => ' from index and worktree',
-		PARTICIPLE => 'discarding',
 		FILTER => undef,
 		IS_REVERSE => 1,
 	},
@@ -166,9 +148,6 @@ my %patch_modes = (
 		DIFF => 'diff-index -R -p',
 		APPLY => sub { apply_patch_for_checkout_commit '', @_ },
 		APPLY_CHECK => 'apply',
-		VERB => 'Apply',
-		TARGET => ' to index and worktree',
-		PARTICIPLE => 'applying',
 		FILTER => undef,
 		IS_REVERSE => 0,
 	},
-- 
2.11.0.rc0.23.g8236252

