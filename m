Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AC31F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeJWSqK (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:46:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41485 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbeJWSqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:46:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id p5-v6so402301plq.8
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A2im7ztCWTjsqeQUMVRv5lfLzu6t4vsrM5HPLoPDR/A=;
        b=qogjpqXnxYMB8ucBGUCwzWclJX4KAB1qwfOp2JM33eGMR/AfiDAV5WgV/NJLvyYO7r
         4ZOLwXv2BTObrBNQdV1YIO++2+v/ftQTUuBXlWex1cKk/GgGeDddLohQeYHBDwecKb0q
         rm++N6tFi9fq8e+nYdTkk3e1NFcCFT4Hzft7mfQzRCF9paGOMvujC+56SV6iux5+W5zH
         4pZXbX7X8o4rrGMZ5+M6ACm5ra7qlFuv2U2Vr/bKESP/yXoGMkQrxjX4YqZb2VMAVP7F
         w28jC6d9iQei7npkjTS41Zw8vdWLI0symqpVsmRgGM1RQuW2yQXEdRoF0rh1LPhDwPVZ
         MqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A2im7ztCWTjsqeQUMVRv5lfLzu6t4vsrM5HPLoPDR/A=;
        b=aUMnnIHJ/1MiFw+cPcOvWXD+fdJHGAZcFhu4zcTSsvbCAQFCuP+Xv4e5/YAfGVqYo2
         IY20MoeZcJIGxfgWxjFXkMRfcK1DGY1sNiKiCa+sAR2jKo50A7ECGSgRr65uOL9oKurR
         j3v83yN0KEprOgI0Se1idUONssCY4s9/QukvtUJ4WyepU9PS38yEEhnNi/mb5WqLM+v7
         Qc0/0Y1BhZm/BY5G56TnCNEsg3dc8SwAfk+JT0vSPZQf5X6Nc1Koinf3HpzRU2c66+CD
         Ctq2AZtdbWkEPTE67xK/YRqN0MIeB4QPgERKh5WgpAbCDonqzaTAmA29RQP1mmxM8ESN
         Gqzg==
X-Gm-Message-State: AGRZ1gLdCG4XeHGLe7TR2b1zzn+QM8XsXSTDWdoyRXDbQ6qFt1CNC/Eu
        edaAwv4huZtj3WObmpJoazxaCJqK
X-Google-Smtp-Source: AJdET5cY4TvZnVaf2FTkOXwrheqFGP/tPxA36Na3Pz2oYGUNkWMA66MQXrk2Lu5Xp8ay2qwhjif4qg==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1-v6mr1778582plt.34.1540290202275;
        Tue, 23 Oct 2018 03:23:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id k24-v6sm1255514pfi.11.2018.10.23.03.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:23:21 -0700 (PDT)
Date:   Tue, 23 Oct 2018 03:23:21 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 10:23:15 GMT
Message-Id: <f2ce9bdc01892b514f75c6c25c3393765593b1ca.1540290197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.53.git.gitgitgadget@gmail.com>
References: <pull.53.git.gitgitgadget@gmail.com>
From:   "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] mingw: replace MSVCRT's fstat() with a Win32-based
 implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Karsten Blees <blees@dcon.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karsten Blees <blees@dcon.de>

fstat() is the only stat-related CRT function for which we don't have a
full replacement yet (and thus the only reason to stick with MSVCRT's
'struct stat' definition).

Fully implement fstat(), in preparation of implementing a POSIX 2013
compatible 'struct stat' with nanosecond-precision file times.

This allows us also to implement some clever code to handle pipes and
character devices in our own way.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d2e7d86db..07fc0b79a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -771,20 +771,31 @@ int mingw_stat(const char *file_name, struct stat *buf)
 int mingw_fstat(int fd, struct stat *buf)
 {
 	HANDLE fh = (HANDLE)_get_osfhandle(fd);
+	DWORD avail, type = GetFileType(fh) & ~FILE_TYPE_REMOTE;
 
-	if (fh == INVALID_HANDLE_VALUE) {
-		errno = EBADF;
-		return -1;
-	}
-	/* direct non-file handles to MS's fstat() */
-	if (GetFileType(fh) != FILE_TYPE_DISK)
-		return _fstati64(fd, buf);
+	switch (type) {
+	case FILE_TYPE_DISK:
+		return get_file_info_by_handle(fh, buf);
 
-	if (!get_file_info_by_handle(fh, buf))
+	case FILE_TYPE_CHAR:
+	case FILE_TYPE_PIPE:
+		/* initialize stat fields */
+		memset(buf, 0, sizeof(*buf));
+		buf->st_nlink = 1;
+
+		if (type == FILE_TYPE_CHAR) {
+			buf->st_mode = _S_IFCHR;
+		} else {
+			buf->st_mode = _S_IFIFO;
+			if (PeekNamedPipe(fh, NULL, 0, NULL, &avail, NULL))
+				buf->st_size = avail;
+		}
 		return 0;
 
-	errno = EBADF;
-	return -1;
+	default:
+		errno = EBADF;
+		return -1;
+	}
 }
 
 static inline void time_t_to_filetime(time_t t, FILETIME *ft)
-- 
gitgitgadget

