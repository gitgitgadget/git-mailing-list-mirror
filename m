Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F310B20986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967115AbcJFJMX (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:12:23 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37687 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966161AbcJFJMV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:12:21 -0400
Received: by mail-wm0-f47.google.com with SMTP id b201so32954442wmb.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 02:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FoX6BV8vFdysqyjPcx1bI3/tiNjPzVVAr+RLXJWHxYM=;
        b=V0THYdLAewMLaW5utGNKId+50WnOYzgRuOe06UMJynsY280ri2j3131flqjOvlbkgd
         MuPLBYv1h7v3yX0dJqee+eIZjiEbLFDcTWSXt6YWhqiGWWL1Q2rtP9qDDz5YxNrVE60o
         /8di1lm7fUdIE0iqFRHOJWlV7pYFI+3+uhqUrxaIl3oL6mLT4P1oKe99cGeudCgoSLVj
         PWvw+QxULkhQty4BlpSYxg61uYIi2QIDdVa04ASeNeCiu8covSzSq8EFVvvgqfeQQYFw
         tNZpd13EpHxHX9KbbOHyY/WgJtTe404uqYYLd54pAJM7YjmZJGTJuuiKU3yKssgF8Z53
         GunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FoX6BV8vFdysqyjPcx1bI3/tiNjPzVVAr+RLXJWHxYM=;
        b=RGK8NA+sO9Z96nC3ES0Z+bf0r6UVMTiNHyPYKT0wuuXYoRk2jnf9jSV800IGa6Moxf
         IsDsTv6BC/FSJH3djQgJLsfzWctkoDOx+6u22w80OxQH95v/mHnbksBzLS3wzFStYYeQ
         15gAb//cqdiCHj2RjC1IO2bE2OBmOkTArGPOQtKBjRVJewR02mQ0wZaBmiydbU1H/+cj
         KBZn0bHdd/mCgtoq83/gr9I/aB/NyLtkcQ5L6+s999kuRJr/A3p7moMiyrE0uR9TOJK6
         QqXfa8bFfx9AIenyLE0fkalHdrLlkk0ojU27odzqIsyftZuDBKLyF00IVxX0eAKAS1su
         dFOg==
X-Gm-Message-State: AA6/9RmV+Tk+T/72MhWAlkz3Sqo+JR8Fyx0bkOveW15ojoek8zO4zmoViIFjUOy98DYQrw==
X-Received: by 10.194.118.131 with SMTP id km3mr11095244wjb.173.1475745139786;
        Thu, 06 Oct 2016 02:12:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 137sm34169946wmi.16.2016.10.06.02.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 02:12:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] gitweb: Fix a typo in a comment
Date:   Thu,  6 Oct 2016 09:11:33 +0000
Message-Id: <20161006091135.29590-2-avarab@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20161006091135.29590-1-avarab@gmail.com>
References: <20161006091135.29590-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a typo'd MIME type in a comment. The Content-Type is
application/xhtml+xml, not application/xhtm+xml.

Fixes up code originally added in 53c4031 ("gitweb: Strip
non-printable characters from syntax highlighter output", 2011-09-16).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 44094f4..cba7405 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1616,7 +1616,7 @@ sub esc_path {
 	return $str;
 }
 
-# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
+# Sanitize for use in XHTML + application/xml+xhtml (valid XML 1.0)
 sub sanitize {
 	my $str = shift;
 
-- 
2.9.3

