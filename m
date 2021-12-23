Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E000C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 23:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbhLWXwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 18:52:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50909 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbhLWXwX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 18:52:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B10AF016A;
        Thu, 23 Dec 2021 18:52:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=J
        AH3DvR3icCTb3XLcwyYlY8iKR4G0YBmK051AbCxd4g=; b=ucjMcxXQAjI7UfieC
        6MXJXeFu4aGUF6H9vGMb6mBCafq7Wh4p1aAqB/luZoV+s6l/dq7q1r2V4hsk6Qyq
        r/joF65i1oqxcj0JKLYqj5WySSwe9pRfazMi4lzAK2SbMFZVML2tBS2sA0fD15BX
        7K2aYU2cpdRZzyd0LTZLjssX+o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82CBDF0169;
        Thu, 23 Dec 2021 18:52:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF563F0168;
        Thu, 23 Dec 2021 18:52:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [RFC] squelch log4j inquiries
Date:   Thu, 23 Dec 2021 15:52:20 -0800
Message-ID: <xmqqmtkq6frf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EDF4CB4-644B-11EC-B483-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wonder if we should do something like this, for limited time like
a few months or so, so that we have something prominently shown at
places like https://github.com/git/git/

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 README.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git c/README.md w/README.md
index f6f43e78de..76e99fe5bb 100644
--- c/README.md
+++ w/README.md
@@ -7,6 +7,9 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
+No part of Git is written in Java, hence it is not susceptible to
+the log4j vulnerability that has been causing sensation recently.
+
 Git is an Open Source project covered by the GNU General Public
 License version 2 (some parts of it are under different licenses,
 compatible with the GPLv2). It was originally written by Linus
