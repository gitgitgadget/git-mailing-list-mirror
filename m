Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B39C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 03:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiADDQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 22:16:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56016 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiADDQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 22:16:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 950D5172463;
        Mon,  3 Jan 2022 22:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ZyCzJfQXjWClUwJA8w47XaoXfK5bdWYnQpM/AVxc9Dc=; b=u4CT
        sxAdlWljmy6p8Vf9y1otBD8IEnPTC35ENmalP0digJTKJA9eQrdUZyanTelDb1oV
        GqKz9v8a+5wQPpILnqArcRoO8RRY1CPZtcAwo1mwmRTiWQ5CqZojZjmUbp5GYw8P
        LfJic7FXch7lCthwG3yKGBg0EpWamm3rq8yQZgQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D7BC172461;
        Mon,  3 Jan 2022 22:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC8FF17245E;
        Mon,  3 Jan 2022 22:16:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 1/2] name-rev: deprecate --stdin in favor of
 --annotate-text
References: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
        <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
        <55ec2a5fa3e748b7e5f9ef871214563ba2b28adf.1641221261.git.gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 19:16:42 -0800
Message-ID: <xmqq4k6kfaw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE3561A2-6D0C-11EC-B346-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Introduce a --annotate-text that is functionally equivalent of --stdin.

This line and the title need to be updated to use "--annotate-stdin".
