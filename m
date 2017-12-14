Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFAE91F404
	for <e@80x24.org>; Thu, 14 Dec 2017 23:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754435AbdLNXel (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 18:34:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:59289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754420AbdLNXek (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 18:34:40 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKpQ4-1ePd1Q09WS-0000UX; Fri, 15
 Dec 2017 00:34:36 +0100
Date:   Fri, 15 Dec 2017 00:34:34 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 1/2] version --build-options: also report host CPU
In-Reply-To: <cover.1513294410.git.johannes.schindelin@gmx.de>
Message-ID: <a827bc297da7c7dcfa51c07b5fa29dd474fa287e.1513294410.git.johannes.schindelin@gmx.de>
References: <cover.1512752468.git.johannes.schindelin@gmx.de> <cover.1513294410.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ol1z+bl9x4YiETU/XMmH0eH+c5vM89l7DUTvec6aQCJ8RbE8Ib0
 e/9yK5hc0gGCccUSHvGmoxuWbDZKf4i3PniCWtOIQZBxeMmCw7bckSo69Rc4nA7pjjErReS
 JwevLN/xCFwVwMOcfSkZY2PDZZICejC/ITa9wEyStl9FTw8ufAHcl24XZQuoyVj4Ssz23tS
 fqQ68WMzqhkT1Dky/gGYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:13Sbs8Y+Lc4=:SlpFiD+ynORjmC8WvExPWf
 81ldbslF/usta2PNdB9Ow8DVdrFey745PS0CAU0b8S4X7kRcevaFUMhroVLGvFfiM4IulS8AS
 f/PSP0wlF62osiBnc0oByhqU7vbxrcuZsVSkMwR96epXS2nbJlV1zNG1WuBblGLzLO61Z8BN2
 V/YZn5PNC/0k0FvHptNB5M3OjAWEZVi++ySv/mRXPcte+klBbV4guJSfhum1C/F71iut7jfZu
 seu8m52e97znj0JBgKpHtl4W4jYXkoSmJq9Zh9/YSqvOcv/IpD4h6TTbPLOwyWd59dcWiCjH3
 Z22T9m0F95Dal+gtsSAZAPr9l+/d5E4Xjvkjzm8cTWgvRh4l+CWoLwArl2GqFjPvkW7oUyNXJ
 OmGJ8G5b2CRoPYBdSJggjeoSrYcgKR2ZtVwyzbCTi4xa5bjSFCYJYsTbjBFBnRh8X7R1fOiv0
 4M4zFI97T5RDObTkPWRGLRDFBcDrYfsFevL1WYP27WtZScY6VQCkGx7Pt+JcRVxSmL3bUfI+5
 m6iepzCz3wZeXY194flV/fdGFHZHE+sS+7mww68gf2nlGsbvgCMl2vs/gufdDV2oahwQszP7K
 D1qa+VHM8oyWjujznzU9EfaF1CasHv9ooV2QOqViubAxaf6mq+Yf9ok3oetL+ubAzsad+SbKG
 H60UN/kvhJJuThKLvDSkJfnk2vPcCM85MeB0XGleY6XVJJY/DAxZQoHR7Vi3LZFLN7w/UJOxO
 l2zL2cFKXL+3l0B4LFEeOVWnPK+HdDpSkAyYcpyVuiwNAvXdrtYkJ4lfsqeE8t0/h3PpJ4Pn/
 8yFdftSvWLkrj7yOovDffG0/5XMqZOYK6tDYUuZ+XT+LqgmBfA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

It can be helpful for bug reports to include information about the
environment in which the bug occurs. "git version --build-options" can
help to supplement this information. In addition to the size of 'long'
already reported by --build-options, also report the host's CPU type.
Example output:

   $ git version --build-options
   git version 2.9.3.windows.2.826.g06c0f2f
   cpu: x86_64
   sizeof-long: 4

New Makefile variable HOST_CPU supports cross-compiling.

Suggested-by: Adric Norris <landstander668@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 9 +++++++++
 help.c   | 1 +
 2 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index fef9c8d2725..5587bccc932 100644
--- a/Makefile
+++ b/Makefile
@@ -425,6 +425,9 @@ all::
 #
 # to say "export LESS=FRX (and LV=-c) if the environment variable
 # LESS (and LV) is not set, respectively".
+#
+# When cross-compiling, define HOST_CPU as the canonical name of the CPU on
+# which the built Git will run (for instance "x86_64").
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1095,6 +1098,12 @@ else
 BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
 endif
 
+ifeq (,$(HOST_CPU))
+	BASIC_CFLAGS += -DGIT_HOST_CPU="\"$(firstword $(subst -, ,$(uname_M)))\""
+else
+	BASIC_CFLAGS += -DGIT_HOST_CPU="\"$(HOST_CPU)\""
+endif
+
 ifneq (,$(INLINE))
 	BASIC_CFLAGS += -Dinline=$(INLINE)
 endif
diff --git a/help.c b/help.c
index 88a3aeaeb9f..cbcb159f367 100644
--- a/help.c
+++ b/help.c
@@ -412,6 +412,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	printf("git version %s\n", git_version_string);
 
 	if (build_options) {
+		printf("cpu: %s\n", GIT_HOST_CPU);
 		printf("sizeof-long: %d\n", (int)sizeof(long));
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
-- 
2.15.1.windows.2


