Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178DA20281
	for <e@80x24.org>; Mon,  2 Oct 2017 22:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdJBW4j (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 18:56:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:64142 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdJBW4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 18:56:38 -0400
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MD9J6-1e6uT23thE-00GXv6; Tue, 03 Oct 2017 00:56:37 +0200
Date:   Mon, 02 Oct 2017 22:56:36 +0000
Message-ID: <20171002225636.Horde.mXj_gBTKz-CxnFKzUqiNDA1@bedhanger.strangled.net>
From:   Bedhanger <bedhanger@gmx.de>
To:     git@vger.kernel.org
Cc:     Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] PR msg: capitalise "Git" to make it a proper noun
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-Provags-ID: V03:K0:+EHwMoYWAd/JM0canPjhvbQpjjfJRFfN149tAkCM1n6B3fTBi/u
 mAQsfDroPZtDvEVD2oq7U04Fesryqz51ZQfRbDyzCgR/GAVL1irmd8sbx7YgaoRUBzjwOrL
 VAja2fW9Evv58bANqX5FMrsiJXh9hOYQYVFm3ejjxvJGFI21KSldOGYfYjLHOppqtgY86GD
 DvChsqLnXHnEaofvh4UDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iy9QiB/14u8=:LjJXIHxHXz4tN8LexPFVY+
 iC/ax7jhz2Y+XTyT8+j0LKuU7z89BFwklvM0Z98R6CsPbEugxEXgJUR0ImoVaLTon3rpsMMO+
 pVEUgTTD1kQBrA5/SwUQRZKyQeK4le810lWzCSoCi3pzjCPP3by4DGg3/wZ9BwwT6B3NkjAZ2
 xuJ6ZigOUp9SX6oBSTX1dDb+grAlSte9QsDk2W+MuuwGRGlMnJG2tCTkvMY+sEnh+5BBPf+WV
 OggqpEj7pIZtry91udD1/E7IVDBxT4eYVmAWxbUhsOJ7njYzLSx4DNU2SwS+JjUrPOkiV972/
 SfPeCQeqvs8BIlMqwY0awEMMKkeoWS8RrYla5CxdRu4MtTohvlAva3DTiovGtsMwwHqNST0OA
 ot9Bwi/6crsDE1AnAaeLF9Iz8J3yXBvD9UQG9zsvmCwNwHuf7xoST/y+MmhkDtErIeeyA7hiP
 y9jGlY4aTXtqAF7B6Yh4i1//YcNwii04I3Mz45rzEQ/UfQrfFX4uU/1FubG4EdUqcwFHHZHxE
 KhvtP2K2bW+LKKTjZyJ50qIQqm21+QXpjk1W34p2cOsfddkL5goLPBsnI4/Z2WatjYuhZ5C0F
 21QITfGVz7JaNLqhM4cMcE+1YSWDI1aTyiEpgrr0ad9lgZYe8L7IQ4rGQTrEPnpQuBxUFsXEl
 yGhAXRYgab5nMbt1nFJ3QxbUAja04n2KcLaPkn2fGgl2/JKzVsrV4T/7HkTfvJRViMPxmrJ2c
 9SPGcvQVZcY/4hWvEvEBcr61ZjVncqaqHbk0Q0hGbZcHyFZs7DM7nhASU0hWb0YH9zEZmCm4f
 SM5+VJ1wjQldG8tM3mEWVlWhI/n8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Of the many ways to spell the three-letter word, the variant "Git"
should be used when referring to a repository in a description; or, in
general, when it is used as a proper noun.

We thus change the pull-request template message so that it reads

    "...in the Git repository at:"

Besides, this brings us in line with the documentation, see
Documentation/howto/using-signed-tag-in-pull-request.txt

Signed-off-by: bedhanger <bedhanger@gmx.de>
---
  git-request-pull.sh     | 2 +-
  t/t5150-request-pull.sh | 4 ++--
  2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index eebd33276da9..13c172bd94fc 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -128,7 +128,7 @@ git show -s --format='The following changes since  
commit %H:

    %s (%ci)

-are available in the git repository at:
+are available in the Git repository at:
  ' $merge_base &&
  echo "  $url $pretty_remote" &&
  git show -s --format='
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 82c33b88e710..08c210f03586 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -68,7 +68,7 @@ test_expect_success 'setup: two scripts for reading  
pull requests' '
  	cat <<-\EOT >read-request.sed &&
  	#!/bin/sed -nf
  	# Note that a request could ask for "tag $tagname"
-	/ in the git repository at:$/!d
+	/ in the Git repository at:$/!d
  	n
  	/^$/ n
  	s/ tag \([^ ]*\)$/ tag--\1/
@@ -192,7 +192,7 @@ test_expect_success 'pull request format' '

  	  SUBJECT (DATE)

-	are available in the git repository at:
+	are available in the Git repository at:

  	  URL BRANCH

-- 
2.13.6

