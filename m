Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCFD41F454
	for <e@80x24.org>; Wed, 31 Oct 2018 21:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbeKAGLZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 02:11:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46105 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKAGLY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 02:11:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id c13-v6so16511plz.13
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eXKxDCIT68c72MSAMTsrlLIQ4eg1g/AkVPETTLBCdmc=;
        b=VYgMTv5ixFOPrYlqunsMVKEUqZzZKcJoVy5omyB8Q3klrZYuHhSSesGbdVC7AFCqv2
         GuwoLAvZYVdfAdFIj9ZBy/xw6eF7Pn1huooAenxotq7JCjGYzjiFrfCtw56G6HQybXlw
         HXR6UNRhZ4ZsvaOIsTnaaXItoIrg79gqTfYxSB8RvT/J9LKB4vw4b5QZ4rjJ5BlIpRaH
         DZUCqJo2zDBbaOx6GbTRa+OVfDly7yQEJd5oucdABW3eMx6nPp37k1kpGdieMkHWMhAP
         qF2BUZ4Vcu0ZREm2dMbXg6r3C2eLM+CL1zeh5Wj2ikNFS9Km34/gkFan/8A47ilZhsrU
         5Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eXKxDCIT68c72MSAMTsrlLIQ4eg1g/AkVPETTLBCdmc=;
        b=n75Brt/M+heuIyHmcBF7mKmCpNiPsYdNPoebvvRMfKg6vJDpnmy1bFtL0V/Hl2cGB+
         8I09qxaebwHjf43jOgMGV+ZuQYdsQTrvxP6+PJ0rWVINT3O/yWfGFD91gHtMnUQ0EbnK
         OWeMgTwKXWnUTLRN93rtQPo2VQCIVrZ4oXF/vCEP1ch0KmWAOvggarGUkaxHO8ZUc62F
         +f26jOLtNvPFd8rkx+Z8T8pv1bSwQ/rILHlokRDThhxtsusIEnT3hUxQvABNo4K4182E
         MnJfSIR8hGBvEUCetxQceU3ddz78n3SGexJy/+fbLddHGBJYHzQIlaxh0nrPe1GUn/nO
         C/uw==
X-Gm-Message-State: AGRZ1gJ6rf1E61HpjlapHhLWTuqS5PDLVUTVVt/BHUC4tS4HB+E7b1KY
        AmkJhSxcpr0Ioy8/TgwZwsWirmwG
X-Google-Smtp-Source: AJdET5ey7HLaYZc9aAqIJVuY3HYF4NbYV1eTdogEGcinWvcX5FNk7GvcDU26bwAD9cQ1zmoNN9tb/Q==
X-Received: by 2002:a17:902:654a:: with SMTP id d10-v6mr4752266pln.302.1541020297560;
        Wed, 31 Oct 2018 14:11:37 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id c124-v6sm39867106pfa.119.2018.10.31.14.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 14:11:36 -0700 (PDT)
Date:   Wed, 31 Oct 2018 14:11:36 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 21:11:33 GMT
Message-Id: <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.64.git.gitgitgadget@gmail.com>
References: <pull.64.git.gitgitgadget@gmail.com>
From:   "Steve Hoelzer via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Steve Hoelzer <shoelzer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Steve Hoelzer <shoelzer@gmail.com>

From Visual Studio 2015 Code Analysis: Warning C28159 Consider using
'GetTickCount64' instead of 'GetTickCount'.

Reason: GetTickCount() overflows roughly every 49 days. Code that does
not take that into account can loop indefinitely. GetTickCount64()
operates on 64 bit values and does not have that problem.

Note: this patch has been carried in Git for Windows for almost two
years, but with a fallback for Windows XP, as the GetTickCount64()
function is only available on Windows Vista and later. However, in the
meantime we require Vista or later, hence we can drop that fallback.

Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/poll/poll.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index ad5dcde439..4abbfcb6a4 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -18,6 +18,9 @@
    You should have received a copy of the GNU General Public License along
    with this program; if not, see <http://www.gnu.org/licenses/>.  */
 
+/* To bump the minimum Windows version to Windows Vista */
+#include "git-compat-util.h"
+
 /* Tell gcc not to warn about the (nfd < 0) tests, below.  */
 #if (__GNUC__ == 4 && 3 <= __GNUC_MINOR__) || 4 < __GNUC__
 # pragma GCC diagnostic ignored "-Wtype-limits"
@@ -449,7 +452,8 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
   static HANDLE hEvent;
   WSANETWORKEVENTS ev;
   HANDLE h, handle_array[FD_SETSIZE + 2];
-  DWORD ret, wait_timeout, nhandles, start = 0, elapsed, orig_timeout = 0;
+  DWORD ret, wait_timeout, nhandles, elapsed, orig_timeout = 0;
+  ULONGLONG start = 0;
   fd_set rfds, wfds, xfds;
   BOOL poll_again;
   MSG msg;
@@ -465,7 +469,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
   if (timeout != INFTIM)
     {
       orig_timeout = timeout;
-      start = GetTickCount();
+      start = GetTickCount64();
     }
 
   if (!hEvent)
@@ -614,7 +618,7 @@ restart:
 
   if (!rc && orig_timeout && timeout != INFTIM)
     {
-      elapsed = GetTickCount() - start;
+      elapsed = (DWORD)(GetTickCount64() - start);
       timeout = elapsed >= orig_timeout ? 0 : orig_timeout - elapsed;
     }
 
-- 
gitgitgadget
