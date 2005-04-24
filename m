From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Simplify building of programs
Date: Sun, 24 Apr 2005 02:23:06 +0200
Message-ID: <20050424002306.GB7437@diku.dk>
References: <20050423235956.GA7437@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 24 02:18:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUpO-0007dZ-9R
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVDXAXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVDXAXL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:23:11 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:51940 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262201AbVDXAXI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:23:08 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id B77156E28FB; Sun, 24 Apr 2005 02:22:16 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 81ED96E1FE7; Sun, 24 Apr 2005 02:22:16 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 228A661FDD; Sun, 24 Apr 2005 02:23:07 +0200 (CEST)
To: torvalds@osdl.org, git@vger.kernel.org
Mail-Followup-To: torvalds@osdl.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050423235956.GA7437@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[ Sorry, newbie in action. Last patch was for cogito, here it is the for
git in case it matters. ]

Do not first build .o files when building programs.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

--- 30290c79f4914d7575c87d1c06f441d8a3bc5115/Makefile  (mode:100644 sha1:57e70239503466fb3a77f1f2618ee64377e8e04b)
+++ uncommitted/Makefile  (mode:100644)
@@ -50,7 +50,7 @@
 
 init-db: init-db.o
 
-%: %.o $(LIB_FILE)
+%: %.c $(LIB_FILE)
 	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
 
 blob.o: $(LIB_H)

-- 
Jonas Fonseca
