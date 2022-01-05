Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59806C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbiAEUmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:42:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57185 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244127AbiAEUl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:41:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE9DE17B0A8;
        Wed,  5 Jan 2022 15:41:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0WRhidNSSeF87nlI51zy9nuQ4AN86ku/l7U1Jj
        1YiDQ=; b=TF8h5IttTbmuIItsh+SodkFDPpxsYXUga07rDmfnsQRIXl4cbSI5JG
        7fcO+AZbAewp6YQ1EN1e+JFNUCKaImE39bhFjn57ZASduWnNX5SZ71bjaYJms1bM
        tr0/NPy1T/qln02LhQc2jbymojOCYvjk27EYc/wfYagiosydLRCgE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6A1317B0A7;
        Wed,  5 Jan 2022 15:41:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24F9017B0A6;
        Wed,  5 Jan 2022 15:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH] t/README: fix typo
References: <pull.1110.git.1641338224631.gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 12:41:54 -0800
In-Reply-To: <pull.1110.git.1641338224631.gitgitgadget@gmail.com> (Marc
        Strapetz via GitGitGadget's message of "Tue, 04 Jan 2022 23:17:04
        +0000")
Message-ID: <xmqqo84phq3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBFEC7FC-6E67-11EC-A7CC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space speparated list of
> +GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space separated list of

Thanks, queued.
