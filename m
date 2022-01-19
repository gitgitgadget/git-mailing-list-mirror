Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5E8C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbiASA0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:26:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52976 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350480AbiASA0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:26:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 239B016D66D;
        Tue, 18 Jan 2022 19:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t9Q1E8SuKccAADNDw1MsUorxOunx1+Jb00n1Ts
        Um+oM=; b=HxcX3ptuaVU/HOMjlt5XvFulwLBfqxGJYPpFjyyFxun2SHVSUWi8SY
        9YZs2MxUzbW5YcEEeTv1EhhsMibACHX9iBLX8ePBhME18zX5wWUBunATUKjBY7yb
        L+iulPePRtzlQMh0Et3q7lYCKOJXxj3AkmAwbiRgxacq1nTbesv7A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CB1616D66C;
        Tue, 18 Jan 2022 19:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8734D16D66B;
        Tue, 18 Jan 2022 19:26:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 3/3] fetch --negotiate-only: do not update submodules
References: <20220113004501.78822-1-chooglen@google.com>
        <20220118185453.33710-1-chooglen@google.com>
        <20220118185453.33710-4-chooglen@google.com>
        <xmqqtue0r978.fsf@gitster.g>
        <kl6lpmooy5lq.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 18 Jan 2022 16:26:01 -0800
In-Reply-To: <kl6lpmooy5lq.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 18 Jan 2022 15:41:21 -0800")
Message-ID: <xmqqpmoopo4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 620B90D2-78BE-11EC-B1A8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Ah, I misunderstood. I'll blame the fact that I'm recovering from
> COVID ;) I'll remove the block from the "case".

Thanks.  Take it easy and be safe.

Will queue the updated one.  It looks good to me otherwise; unless I
hear otherwise from others, let's have it in 'next' soon, and
include it in the first batch after the current cycle.

