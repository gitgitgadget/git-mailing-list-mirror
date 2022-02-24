Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9039BC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 19:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiBXTzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiBXTzq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 14:55:46 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2676725D6EC
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 11:55:16 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91D9C10D265;
        Thu, 24 Feb 2022 14:55:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=11rYtv+1QaFmSsRXWtSAASkEp3r4JOIQWZaLo5
        Lfoo4=; b=QeDFtHeFkjmTMav1fpJH84YmUEz/35kgRpanSOEL1yPaCFFB+69ZcJ
        4+KP8vQxG3d8tOrWP5rTV5P/HiibnqHOBpXMrWC9PQa/KRXQjdltv0vzxBy6Q+Io
        UdMGLmD0d+ErvND/pqQqoQ+vPu30wrYaYcLc109YXGj0iJ6GIJ0Ho=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6092A10D262;
        Thu, 24 Feb 2022 14:55:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F3E110D261;
        Thu, 24 Feb 2022 14:55:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: ar/submodule-update (wa Re: What's cooking in git.git (Feb
 2022, #06; Wed, 23))
References: <xmqq1qztortk.fsf@gitster.g>
        <kl6lmtig40l4.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 24 Feb 2022 11:55:06 -0800
In-Reply-To: <kl6lmtig40l4.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 25 Feb 2022 01:48:55 +0800")
Message-ID: <xmqqo82wkpk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB9D42AE-95AB-11EC-B90E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I've dug a little deeper, and I think my plan to reroll this as two
> series [1] makes sense:
>
> 1. Small, obvious conversions from sh->C.
> 2. Finalizing the conversion.
>
> (1) has only trivial conflicts, and is relatively easy to review, so I
> expect that to go through quickly.
>
> This should also buy some time to finalize those other topics and
> hopefully make coordination simpler.

Wonderful.

