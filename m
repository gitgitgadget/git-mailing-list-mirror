Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD63CEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjGEGNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGEGMy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:12:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7810E3
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:12:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BE20183C70;
        Wed,  5 Jul 2023 02:12:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nw/ZQzMAXkvPePhHXrr06R53ZliXxNByU1lFBX
        zrBE0=; b=xI/e0OIEZq6gwhH8br4uMWHb8vPO4qkOMW9tNhNShqaJJS9Z0Qp3bI
        ZQlPZslA1pxvs/iFDcVFBSs9jpTZwPEhp1VtQXtq8QvPt0oPxp99PysKyBwKfCx9
        b+9RbxfRDxqhoYBWAIXIQKct7zecbGeZes7fQZfaHBRU961hb8lLU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55512183C6E;
        Wed,  5 Jul 2023 02:12:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3E97183C6B;
        Wed,  5 Jul 2023 02:12:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: add necessary headers to Documentation/MFOW.txt
References: <20230702151457.3227-1-vinayakdev.sci@gmail.com>
Date:   Tue, 04 Jul 2023 23:12:51 -0700
In-Reply-To: <20230702151457.3227-1-vinayakdev.sci@gmail.com> (Vinayak Dev's
        message of "Sun, 2 Jul 2023 20:44:57 +0530")
Message-ID: <xmqqilay3mzg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9A47154-1AFA-11EE-9DB5-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vinayak Dev <vinayakdev.sci@gmail.com> writes:

> I sent a patch to the mailing list previously, but today I noticed that
> the CI builds for the branch on my fork were failing. I turns out that
> the tutorial required addition of more files than I had noticed.
> I am really, really sorry for this mistake, but I am sure that the tutorial 
> is fixed now. The CI builds now pass perfectly.

That is OK.  So the other one turned out to be a work-in-progress,
and this is the final version, right?

Thanks for working on this.  Will queue.
