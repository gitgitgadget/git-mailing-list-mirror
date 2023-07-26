Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDAFC0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 22:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjGZWJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 18:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGZWJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 18:09:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81171270B
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 15:09:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 244791A225;
        Wed, 26 Jul 2023 18:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/252hDuKWA1TRJv05APGSD4wGv9rWccPsmVyc9
        aX5ZM=; b=LEDoTKEFZrlgwM6XBjHtsOH9Y9NhH0uC4M8btyaQouCkZJQnt9ERfT
        9bqm+5Ao99IvhF0Nj/u0M2tS5PPfYCoUxwdMzDto8tEZy3lIJCWdUx68fjNnmcju
        JezzYdZRvLQqYhTgQcU4bdKUAU6XIiIkRua5G2iWdL+O1Bus1vGK8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C82F1A224;
        Wed, 26 Jul 2023 18:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ABF841A220;
        Wed, 26 Jul 2023 18:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 0/3] t2400: Fix test failures when using grep 2.5
References: <20230715025512.7574-1-jacobabel@nullpo.dev>
        <20230716033743.18200-1-jacobabel@nullpo.dev>
        <20230721044012.24360-1-jacobabel@nullpo.dev>
        <20230726214202.15775-1-jacobabel@nullpo.dev>
Date:   Wed, 26 Jul 2023 15:09:42 -0700
In-Reply-To: <20230726214202.15775-1-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Wed, 26 Jul 2023 21:42:09 +0000")
Message-ID: <xmqq4jlqcok9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FEBDB9C-2C01-11EE-89CE-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> This patchset is in response to build failures on GGG's Cirrus CI 
> freebsd_12 build jobs[1] and was prompted by a discussion thread [2].
> These failures seem to be caused by the behavior outlined in [3]. 

Looking very good.

Will queue.  Let's plan to merge it down to 'next' shortly.

Thanks.
