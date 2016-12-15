Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F2520A48
	for <e@80x24.org>; Thu, 15 Dec 2016 11:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757391AbcLOL3L (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 06:29:11 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36203 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757367AbcLOL3K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 06:29:10 -0500
Received: by mail-pf0-f194.google.com with SMTP id c4so2782690pfb.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 03:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LvZhxImKi5jiw35WAPsOrE7JIhLKx2gHAbW1hFUW8OU=;
        b=r9WNxOaPUIVQ6OslagmGIlfjMd0aYlczkygoeg7FPdfgK/qP8cVKd3OAOrevTy1XLt
         +OFa/66u2t6OT09hX/CpFl225B7f5W6MYQNl31dMiWNZ/yx19/7Lulp+pAPDx9WOa3M5
         kD4sExPAcSfrzJKjwueiWOv1/5qhaUadotny0T9rNvqtS0uzYxVMjl86/EBo9E5rzEer
         v561mMwBGrxswEWvUX1U+WMvarXpO24PoKVMWEfIVhdqDnZrCJaOrV5ea2XwNM8EMzmD
         OdwO/nT3J7Yg6dsWgOaIdqTLmETz6V1MMmxUK4Z6CrdfM2DrBFrqu1mYM53mItFmY9Zj
         wImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LvZhxImKi5jiw35WAPsOrE7JIhLKx2gHAbW1hFUW8OU=;
        b=UwStymsXdPuYsNdFu5qL5xFuKHPim2tStbGmEEPZMeguJwtTOWk7y/jesaT2lNKM/E
         h5cNR4QVInA1lRTNNYd6ciH9yPnM7ldiliXjzWmHuSzO2QsMFspCbPJfDix2Ors1SLC0
         vZ281vXjsVMcpCYmgzknD6iDf/jsVlaYujjCmCCY01dxQYvtOjvBCK1kHUMwY9sSG32e
         w04HPZwhNysEtXLrL6TC2xJx7JL1jcIDQFArfb7RcHx3GVumUL9U+/cMRnh96BqtuX9y
         EwOiiV1vF68iE4YIfrNeFihw1BcxLomQ+ofM/JcXQoDXJbDds6OZQHm91vr9zHyTUxrJ
         GCNA==
X-Gm-Message-State: AKaTC023vROBJF1R8ch8flSJGN6dc0FrRCMRxm/5XCBbxZi1yaZHe5tby8E23rjHqLR4gA==
X-Received: by 10.98.201.196 with SMTP id l65mr1740682pfk.116.1481801349690;
        Thu, 15 Dec 2016 03:29:09 -0800 (PST)
Received: from kpdpro.suho.local ([118.211.97.195])
        by smtp.gmail.com with ESMTPSA id 189sm3930190pgh.5.2016.12.15.03.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2016 03:29:08 -0800 (PST)
From:   Pierre Dumuid <pmdumuid@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     Pierre Dumuid <pmdumuid@gmail.com>
Subject: [PATCH 6/6] Rename 'remotes/' to 'r../' in heads
Date:   Thu, 15 Dec 2016 21:58:47 +1030
Message-Id: <20161215112847.14719-6-pmdumuid@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161215112847.14719-1-pmdumuid@gmail.com>
References: <20161215112847.14719-1-pmdumuid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Pierre Dumuid <pmdumuid@gmail.com>
---
 gitk | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 0903d2d..6f50b06 100755
--- a/gitk
+++ b/gitk
@@ -6731,22 +6731,28 @@ proc drawtags {id x xt y1} {
     set yb [expr {$yt + $linespc - 1}]
     set xvals {}
     set wvals {}
+    set newTags {}
+
     set i -1
     foreach tag $marks {
 	incr i
+	set newTag $tag
+	regsub {^remotes} $newTag "r.." newTag
+
 	if {$i >= $ntags && $i < $ntags + $nheads && $tag eq $mainhead} {
-	    set wid [font measure mainfontbold $tag]
+	    set wid [font measure mainfontbold $newTag]
 	} else {
-	    set wid [font measure mainfont $tag]
+	    set wid [font measure mainfont $newTag]
 	}
 	lappend xvals $xt
 	lappend wvals $wid
+	lappend newTags $newTag
 	set xt [expr {$xt + $wid + $extra}]
     }
     set t [$canv create line $x $y1 [lindex $xvals end] $y1 \
 	       -width $lthickness -fill $reflinecolor -tags tag.$id]
     $canv lower $t
-    foreach tag $marks x $xvals wid $wvals {
+    foreach tag $marks x $xvals wid $wvals newTag $newTags {
 	set tag_quoted [string map {% %%} $tag]
 	set xl [expr {$x + $delta}]
 	set xr [expr {$x + $delta + $wid + $lthickness}]
@@ -6778,7 +6784,10 @@ proc drawtags {id x xt y1} {
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
 		-width 1 -outline black -fill $col -tags tag.$id
 	    if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
-	        set rwid [font measure mainfont $remoteprefix]
+		set newRemotePrefix $remoteprefix
+		regsub {^remotes} $newRemotePrefix "r.." newRemotePrefix
+
+	        set rwid [font measure mainfont $newRemotePrefix]
 		set xi [expr {$x + 1}]
 		set yti [expr {$yt + 1}]
 		set xri [expr {$x + $rwid}]
@@ -6786,7 +6795,7 @@ proc drawtags {id x xt y1} {
 			-width 0 -fill $remotebgcolor -tags tag.$id
 	    }
 	}
-	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $headfgcolor \
+	set t [$canv create text $xl $y1 -anchor w -text $newTag -fill $headfgcolor \
 		   -font $font -tags [list tag.$id text]]
 	if {$ntags >= 0} {
 	    $canv bind $t <1> $tagclick
-- 
2.10.2

