Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1F220A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 23:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLHXPy (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 18:15:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63232 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeLHXPx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 18:15:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 899301121AB;
        Sat,  8 Dec 2018 18:15:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=2hmSjl1It9qYjK5pOpe4YiemAKk=; b=NtP3VhJWY6VGd/VsxxXk
        zQ5F12QoVQK0FTXxnVwHhRSSmenEujaFZhmfRTwQJslJFIyZGFBPyVf6sFb8q6Na
        2OwZbhsCSM2me9Ez/B4e/nDI/m0GZhb0QqNxYGy258tudCzs/owGjVUrRr8QSPPm
        Hm8BF9ilP2wdsffJf87pIqo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83CDE1121AA;
        Sat,  8 Dec 2018 18:15:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=mesmtp; bh=Ep1xZnNqLy2WOeoCB3xxa7gIlPpnxmoyocHr6keN2Nk=;
 b=suy5ZYaFHObEcdwCQh0s/8rQGkh3EneomIZsLfpYPzFmcG0MBL4aI9KPNt+gzEAfl5+i37GlNCuruceTGDIpRfZUGx5EKXG/wh6b+KuX8Cge3p7+9dcAkcXhOVTJ2YIsntXxqwImvsXtiosU7fKyOuztMQKA9FeRbQG+PTU6Ki4=
Received: from hylob.local (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 098391121A7;
        Sat,  8 Dec 2018 18:15:51 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] rebase docs: drop stray word in merge command description
Date:   Sat,  8 Dec 2018 18:15:41 -0500
Message-Id: <20181208231541.1341999-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-Pobox-Relay-ID: 3426D7EE-FB3F-11E8-BC30-BFB3E64BB12D-24757444!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Delete a misplaced word introduced by caafecfcf1 (rebase
--rebase-merges: adjust man page for octopus support, 2018-03-09).

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index dff17b3178..2ee535fb23 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -979,7 +979,7 @@ when the merge operation did not even start), it is r=
escheduled immediately.
=20
 At this time, the `merge` command will *always* use the `recursive`
 merge strategy for regular merges, and `octopus` for octopus merges,
-strategy, with no way to choose a different one. To work around
+with no way to choose a different one. To work around
 this, an `exec` command can be used to call `git merge` explicitly,
 using the fact that the labels are worktree-local refs (the ref
 `refs/rewritten/onto` would correspond to the label `onto`, for example)=
.
--=20
2.19.2

