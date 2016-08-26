Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69E61FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 20:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbcHZU0g (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 16:26:36 -0400
Received: from mout.web.de ([212.227.17.11]:58417 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbcHZUZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 16:25:56 -0400
Received: from atze2.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MeBPe-1bU7eA00MA-00Pytw; Fri, 26 Aug 2016 22:19:20
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 2/2] gitattributes: Document the unified "auto" handling
Date:   Fri, 26 Aug 2016 22:18:48 +0200
Message-Id: <20160826201848.28381-1-tboegi@web.de>
X-Mailer: git-send-email 2.9.0.243.g5c589a7
In-Reply-To: <xmqqpoowlgpv.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoowlgpv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:SpVQJec8Jir3IDaVJ0+F5ogInXh2liu9/bl/4p+0miQR5HtM7Kp
 OB4cFKNuCGOnpKng+AxTL0IsSVEiDCxxKUZMawkhq5KENDaoYhPG5roE5AgqNy6iNfsEXKm
 gsL9NZqygii3VlzPz4Sdfxmncw64wwPdi0DnBo6ggzTnxfpFHy4qIJBp2TjQBLICRAySvhZ
 5a5fWxx4KOxDkMgFWvPSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JRr0bh6RsAQ=:mgakECaJKCjcCyNsIM/JcM
 zrdjYa1hkMmsOYdgxO2B0vzlGU0m/bJPM8+j6BqBGd7FSeSfI8+9JgRhXHGACaW9zHOnRl4SH
 cK4RMbFV0RSwwfUb5HPTlx9tEhiCEyP5yF+nKPG6Tk+0xtAyUhYFo4mZk9AHMMyV4bPRl6bbE
 aEYcmX0pwz7v27YqBD1QyddFfwn5WSLDDIFwIwE+ECn2T9Hiz5DHXPi2WC5m/wEMcQqjrlYml
 UAAn+rVY0MFP0X2kAVTemaPaE2t3BvcUYlix7/1VRRN3u02w6dsNJlq14z7AoXQdHVymx6Xg5
 D1ZX6A/opD54lJvDJ43Sg2xdlZ31eNHEwhjmW6FqkWM5nSUrW/ggmkZADEPiB1Gf/Zz79rW/g
 vqgkhrb80P1ib3yJKmYgHEkvF3eKaaH9aGcDE8IR5taf1ZDWL6dueLuG4d/z/dQ4GqwXeET/w
 OAQqKT++nMppx7baDjvxF0pfNgRCzg65J7q9bzAy1ojxCQxKuenMgxKlUlG0j8oOXRwn3wIor
 iQyv1hcpRrUi3em0QpZGbuujUL5T2EABm5AzDQDaFaLvMiMH2A8FdrgwczSAuQ2AfR9LJ4hz4
 2bEDZbVFxkA0xRJAvqOJhAbpCnuWo0F2IePlvyi0e0mcp19c9tI5bLfza0H91tR/nRoKob91N
 yimaW+lLiMp2BEbtZhG8/Nlx4lrwZe6iqe6hgmsGZASXnP8RL/OpiNITyzx4TVJvVis8dBtjg
 bGOvuhHXWRTlUIFET4icvet3TZgPkCIgGTLa89p/qQCvFrTt59R+soyQx9NuMuGu4m5Awnj0H
 BoWi9o6
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
 Documentation/gitattributes.txt | 58 +++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 807577a..7aff940 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -182,23 +182,6 @@ While Git normally leaves file contents alone, it can be configured to
 normalize line endings to LF in the repository and, optionally, to
 convert them to CRLF when files are checked out.
 
-Here is an example that will make Git normalize .txt, .vcproj and .sh
-files, ensure that .vcproj files have CRLF and .sh files have LF in
-the working directory, and prevent .jpg files from being normalized
-regardless of their content.
-
-------------------------
-*               text=auto
-*.txt		text
-*.vcproj	text eol=crlf
-*.sh		text eol=lf
-*.jpg		-text
-------------------------
-
-Other source code management systems normalize all text files in their
-repositories, and there are two ways to enable similar automatic
-normalization in Git.
-
 If you simply want to have CRLF line endings in your working directory
 regardless of the repository you are working with, you can set the
 config variable "core.autocrlf" without using any attributes.
@@ -208,35 +191,42 @@ config variable "core.autocrlf" without using any attributes.
 	autocrlf = true
 ------------------------
 
-This does not force normalization of all text files, but does ensure
+This does not force normalization of text files, but does ensure
 that text files that you introduce to the repository have their line
 endings normalized to LF when they are added, and that files that are
 already normalized in the repository stay normalized.
 
-If you want to interoperate with a source code management system that
-enforces end-of-line normalization, or you simply want all text files
-in your repository to be normalized, you should instead set the `text`
-attribute to "auto" for _all_ files.
+If you want to ensure that text files that any contributor introduces to
+the repository have their line endings normalized, you can set the
+`text` attribute to "auto" for _all_ files.
 
 ------------------------
 *	text=auto
 ------------------------
 
-This ensures that all files that Git considers to be text will have
-normalized (LF) line endings in the repository.  The `core.eol`
-configuration variable controls which line endings Git will use for
-normalized files in your working directory; the default is to use the
-native line ending for your platform, or CRLF if `core.autocrlf` is
-set.
+The attributes allow a fine-grained control, how the line endings
+are converted.
+Here is an example that will make Git normalize .txt, .vcproj and .sh
+files, ensure that .vcproj files have CRLF and .sh files have LF in
+the working directory, and prevent .jpg files from being normalized
+regardless of their content.
+
+------------------------
+*               text=auto
+*.txt		text
+*.vcproj	text eol=crlf
+*.sh		text eol=lf
+*.jpg		-text
+------------------------
+
+NOTE: When `text=auto` conversion is enabled in a cross-platform
+project using push and pull to a central repository the text files
+containing CRLFs should be normalized.
 
-NOTE: When `text=auto` normalization is enabled in an existing
-repository, any text files containing CRLFs should be normalized.  If
-they are not they will be normalized the next time someone tries to
-change them, causing unfortunate misattribution.  From a clean working
-directory:
+From a clean working directory:
 
 -------------------------------------------------
-$ echo "* text=auto" >>.gitattributes
+$ echo "* text=auto" >.gitattributes
 $ rm .git/index     # Remove the index to force Git to
 $ git reset         # re-scan the working directory
 $ git status        # Show files that will be normalized
-- 
2.9.0.243.g5c589a7

