Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B707207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 20:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939671AbdD0U0D (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 16:26:03 -0400
Received: from mout.web.de ([212.227.17.12]:61415 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939060AbdD0U0C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 16:26:02 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNnw-1dqOA13g4e-00maHq; Thu, 27
 Apr 2017 22:25:50 +0200
Subject: Re: What's cooking in git.git (Apr 2017, #06; Wed, 26)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqfugupnk3.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a7545d98-7203-7bd6-faa2-9bb1e718539a@web.de>
Date:   Thu, 27 Apr 2017 22:25:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <xmqqfugupnk3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:QzDzNw+hC8D4ESYrdH5Kqnm42Lgoc2UKfDnEO3okwnQXTdJMlfi
 RBv6wEM0avIy0dW/aBSXxeYH3u4n8JVykzboin6AZTJJCNkQ66cKDtxfRW3DlI2Pz6TjPMl
 S+UOxX6kXwIaaUU25mWRyrM1VMgcWrraG/C+Hq6Z+UoO0T53BFuakpH8sTu6AB5IKIkbF06
 9+QFcqHPdXYOmWYZ0otSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oCzF+9PT/Dk=:QZPOj+8BH2HuCKYzX7zdfE
 dju+FRzAWs5rGBeEaK/j2eqalUn4iLLFbg7ojShD6OIradgdd2frXnn8Tkbe0Kq9UBB9VfCiN
 xBJjctoFCFx6bbuOS4kbdgi0oSwVHf1m7gR9rndsiI8nRPY7a3k7UGuJdEu5iskC/y6jZP7Pn
 IoamaaNvcVJUbQD9mzqEtzVYBk4lvateRDljdOdQQNySVRSc87uag0zlpvx09OorjH/MV53wI
 /VLp9CbEcAsznc9F/6pk2TyeEVax1lcS2fgUrvoh6kaLJMv6PyHEWdNK7cai3ioOBvML0jCGL
 BJnWNKbQSWAtj+01wc9txYiJdMiShAkwdUxQONtmiG0yKZeZU1fHAJNer7jBb/fkBGnnm/8tK
 PO4CuNMjH8uLnhHHvCKy7h9mzZsH3gCoiv/5YnLx+AZA0gdrqIVhuRTFbmnyukXx4h49KTwjo
 WEof4nBooj7uo3SQGL/BNyAyYadQYhqQ/ff7s1y1W86eMXQ6saXUNBC1TuLbAZishQUjLKL/0
 1/xcrtHPvyVbwqNSUfnwiFS20YQDHEjXdNiiXpQvp4rzYkTRdLh9r9DeT2DUpGfeZIaJZbZ3I
 KF3F6npWZvcruiYNTHIGlNJYAgaYkvmX8CoCMtjhuxHWItOH5gWRicxbZAWjVoLNX5KhClOGb
 TtXGDwln5MYqV2n2MHSVQxryGDMESzdb1dgHQ6Hvk3utnKTqkD7OOwUMYhcGmTqYYUdhe+nx8
 u8D/D1uGKJ7muRRlVvHkXSl2AnSjPARIec3qAaJiV+KsAp7cHRgoP5g/Z0y/tLlLuDNNMbNu7
 DkoxyHU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.2017 um 04:54 schrieb Junio C Hamano:
> * rs/large-zip (2017-04-24) 5 commits
>    (merged to 'next' on 2017-04-26 at a6beab60f2)
>   + archive-zip: support files bigger than 4GB
>   + archive-zip: support archives bigger than 4GB
>   + archive-zip: write ZIP dir entry directly to strbuf
>   + archive-zip: use strbuf for ZIP directory
>   + archive-zip: add tests for big ZIP archives
> 
>   "git archive --format=zip" learned to use zip64 extension when
>   necessary to go beyond the 4GB limit.
> 
>   Will merge to 'master'.

Woah, that was quick.  We need this fix on top:

-- >8 --
Subject: [PATCH] archive-zip: set version field for big files correctly

Signal that extractors need to implement spec version 4.5 (or higher)
for files with sizes of 4GB and more.  Older unzippers might produce
truncated results otherwise; they should rather refuse to extract.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive-zip.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 44ed78f163..e81c5ac15a 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -298,6 +298,7 @@ static int write_zip_entry(struct archiver_args *args,
 	int is_binary = -1;
 	const char *path_without_prefix = path + args->baselen;
 	unsigned int creator_version = 0;
+	unsigned int version_needed = 10;
 	size_t zip_dir_extra_size = ZIP_EXTRA_MTIME_SIZE;
 	size_t zip64_dir_extra_payload_size = 0;
 
@@ -382,8 +383,11 @@ static int write_zip_entry(struct archiver_args *args,
 	if (stream && size > 0x7fffffff)
 		need_zip64_extra = 1;
 
+	if (need_zip64_extra)
+		version_needed = 45;
+
 	copy_le32(header.magic, 0x04034b50);
-	copy_le16(header.version, 10);
+	copy_le16(header.version, version_needed);
 	copy_le16(header.flags, flags);
 	copy_le16(header.compression_method, method);
 	copy_le16(header.mtime, zip_time);
@@ -509,7 +513,7 @@ static int write_zip_entry(struct archiver_args *args,
 
 	strbuf_add_le(&zip_dir, 4, 0x02014b50);	/* magic */
 	strbuf_add_le(&zip_dir, 2, creator_version);
-	strbuf_add_le(&zip_dir, 2, 10);		/* version */
+	strbuf_add_le(&zip_dir, 2, version_needed);
 	strbuf_add_le(&zip_dir, 2, flags);
 	strbuf_add_le(&zip_dir, 2, method);
 	strbuf_add_le(&zip_dir, 2, zip_time);
-- 
2.12.2

