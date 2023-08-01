Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08B5C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjHASoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHASoV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:44:21 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191F92689
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:44:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54F8621EB4;
        Tue,  1 Aug 2023 14:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8MupRiamnjX46THyyvwdqNdLf5VGCejeQIgvO2
        QIP5g=; b=IL8NsMTtyqeyCK0k3OGU1ANbzHGmBqP8gKNmTy3iKNR2dfKRM9/6KO
        RgVFbsry3FZN/f3k6DHRqbj+Xan/Vp5i8Q8iXUkH3dlWto25QxOaNKgTX08i3kiJ
        OmU5zoBjSXgFz3FS5K3qrQ/rA5isJ+hq0Dsk9+G2aDhae9xVdzaN8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D79421EB3;
        Tue,  1 Aug 2023 14:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37D0121EB0;
        Tue,  1 Aug 2023 14:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v7 0/7] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1690912539.git.jonathantanmy@google.com>
Date:   Tue, 01 Aug 2023 11:44:06 -0700
In-Reply-To: <cover.1690912539.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 1 Aug 2023 11:41:35 -0700")
Message-ID: <xmqqbkfqbo21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65E21F14-309B-11EE-8ED5-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Taylor also suggested copying forward Bloom filters whenever possible
> in this patch set [3], but also that we could work on this outside this
> series [4]. I did not implement this in this series.

I think it is a good place to stop, as it would merely be a quality
of implementation difference and would not change the transition
story very much.

Thanks for working well together.  Will queue.
