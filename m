Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F74CEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 05:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGEFiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 01:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjGEFh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 01:37:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4F41703
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 22:37:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7508C32246;
        Wed,  5 Jul 2023 01:37:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VVizvF9oowYD7NQwKEJ5hOscy79qMi68IYI4O3
        1fDLA=; b=WGq2LGZ8//1a5nFhzUAIw94tMkr2w+zAIwcafmnah86S6igdxIfbK0
        unnCz2z5PB294xgxz6znVVjT9Yby/n5A6ukGEaAYad4imWZh5O1LXDhPFLLSITp7
        +Hqe+Q3JGsVJGW051y9GxvPjVE2UUsxNZGNVd2VgPuD4korURHVFY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6021132245;
        Wed,  5 Jul 2023 01:37:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C412232244;
        Wed,  5 Jul 2023 01:37:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2023, #08; Fri, 30)
References: <xmqq5y747l16.fsf@gitster.g>
        <CADE8NarZ7B8VC2cnh4Vt8o0YyNswguXDeJtfEk=9_isHzv4SNg@mail.gmail.com>
Date:   Tue, 04 Jul 2023 22:37:52 -0700
In-Reply-To: <CADE8NarZ7B8VC2cnh4Vt8o0YyNswguXDeJtfEk=9_isHzv4SNg@mail.gmail.com>
        (Vinayak Dev's message of "Sat, 1 Jul 2023 13:44:13 +0530")
Message-ID: <xmqq1qhm5367.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16948EAC-1AF6-11EE-9474-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vinayak Dev <vinayakdev.sci@gmail.com> writes:

>> * vd/adjust-mfow-doc-to-updated-headers (2023-06-29) 1 commit
>>  - docs: include "trace.h" in MyFirstObjectWalk.txt
>>
>>  Code snippets in a tutorial document no longer compiled after
>>  recent header shuffling, which have been corrected.
>>
>>  Will merge to 'next'?
>>  source: <20230629185238.58961-1-vinayakdev.sci@gmail.com>
>
> I found an error in this patch while fixing Emily's branch to which the tutorial
> points, which I linked in a prior mail[1]. This would also require "hex.h" to be
> added down in the tutorial where the function oid_to_hex() has been called.
> Accordingly, I have fixed this mistake and rebased, and will send it
> as a resubmission.

Thanks, will take a look at the updated one.
