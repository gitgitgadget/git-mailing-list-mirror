Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F794C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 22:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbhLAWSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:18:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64750 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbhLAWS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:18:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D4ED102A35;
        Wed,  1 Dec 2021 17:15:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2TT0S4jkq/UQtlbgamRBHF2og9oG9N/Pm3i7Yd
        HTNf8=; b=kkb+flSqWX9b0djyvqZf6FhW6B7g3caYjfQmuikuPhswffJFEtXxN5
        IV6VRZzkKXo9fUV+4p0rkxyhkIePP2/idcer29qr2FxkFMIeTIvOdsW0PvaSNOmP
        JisQE9TZrwrMbmojf0+X8gnWDPLEF5CuvLoMbDM6E/5I4bTc2pgNQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9F08102A33;
        Wed,  1 Dec 2021 17:15:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEB57102A32;
        Wed,  1 Dec 2021 17:15:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: en/zdiff3
References: <xmqqzgpm2xrd.fsf@gitster.g>
        <CABPp-BERnA+tyP0RTQ-iXcm5wwO5GbjasP3O-MjqSHGauyibFQ@mail.gmail.com>
Date:   Wed, 01 Dec 2021 14:15:01 -0800
In-Reply-To: <CABPp-BERnA+tyP0RTQ-iXcm5wwO5GbjasP3O-MjqSHGauyibFQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 30 Nov 2021 15:52:13 -0800")
Message-ID: <xmqqpmqgyntm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2216BBF4-52F4-11EC-BA13-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Nov 30, 2021 at 6:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * en/zdiff3 (2021-09-20) 2 commits
>>  - update documentation for new zdiff3 conflictStyle
>>  - xdiff: implement a zealous diff3, or "zdiff3"
>>
>>  "Zealous diff3" style of merge conflict presentation has been added.
>>
>>  What's the status of this thing?
>
> I resubmitted it before you added this question, and have pointed out
> the resubmission in response to the past "What's cooking" emails, but
> perhaps it'll be easier for me to just resubmit with no changes.  I'll
> do that.

Thanks.  Yes, for anything that is older than a month, it always is
easier that way.
