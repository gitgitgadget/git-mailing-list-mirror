Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB2CC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 07:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiBVHXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 02:23:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiBVHXN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 02:23:13 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004F37C144
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 23:22:47 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF9B617BC88;
        Tue, 22 Feb 2022 02:22:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Uli8EMBGQZLM8IbECIzQt3xaa2z2HyvssRMb8miqemc=; b=dQ7Q
        +I3l2USHbJDwbVtKtJYyzeqS3GQFc3dGUScy9k3WO+s5tYoL31HyYAgcE6StnGRS
        trcznSD/ZJf2AwwajNVWG8xPN9w4e3zhc/ZYLlmBUzLxI1MHOi8pA10CRzN+KqRQ
        GvRgR83OUi8twHojyW02TTO45Dv+vgt/2Fl6JQk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7D8617BC87;
        Tue, 22 Feb 2022 02:22:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D78317BC86;
        Tue, 22 Feb 2022 02:22:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 06/11] worktree: use 'worktree' over 'working tree'
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <a375e4b6ff0e5f77fcfaac44945e5722b0f9ab9c.1645489080.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 23:22:44 -0800
Message-ID: <xmqq35kbwekb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AC842CE-93B0-11EC-95D1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +Similarly, if the working directory for a linked worktree is moved without

"the working tree for a linked worktree" is the phrase used in
05/11, which this part should also adopt, I think.

From 8da2786fa1ff0d094a5c8e7151bfadbd9ca3dd4e Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 21 Feb 2022 23:18:45 -0800
Subject: [PATCH] fixup! worktree: use 'worktree' over 'working tree'

---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 46afc7224f..2447cd8034 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -139,7 +139,7 @@ worktrees will be unable to locate it. Running `repair` in the main
 worktree will reestablish the connection from linked worktrees back to the
 main worktree.
 +
-Similarly, if the working directory for a linked worktree is moved without
+Similarly, if the working tree for a linked worktree is moved without
 using `git worktree move`, the main worktree (or bare repository) will be
 unable to locate it. Running `repair` within the recently-moved worktree
 will reestablish the connection. If multiple linked worktrees are moved,
-- 
2.35.1-273-ge6ebfd0e8c

