Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30CE1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 13:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933240AbeFKN6m (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 09:58:42 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:54862 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933007AbeFKN6l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 09:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4ZdFoqvCRgQdNwCQ/3yR/5t05wQH1p4caUjjN3OthZ8=; b=cxYF6ZneH6vraTpjOUHZy/Ic4f
        s/PB3oEHnxU0fT1eph+Ln/0p0hAUVkdcRophoQjSg2Xuk6xTqdksF4RxqXYq2In8vRXlyXUnXcatm
        6pw8MoWLY+Bl2ImXMcAzeyJQKK45YC6G+eJANetEWwZZ4H2+f1LEVnJt/eg6QCxBpevBZ+OkYZEwa
        f7uadlfODuh0F5E0hjbEYhASqXZjhLvG8TLvsyBsn8unPK/DbISbi6NTuu6D2TednaD0N6qfap1Iq
        2kxXyyHwSgTcKZMlS4hrh3/J/Fq1+48j0zk/yuq3chqMSreXzclaB2+SMxQfK0Lr/T3NB1J1KvXbJ
        9JhivALQ==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:46844 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fSNLD-004Ib1-4o
        for git@vger.kernel.org; Mon, 11 Jun 2018 09:58:40 -0400
Date:   Mon, 11 Jun 2018 09:56:13 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] diff-options.txt: fix minor typos, font inconsistencies, in
 docs
Message-ID: <alpine.LFD.2.21.1806110954470.14784@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f466600972..30aad8396d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -64,7 +64,7 @@ ifndef::git-format-patch[]
 endif::git-format-patch[]

 --indent-heuristic::
-	Enable the heuristic that shift diff hunk boundaries to make patches
+	Enable the heuristic that shifts diff hunk boundaries to make patches
 	easier to read. This is the default.

 --no-indent-heuristic::
@@ -106,7 +106,7 @@ diff" algorithm internally.
 	low-occurrence common elements".
 --
 +
-For instance, if you configured diff.algorithm variable to a
+For instance, if you configured the `diff.algorithm` variable to a
 non-default value and want to use the default one, then you
 have to use `--diff-algorithm=default` option.

@@ -350,7 +350,7 @@ ifndef::git-format-patch[]
 	Warn if changes introduce conflict markers or whitespace errors.
 	What are considered whitespace errors is controlled by `core.whitespace`
 	configuration.  By default, trailing whitespaces (including
-	lines that solely consist of whitespaces) and a space character
+	lines that consist solely of whitespaces) and a space character
 	that is immediately followed by a tab character inside the
 	initial indent of the line are considered whitespace errors.
 	Exits with non-zero status if problems are found. Not compatible
@@ -364,7 +364,7 @@ ifndef::git-format-patch[]
 	this option is not given, and the configuration variable
 	`diff.wsErrorHighlight` is not set, only whitespace errors in
 	`new` lines are highlighted. The whitespace errors are colored
-	whith `color.diff.whitespace`.
+	with `color.diff.whitespace`.

 endif::git-format-patch[]

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
