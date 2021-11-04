Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C168C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0743561168
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhKDRj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:39:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64789 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbhKDRjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 13:39:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB3FD16DA6F;
        Thu,  4 Nov 2021 13:36:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=P4UECUCSML09
        /hzEBGoeWGl9uAAXlRS328BgJNHyiB4=; b=VuHag4RgDAq+uXJNSeVjivD2wWiP
        PcfMV+fO/MmCt7iVVmvnCkR8pB2WVytmN842phRnpz2ZNcyLDEkoCrlbtuEqcHZ/
        qvOzzj3PPaoyzFuW3PbvxjaaQ6fdR+vsTHZoSTQQT7BDA7EfZJJt+ppsbvDBoSlR
        2xz/pGOy17u9Kgs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2BC416DA6E;
        Thu,  4 Nov 2021 13:36:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9597716DA6D;
        Thu,  4 Nov 2021 13:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
        =?utf-8?Q?Jean?= =?utf-8?Q?-No=C3=ABl?= AVILA 
        <jn.avila@free.fr>,
        =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Eli Schwartz <eschwartz@archlinux.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in
 placeholders
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
        <ee376004-a4dd-539d-28b3-3fc5baa6fe00@archlinux.org>
        <2803948.JoDkH9avOM@cayenne> <xmqqmtmocqz4.fsf@gitster.g>
        <0b404448-cd4b-8614-2c49-c4683b56879f@gmail.com>
        <xmqqlf258aq3.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111040134110.56@tvgsbejvaqbjf.bet>
Date:   Thu, 04 Nov 2021 10:36:42 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2111040134110.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 4 Nov 2021 01:38:03 +0100 (CET)")
Message-ID: <xmqqh7cr3jrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C6CB232A-3D95-11EC-B3D7-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:
>> ...
>> > Agreed. Should reroll the patch series?
>>
>> I guess another (hopefully the final) reroll would not hurt (but we
>> are not in hurry---this may be among the topics that graduate early
>> in the next cycle, but not during this cycle).
>
> I fear that it won't be as easy to send the next iteration as one might
> think: GitGitGadget works off of open Pull Requests on GitHub. And ...
> ...it into the cover letter, then send a "v3" (which is actually a v1).

I see Jean-No=C3=ABl is a long-time community member whose contribution
dates back to 2012, which presumably predates GGG, so I suspect that
"contributors who use GGG cannot send a series without it" would not
apply here.
