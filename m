Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C5E7545F
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbjJCSvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjJCSvk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:51:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38184AF
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:51:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B13F21B7B67;
        Tue,  3 Oct 2023 14:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=eW+VgsQ/PdIU4c8R0zlUii7ZCk4av4T1LyVN71
        8Jgrw=; b=qCmgPdWYKtStIRzTVqtjpYT6Gy9BHGzs99HG/74ECn1PHN3yjTUsgp
        zAScjiPe7+1B+PbnksF8xGmLZ90LDKBDLBDEOWhhG0DoJ4y/GldWpmCvPH2o5oTL
        qq0El/1yQahco1JtjWhF2OLSE8dabrP7rDN40s4F7yrtSx5qIc8IU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A97F41B7B66;
        Tue,  3 Oct 2023 14:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 150EF1B7B65;
        Tue,  3 Oct 2023 14:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luma <ach.lumap@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy] Move existing tests to a unit testing framework
In-Reply-To: <CAFR+8DynAJ7eieMYUrezoNii5tzARNbESFxRCcT4w6okS5FZDg@mail.gmail.com>
        (Luma's message of "Tue, 3 Oct 2023 15:30:18 +0100")
References: <CAFR+8DynAJ7eieMYUrezoNii5tzARNbESFxRCcT4w6okS5FZDg@mail.gmail.com>
Date:   Tue, 03 Oct 2023 11:51:34 -0700
Message-ID: <xmqqedibzgi1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0DA436E-621D-11EE-B1E1-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luma <ach.lumap@gmail.com> writes:

> Hi;
> My name is Luma, and  I wanted to take a moment to introduce myself
> and share some
> insights on an essential aspect of  avoiding pipes in git related
> commands in test scripts.
>
> I am an outreachy applicant for the December 2023 cohort and look
> forward to learning from you.

I notice that the title of the message and the immediate topic you
discuss in the body of the message do not match.  I presume that the
topic on the title is what you prefer to work on if the unit testing
framework is ready by the time Outreachy program starts, and the
mention about "do not clobber exit code of Git with pipes in the
tests" is your "dip the tip of a toe in water" microproject?

Welcome to the Git development community.

Do you have a single word name?  If so please disregard the below,
but in case "Luma" is just a nickname (e.g. like I am introducing
myself to my Git friends "Hi, I am Gitster!") you use online, please
read on.

For signing off your patches, we'd prefer to see your real name
used, as Signed-off-by: is meant to have legal significance.  And
because we also expect the authorship identity to match the
name/e-mail of the sign-off, it would mean your patch submissions
are expected to look like:

	From: Luma <ach.lumap@gmail.com>
	Subject: ... title of the patch goes here ...

	... body of the proposed commit log message goes here...

	Signed-off-by: Luma <ach.lumap@gmail.com>

but "Luma" replaced with your full real name.

Thanks.
