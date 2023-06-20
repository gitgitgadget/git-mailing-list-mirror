Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47A0EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 20:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjFTUgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFTUgW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 16:36:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FDD187
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 13:36:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E53481953A9;
        Tue, 20 Jun 2023 16:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m1rBoQmZk/d8/S6g3WuXqyAqXE5Fo/C4HRKueK
        zFwdg=; b=Aup90QGszmDQjL5gGMvuWkLQes3qxt2CdFn0LfPAgfb5kPZ6vR6JQo
        bhW+89hK2JViKZceZvNLrrJ7lE6Lj0oEKETRHjW5aYs15ahc7dTW9ZMqO9dNZXyD
        +LwtegLmoxoJvRmNh7boWqLfcz6/K4IKZ+ujW+0FfGCYwI2/lZ1yA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE23A1953A8;
        Tue, 20 Jun 2023 16:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B8771953A7;
        Tue, 20 Jun 2023 16:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, peff@peff.net,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <xmqqmt10v8nl.fsf@gitster.g>
        <20230619060815.2291-1-tenglong.tl@alibaba-inc.com>
Date:   Tue, 20 Jun 2023 13:36:19 -0700
In-Reply-To: <20230619060815.2291-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Mon, 19 Jun 2023 14:08:15 +0800")
Message-ID: <xmqq1qi5na64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D2A7A80-0FAA-11EE-A5F4-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> I think we are now in a new cycle, maybe we could rewind and use
> v11 directlly? Sorry that it may have brought on extra work.

I think the tl/notes-separator topic is no longer in 'next' so we
can do whatever you like to it ;-).  It would be easy to just
replace the whole thing with newly reviewed version.

Thanks.
