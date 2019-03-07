Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4AB20248
	for <e@80x24.org>; Thu,  7 Mar 2019 06:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfCGGFE (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 01:05:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38301 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGGFE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 01:05:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so10399430pgl.5
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 22:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=U8VlA82TK7atpj+Es0OYZ/Z5djYU6BDgIwW/6rdvEoc=;
        b=UwJ6PBDEPL3Q3aKdGo4tjwQoMFD7xf/2N4pD+NDRGvxUPzLmzjweDztWr+HsiAs2Ns
         JkXjpGGqnrLX8eRUNZ345i7BlcbFq2eg39fQTeM1PW+cnoSggG7cD8uM/wPRZ5YMa44i
         YJ6mnR7iEPvW//npBAXMNyF4mfb8s26NjZV/GuE3Wa8ksWKLUeYirV32rS8ansgz47nZ
         jjtgtyXErmPffiFUFPK8wkMDv2yigrutoyispEksHMA2Ui257yzbkpVXhsc0iNyiLKfb
         Kv5jeAupKPZdLnB8xppRZjIvctJeXmkKAmF3au9qMlru0Rf0fW7VdT1bSiGkaH3g6g/b
         MGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=U8VlA82TK7atpj+Es0OYZ/Z5djYU6BDgIwW/6rdvEoc=;
        b=XLRMuTOzjXFdY5XZl/UQheRw5Zu/iug1hFjDJqgst23PZUctTjbpAr2BZytFyryhQq
         U7tUJYppecX66nfSlHRFuiGLnu3a+8R+yU4b3iYVX6mCl4BwmIhUpg2DAtcBHBOa+QM8
         lFzPUrmlY3oa+8fawmPbExOUI4/TafzVDqBL6Y56YizxT6zO3cBwcacNbRa1hV5FH5qB
         7wL88l5pakwPGQsbbPFDCtGmPD+LvWKheL+0p2QR22bbUmymXfuH6WpCOcNf9c1PwEIz
         qDiycKToXPxKy8xWVfXJVlaYY2ioRj8Syr+CsTURKrS2yAo5CN4nZ1sN3h7D4PvdsN+/
         u+QA==
X-Gm-Message-State: APjAAAVuNFZeQBF0iarFucEzUJTCrlFJw4adeLK9kS8zFS+q6CMdvEQT
        LpV6kFSH+6rPAgZiRB1nS8I2EeRN
X-Google-Smtp-Source: APXvYqzNIMj64645jt2wu+xtBP3MbYsQ7btlATUvf/+1hnILgy2HQ4UhfgC07xf0H0TRGGlp5FsRUA==
X-Received: by 2002:a62:29c6:: with SMTP id p189mr11438704pfp.194.1551938703227;
        Wed, 06 Mar 2019 22:05:03 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id e21sm9618269pfh.45.2019.03.06.22.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 22:05:02 -0800 (PST)
Date:   Wed, 6 Mar 2019 22:05:01 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/1] git-clean.txt: clarify ignore pattern files
Message-ID: <2eda83517ebad39e14dca9d86b9dc2e0d32e37ef.1551938421.git.liu.denton@gmail.com>
References: <cover.1551868745.git.liu.denton@gmail.com>
 <cover.1551938421.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1551938421.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the git-clean documentation, -x and -e documented .gitignore,
$GIT_DIR/info/excludes but neglected to mention the file pointed to by
core.excludesFile.

Remove specific list of files and, instead, reference gitignore(5)
documentation so that information is consolidated and the git-clean
documentation is more precise.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-clean.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 03056dad0d..d251ef9dd2 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -55,13 +55,12 @@ OPTIONS
 
 -e <pattern>::
 --exclude=<pattern>::
-	In addition to those found in .gitignore (per directory) and
-	$GIT_DIR/info/exclude, also consider these patterns to be in the
-	set of the ignore rules in effect.
+	Use the exclude pattern in addition to those found in
+	`.gitignore` and similar files (see linkgit:gitignore[5]).
 
 -x::
-	Don't use the standard ignore rules read from .gitignore (per
-	directory) and $GIT_DIR/info/exclude, but do still use the ignore
+	Don't use the standard ignore rules read from `.gitignore` and
+	similar files (see linkgit:gitignore[5]), but do still use the ignore
 	rules given with `-e` options.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
 	conjunction with 'git reset') to create a pristine
-- 
2.21.0.368.gbf248417d7

