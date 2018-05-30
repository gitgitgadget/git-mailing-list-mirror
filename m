Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BDCD1F42D
	for <e@80x24.org>; Wed, 30 May 2018 13:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeE3NGC (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 09:06:02 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:44848 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbeE3NGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 09:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H4dAqcrgZ2VdZp2aIn69KekZju8wzJFkGVCAfc5jBE4=; b=fLK2zrYm4Ht5fo8l3Wky3fvwfA
        hJ5q3WaYkkcmOT4xD9NT4/0fUYCks4DgS5Q3gEFXIDwYhNIsc+zkXIKsX6KCnE7SYW5cV19OELEzV
        fBvhcq8ruOzj9zMACwAk38zXaFpIbhgaGkinKvhktBpiD5ju43NWYAm8R4Be+635hRkrkhHwCHBR/
        J9Vfv4zX1x/NJUK3p4yGZo1T3EdaihK5IJUBaX7cTe8MOSE/cGE+2oCukb9vBdzuceejleUgoXwL2
        S4CAmu0PWvmTqjqg6eapen2SZ9I9GEdZqTNnmkI9XYIRlqKTkAQGZOxRF78iYDybFc+9cf6OAWPi2
        MWXFB+wA==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:52590 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fO0nd-00EkpT-VW
        for git@vger.kernel.org; Wed, 30 May 2018 09:05:59 -0400
Date:   Wed, 30 May 2018 09:04:00 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] p4.txt: Use backquotes for variable names
Message-ID: <alpine.LFD.2.21.1805300901400.14918@localhost.localdomain>
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


For consistency, use backquotes when referring to environment
variables, as is done in other man pages.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index b0abe2cb0..004944b3c 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -392,7 +392,7 @@ dedicating a client spec just for 'git p4'.
 The name of the client can be given to 'git p4' in multiple ways.  The
 variable 'git-p4.client' takes precedence if it exists.  Otherwise,
 normal p4 mechanisms of determining the client are used:  environment
-variable P4CLIENT, a file referenced by P4CONFIG, or the local host name.
+variable `P4CLIENT`, a file referenced by `P4CONFIG`, or the local host name.


 BRANCH DETECTION
@@ -461,22 +461,22 @@ General variables
 ~~~~~~~~~~~~~~~~~
 git-p4.user::
 	User specified as an option to all p4 commands, with '-u <user>'.
-	The environment variable 'P4USER' can be used instead.
+	The environment variable `P4USER` can be used instead.

 git-p4.password::
 	Password specified as an option to all p4 commands, with
 	'-P <password>'.
-	The environment variable 'P4PASS' can be used instead.
+	The environment variable `P4PASS` can be used instead.

 git-p4.port::
 	Port specified as an option to all p4 commands, with
 	'-p <port>'.
-	The environment variable 'P4PORT' can be used instead.
+	The environment variable `P4PORT` can be used instead.

 git-p4.host::
 	Host specified as an option to all p4 commands, with
 	'-h <host>'.
-	The environment variable 'P4HOST' can be used instead.
+	The environment variable `P4HOST` can be used instead.

 git-p4.client::
 	Client specified as an option to all p4 commands, with

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
