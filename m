Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C4C433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 22:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiDPWpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 18:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiDPWpF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 18:45:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C14E393FF
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 15:42:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E4C9129192;
        Sat, 16 Apr 2022 18:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dNKJu2azR/U+6qnmmOwqtiHEXu8lVxyuWuIyOp
        FLq9s=; b=LgsZBjQygwTcYqc7nEsXcczF1OZjjFhxbJ5mWH67re8/yCdrn/BTmP
        D/OHaWjkMc/eRQdy1tP3h6HafeJaxONSJvu5UxbZgmWN1B7b0+mfNzxCiUOZ4VoN
        ICyo6UosbVVMPPApaDiZZK/KdeMeNacbXl3l6xq4c86mYiGxQBnGU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47C37129191;
        Sat, 16 Apr 2022 18:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E566129190;
        Sat, 16 Apr 2022 18:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     scs@eskimo.com (Steve Summit)
Cc:     git@vger.kernel.org
Subject: Re: suggestion for git glossary: "ort"
References: <2022Apr16.1107.scs.0007@quinine2.home>
Date:   Sat, 16 Apr 2022 15:42:29 -0700
In-Reply-To: <2022Apr16.1107.scs.0007@quinine2.home> (Steve Summit's message
        of "Sat, 16 Apr 2022 11:07:09 -0400")
Message-ID: <xmqq5yn84pm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FCFFF88-BDD6-11EC-917C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

scs@eskimo.com (Steve Summit) writes:

> I kept seeing references to "ort" in the git source code, and I
> had no idea what it meant.  Grepping around in the Documentation
> tree eventually revealed: it's a new merge strategy!  Suggested
> glossary patch attached; feel free to improve.

If the aim is to unconfuse those who are new to the codebase, read
builtin/merge.c and merge-ort-*.[ch], and wonder what "ort" refers
to, I doubt it would help all that much to add a new entry to the
glossary, especially if they do not think of first taking a look at
"git merge --help", which has its own large section on "ort".

Or is your main issue is even after you discover that "ort" is one
of the merge strategies supported by Git, it is unclear how that
short non-word was invented?

