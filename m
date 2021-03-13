Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E54C433E6
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4079564F1E
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhCMQL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 11:11:26 -0500
Received: from mout.web.de ([212.227.15.3]:53819 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhCMQK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 11:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615651848;
        bh=5jocmjVqDQ3BcwFmHFZgunFOYCgI9eJUvgrDfLGvjng=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=om57vuv0fi91fiJe1m0OezsEsf9CIxTu6jrViFX56JIkRSYur+z3KMRYUgWI9aL0X
         BHy//7+Q58AWxHIHzAu6gGoHg538z4e8ErafVAqO+Hmk2xLXrT9t6fSgURW2RC1ZAz
         OAz+ZYS1LDyj/Pmfe3X2GxwYgCBN6wEXb60T/Qsw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Lsy7e-1ljd3a2xw2-012VyL; Sat, 13 Mar 2021 17:10:48 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Subject: [PATCH 1/2] git-compat-util.h: drop trailing semicolon from macro
 definition
Message-ID: <b417c7cc-8e40-04df-0314-d4c3fab278b7@web.de>
Date:   Sat, 13 Mar 2021 17:10:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:udNhVSfihq439hsmUPFfkgo1IrFMp7TC1YUtmAkPMzWBLenydTa
 QZKy8bQpTAS+hQXeQ3KXGigRwEDY7bhct1vfgKJvWIAe7fnnRzcdqjCFXWP0tgM4qYU/LzN
 QxUsfbYtqltym0LEbrzvXKz5zAwMvdlPUu8WEMkZyCUyMkwljg01e4l6ezmOuswa2jTgFYh
 Pex4McwYUSiJ5VwNjq+Ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QxTN35tfUrE=:B+5ifxEW9C/62/G12b1PZx
 P9nGIF2t7utrrp1xqWPItGGui9Qqf42pqv/DbTCm7HW/fYYwvRTYfebApryQshKtqZ2+0DeOE
 X72N6bu0FllOZRCpDznjlNBjnWNrtUBO+dtPapof+ZpWK5yhIiOcTQQI36FhRFjbcPfLcje1U
 6zpKuKFrP7IOuVnZu6lqPGNhQ9M/C6Jysgc5SAk0fPNsX5WXyZb+/0kS80/4Zh9bs5wYGX/8/
 DRs/84l2yXxv7xMOa0Rmn7lw+/Ra8G0ykBnxZJ/hz+WZnSn8Aosq89jJaPRT1HBs8k6viIqUv
 Drrgdtmcqz/Bg50x9hnrp87lUObx9huf2dTy+UlFzTRfiFP5i5mYwMMIeNEOs38Fi3caTMzLf
 kYr1/z5LswC+PkwoFI/ZNo3eqy//GJ0PhZMAOPq5wmVmbKLJXkNN2T9Qe3n6HKM4HeTpJ5ZFb
 BmrzuSWmqJiDNC8hI45XoMttoIdGRaB9NIFjZWXldAVzw52roEcZ2e+W+P4zadTsLyWTTfvrQ
 ouduYOTk1Nve5/EyN/KPAkY42CvlOsya50takJJbMoy5vck8kOEbBHCi5wyB+HKUrzrRMGpRK
 xVRdcivJLtp8QR8ZI9k48bsuRYAWJeW8N08maVM44AZsKhVP15ZrKnlDmzRG5ZoAIGRoE6C69
 7ls4SK8MkqSxaOu5VrqjH87WVbCMXN9hefGqai8mnDnCEiJEvy3OyTIGckzkLZhV+Cmg85hMj
 ip2InX+ny0OFAA5wM3TZ7B7TAHJcvPsLhPDxv1KJyVryZcWNjNmXqP7kIcsXPcNe/lfnLlveg
 RfPqk8IfWgdtzi/JpCEBT9/knteQ/g7m/jCkoX3JfFWLBU5DxgJFJtt6mdKFRD75wdgJhQxqb
 hR1RIB8ELv8k1uEe6h7g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make CALLOC_ARRAY usable like a function by requiring callers to supply
the trailing semicolon, which all of the current ones already do.  With
the extra semicolon e.g. the following code wouldn't compile because it
disconnects the "else" from the "if":

	if (condition)
		CALLOC_ARRAY(ptr, n);
	else
		whatever();

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 3b2738c73d..dcc786edaa 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -898,7 +898,7 @@ int xstrncmpz(const char *s, const char *t, size_t len=
);
 #define FREE_AND_NULL(p) do { free(p); (p) =3D NULL; } while (0)

 #define ALLOC_ARRAY(x, alloc) (x) =3D xmalloc(st_mult(sizeof(*(x)), (allo=
c)))
-#define CALLOC_ARRAY(x, alloc) (x) =3D xcalloc((alloc), sizeof(*(x)));
+#define CALLOC_ARRAY(x, alloc) (x) =3D xcalloc((alloc), sizeof(*(x)))
 #define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), st_mult(sizeof(*(x)=
), (alloc)))

 #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(ds=
t)) + \
=2D-
2.30.2
