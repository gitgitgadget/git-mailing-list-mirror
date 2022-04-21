Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045D2C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391099AbiDUSDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391035AbiDUSDO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:03:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABFD4A90E
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:00:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED9DD1947DE;
        Thu, 21 Apr 2022 14:00:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WRog7sppuLtxUEhDU0SNoN8daeMaLV39PvpjyW
        5t//U=; b=YvX6MEz8mRAy5nPkTLaO9wgMEQ6Y32B1tDWb9dUTZmRyROZobJFWbI
        b2sEkChcJQ42lPEIhUBG5cOZ31CSSdm9OBDd5GwLZscNuHXfRksUmNOvpYlS2q4L
        5qcoGYYd2nsbJFkgbQRol2UBipf1l9zoTrzgtFEnLzv4wJSpPaRv0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6EE21947DB;
        Thu, 21 Apr 2022 14:00:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5CC931947D8;
        Thu, 21 Apr 2022 14:00:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH] clone: ignore invalid local refs in remote
References: <pull.1214.git.1650301959803.gitgitgadget@gmail.com>
        <xmqqczhbo4s3.fsf@gitster.g>
        <b884d627-4a81-5be9-eed5-feff3b2bd010@github.com>
Date:   Thu, 21 Apr 2022 11:00:16 -0700
In-Reply-To: <b884d627-4a81-5be9-eed5-feff3b2bd010@github.com> (Derrick
        Stolee's message of "Thu, 21 Apr 2022 09:29:32 -0400")
Message-ID: <xmqq7d7ijozz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6DCF054-C19C-11EC-AD0F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Sorry, this title of the commit message is stale from a version
> where I started making the clones succeed (but without these
> bad refs). I changed my mind to only switch BUG() to die() to
> avoid giving the impression that we have a "matching" repo after
> the clone.

Ah, that figures ;-)

> Perhaps the commit could instead start with
>
> 	clone: die() instead of BUG() on bad refs
>
> ?

Yeah, it would be the title I would have been happy with.



