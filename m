Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567BDC001B0
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 17:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjHNRLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 13:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjHNRKp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 13:10:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D691DE65
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 10:10:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 474311983A8;
        Mon, 14 Aug 2023 13:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=49XBDBzVe/pp+uNDIxdJOTuTaFacJCracFdBzi
        YqBFA=; b=tXRk/HQxn2YBc+DIBB1v6GAMtNIlWa7TLKBAVBgDn9FTadclki72jx
        j3MduRoXUU0hyF3RG7f2BhTO6fMcj04Spp/dPFsTauPL3qXNxVC8zhsAe+BNO1pQ
        Xsbp2DWLnY7rV/USXHqYAFhXM+wCo1pciMlJGq7Rtpa84pGkAY5PQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F0F91983A6;
        Mon, 14 Aug 2023 13:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C9A71983A5;
        Mon, 14 Aug 2023 13:10:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 0/3] check-attr: integrate with sparse-index
References: <20230718232916.31660-1-cheskaqiqi@gmail.com>
        <20230811142211.4547-1-cheskaqiqi@gmail.com>
        <3b2a5b4b-ab8f-746b-6b69-8e8262b6390b@github.com>
Date:   Mon, 14 Aug 2023 10:10:42 -0700
In-Reply-To: <3b2a5b4b-ab8f-746b-6b69-8e8262b6390b@github.com> (Victoria Dye's
        message of "Mon, 14 Aug 2023 09:24:30 -0700")
Message-ID: <xmqq4jl1lfcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80A8B306-3AC5-11EE-A42E-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Shuqi Liang wrote:
>> change against v4:
>
> I've reviewed the patches in this version and all of my prior feedback
> appears to be addressed. Overall, I think this is ready to merge. 
>
> I see that you didn't take the suggestion from [1], though. I personally
> don't consider it a blocking issue, but I am curious to hear your
> thoughts/reasoning behind sticking with your current patch organization over
> what was suggested there.
>
> [1] https://lore.kernel.org/git/kl6la5v82izn.fsf@chooglen-macbookpro.roam.corp.google.com/
>
> Otherwise, a couple notes:

Thanks for a review Victoria, and Shuqi, thanks for working on the
topic.

I too am curious what your response to [1] would be, by the way.

