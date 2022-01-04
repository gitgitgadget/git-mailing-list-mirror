Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0643C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 20:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiADULK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 15:11:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63832 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiADULJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 15:11:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E3F711505B;
        Tue,  4 Jan 2022 15:11:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hPfHEfNugEh7ywpMJKmLF41fxW0tMTFJVQ8y+g
        kXpfk=; b=WC1o5gltxE+Xd2cimLnqJ91i2jmGzw0rWNACyct8XUFU18TO2uwMPS
        VvZ0TfRTXZUwflQAFNsI4z0h28IbeN2FPObzr8yQIwXkGzxiUYmHdGaQ5r84BMWZ
        m2/wUfWwHaOTNYzvBaXBfGVn96on3ba36bybZgqOMv3RRd/ifx5LE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3516411505A;
        Tue,  4 Jan 2022 15:11:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69BF2115059;
        Tue,  4 Jan 2022 15:11:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, lenaic@lhuard.fr
Subject: Re: lh/use-gnu-color-in-grep, was Re: What's cooking in git.git
 (Jan 2022, #01; Mon, 3)
References: <xmqqsfu4duxl.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201041458150.7076@tvgsbejvaqbjf.bet>
        <25d00bcb-3345-c221-6a38-593f23f942f3@gmail.com>
Date:   Tue, 04 Jan 2022 12:11:06 -0800
In-Reply-To: <25d00bcb-3345-c221-6a38-593f23f942f3@gmail.com> (Philippe
        Blain's message of "Tue, 4 Jan 2022 13:06:25 -0500")
Message-ID: <xmqqbl0rcld1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74424C3E-6D9A-11EC-9AFA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> FWIW I am in favor of adjusting Git's `grep` colors to GNU's
>> version. From
>> the users' perspective, it provides more consistency and less unexpected
>> surprises.
>
> For what it's worth, I'm also in favor of that change. It's been
> in my todo list of possible enhancements for a little while. I
> agree with Dscho that it's more consistent for users to have the
> same default colors as GNU grep.

I am not a huge fan of adjusting our defaults to other people's
default, since they can match ours to "have the same default", if
they wanted to.  Also we are risking complaints from those who would
say "We've been happily using the default coloring, and you suddenly
changed it to something ugly. We want our color back and we do not
care that now you match what GNU does".

But it seems that I won't have to be the one who need to field such
complaints, and instead we have at least two well-known people in
the list who volunteered for the role, so let's take it as-is.



