Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACCAC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 18:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778946108B
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 18:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbhKISaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:30:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54733 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbhKISaE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 13:30:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8A0C150959;
        Tue,  9 Nov 2021 13:27:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VEcaZYwjDzoXc0GQorW0h63nSNEf3QE8Ikl8Lz
        SfRSE=; b=DAh5ASFV00dZaOgMeFi58eNof5ROBLINo/SalAKELD5lH1k4RUMqFv
        KbYmb4G3BOoK9bOvFBD3yedgPhjT5T9nsT76igyNrzRMc4Rg0dkn+mv9NoOcFujS
        goBH4b0pLBAizw7w3JHUUWv99n/6JDKIa7sYya0juhA7GMHtivI9Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E4D2150958;
        Tue,  9 Nov 2021 13:27:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DCE86150957;
        Tue,  9 Nov 2021 13:27:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.34.0-rc1
References: <xmqqsfwc4yne.fsf@gitster.g>
        <defd82c5-a197-d52e-8386-c54d7d8e0770@gmail.com>
Date:   Tue, 09 Nov 2021 10:27:14 -0800
In-Reply-To: <defd82c5-a197-d52e-8386-c54d7d8e0770@gmail.com> (Derrick
        Stolee's message of "Mon, 8 Nov 2021 20:41:19 -0500")
Message-ID: <xmqqfss52ni5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA3EC84E-418A-11EC-B09F-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/3/2021 7:17 PM, Junio C Hamano wrote:
>>  * Drop "git sparse-index" from the list of common commands.
>>    (merge 6a9a50a8af sg/sparse-index-not-that-common-a-command later to maint).
> Late correction for the release notes: this should be
>
>   * Drop "git sparse-checkout" from the list of common commands.
>
> It's confusing because 6a9a50a8af (command-list.txt: remove 'sparse-index'
> from main help, 2021-10-24) is the source of the typo and I didn't catch
> it, either.

Thanks.
