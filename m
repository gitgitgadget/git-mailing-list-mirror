Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C348F20248
	for <e@80x24.org>; Wed,  6 Mar 2019 09:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfCFJOy (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 04:14:54 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:43372 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfCFJOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 04:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bv/Ljbrvv6ANKb4SF6kB5I+P/uPhyc0rx6kxB+v6yX4=; b=L1wPvaj97wXslEyDr26xQtwGly
        f+pXw2G5YzTEVds63PpHx/HGSJdP3CbSvoRNBQq7EOylBtNV7HsMKV5engjsCixuM6T3MKc0m0mzR
        HEKGIIDyYGaZwXL6yW6t6Z8tbKDc+0mbGmyTwYOhomcY9V7Cdr0FcDFG664zfjKM2EDMxbUlbChmY
        RvT11wB9TWPZ3RUBNHGs1DLQvYjgpaW6xAjjz3Cfel0achX8tJAxb7z3ROkZtVVqKlhm5LJvZFDF7
        pXmQ558PBNUuo7XV/Ed5V0MuqcVL7MRxCVyONAdBoiS3fGAjiCV9TgRhGM1KDLvlJVGtmhrPktz7L
        VsheKpEg==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:43148 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h1SdS-002zkY-Fc
        for git@vger.kernel.org; Wed, 06 Mar 2019 04:14:52 -0500
Date:   Wed, 6 Mar 2019 04:14:44 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] attr.c: ".gitattribute" -> ".gitattributes" (comments)
Message-ID: <alpine.LFD.2.21.1903060413140.16835@localhost.localdomain>
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


Correct misspelled ".gitattribute" in comments only, so no functional
change.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/attr.c b/attr.c
index fdd110bec5..93dc16b59c 100644
--- a/attr.c
+++ b/attr.c
@@ -431,14 +431,14 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * Like info/exclude and .gitignore, the attribute information can
  * come from many places.
  *
- * (1) .gitattribute file of the same directory;
- * (2) .gitattribute file of the parent directory if (1) does not have
+ * (1) .gitattributes file of the same directory;
+ * (2) .gitattributes file of the parent directory if (1) does not have
  *      any match; this goes recursively upwards, just like .gitignore.
  * (3) $GIT_DIR/info/attributes, which overrides both of the above.
  *
  * In the same file, later entries override the earlier match, so in the
  * global list, we would have entries from info/attributes the earliest
- * (reading the file from top to bottom), .gitattribute of the root
+ * (reading the file from top to bottom), .gitattributes of the root
  * directory (again, reading the file from top to bottom) down to the
  * current directory, and then scan the list backwards to find the first match.
  * This is exactly the same as what is_excluded() does in dir.c to deal with
@@ -899,7 +899,7 @@ static void prepare_attr_stack(const struct index_state *istate,
 	 * set of attribute definitions, followed by the contents
 	 * of $(prefix)/etc/gitattributes and a file specified by
 	 * core.attributesfile.  Then, contents from
-	 * .gitattribute files from directories closer to the
+	 * .gitattributes files from directories closer to the
 	 * root to the ones in deeper directories are pushed
 	 * to the stack.  Finally, at the very top of the stack
 	 * we always keep the contents of $GIT_DIR/info/attributes.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
