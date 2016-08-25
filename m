Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A922018E
	for <e@80x24.org>; Thu, 25 Aug 2016 15:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755716AbcHYPna (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:43:30 -0400
Received: from mout.web.de ([217.72.192.78]:57784 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755752AbcHYPn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:43:27 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MORiL-1bXA3B1gQf-005pbN; Thu, 25 Aug 2016 17:42:56
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/2] git ls-files: text=auto eol=lf is supported in Git 2.10
Date:   Thu, 25 Aug 2016 17:52:57 +0200
Message-Id: <20160825155257.28968-1-tboegi@web.de>
X-Mailer: git-send-email 2.9.3.599.g2376d31.dirty
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kVLrLYZ4vbau1aeCVMW3zEpwUS+lJOGXHAaEajWPIC+hCVDA6Jc
 fyLdnT7t7zeYS8AR350U1SbEug4oLPOVwWV4YKI+in/JA/198izeH3C4fQKgWbKw24Rkap5
 T/7LWrOHt1emGtPEMRSRB94k2x8s9s9D2ZZ7YScOKv+QjPOrnMKq6dYlPEI4RCTsoIJrLE3
 Ms1OWdSXcxDWNSE1ckb0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tRk+Knalw9w=:Db2zHyNVe3sxyOBIqhi8jq
 73fv5J0hwlnb5l1CsypWxjbHmmhrR5Ff4BfIOywZxlT1PTOxQzs5fogh5LteQwlBK3GVYMs0J
 7Mw6JMcxCHdUcK8DQD/6qz8r1pygJqX3S3PTH2Ihu8yLy5GJs3pI6SWIKWNB6G5x0RjsOCyot
 Mulr60sIlBRa3WaGBnifX6u388QPZaiR/I4GsTQKP9W6DXc/zFQP2/6qHgP90uvWmPsf31S6w
 SIpkkoUKCr3ywfYHeG68k77lqnXgJcFHy9KBWzSgub4p2PymbVfrwSbcKtXPLCwmTgeIfCd3j
 uznL9fKWFKdAUv9v0lW9Eps8ZAoa9MnWE2Vj2XBGpn7wJ3dKi+gmDdIbxHfYRNpz6pvheCRCz
 bGCrWLA+43snVKZM1bQWUgfGH3DQaJBEcCqtxNlm/FCVur/d4U6rcsrVfBcqetzjCU/HSj9N/
 r2k1UkiAnMPNVz74Y6JdwH4uwt62NsyQd0dAZ3kFPaJHyjup+jibb3wd3uEay76W1rijfS/z6
 ZAxjn3CcbH5QNKm1UlxX6f8KogLe3Da3z8CUNorUEH2/UPA62MaR5b7Rgt1rANjrwMYi15T6j
 /0UGo1WhbEQljW8BrSbn9T2T5jalZCsbWTMeOOwinBhNOwEV5KUqbNT+cUtQS5Zl/sm0JQwPk
 Bulm2iZnFSOczYM4ctsyBPEqHsoNcaCpkAonKgAMMaRIPV2A8MbQ50zWD2UbENRotxIUlGVbM
 vX0J9/j+JhF/1Q3n/2t55HhqTmF2M5/YBq4S05+Rec4HJKGPXKwpjtiLwdxYujIfCPTWWpuSo
 1Z1Dlre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

The man page for `git ls-files --eol` mentions the combination
of text attributes "text=auto eol=lf" or "text=auto eol=crlf" as not
supported yet, but may be in the future.
Now they are supported

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/git-ls-files.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 078b556..0d933ac 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -159,8 +159,7 @@ not accessible in the working tree.
 +
 <eolattr> is the attribute that is used when checking out or committing,
 it is either "", "-text", "text", "text=auto", "text eol=lf", "text eol=crlf".
-Note: Currently Git does not support "text=auto eol=lf" or "text=auto eol=crlf",
-that may change in the future.
+Since Git 2.10 "text=auto eol=lf" and "text=auto eol=crlf" are supported.
 +
 Both the <eolinfo> in the index ("i/<eolinfo>")
 and in the working tree ("w/<eolinfo>") are shown for regular files,
-- 
2.9.3.599.g2376d31.dirty

