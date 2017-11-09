Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9641F442
	for <e@80x24.org>; Thu,  9 Nov 2017 12:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbdKIMg0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 07:36:26 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:44622
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754268AbdKIMgZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2017 07:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1510230984;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=yv99pT/IoZW6RYwPlxZCx75lKB5XDc93iVdYzxBXA/g=;
        b=h/IGVTgv4iOip1TkLvC3zI5ZH7+RbqnI4VZeSbd4G0I+XQm+f9/POOG7ElHAh8gZ
        xdTSSuXIJ+Pw4tBwi6Dt1Kmii48N4O37KGdR6r31iNeAwnqjQ88LJMm2WgyUQF6oAoA
        wxFxd4nCZE7y91tHHhaEtLquK7YJgmpbTrBdlF2g=
From:   Kazuo Yagi <kazuo.yagi@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015fa0c804c4-7dc9e5b3-e34e-45e2-b92f-3f4183406020-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Documentation: fix typos for the reference in
 new-command.txt
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 9 Nov 2017 12:36:23 +0000
X-SES-Outgoing: 2017.11.09-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/howto/new-command.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/new-command.txt
index 15a4c8031f1f3..ac73c98be72de 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -1,13 +1,13 @@
 From: Eric S. Raymond <esr@thyrsus.com>
 Abstract: This is how-to documentation for people who want to add extension
- commands to Git.  It should be read alongside api-builtin.txt.
+ commands to Git.  It should be read alongside builtin.h.
 Content-type: text/asciidoc
 
 How to integrate new subcommands
 ================================
 
 This is how-to documentation for people who want to add extension
-commands to Git.  It should be read alongside api-builtin.txt.
+commands to Git.  It should be read alongside builtin.h.
 
 Runtime environment
 -------------------
@@ -48,7 +48,7 @@ binary); this organization makes it easy for people reading the code
 to find things.
 
 See the CodingGuidelines document for other guidance on what we consider
-good practice in C and shell, and api-builtin.txt for the support
+good practice in C and shell, and builtin.h for the support
 functions available to built-in commands written in C.
 
 What every extension command needs

--
https://github.com/git/git/pull/430
