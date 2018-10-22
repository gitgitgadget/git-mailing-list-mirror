Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D66B1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbeJWFGb (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:06:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34991 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbeJWFGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:06:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id w186-v6so456145wmf.0
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZL8OGRnPcCzp5CYP0PRHw5mlUL9DMIzcaR4lBnDuVRQ=;
        b=Stx3DpSQWZsRrzKGuNV3t2QsVighsYGkXx7vsyRGe2aqo0OPJexdopmlh8Cq641jft
         HpazqkPEaa22MT4OPXUMvCHLpxW0ErCo6ff2sLKwVvBW5nTbVATpgfH6sQ7U2KKZ620P
         vb/pZGqwaBvvVFBF5clLBfb4ech+OZQ6TeH8rjvNednVkGa2V9rDSFxAq3AlRyDrFMcP
         7+YnFvdAj13fmSF7DaWcbh3o4od5A0vAPJolXJkNyayMmKFXgYhGCKYIQVjUApS9QU4f
         3AXlfU944ZNvfCcizc6l6DXmHABoJRcnOVhoE/y3mJPuBBNNXI08moUsX2XC1EwtskFd
         CcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZL8OGRnPcCzp5CYP0PRHw5mlUL9DMIzcaR4lBnDuVRQ=;
        b=orIrk/qsIcBtmtwF+wgFK96lAMQOZZEyO6Azwa2MTtiqkLJMQrHjSyS9lSGxKAB9E7
         G2dhUCreBr8r1uUQ4moY3RqRiF4lbQNnrOImXMUb3e+gEnwg7KeQvE4qrqZCWYkH9TAh
         /Qq+ottqDWHmTKiY88OdMwX7LUnIx2eJm4BXconWA1mNaLYKWwTdriPurcb2l8aoY5n0
         4VGn8yVJEmuWLQ4uPdP1OToPZPtJPXZxl2qTPUMQWLTp+qvwGzAJ4VZX/zTUXLW/a1+X
         p8dNKrkedA8iASsCpYEjhcRtPgtdeC6yTRTk1mBPxCuyVldKvOruhuW61TIde4FMPVbe
         ZSAw==
X-Gm-Message-State: ABuFfohHZwHj/uInA3PhFYg/+88sqk0MLIgwePoRF1+AsarcoQWPYenC
        wxOz52Fe5JAfF73VlIsl65YCD+Sa
X-Google-Smtp-Source: ACcGV63oiBXa7xSv0onG4CcEfHZgVeaZs5AU/xw0dZXPrxM5pGvldqPCMqrrPJDIdsYvtEUx0Vn9Gw==
X-Received: by 2002:a1c:950f:: with SMTP id x15-v6mr16938412wmd.3.1540241183960;
        Mon, 22 Oct 2018 13:46:23 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:4936:e72c:acbd:e1bd])
        by smtp.gmail.com with ESMTPSA id r134-v6sm9526526wmg.9.2018.10.22.13.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:46:23 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 4/6] doc: fix descripion for 'git tag --format'
Date:   Mon, 22 Oct 2018 22:45:44 +0200
Message-Id: <20181022204546.20354-5-asheiduk@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022204546.20354-1-asheiduk@gmail.com>
References: <20181022204546.20354-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--format=<format>' is now listed in the 'OPTIONS' section, not only
the '<format>' string itself. The description moved up a few paragraphs
because '<format>' is not a standalone paramater but a parameter for the
option '--format'.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-tag.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 92f9c12b87..f2d644e3af 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -187,6 +187,12 @@ This option is only applicable when listing tags without annotation lines.
 	`--create-reflog`, but currently does not negate the setting of
 	`core.logAllRefUpdates`.
 
+--format=<format>::
+	A string that interpolates `%(fieldname)` from a tag ref being shown
+	and the object it points at.  The format is the same as
+	that of linkgit:git-for-each-ref[1].  When unspecified,
+	defaults to `%(refname:strip=2)`.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
@@ -198,12 +204,6 @@ This option is only applicable when listing tags without annotation lines.
 	The object that the new tag will refer to, usually a commit.
 	Defaults to HEAD.
 
-<format>::
-	A string that interpolates `%(fieldname)` from a tag ref being shown
-	and the object it points at.  The format is the same as
-	that of linkgit:git-for-each-ref[1].  When unspecified,
-	defaults to `%(refname:strip=2)`.
-
 CONFIGURATION
 -------------
 By default, 'git tag' in sign-with-default mode (-s) will use your
-- 
2.19.1

