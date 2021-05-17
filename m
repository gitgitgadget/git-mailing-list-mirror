Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB6DC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518DE61263
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhEQTd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 15:33:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51066 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhEQTdx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 15:33:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2717E133490;
        Mon, 17 May 2021 15:32:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CqMDKMZpDXkt4dEWvuXMXqve00D52c6IQ/1P8N
        I/1ec=; b=jHKoUCvj1scx9fhrM5BAXJ9EYyJ9x88rQ0KCDBFHoOG2waN4465mfd
        28C1wk5sajFY5XgsxVeo/Hqm+wagM1EUkrK3n1AiaV188IPkV+xePVMm/oN1ZdHa
        mI7DFM0ky0nKnOiGMipsTb1/n/tgDBPY2DV5BufMSfrske0xqWXl4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F3E513348F;
        Mon, 17 May 2021 15:32:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05B6D13348E;
        Mon, 17 May 2021 15:32:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] parallel-checkout: send the new object_id algo
 field to the workers
References: <a4225bc79d963c5a411105e2b75f9ca4b80de835.1621000916.git.matheus.bernardino@usp.br>
        <YJ7VI5kHAAk126YJ@camp.crustytoothpaste.net>
        <7182880b-0f1e-7b3e-dc6e-b72c8ddd14b3@gmail.com>
Date:   Tue, 18 May 2021 04:32:30 +0900
In-Reply-To: <7182880b-0f1e-7b3e-dc6e-b72c8ddd14b3@gmail.com> (Derrick
        Stolee's message of "Mon, 17 May 2021 12:54:21 -0400")
Message-ID: <xmqqh7j16trl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FBB9ECA-B746-11EB-9D31-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> The patch looks fine to me.
>
> Chiming in to say I agree that this is a good patch.

Me three?

Let's have the non-RFC final patch.
