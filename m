Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB3F1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 02:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933203AbeBMCYC (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 21:24:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33166 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933132AbeBMCYB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 21:24:01 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 302F260987;
        Tue, 13 Feb 2018 02:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1518488640;
        bh=oRy9sMKJzq1sMyaxBa9fiOd8i3gNLmt/Cu1QcHa/5Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=1NIm8+N2GefteGrqf5iSUIx3lEwrlYpsMvgTD7E3Wpqz6nUvsq8OzUA66Sfvorofd
         ePxUbuRbS/Zv894mI9fx9yZPH8v0/J53gWcpdiFkMgELfkY4BWu2OhZ/THCopU5jWY
         QgGeI6Nx9AAA1vJ7JgJMewnwlu1Pr4UR8AbZ6wRGdhCPiy/DDhrXFGUccBOMsmOAud
         1nUnTytObhYC5M+q+jnTuAMpv9bdHzNsUPQicL/hidyrGeOFSO9rzSBhxOjT+Rd0t4
         nVtyvjWP3wvwGe4iE1wl3sob4Y3klPzLuTo89mfRZZlDTM7FgXFn23cRTB5JWeFzti
         EEMw0q3KvT820HR6HhjpidlJhGXZi9vcXB7GOgoXCFXtG3+2dlf4j3NBgu0o/29A9q
         gvco75ECa0gU7KXYkzrtViTLycA+48Rae3t5PuwFreGuWyGOx2OAcfo2qmR+NrPQWe
         75HdgHi07d6MxS8EEFFnfaMn4dm+SllukJonIHnyump0Io7QK+9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] docs/interpret-trailers: fix agreement error
Date:   Tue, 13 Feb 2018 02:23:52 +0000
Message-Id: <20180213022352.23742-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.101.gde0f0111ea
In-Reply-To: <20180208025614.872885-1-sandals@crustytoothpaste.net>
References: <20180208025614.872885-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the description of git interpret-trailers, we describe "a group…of
lines" that have certain characteristics.  Ensure both options
describing this group use a singular verb for parallelism.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 9dd19a1dd9..ff446f15f7 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -51,7 +51,7 @@ with only spaces at the end of the commit message part, one blank line
 will be added before the new trailer.
 
 Existing trailers are extracted from the input message by looking for
-a group of one or more lines that (i) are all trailers, or (ii) contains at
+a group of one or more lines that (i) is all trailers, or (ii) contains at
 least one Git-generated or user-configured trailer and consists of at
 least 25% trailers.
 The group must be preceded by one or more empty (or whitespace-only) lines.
