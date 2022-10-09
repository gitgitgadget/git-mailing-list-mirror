Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3320FC433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 12:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJIMrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 08:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJIMrg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 08:47:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB42B61F
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 05:47:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D290167C43;
        Sun,  9 Oct 2022 08:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=OLgY5/3Bhh+vLx8MT1/1xe7FB5DjNfYaTboQ1CRRC3o=; b=HpLb
        lo4jO/cjxI9jTd8Dt7vYO3c44k49P73SKdrovnDCyHmXa/oFWY6iwunkzzV8ii9O
        DkCE5QLDi6DsplRlXqHuHCYQtdQvUiIUcDnu9ohIWYXO+PDevg3uRiO//z3YNcWo
        uyHaKu0I/M6jGGWX7c7zHklyMnPlrneuJfuTTyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40E05167C41;
        Sun,  9 Oct 2022 08:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A072167C40;
        Sun,  9 Oct 2022 08:47:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] symbolic-ref: teach "--[no-]recurse" option
References: <xmqqleprcn08.fsf@gitster.g> <xmqqsfjzaq78.fsf@gitster.g>
        <0b44cdca-3115-e09e-70c8-6f56101c3d9c@gmail.com>
Date:   Sun, 09 Oct 2022 05:47:31 -0700
Message-ID: <xmqqa66588po.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AC3858E-47D0-11ED-8700-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 10/8/22 11:34, Junio C Hamano wrote:
>> Suppose you are managing many maintenance tracks in your project,
>> and some of the more recent ones are maint-2.36 and maint-2.37.
>
> The example case above is from recent Git releases, right?

It is left to reader's imagination.  Concrete numbers are easier to
understand, as it would be clear that 2.36 comes before 2.37 which
comes before 2.38.

