Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D69C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794FD20870
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bNQdYjLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKBWhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:37:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57384 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgKBWhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:37:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46444102288;
        Mon,  2 Nov 2020 17:37:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZgZ1JDrwERiDNYqkOKhLbU9fA9Y=; b=bNQdYj
        Lwx7tAcIPL1sz3MkRmJ+rg2XWgFDLTKJQt5kLM1qW+2m1GEKC7cxwjwokr0p18P2
        9fpXpxaG2tRw2Qqw5qfeNY+23WlScnkqt50mPP/Q97T5IpiP/plq+ynHrDwkG1+f
        BF/0ns8QsJASGmL4fI10NoJqo+cdLCG+7E1Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IepleneKeT+eC0y269pQwunruDh7hVm/
        1sYWIrRVRkEFj7oxZA1kDg5LIQALIog0heiF6dD73OJYgsSO+tVlQC2denIpEJZ/
        e9Qt/x3RVujY206Z3R5E4Ns5JM1IpJMacJ7tFOXoBb4gEWYMgMmioCyxc9m6D2tj
        Jz4IPEazsNE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23CCE102287;
        Mon,  2 Nov 2020 17:37:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0980C10226F;
        Mon,  2 Nov 2020 17:37:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?0JvRkdGI0LAg0J7Qs9C+0L3RjNC60L7Qsg==?= 
        <lesha.ogonkov@gmail.com>, Stefan Haller <lists@haller-berlin.de>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH] Fix zsh installation instructions
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
        <xmqqr1to8dv9.fsf@gitster.c.googlers.com>
        <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
        <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
        <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de>
        <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
        <xmqqwnzbbfsi.fsf@gitster.c.googlers.com>
        <CAMP44s2DR=pV3frOePMbSyikA-KonZ5XWD7o5SqKhUbzohAFtQ@mail.gmail.com>
        <xmqqtuuc7wgu.fsf@gitster.c.googlers.com>
        <CAMP44s1+bJMrmJWeAQx18S-=spoKb0BmzWyJ4WgzuE+rNuf0cg@mail.gmail.com>
Date:   Mon, 02 Nov 2020 14:37:17 -0800
In-Reply-To: <CAMP44s1+bJMrmJWeAQx18S-=spoKb0BmzWyJ4WgzuE+rNuf0cg@mail.gmail.com>
        (Felipe Contreras's message of "Mon, 2 Nov 2020 14:49:51 -0600")
Message-ID: <xmqq7dr3s7vm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F724F9D4-1D5B-11EB-8271-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This should be enough:
> ---
> autoload -U compinit && compinit
> ---
>
>> Makes sense.  Instead of adjusting my rerere database for that,
>> ejecting lo/zsh-completion topic would be easier---what the other
>> half of that patch does is already in your 29-patch series.

Your 29-patch series is now in 'next'; I have this feeing that
nobody around here would offer any meaningful reviews on it, so it
may graduate sooner than the usual topics.

Thanks.
