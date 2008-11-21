Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 27965 invoked by uid 111); 21 Nov 2008 10:05:25 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 21 Nov 2008 05:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbYKUKFT (ORCPT <rfc822;peff@peff.net>);
	Fri, 21 Nov 2008 05:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbYKUKFT
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 05:05:19 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:61666 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbYKUKFR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 05:05:17 -0500
Received: by fg-out-1718.google.com with SMTP id 19so681685fgg.17
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 02:05:15 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=P39J4gHwMLZtFk2yF7RQRspYB25BwkrU+5/HI8aKddc=;
        b=UxUhP3PN8kwyj7aw5Rbrq7KBjHCjLY03Ii+Ssf0NmZrNwgWzufUb0Qf9FOD+CsHTkM
         MJF31M7cQnymcAUpVjVaauLV860ajx4OlLtVZnjLw4rdNeCai4wEY6/3KR5I+Glgp5uU
         4EPD1a9GnB7XJ65sfjAKUN4ZqEqcosSQQg8Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qiCP0inBEaax7N52RB+N99z9PIPBKURazp4OKMbjmL1tqXXc+morTqrRm5cOPTCR0U
         xDQ+1mS7gMnJTAzEA91GiLRRAgPpSM/GO7yCUAh7jt3oqdtr2XSbw9ZL1MgOjawrZwuR
         3AEKLSMqzR42ciF/VBCkbTXVT9r277atwGRkg=
Received: by 10.187.231.13 with SMTP id i13mr47581far.92.1227261915781;
        Fri, 21 Nov 2008 02:05:15 -0800 (PST)
Received: from localhost (p5B0F7F2A.dip.t-dialin.net [91.15.127.42])
        by mx.google.com with ESMTPS id b17sm2617366fka.7.2008.11.21.02.05.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Nov 2008 02:05:15 -0800 (PST)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: [TopGit PATCH] put die() messages to stderr
Date:	Fri, 21 Nov 2008 11:05:00 +0100
Message-Id: <1227261900-23420-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.0.3.618.g55080
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg.sh b/tg.sh
index 4dcc15e..21294f9 100644
--- a/tg.sh
+++ b/tg.sh
@@ -13,7 +13,7 @@ info()
 
 die()
 {
-	info "fatal: $*"
+	info "fatal: $*" >&2
 	exit 1
 }
 
-- 
tg: (f17218e..) bw/die-to-stderr (depends on: master)
