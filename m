Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B09201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 12:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932325AbdBVMZ4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 07:25:56 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40090 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932233AbdBVMZy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 07:25:54 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7E6ED280AD
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487766352;
        bh=aiWHOgl46P0D+i/yDTvCctWEdoVONVYDgVotkvpI774=;
        h=From:To:Subject:Date:From;
        b=fVKumLK2yHhwfCak3SvcYEcM9geS+1DcTOesjPiiWDVMc7TII7TeGS+NSLRigMHmH
         bBkGtlrLkmxA6VLkonu0IPoUl7adzqOVhvwQ91jIb9/A95exJntlxx5fNt6vg1yFut
         Wb/b4oD5JVu7+PB2broU6YmnShNXoRBs48V7Ayu3XPwZ0hFH0MaXGYHxGOqrhlXwCx
         vd+utJ9BM7QnzDIQ8S0CrMMa52hIiLZabWxX1i1CpxEZXpoH2caC+SzJghgmQU4Amb
         NUSjr1QQMXSjhXWSzetuot7vGIoAd1cH5p2+q26dtoT9QUQC/pzacf1LcSa9jvloSU
         sffnlGMVPX05UflJwhdNBL9iVFkLHE/671nH3ECVW02Q741BfAyyN97RNn05XqKMbz
         Dhtonbk6fd+0ndbrpzGRPCxVUscRhOhNINpwJO6XrVeiW64aRYrSTwLuoJ1G/Rnfl+
         ITcuUQ3qD+lTpmXjHpztN5N16EC5Eu2QPoCKMlYkzjU+/LKo6Y2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [PATCH] Documentation: use brackets for optional arguments
Date:   Wed, 22 Feb 2017 12:25:46 +0000
Message-Id: <20170222122546.922199-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for git blame used vertical bars for optional
arguments to -M and -C, which is unusual and potentially confusing.
Since most man pages use brackets for optional items, and that's
consistent with how we document the same options for git diff and
friends, use brackets here, too.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/blame-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 2669b87c9d..dc41957afa 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -77,7 +77,7 @@ include::line-range-format.txt[]
 	terminal. Can't use `--progress` together with `--porcelain`
 	or `--incremental`.
 
--M|<num>|::
+-M[<num>]::
 	Detect moved or copied lines within a file. When a commit
 	moves or copies a block of lines (e.g. the original file
 	has A and then B, and the commit changes it to B and then
@@ -93,7 +93,7 @@ alphanumeric characters that Git must detect as moving/copying
 within a file for it to associate those lines with the parent
 commit. The default value is 20.
 
--C|<num>|::
+-C[<num>]::
 	In addition to `-M`, detect lines moved or copied from other
 	files that were modified in the same commit.  This is
 	useful when you reorganize your program and move code
