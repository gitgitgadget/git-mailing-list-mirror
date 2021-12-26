Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3C5C433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 04:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhLZEJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 23:09:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57574 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhLZEJo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 23:09:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19829E9E33;
        Sat, 25 Dec 2021 23:09:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=GgEufgcu/BFC1ZaiXIBUSYuRPxoyB19xZvr2X/SMSEM=; b=lYH9
        jjZ2rCSyzPoXUVsF6sJ6LUW6dn5pyjpYt1e466Z8kCwlGdFIWRnjDypXGhnqVrDH
        WhMKzDmvIngzJHqs7R0LXz2IvfzKVcdVXyBeZYA0V5FXwLYbbZ7ZfOeGdbaEVYEh
        MAMr6Z9HY7eMKDtgObGldOkFwtmK3R9HSOTqgWs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10ADAE9E32;
        Sat, 25 Dec 2021 23:09:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72606E9E31;
        Sat, 25 Dec 2021 23:09:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v6 5/5] branch: add --recurse-submodules option for
 branch creation
References: <20211216233324.65126-1-chooglen@google.com>
        <20211220233459.45739-1-chooglen@google.com>
        <20211220233459.45739-6-chooglen@google.com>
Date:   Sat, 25 Dec 2021 20:09:41 -0800
Message-ID: <xmqqpmpk2eii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A706D0C2-6601-11EC-B2B3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be squashed if we were to take the series queued on 'seen'
otherwise as-is (or if the series will be rerolled, please squash it
into the new round on your end).

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
Subject: [PATCH] fixup! branch: add --recurse-submodules option for branch
 creation

Style fix to have SP on both sides of () in

    shell_function () {

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3207-branch-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
index a2dfb5ad7f..4256a95f4e 100755
--- a/t/t3207-branch-submodule.sh
+++ b/t/t3207-branch-submodule.sh
@@ -44,7 +44,7 @@ cat >"$CLEANUP_SCRIPT_PATH" <<'EOF'
 EOF
 chmod +x "$CLEANUP_SCRIPT_PATH"
 
-cleanup_branches() {
+cleanup_branches () {
 	TRASH_DIRECTORY="\"$TRASH_DIRECTORY\"" "$CLEANUP_SCRIPT_PATH" "$@"
 } >/dev/null 2>/dev/null
 
-- 
2.34.1-568-g69e9fd72b5

