Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AF3C2D0C2
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 17:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3779D22B48
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 17:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ovsienko.info header.i=denis@ovsienko.info header.b="mSKRJCJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgADRov (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 12:44:51 -0500
Received: from mailout-l3b-97.contactoffice.com ([212.3.242.97]:44282 "EHLO
        mailout-l3b-97.contactoffice.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbgADRov (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Jan 2020 12:44:51 -0500
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Jan 2020 12:44:50 EST
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
        by mailout-l3b-97.contactoffice.com (Postfix) with ESMTP id 8B845810
        for <git@vger.kernel.org>; Sat,  4 Jan 2020 18:39:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1578159569;
        s=20191222-27gd; d=ovsienko.info; i=denis@ovsienko.info;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1089; bh=Doz7gAt7qtf4mijK7uA4zbBBhcYWbaQci7iDf0q5Zfo=;
        b=mSKRJCJ2l31D7cRoVcaMEuKlqwYQCUyh+KlaJQnHb7fdGnZFqo5snu0j2DTCY/CI
        1xB5+UrG5kXRBXsrfBCQJjWeKbFBs1RBJzApbdY/Fjkb0N2ndMrY8z3gKH/Uss1qS45
        eT5aRctOZ1u5GA/WD3QVG4tBPvi3WaeTr8vnpHH6V0eyNy+qv9mX2TLcm5+p+qzxPd+
        4WWAvRpVFe8Fm9u3M1/oZ7Bq+u/QkAfGRbBcXruNMG9m0awimte8W2M9cBe6+keMLEq
        QQtEFL5P6gCFvQGLTfKJQiWlOUk4MkbkfdLBmypUX6YyjvPrhKWwRiRsZZkmjOcI4gG
        yoc0LKlgPw==
Received: by smtp.mailfence.com with ESMTPA
          for <git@vger.kernel.org> ; Sat, 4 Jan 2020 18:39:25 +0100 (CET)
Date:   Sat, 4 Jan 2020 18:39:26 +0100 (CET)
From:   Denis Ovsienko <denis@ovsienko.info>
To:     git@vger.kernel.org
Subject: [PATCH] gitweb: fix a couple spelling errors in comments
Message-ID: <20200104173923.45537050@basepc>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:235611502
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Date: Sat, 4 Jan 2020 17:33:55 +0000

Signed-off-by: Denis Ovsienko <denis@ovsienko.info>
---
 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0f857d790b..65a3a9e62e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -741,7 +741,7 @@ sub evaluate_gitweb_config {
 	$GITWEB_CONFIG_SYSTEM = "" if ($GITWEB_CONFIG_SYSTEM eq $GITWEB_CONFIG_COMMON);
 
 	# Common system-wide settings for convenience.
-	# Those settings can be ovverriden by GITWEB_CONFIG or GITWEB_CONFIG_SYSTEM.
+	# Those settings can be overridden by GITWEB_CONFIG or GITWEB_CONFIG_SYSTEM.
 	read_config_file($GITWEB_CONFIG_COMMON);
 
 	# Use first config file that exists.  This means use the per-instance
@@ -5285,7 +5285,7 @@ sub format_ctx_rem_add_lines {
 		#    + c
 		#   +  d
 		#
-		# Otherwise the highlightling would be confusing.
+		# Otherwise the highlighting would be confusing.
 		if ($is_combined) {
 			for (my $i = 0; $i < @$add; $i++) {
 				my $prefix_rem = substr($rem->[$i], 0, $num_parents);
-- 
2.17.1
