Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFEFC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 23:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAC6610CE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 23:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhJMXvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 19:51:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61887 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhJMXve (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 19:51:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D6DDF168D;
        Wed, 13 Oct 2021 19:49:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2QwBnZsiqqvDkj4oQCLuAoNfKvXSe5jBaaolYc
        frm2I=; b=vAkoXhlKmD0iOwuk36GG7ZzONFP9hsfP3l4uhsVyg6N8tEuMV+tM+w
        9JwVZ2c2yM5ZKqxQOeoMjWtp1eEqeX7EA8wfCaQjXLAH0iZo2qjE8gTmAcxIsR2N
        iQdoigo/nbOUZmZUqrnNtBOyGJynweLmBaOdAd0oL2nhvPgwrJAO0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 848C3F168C;
        Wed, 13 Oct 2021 19:49:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E67BCF168B;
        Wed, 13 Oct 2021 19:49:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci(windows): ensure that we do not pick up random
 executables
References: <pull.1057.git.1634129748874.gitgitgadget@gmail.com>
        <xmqqpms8hlop.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2110132353160.395@tvgsbejvaqbjf.bet>
Date:   Wed, 13 Oct 2021 16:49:28 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2110132353160.395@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 14 Oct 2021 00:01:55 +0200 (CEST)")
Message-ID: <xmqqily0eb93.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 351498E2-2C80-11EC-B263-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> So do you want this forked from v2.33.0 (and merged to 'maint' so
>> that v2.33.2, if we need to issue it, would have it)?
>
> Well, I followed your custom and based it on the oldest applicable topic,
> js/ci-windows-update. My preference would be for this to be merged into
> `maint` rather sooner than later, so that GitGitGadget PRs could target
> `maint` and get a meaningful test coverage.

Yes, will do.  Tonight's pushout did not have it in 'next', but I do
not think of a reason why we shouldn't fast-track the topic.

Thanks.
