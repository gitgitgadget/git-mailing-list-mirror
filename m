Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669C61F516
	for <e@80x24.org>; Mon, 25 Jun 2018 19:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755635AbeFYTSp (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 15:18:45 -0400
Received: from dmz-mailsec-scanner-4.mit.edu ([18.9.25.15]:44762 "EHLO
        dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753182AbeFYTSo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Jun 2018 15:18:44 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jun 2018 15:18:44 EDT
X-AuditID: 1209190f-a99ff70000000b3b-f6-5b313ee71d4a
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E2.02.02875.7EE313B5; Mon, 25 Jun 2018 15:13:43 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id w5PJDfD1011176;
        Mon, 25 Jun 2018 15:13:41 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.18.248.31])
        (authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id w5PJDc6X012984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Jun 2018 15:13:40 -0400
Received: by darkmatter.mit.edu (Postfix, from userid 32861)
        id AEEF4354B44; Mon, 25 Jun 2018 15:13:38 -0400 (EDT)
From:   =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To:     git@vger.kernel.org
Cc:     Dan Jacques <dnj@google.com>,
        =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH] Makefile: tweak sed invocation
Date:   Mon, 25 Jun 2018 15:13:25 -0400
Message-Id: <1529954005-18189-1-git-send-email-asedeno@mit.edu>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixCmqrPvczjDa4MwFKYsrizYwWcx/vJ3N
        outKN5MDs8fOWXfZPRZsKvX4vEkugDmKyyYlNSezLLVI3y6BK2PJhfeMBTdYK478mMzcwLiO
        pYuRk0NCwESi8/APIJuLQ0hgMZPE/aYP7CAJIYGNjBI3rhVBJC4xSfTsvgJUxQHklEhs2ygA
        YrIJOEkcvKQEUi4iIC7x9vhMdpAws0C6xMeN6SBhYQF9iYmtt9i6GNk5WARUJY67gER5Bewl
        9k/bwwZxgJzE+eM/mSHighInZz5hgRiiLrF+nhBImFlAXqJ562zmCYz8s5BUzUKomoWkagEj
        8ypG2ZTcKt3cxMyc4tRk3eLkxLy81CJdE73czBK91JTSTYzgkJTk38E4p8H7EKMAB6MSD++K
        lwbRQqyJZcWVuYcYJTmYlER505gNo4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8NrtByrnTUms
        rEotyodJSXOwKInzZi9ijBYSSE8sSc1OTS1ILYLJynBwKEnwnrUFGipYlJqeWpGWmVOCkGbi
        4AQZzgM0PAikhre4IDG3ODMdIn+KUVFKnJcJGPVCAiCJjNI8uF5wyhD6If+KURzoFWHeDSDt
        PMB0A9f9CmgwE9DgsscgVxeXJCKkpBoYLTuCr1gamqspvuJgC/rUu+GLN5P2Me3kCj32tCad
        WeHhen/99yZ+Lp/1s4v376Tbf8tcWnZKfC245LBXZI276DX77QqbvK4mfuXc+zXN6Z34umCJ
        mbdurjWZ+P66aAaL9fXePW0HJVmv1X5vn5zlLh5g43V7auSsq9/ke8/nF93J33hKtPKLEktx
        RqKhFnNRcSIACRQke/QCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With GNU sed, the r command doesn't care if a space separates it and
the filename it reads from.

With SunOS sed, the space is required.

Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e4b503d..5bac181 100644
--- a/Makefile
+++ b/Makefile
@@ -2109,7 +2109,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	rGIT-PERL-HEADER' \
+	    -e '	r GIT-PERL-HEADER' \
 	    -e '	G' \
 	    -e '}' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-- 
2.1.4

