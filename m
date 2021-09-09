Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7A7C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625BC60F4A
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhIIRqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 13:46:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51774 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbhIIRqn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 13:46:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06DA8DE4A3;
        Thu,  9 Sep 2021 13:45:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/2iEWi+1QRDdF8Ubmdak/92Vtun5XOxYaMSnyN
        CkDb8=; b=oFB/iwwmVI69HGgG/s3tbeleikJe9XmGK8CWlF0qe9DnsBdVCAv423
        oRp2lDIvm1KTj9aiKbvmS9zpm2scKAwqvLeo/0D3MU1CIz/NpTVtS7yOqvhTfDYG
        EusQycLMqhIIkPmPcLzqbEQUAiv15KpiIQs5lnZHuiRqzEOSmct2U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F24E6DE4A2;
        Thu,  9 Sep 2021 13:45:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62780DE4A1;
        Thu,  9 Sep 2021 13:45:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
References: <xmqqsfyf5b74.fsf@gitster.g>
        <c0c24993-77e2-51a1-c352-0399c59f1f94@ramsayjones.plus.com>
Date:   Thu, 09 Sep 2021 10:45:32 -0700
In-Reply-To: <c0c24993-77e2-51a1-c352-0399c59f1f94@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 9 Sep 2021 03:59:57 +0100")
Message-ID: <xmqq1r5x1w3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB71AEC6-1195-11EC-95FB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 08/09/2021 16:38, Junio C Hamano wrote:
>
> test t5319-multi-pack-index.sh on 'seen' has been failing for
> several days, so I had a quick look tonight. This issue relates
> to the following two topics:
> ...
> The merge commit 24cade3ceb ("Merge branch 'jb/midx-revindex-fix' into seen",
> 2021-09-07) basically takes two versions of the same patch and keeps both
> versions of the same test. The two patches are:
> ...
> The second patch even includes an acknowledgment of 'Original-patch-by:
> Johannes Berg <johannes@sipsolutions.net>' (ie the first patch).

You're right.
Thanks for helping me straighten the mess.


