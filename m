Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB93A2021F
	for <e@80x24.org>; Tue,  2 Aug 2016 23:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbcHBXwZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 19:52:25 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34545 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbcHBXwN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 19:52:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id p64so71009198pfb.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 16:51:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=S9Tfpn7PLdzl52QpLb6dt8ZrDiFw3+2q/brog6YZ7y8=;
        b=aQqjJidxLhGzqqzlEeq6vu+DW5QC8WQopjd1d3SLL3WR8ywK5yGOuz1fEaKQYhEZdV
         GwVPUrUUe8jXkJFygVmudITWHgVIR1BL34//ALcr4Fqr4Mnjobv1hWg0Bb6u/Cq+ZWCC
         oOhtv0h1uYBVw6SjjpbAsNH69uavwjDLw3wccI7keQruDxFUChuadps32XtSzo+0F7YP
         ogO800JRsUfJgsncAMaLJdgZMqr71B/z7zb+gpupMNeNccihWMp3k99QgguC57lumfVc
         okl7FfmnweKVDLcbxNbn1WPFijdeNV49MrZosjQo6rcbcZYbCrW5jh6NdBbFxYppa8DB
         qRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S9Tfpn7PLdzl52QpLb6dt8ZrDiFw3+2q/brog6YZ7y8=;
        b=ebb2LzzSbQ/EBdNEsEVEKfBc2oQFrhQhJSlI2OCgD/azYTpNoG8SOccKD9fwfxNxYu
         fkeHEsF1gQCwSCaYa/+ooFgL6uGpuQgMVB/b6cgTR0PXFFmEq134AWTFBRmDKTDZPXA/
         O6mATFvzxakFF/F7EnttLR4ttWPXcd6W8MNx/9Wa3Aho008ZZcDhsEkVKkgAcZSUAU1W
         uPhp7aiFpyYOG0C5Fmylz/F60EhgXemwRXxiFtYp9VHjcqEY6NRzpFP5Mtkw7wGtvt0Y
         pSKhtEXc59ODIljMwsCoc/Np67CIS+ScVDH4fOsNpW8meaKTwogCPPkQeMzvv6HoUfyS
         z2gg==
X-Gm-Message-State: AEkoousWyZpvviuzmsJGyzI4tP/FRx6aqBfkPlTz+GK6hGJ9OpA0DjJBwUCeEwBbPSXcDooV
X-Received: by 10.98.204.216 with SMTP id j85mr110938907pfk.147.1470181901360;
        Tue, 02 Aug 2016 16:51:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c95e:4bc7:6c52:ebb0])
        by smtp.gmail.com with ESMTPSA id v26sm7360411pfi.41.2016.08.02.16.51.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Aug 2016 16:51:40 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] gitmodules: document shallow recommendation
Date:	Tue,  2 Aug 2016 16:51:36 -0700
Message-Id: <20160802235136.27132-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.525.g1760797
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This goes on top of origin/sb/submodule-recommend-shallowness.
 I just realized we had an extra page for all the configuration options,
 so let's keep that in sync.
 
 Thanks,
 Stefan 

 Documentation/gitmodules.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index ac70eca..b97b331 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -79,6 +79,11 @@ submodule.<name>.ignore::
 	"--ignore-submodule" option. The 'git submodule' commands are not
 	affected by this setting.
 
+submodule.<name>.shallow::
+	When set to true, a clone of this submodule will be performed as a
+	shallow clone unless the user explicitely asks for a non-shallow
+	clone.
+
 
 EXAMPLES
 --------
-- 
2.9.2.525.g1760797

