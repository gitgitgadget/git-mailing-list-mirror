Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A753DC0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 05:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjG1FLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjG1FLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 01:11:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9723C2F
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 22:11:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 140DB33F5E;
        Fri, 28 Jul 2023 01:11:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dnTB4cRKBaG8XQ1xleRHojLH+fzuDe0HDBSc0i
        /z6zc=; b=PX4cBSzMZtyltedLXPClGVSGKjUVHhkSd23HN1wFg84vNeW6bhELuw
        xk8MLngfmOPZfw8+xi0SqbslGmkinGZjROnL5LR4K4uczS6MtHnJL2WhlQ3sySHP
        8+oY35jcU47JGgsfCdgc6Nl97zPN7ZrqaV0WPqZRhpOCh1WHjHK28=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D09F33F5D;
        Fri, 28 Jul 2023 01:11:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A75933F5C;
        Fri, 28 Jul 2023 01:11:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #06; Thu, 27)
References: <xmqqh6po95a5.fsf@gitster.g>
        <dnydxyrjutreobayldz5ystptwyhafaebhycm2ymhj7nhiwbyo@ubfnxgbnf7cz>
Date:   Thu, 27 Jul 2023 22:11:15 -0700
In-Reply-To: <dnydxyrjutreobayldz5ystptwyhafaebhycm2ymhj7nhiwbyo@ubfnxgbnf7cz>
        (Jacob Abel's message of "Fri, 28 Jul 2023 02:13:27 +0000")
Message-ID: <xmqqy1j07h8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E17E940-2D05-11EE-B147-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> On 23/07/27 06:46PM, Junio C Hamano wrote:
>> * ja/worktree-orphan-fix (2023-07-26) 3 commits
>>   (merged to 'next' on 2023-07-27 at e475016065)
>>  + t2400: rewrite regex to avoid unintentional PCRE
>>  + builtin/worktree.c: convert tab in advice to space
>>  + t2400: drop no-op `--sq` from rev-parse call
>> 
>>  Fix tests with unportable regex patterns.
>> 
>>  Will merge to 'master'.
>>  source: <20230726214202.15775-1-jacobabel@nullpo.dev>
>
> Now that this patchset has been merged to `next` I was able to confirm
> that the Cirrus CI builds on `freebsd_12` are passing again.
>
> source: https://cirrus-ci.com/task/4872784707321856?logs=test

Thanks for a positive confirmation ;-)
