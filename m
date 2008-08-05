Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 23759 invoked by uid 111); 5 Aug 2008 15:07:55 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 05 Aug 2008 11:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbYHEPHp (ORCPT <rfc822;peff@peff.net>);
	Tue, 5 Aug 2008 11:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756165AbYHEPHo
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 11:07:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:16640 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808AbYHEPHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 11:07:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1306562fgg.17
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 08:07:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=3wqvlrk9Dwa/7nCiNL7ihkFpW+RyqMKYlJRXvt+xC+M=;
        b=ZASMrlU1xkIAVV+tMQZ1B752O+1fENjrxHvLK9dqSKCknPw85toJ5Fu2iedVU1ei4h
         i5uYtFr1ZF65RYLb5xNOHPsDNFpv7TU2WPKHR9aH4A8md7pFmKTUfG1npo6gqfdx2Kj3
         LCk18FitS9f/r6WapT4+u8pBne1wQbMZ1zspo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XZNP0OJKY/vduXvX6/33lhMsCso5CPQ/sXjKGN6vdWylu2ee7P2y2luvsWluMy7BNU
         oNrdC+4+RHzTVKNbuM5NQNvTaTpWOpH4d1IHOwNzxck/x7RTRnLROibWIqv5YZF3m/cR
         +qYzvb7JTruWUpN0YFwDUTa5R09h4uaIdpqAM=
Received: by 10.86.98.10 with SMTP id v10mr11766549fgb.39.1217948861521;
        Tue, 05 Aug 2008 08:07:41 -0700 (PDT)
Received: from localhost ( [217.234.112.152])
        by mx.google.com with ESMTPS id e20sm2052099fga.1.2008.08.05.08.07.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Aug 2008 08:07:40 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: [TopGit PATCH] tg-create.sh: fix help string
Date:	Tue,  5 Aug 2008 17:07:38 +0200
Message-Id: <1217948858-17466-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.5.5.GIT
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The help string of the tg-create command was not changed with the commit
"Change usage (-d ->arguments) <ab712f2ed92a6e451bf2d482b03d2559697bf100>".

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-create.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg-create.sh b/tg-create.sh
index d196e4f..5438deb 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -15,7 +15,7 @@ while [ -n "$1" ]; do
 	arg="$1"; shift
 	case "$arg" in
 	-*)
-		echo "Usage: tg create [-d DEPS...] NAME" >&2
+		echo "Usage: tg create NAME [DEPS...]" >&2
 		exit 1;;
 	*)
 		if [ -z "$name" ]; then
-- 
tg: (24367cc..) t/fix-tg-create-help-string (depends on: master)
