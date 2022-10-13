Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF36C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 20:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJMUfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 16:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJMUfa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 16:35:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EADB1DD2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 13:35:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92E4F158DBF;
        Thu, 13 Oct 2022 16:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gfk870fwgbnqVytCVBJht2+KQdLUCYdzqv4NN5
        Px1aM=; b=tzqYohy5aN3YZL/K1FfxnG371S3OmnVGOYnFryT0VWzeNI33VeZo7s
        OaBVaCYU4ESi/hI7NKerV1umbJdkMLztyNv8hPfwsIHJX1IX10AAttq1Py5De2E7
        q0uQ+zPyNv5s+mvmYm2cWVDeYO7tvzfNMfp+Cs+vsiMzPsYDKzAjg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A125158DBE;
        Thu, 13 Oct 2022 16:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF268158DBC;
        Thu, 13 Oct 2022 16:35:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        vdye@github.com
Subject: Re: [PATCH 0/4] midx: trace2 regions and grab-bag patches
References: <cover.1665612094.git.me@ttaylorr.com>
        <fa47a48b-6da7-a456-05d6-cd5c17b159c3@github.com>
Date:   Thu, 13 Oct 2022 13:35:23 -0700
In-Reply-To: <fa47a48b-6da7-a456-05d6-cd5c17b159c3@github.com> (Derrick
        Stolee's message of "Thu, 13 Oct 2022 09:10:16 -0400")
Message-ID: <xmqq1qrbfoms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90E131E6-4B36-11ED-A297-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 10/12/2022 6:01 PM, Taylor Blau wrote:
>> Here is a small handful of MIDX and MIDX bitmap-related patches that
>> I've been carrying in GitHub's fork for a while now and forgot to send
>> upstream.
>> 
>> The first is a small typofix, and the second is a legitimate bug fix
>> which allows us to consider annotated tags as bitmap candidates during
>> commit selection. The final two are trace2 regions and instrumentation
>> that I've found helpful when rolling out MIDX bitmaps in a production
>> setting.
>> 
>> Sorry that these are so disjointed in nature ;-). I figured that it was
>> better to send a grab-bag series like this than to hold onto these
>> patches forever!
>
> As advertised, this set of patches are all nice and small. I've found
> the additional tracing useful during performance investigations and
> unobtrusive otherwise.
>
> Though they looked familiar, I gave them a careful read and have no
> comments. LGTM.

Yeah, they look good to me, too.

Thanks, both.
