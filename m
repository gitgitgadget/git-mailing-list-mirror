Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CD1C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 08:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5864561355
	for <git@archiver.kernel.org>; Wed, 19 May 2021 08:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbhESIiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 04:38:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53946 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbhESIiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 04:38:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BBB112CD77;
        Wed, 19 May 2021 04:36:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FMi/HfxooxeOxXvagZmt7RTqoSFFqxCpNSAuQZ
        kMf0Y=; b=yPzGVFMB0QGe+QbwEh0XSS4+N6SDDo+7WCVD5v3LC+47u/GRk0jiUj
        6hTytzJX8mNtz+7Ml2N7bmTbMTak3BYNt9YgCGPjjbEKP7FDPN1OuifFus2LuXTb
        qCJyMK9GHBJv/taf89Zc5a9ewkdtAp+UrEvLph7bHGc6/Mm06pXZA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85C6F12CD76;
        Wed, 19 May 2021 04:36:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC43712CD75;
        Wed, 19 May 2021 04:36:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Reuven Y. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Reuven Y." <robi@post.jce.ac.il>
Subject: Re: [PATCH] docs: typo in glossary content
References: <pull.957.git.1621406381404.gitgitgadget@gmail.com>
        <xmqqtumzxjef.fsf@gitster.g>
Date:   Wed, 19 May 2021 17:36:38 +0900
In-Reply-To: <xmqqtumzxjef.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        19 May 2021 16:38:48 +0900")
Message-ID: <xmqqpmxnxgq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54D39ABA-B87D-11EB-B748-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Reuven Y. via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
>> index 67c7a50b96a0..e75aed00ffe1 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -146,7 +146,7 @@ current branch integrates with) obviously do not work, as there is no
>>  	<<def_revision,revision>> and you are "merging" another
>>  	<<def_branch,branch>>'s changes that happen to be a descendant of what
>>  	you have. In such a case, you do not make a new <<def_merge,merge>>
>> -	<<def_commit,commit>> but instead just update to his
>> +	<<def_commit,commit>> but instead just update to this
>>  	revision. This will happen frequently on a
>>  	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
>>  	<<def_repository,repository>>.
>
> Actually, "his" is what was intended by the original introduced at
> 9290cd58 (Added definitions for a few words:, 2006-05-03).  
> ...
> I do not mind neutering the expression with "the other party",
> especially since that would help reduce confusion.  How about
> phrasing
>
>     In such a case, you do not make a new <<def_merge,merge>>
>     <<def_commit,commit>>, but instead just update your branch to
>     point at the same revision as the other party's.  This will
>     happen often ...
>
> perhaps?

Alternatively, since we start with "you are 'merging' another
branch's changes", we could say

    ... but instead just update your branch to point at the same
    revision as the branch you are merging.  This will happen often
    ...
