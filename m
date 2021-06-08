Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B2C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0788C6124C
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFHBUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 21:20:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61752 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFHBUg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 21:20:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D050DBDC3;
        Mon,  7 Jun 2021 21:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7pAK2fOSc6M9qE6j+SDXha7Nh4x4fcg0vCS3V1
        ElqQg=; b=fBesVw3f9C8fIiIJuCX5r9LSlIspPtyBV61NV5hOJJVY5DpW71z4p4
        +kejePVVedEOkM/X+J1wff80+1fDHK9/fbgFZGn9fTWOg9sAjFnuioH1wDxgNbmp
        5rKGopL4lZYBDY9fbRSjgaDmwrYl71MznSRc9EseceTmqkxqznIHE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15851DBDC2;
        Mon,  7 Jun 2021 21:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9951FDBDC1;
        Mon,  7 Jun 2021 21:18:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 10:18:43 +0900
In-Reply-To: <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 07 Jun 2021
        16:57:45 +0000")
Message-ID: <xmqqh7i9rw5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 773FE0E8-C7F7-11EB-B285-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 55287d72e0ef..b518d3157f70 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -373,7 +373,7 @@ If you like, you can put extra tags at the end:
>  . `Acked-by:` says that the person who is more familiar with the area
>    the patch attempts to modify liked the patch.
>  . `Reviewed-by:`, unlike the other tags, can only be offered by the
> -  reviewer and means that she is completely satisfied that the patch
> +  reviewer and means that they are completely satisfied that the patch

All the other changes in this step, including the one that is a
quote of past e-mail sent to the list, didn't sound so awkward and
good, but this one does sound strange for this non-native speaker.

Granted, the use of "she" here is already awkward (in the sense "why
do we assume that the reviewer is of certain gender?"), but "they"
looks ungrammatical on top of that awkwardness.

    `Reviewed-by:`, unlike the other tags, can only be offered by
    reviewers themselves when they are completely satisified with
    the patch.  It is offered only after a detailed review by
    reviewers who are known to be experts in the affected area by
    the community members.

perhaps?
