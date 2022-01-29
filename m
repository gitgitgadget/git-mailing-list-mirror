Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F7CC433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 02:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352214AbiA2Ctt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 21:49:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57506 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiA2Cto (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 21:49:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EC6D109CDC;
        Fri, 28 Jan 2022 21:49:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=5
        WxVfiJo3HKF5NUrbCX6RUIBiJgqo+PJ9xcYKLVmzI4=; b=oGlYYlPTIAxXMCyb+
        GE7UrM2wrxAzphtEcig5Xui6fgfEnGAlkCyv+Gf8DNrYWoBnXxHH9mM0dInuoVCV
        zSUtEgXmnHT4poGcJjMlIBMuyZPwA6hMoSAvjTfuaUKmot8/yCts2myMmb9rHFnU
        xI62MoC9x3/dEHxt+1tQop/NBI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26F5F109CDB;
        Fri, 28 Jan 2022 21:49:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8ABA4109CDA;
        Fri, 28 Jan 2022 21:49:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.35.1
Date:   Fri, 28 Jan 2022 18:49:42 -0800
Message-ID: <xmqq1r0rtfw9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CB3ED84-80AE-11EC-93C7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.35.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.35.1'
tag and the 'maint' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.35.1 Release Notes
=========================

Git 2.35 shipped with a regression that broke use of "rebase" and
"stash" in a secondary worktree.  This maintenance release ought to
fix it.

----------------------------------------------------------------

Changes since v2.35.0 are as follows:

Elijah Newren (1):
      sequencer, stash: fix running from worktree subdir

Junio C Hamano (1):
      Git 2.35.1

