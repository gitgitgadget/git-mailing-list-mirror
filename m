Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D665C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJMPbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJMPbk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:31:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B8520BE9
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:31:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDCB91BA793;
        Thu, 13 Oct 2022 11:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9dyCwudwyCdcFQa0W+S+gI3N3Dj32A3UdeqQ7e
        1YQP4=; b=ZiVs4GP86MwxM5S9UAXUHqRbWcDjkU7oy5gik3q02mclSc++RU4Moq
        kAOjU5pQ5CcYWYb4CpBr8lR92HgjSFIYawXoZUeJ5U0tYaoNDtQgbthyc8kckQm2
        SLMlHxeQMbdTJwMmFDr8NHfYzveVlsuPDIKfL+ERfpYtfALg7+TqM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E569A1BA792;
        Thu, 13 Oct 2022 11:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28E731BA791;
        Thu, 13 Oct 2022 11:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 0/8] rebase: make reflog messages independent of the
 backend
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <xmqq7d14lqxc.fsf@gitster.g>
        <64155477-827d-6a16-a5fa-7e2cfc78569e@dunelm.org.uk>
Date:   Thu, 13 Oct 2022 08:31:34 -0700
In-Reply-To: <64155477-827d-6a16-a5fa-7e2cfc78569e@dunelm.org.uk> (Phillip
        Wood's message of "Thu, 13 Oct 2022 09:44:52 +0100")
Message-ID: <xmqqh707ivu1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F19A522-4B0C-11ED-BC95-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I pushed it to gitgitgadet, updated the cover letter but forgot to say
> "/submit". I'm hoping that will be the final version and provide a
> stable base for this series.

Thanks, will look forward to.
