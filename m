Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9955AEB64DA
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 01:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGABD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 21:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGABDW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 21:03:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C72D52
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 18:03:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C91D1A3C3C;
        Fri, 30 Jun 2023 21:03:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DaEoRTNGaickOSohT6EWmCuxO3kzs7w3xJvQj+
        3d3Ew=; b=WGVc8S4gkUZzBZltxnYJ/tUdTLs82je3lWOlLAYgg+dGKIyb3fln/6
        uGPQJD3QHdnGnLP3FqkBuTyzLU9raRI2ajA+ixeiAJdEjuz/ZXb2oOm/J3RJglSV
        5Oxgk3lkQpEzEX140alIOxdNPuCmWNz9Nx/tJhvlliBHS+6sHzVss=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 735EC1A3C3B;
        Fri, 30 Jun 2023 21:03:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7C881A3C3A;
        Fri, 30 Jun 2023 21:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net, calvinwan@google.com
Subject: Re: [PATCH v4] unit tests: Add a project plan document
References: <20230517-unit-tests-v2-v2-0-8c1b50f75811@google.com>
        <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
Date:   Fri, 30 Jun 2023 18:03:18 -0700
In-Reply-To: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
        (Josh Steadmon's message of "Fri, 30 Jun 2023 15:51:19 -0700")
Message-ID: <xmqq4jmo5tpl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11B52598-17AB-11EE-A238-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> In our current testing environment, we spend a significant amount of
> effort crafting end-to-end tests for error conditions that could easily
> be captured by unit tests (or we simply forgo some hard-to-setup and
> rare error conditions). Describe what we hope to accomplish by
> implementing unit tests, and explain some open questions and milestones.
> Discuss desired features for test frameworks/harnesses, and provide a
> preliminary comparison of several different frameworks.
>
> Coauthored-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---

> TODOs remaining:
> - List rough priorities across comparison dimensions
> - Group dimensions into sensible categories
> - Discuss pre-existing harnesses for the current test suite
> - Discuss harness vs. framework features, particularly for parallelism
> - Figure out how to evaluate frameworks on additional OSes such as *BSD
>   and NonStop
> - Add more discussion about desired features (particularly mocking)
> - Add dimension for test timing
> - Evaluate remaining missing comparison table entries

Listing these explicitly here is very much appreciated.  Thanks.

