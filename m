Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77166C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 07:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbiCBHGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 02:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiCBHGT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 02:06:19 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B67B54C5
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 23:05:35 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74DB11156D8;
        Wed,  2 Mar 2022 02:05:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6chQtefT5cdd
        2EW++t3mf0VMZ6vQ4sbwkXQzW33n1Kw=; b=egXPvSb1dernbJxEVi5TrMz+JjmQ
        rWbsRiEe6KNtAq6Y2sRLKvljSKssurGaqWz3M20n8Hah7LHQln2YRrZ9C9Vac1Dl
        K5GbjcfrjLYrvKJ3ly80K2C0PVMvqYM6E5w9vSt46jncaxsgWZUKYf1mVSjM15UD
        qgaQQXA7ovL8GCs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B5161156D5;
        Wed,  2 Mar 2022 02:05:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD6871156D4;
        Wed,  2 Mar 2022 02:05:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/scalar-diagnose, was Re: What's cooking in git.git (Feb
 2022, #08; Mon, 28)
References: <xmqqmti9ssah.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2203012353090.11118@tvgsbejvaqbjf.bet>
Date:   Tue, 01 Mar 2022 23:05:32 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2203012353090.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 1 Mar 2022 23:55:18 +0100
        (CET)")
Message-ID: <xmqqfso0omv7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 27652538-99F7-11EC-8F32-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 1 Mar 2022, Junio C Hamano wrote:
>
>> * js/scalar-diagnose (2022-02-06) 6 commits
>>  - scalar: teach `diagnose` to gather loose objects information
>>  - scalar: teach `diagnose` to gather packfile info
>>  - scalar diagnose: include disk space information
>>  - scalar: add `diagnose`
>>  - scalar: validate the optional enlistment argument
>>  - archive: optionally add "virtual" files
>>
>>  Implementation of "scalar diagnose" subcommand.
>>
>>  Expecting a reroll.
>>  cf. What is the status of this thing?
>>  source: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
>
> The status is that I'm woefully short on time and did not even manage t=
o
> read the sub-thread between you and Ren=C3=A9 (which might need another
> adjustment to the code).

FWIW, I think the subthread was mostly about "now we have a new
feature in 'git archive', do we want to use it elsewhere?" tangent
and the outcome of the discussion there won't affect this topic---as
long as this topic needs the new feature it adds to 'git archive',
and the new feature is adequately done, I do not think there is any
need for it to be redone.

Other parts of the series may or may not need reworking, but I do
not recall the details of the topic.

> So maybe set it to `On Hold` for now?

OK.
