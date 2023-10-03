Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAEBE75459
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjJCSmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJCSmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:42:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656D995
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:42:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24C0A1B7A85;
        Tue,  3 Oct 2023 14:42:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wptoCW3v/0Lq
        m0GgRIGwIwKh3nRRCm0EWePSpXCjwNc=; b=UGCJam7RR5ZAnznDMzbhiXQqUowy
        Yi/DRloWRHbkDRC3NUNKbmokfHvXbLjPqlZ29lTnw+DwMynz4eD5E/2BzYosFvFn
        hodLfEeU1jPRHWZ0dZSqvax1mkxI2mb8DGROhvLOvEsW8wn35Aqk+tMxjPcF4V1N
        Z01Wufg04HT+eEE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A9621B7A84;
        Tue,  3 Oct 2023 14:42:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F35C1B7A83;
        Tue,  3 Oct 2023 14:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ach.lumap@gmail.com, git@vger.kernel.org,
        christian.couder@gmail.com
Subject: Re: [PATCH 1/1] t2400: avoid using pipes
In-Reply-To: <CAPig+cSkZ_brRh_ijFRgz3sP9ou5se9-xeRg=C+cV3c3-v3Wtg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 3 Oct 2023 14:01:13 -0400")
References: <20231003174853.1732-1-ach.lumap@gmail.com>
        <20231003174853.1732-2-ach.lumap@gmail.com>
        <CAPig+cSkZ_brRh_ijFRgz3sP9ou5se9-xeRg=C+cV3c3-v3Wtg@mail.gmail.com>
Date:   Tue, 03 Oct 2023 11:42:30 -0700
Message-ID: <xmqqr0mbzgx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9C44552E-621C-11EE-844D-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Oct 3, 2023 at 1:49=E2=80=AFPM <ach.lumap@gmail.com> wrote:
>> t2400: avoid using pipes
>
> Pipes themselves are not necessarily problematic, and there are many
> places in the test suite where they are legitimately used. Rather...
> ...
> readers of `git log --oneline` (or other such commands), a better
> subject for the patch might be:
>
>     t2400: avoid losing Git exit code
>
> That minor comment aside (which is probably not worth a reroll), the
> commit message properly explains why this change is desirable and the
> patch itself looks good.

Thanks for writing and reviewing.  Will queue.
