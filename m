Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D02C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 18:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbiGNS12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiGNS1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 14:27:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA82F67F
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:27:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D515195C15;
        Thu, 14 Jul 2022 14:27:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MZkS5xDhTdndsIuAPwghderHVWOUCHCQQgMOCy
        Qb6ek=; b=pXGy6yiWKCl0TO0YNt0AJBvZ+Z6kqG7hnS7ZTs7ooAr4E6kFTTMqiH
        dFbVTRcci3TKb4pRGQAKwxSRKZZgvMpdDhOoHRoThLBlM12l+sRz10X0qZvkxNEw
        Q+mVQGBreZYerySuI7SuHb3ZEISYvIsCEZ/qLJ7QC7cty9M+6zeT4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3615E195C13;
        Thu, 14 Jul 2022 14:27:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE582195C06;
        Thu, 14 Jul 2022 14:27:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: gc/bare-repo-discovery (was Re: What's cooking in git.git (Jul
 2022, #03; Mon, 11))
References: <xmqqo7xufee7.fsf@gitster.g>
        <kl6lpmia55ys.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq8roxdlhe.fsf@gitster.g>
        <5ps2q552-1rr3-7161-4181-31556pp2ns12@tzk.qr>
Date:   Thu, 14 Jul 2022 11:27:19 -0700
In-Reply-To: <5ps2q552-1rr3-7161-4181-31556pp2ns12@tzk.qr> (Johannes
        Schindelin's message of "Thu, 14 Jul 2022 18:17:39 +0200 (CEST)")
Message-ID: <xmqqmtdb5z3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 994D375C-03A2-11ED-B601-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would find `safe.bareRepository = true` or `false` more intuitive, and
> more concise.

Yup, that is fine by me.

> And if there should be an option to ignore bare repositories when
> discovering a Git repository, it could be a tristate, with `ignore` being
> the value to trigger that mode.

Sounds good.
