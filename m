Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C8C4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJOSdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOSdV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 14:33:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368114CA32
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 11:33:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7AC681C502E;
        Sat, 15 Oct 2022 14:33:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4knoX16Wa0eKaQ7I/Vs7p+jxJFDnGtplfZSMC0
        tRS9o=; b=fX2V7buoRaNhQDErGxEpRk9fqCwUkKQPSOdwiyvwyy2X7CsTFbTKDw
        8hRwJoVj6TFaB8RTnl09Qkj+YkXNB0Ok9WE1V4/dtnRTdR6vUvkpxY2DbNo0GGTy
        BkBZHegQhgm6Cj+5Q77ligTz+h3eM+7O8LWvATjvjNA4Kuv3YZc0Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BE3A1C502D;
        Sat, 15 Oct 2022 14:33:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11DBF1C5028;
        Sat, 15 Oct 2022 14:33:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rupinderjeet Singh <rupinderjeet47@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [suggestion] Fail cherry-pick if it overwrites untracked files
 with the matching file names
References: <CAAheMRzYX6PdWMtcB=px_kD=-gnGGHvDgvR6Jxy94JH2DpYpJw@mail.gmail.com>
Date:   Sat, 15 Oct 2022 11:33:15 -0700
In-Reply-To: <CAAheMRzYX6PdWMtcB=px_kD=-gnGGHvDgvR6Jxy94JH2DpYpJw@mail.gmail.com>
        (Rupinderjeet Singh's message of "Sat, 15 Oct 2022 23:39:34 +0530")
Message-ID: <xmqqbkqd5444.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D55F6982-4CB7-11ED-BFEB-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rupinderjeet Singh <rupinderjeet47@gmail.com> writes:

> Since your email only receives plain-text, I assume I can't send the
> report by uploading it in this email. If there's something I can do
> from my end, or if you need some more information, please let me know.

You do not have to assume that.

"git bugreport" gives a template to create a text file, which you
can paste/include to the body of your e-mail message without making
it an attachment.

