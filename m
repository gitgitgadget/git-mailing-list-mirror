Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586B31F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbfKERHj (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32927 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388177AbfKERHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id s1so22365442wro.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KclAhPavntM2sDuE/cp2Hmb4f0D9F4zQzkAxBPIN5XQ=;
        b=eaBcbn+m6ISQCSq4fZL3/svcQOZuz5ocA6o8CMDU0Bt/D1S0hey+hAAtJSaRTNSTE3
         cOyt7ex4mzEWDeWlsQckEdfVvylBtkdcwoIhpFeUIkWKTuvVV5oRQqJWVdR4WQcUBBl+
         2CY5MykIA2rdiDcJzdU8E5MR+CFxn4XhwW2n5Ywzv362IG76Yg67y4YwZ64zjnRAkFWL
         6MyYlz8bqlfkfIR/EHc44nEPKCa+bSMTSU3bsFP/iaEY77H/xlomRQhRG7FnhzZOEOYC
         qO3RgVXs/RkhFmQRY3SQxobjx2QvVCcxq8UTtvKgCmQXSZulmN5AQRUNWpevmnWj2wg+
         yFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KclAhPavntM2sDuE/cp2Hmb4f0D9F4zQzkAxBPIN5XQ=;
        b=aGFM8b29b6xQ/MgGDB6qe4ivRoA4HiLzOFkx8tL4VngEMvb7I55nOttykVCYuWBDe7
         6HqFSPAaqqi/pqGkI7bNImrGu4RVdoALjb1Es1QnejWG7aUYVl9X5GHV3RQqWGPBGPOO
         +GxuF4EZV62TVygyus6zplnNiZbvVjW5PXPmL8LvrP6GW0ZA3hJabpbZ+7bO3m3NmRpB
         DGebUO9s22kM2btwp20LVsIEmL4uXWoa5gORGADpDUMicIJ+SNkSqF8xhP0YdwPtbOj/
         B2fuLI3VTl+gsFPSJiyXIVg9aZHkTfSkXkNvceguCI5UsqV+xXD1GPnOJdl7+kKIZcwt
         O1KA==
X-Gm-Message-State: APjAAAXp/HRhwGom+W8WtOLI3kt4+8hBzsulyKIl3mzh0GXJ5d711k66
        N5pjctS3+WgfDAnUNtGW0lx43PcV
X-Google-Smtp-Source: APXvYqwC0EwsvRmAVBweM29bLh5j1Knz6mYijNIDBBjwf5JaSjGihPjNpJyozLkMH+kyn3sPk429vA==
X-Received: by 2002:a5d:54cb:: with SMTP id x11mr29641262wrv.161.1572973656533;
        Tue, 05 Nov 2019 09:07:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 36sm42193429wrj.42.2019.11.05.09.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:36 -0800 (PST)
Message-Id: <812c36a6d418276bade9860c083c7d32b158496a.1572973651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:21 +0000
Subject: [PATCH v2 02/11] Fix spelling errors in documentation outside of
 Documentation/
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 INSTALL                       | 2 +-
 contrib/hooks/update-paranoid | 2 +-
 perl/Git.pm                   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/INSTALL b/INSTALL
index c39006e8e7..e7ff0a82b6 100644
--- a/INSTALL
+++ b/INSTALL
@@ -109,7 +109,7 @@ Issues of note:
 
  - Git is reasonably self-sufficient, but does depend on a few external
    programs and libraries.  Git can be used without most of them by adding
-   the approriate "NO_<LIBRARY>=YesPlease" to the make command line or
+   the appropriate "NO_<LIBRARY>=YesPlease" to the make command line or
    config.mak file.
 
 	- "zlib", the compression library. Git won't build without it.
diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index d18b317b2f..0092d67b8a 100755
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -49,7 +49,7 @@ opcode.
 Repository sections are matched on the basename of the repository
 (after removing the .git suffix).
 
-The opcode abbrevations are:
+The opcode abbreviations are:
 
   C: create new ref
   D: delete existing ref
diff --git a/perl/Git.pm b/perl/Git.pm
index 62c472e0ce..54c9ed0dde 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -563,7 +563,7 @@ sub get_record {
 Query user C<PROMPT> and return answer from user.
 
 Honours GIT_ASKPASS and SSH_ASKPASS environment variables for querying
-the user. If no *_ASKPASS variable is set or an error occoured,
+the user. If no *_ASKPASS variable is set or an error occurred,
 the terminal is tried as a fallback.
 If C<ISPASSWORD> is set and true, the terminal disables echo.
 
-- 
gitgitgadget

