From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 1/5] Also install cg-*.txt files
Date: Sat, 13 Aug 2005 18:25:02 +0200
Message-ID: <20050813162502.GB968@diku.dk>
References: <20050813162352.GA968@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 18:25:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3yol-0000FE-Jt
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 18:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVHMQZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 12:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVHMQZE
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 12:25:04 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:15066 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932177AbVHMQZD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 12:25:03 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id B9D5D6E1715; Sat, 13 Aug 2005 18:24:50 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 4C6266E174D; Sat, 13 Aug 2005 18:24:50 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 666ED60A44; Sat, 13 Aug 2005 18:25:02 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050813162352.GA968@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 debian/rules |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -67,6 +67,7 @@ install: build
 	$(MAKE) install DESTDIR=$(CURDIR)/debian/cogito prefix=/usr
 	# $(RM) $(DESTDIR)/usr/bin/cg
 	install -m 0644 Documentation/*.html $(DESTDIR)/usr/share/doc/cogito/html
+	install -m 0644 Documentation/cg-*.txt $(DESTDIR)/usr/share/doc/cogito/txt
 	install -m 0644 Documentation/cogito.txt $(DESTDIR)/usr/share/doc/cogito/txt
 	install -m 0644 Documentation/*.1 $(DESTDIR)/usr/share/man/man1
 	install -m 0644 Documentation/*.7 $(DESTDIR)/usr/share/man/man7

-- 
Jonas Fonseca
