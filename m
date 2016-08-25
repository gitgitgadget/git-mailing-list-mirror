Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCEA32042F
	for <e@80x24.org>; Thu, 25 Aug 2016 15:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756608AbcHYPni (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:43:38 -0400
Received: from mout.web.de ([217.72.192.78]:52502 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755930AbcHYPn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:43:27 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MdLsF-1btn051Smx-00IRuZ; Thu, 25 Aug 2016 17:42:58
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 2/2] gitattributes: Document the unified "auto" handling
Date:   Thu, 25 Aug 2016 17:52:58 +0200
Message-Id: <20160825155258.29007-1-tboegi@web.de>
X-Mailer: git-send-email 2.9.3.599.g2376d31.dirty
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Jwld8ksY5QM9G4AdSo5ZHhvinCRq22Rz/iIbLbXqxecMB0tdhAm
 gq0vTinbq3ut8/42JpB7b+pshORGpDXrqvN3jsksYxvfBnWqYl6kISUYTDlwFC+mkpUjriU
 lv+4CfWjxNG9eQyZt92SKlfVB4mmXTVz3EApELsHAJnn/azOhBWwOMhV2AYgzqegCCv0pAS
 IPrGmI58icaoiHjYMCiSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gw2fO9sIDCQ=:CvzSe0ZCXgCBA3IptLZ7R1
 HVEI6eAkt/Q980tLWCdOBptmtmglmtJkLHoVr6v+TzKrkXqtNX6Jw5qzshSm2ymfpA9BPoCYS
 spF2v0X9iFOzFTMVG2rfehVphbaG6/7lp5AaSqvdVetdrYl/HfP6upPzgHHFrsS4S5WVm2OiJ
 z6e0kMw0kz2TPA1bVowXQfwHXo0YNexWdaaiKMWn94p5/6Z6xmQ8uC0wmxJiEX2TkibvPwm4t
 NxkdRZOtZ6Y0q4t5a2gUjDpAofTcYfOP3Od20AI5bt9Yr32uWQTe0yGLesnl3ghIYJ66kMki6
 si3zDeniSgRbQfYuwfp4f6KJD0b1+FwEAWyPSiFkaEUSsTKmlldE2+o84Q02QbnjYj0U2tCsj
 9gC7P59YLkWkE5eDoeUe2yLgOPjjRWf8CdZADkmbDO8N2FGkt068wwxa2Uz/ROwy4w9q0QBaG
 YFsO4Y61W6JFunqJYwk3UiabkL5Sb5LqVcJpEychyfmub2yCge7rllbUAOCAzD/Bekj38Bbty
 z8jPT6FJbSpryyG+RIyFvFm0NLybg9PEwXMcqjKY7n2J3mG9HSnx4TuXIAcY5+GTzPMv3/+ul
 0d5ADtOhW6n+IZeyLuqpg/g517DQ4UjiDWIW+qZuDFTCbrQYdy0yb1d2TjdyBHDey17/Llotg
 d+Y24kPrKwrrUHqZVjGdqFfwYzFNWj6vUBU8do/O62aX7vSpOeITKm/yey9gIvW4CDx7WgBO2
 AyiHXvPgCSgRTZ1GQ3qEqabR+wU9xhvisF75pT9l/6hcsS9oB1zJgggXswpTl+/Fc6sA86BB0
 Irsmh0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Update the documentation about text=auto:
text=auto now follows the core.autocrlf handling when files are not
normalized in the repository.

For a cross platform project recommend the usage of attributes for
line-ending conversions.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/gitattributes.txt | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 807577a..4012661 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -213,27 +213,35 @@ that text files that you introduce to the repository have their line
 endings normalized to LF when they are added, and that files that are
 already normalized in the repository stay normalized.
 
+If you want to ensure that text files that any contributor introduces to
+the repository have their line endings normalized, you could set the
+`text` attribute to "auto" for _all_ files.
+
+------------------------
+*	text=auto
+------------------------
+
 If you want to interoperate with a source code management system that
 enforces end-of-line normalization, or you simply want all text files
 in your repository to be normalized, you should instead set the `text`
-attribute to "auto" for _all_ files.
+attribute to "text" for text files.
 
 ------------------------
-*	text=auto
+*.txt	text
 ------------------------
 
-This ensures that all files that Git considers to be text will have
+This ensures that all files marked as text will have
 normalized (LF) line endings in the repository.  The `core.eol`
 configuration variable controls which line endings Git will use for
 normalized files in your working directory; the default is to use the
 native line ending for your platform, or CRLF if `core.autocrlf` is
 set.
 
-NOTE: When `text=auto` normalization is enabled in an existing
-repository, any text files containing CRLFs should be normalized.  If
-they are not they will be normalized the next time someone tries to
-change them, causing unfortunate misattribution.  From a clean working
-directory:
+NOTE: When you have a cross-platform project using push and pull
+to a central repository the text files containing CRLFs should be
+normalized. All text files should have a text attribute, either
+`text` or `text=auto`.
+From a clean working directory:
 
 -------------------------------------------------
 $ echo "* text=auto" >>.gitattributes
-- 
2.9.3.599.g2376d31.dirty

