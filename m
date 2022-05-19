Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE3C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 14:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiESOEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiESOEX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 10:04:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50CA101DF
        for <git@vger.kernel.org>; Thu, 19 May 2022 07:04:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABAAD119432;
        Thu, 19 May 2022 10:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=b+3/3v4w5asZHDpz/ivivYgeaRnA0cKdUuoz80VO2jk=; b=VkE7
        5skM5MO5oDhfGkSrEyowdulDBjLKQPq/mIpjTMN8IOZDd/cfndXtyN+WkktqJ7oJ
        K62iGZxs5GIgRoM7CSNcljVMZSGh053W1037DwydetKH/Xbi5gwrCA/Lq42ptBfN
        9yYkb54qxN39I6cJ9sfeF+1AGjZ7VW9e5Am3+ec=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2D40119431;
        Thu, 19 May 2022 10:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1246C11942F;
        Thu, 19 May 2022 10:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 01/17] Documentation/technical: add cruft-packs.txt
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1652915424.git.me@ttaylorr.com>
        <f494ef7377bf8fb14d96e860106033d1bd1c9ec1.1652915424.git.me@ttaylorr.com>
Date:   Thu, 19 May 2022 07:04:18 -0700
Message-ID: <xmqq1qwpsjod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9405C50E-D77C-11EC-82CD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +== Caution for mixed-version environments
> +
> +Repositories that have cruft packs in them will continue to work with any older
> +version of Git. Note, however, that previous versions of Git which do not
> ...
> +cruft packs.

I've compared a rebase of the previous iteration on top of v2.36.0
with the result of application of this iteration on the same commit,
and the above additional documentation seems to be the only real
difference.

Will replace and queue.

Thanks.
