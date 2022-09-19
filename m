Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FF4ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 18:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiISSou (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 14:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiISSos (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 14:44:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE626579
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 11:44:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F85B1CF755;
        Mon, 19 Sep 2022 14:44:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b8HWR/g6RM8rYLuYjMEtAAEomjlIWii0nayO6Y
        2d/Eg=; b=kWippX7pD1efcWo13S5zI9O32DB8JdyChuV9RnzfuD7ycYuIIvPAum
        T0ZwJ/dqfNNt17Mk/BjBIMunpeAhxc9TVjRqzgHmEfTjmquMLFH0uijcF4HXeOCt
        U9JZaLv+NiXcHWK/uO1SQ8d6y4eDH7hfwKBNAA7+D7UvpG3/EHw8k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 67C511CF754;
        Mon, 19 Sep 2022 14:44:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 157E41CF753;
        Mon, 19 Sep 2022 14:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] scalar: fix wrong shell hashbang
References: <pull.1355.git.1663420281187.gitgitgadget@gmail.com>
        <433bf552-db20-9989-92c5-ee625ce9337a@github.com>
Date:   Mon, 19 Sep 2022 11:44:39 -0700
In-Reply-To: <433bf552-db20-9989-92c5-ee625ce9337a@github.com> (Victoria Dye's
        message of "Sun, 18 Sep 2022 13:08:33 -0700")
Message-ID: <xmqqillj9pbc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EEF08F4-384B-11ED-93FF-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Thanks for finding this! However, while your patch fixes the error you've
> identified (I was able to recreate both the original issue and apply your
> patch to fix it), I believe it has already been fixed in 'next' by
> 7b5c93c6c6 (scalar: include in standard Git build & installation,
> 2022-09-02) (archive: [1]).

Yup, thanks.  The topic that contains that commit should graduate to
the master branch before -rc1, like this afternoon ;-)

