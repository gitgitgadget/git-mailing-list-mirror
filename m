Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E4C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 07:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiBVHXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 02:23:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiBVHXA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 02:23:00 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B6E6A06B
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 23:22:35 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F16C10F324;
        Tue, 22 Feb 2022 02:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sZa7npymXa4OZwe9Xd4w9rummS/Lil6JyJPkgK
        3Cm14=; b=UROvxZfxgBqhb9WSTK21y4ImXvb8KCxeyTrQ3wFaVmPu5vpSJd/wp0
        +JQ/d77AkH5C+QgkSfpDr9nNa/sqrI+qSZeqA4+byNsnzjNkpfmC80FTRVvvdlJk
        T8WXDdYBG7Pb3/20l41m0jhCHc8YuZn+boQxtI++XSfHhHxnQn5Dc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64DB610F323;
        Tue, 22 Feb 2022 02:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C86D710F321;
        Tue, 22 Feb 2022 02:22:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 05/11] worktree: use 'worktree' over 'working tree'
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <2801ae232ae5cd0aa431e90eb37bbaf765d64fa5.1645489080.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 23:22:32 -0800
In-Reply-To: <2801ae232ae5cd0aa431e90eb37bbaf765d64fa5.1645489080.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 22 Feb 2022
        00:17:54 +0000")
Message-ID: <xmqqa6ejwekn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 340CCBC6-93B0-11EC-951D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +If the working tree for a a linked worktree is stored on a portable device

a a.

I've prepared the following to be squashed locally.  I also have
another small one for 06/11.

Since 05/11-11/11 all share exactly the same subject, I am not sure
how well "git rebase -i --autosquash" would work, though.  I suspect
it would so very poorly.

Subject: [PATCH] fixup! worktree: use 'worktree' over 'working tree'

---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 1243332d72..46afc7224f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -54,7 +54,7 @@ its associated administrative files, which reside in the repository
 `git worktree prune` in the main or any linked worktree to clean up any
 stale administrative files.
 
-If the working tree for a a linked worktree is stored on a portable device
+If the working tree for a linked worktree is stored on a portable device
 or network share which is not always mounted, you can prevent its
 administrative files from being pruned by issuing the `git worktree lock`
 command, optionally specifying `--reason` to explain why the worktree is
-- 
2.35.1-273-ge6ebfd0e8c

