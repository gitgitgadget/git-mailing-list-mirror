Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722A8C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 21:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245234AbiESVtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 17:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiESVty (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 17:49:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78E3972BA
        for <git@vger.kernel.org>; Thu, 19 May 2022 14:49:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BF1011CC6A;
        Thu, 19 May 2022 17:49:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e3NZluom9aKxqetrUtukne1YfMug75rvABV5yI
        xXqGU=; b=b5AyQ5Qybk6vUt39Fkr32945YbgQV8QmH/8QchE5QHF5YDhL9ghmM6
        UnbzX5+/ARg1retb5QjTGYggnyASDAY+/weJfO8B3xVi0PIJgDhsnDkKm6J1g7vt
        xJJE6ZyJL1Rp/MQbZ6xA43rLJ+TUpxD78NDCcaA79xAfWFZ7hReak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0317C11CC69;
        Thu, 19 May 2022 17:49:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7076011CC68;
        Thu, 19 May 2022 17:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v3 0/5] Improve MyFirstContribution's GitGitGadget section
References: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 14:49:51 -0700
In-Reply-To: <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Thu, 12 May 2022 23:43:32 +0000")
Message-ID: <xmqqpmk9kxa8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D050200-D7BD-11EC-8E41-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Philippe Blain (5):
>   MyFirstContribution: add "Anatomy of a Patch Series" section
>   MyFirstContribution: add standalone section on cover letter
>   MyFirstContribution: reference "The cover letter" in "Preparing Email"
>   MyFirstContribution: reference "The cover letter" in GitGitGadget
>     section
>   MyFirstContribution: drop PR description for GGG single-patch
>     contributions

I am planning to merge it to 'next' soonish.  Please speak up if
anybody has any issues.

Thanks.
