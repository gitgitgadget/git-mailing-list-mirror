Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17E0C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 20:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbhKXUu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 15:50:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62769 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbhKXUuy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 15:50:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EC52FAB76;
        Wed, 24 Nov 2021 15:47:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j/XKWyJXsvE9gpkDIDFZUiC0NEFHA2fndXFkXL
        fVAlg=; b=SvkYI91vu0xLAWVyxhauecF4T6GPbrNvFksCe0ZLU47WKDJJWq68zJ
        nyIjAUblpf6MODq8IC1SA5zUyGnayo6mQ0CDMm73jldNUY09f8WKLYMd4Jv966s3
        7lTLv7Lga+xH12KzCwyH+8KDoIMCUueC2X2SJWN11RBH3Wlg5Hbtc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55B14FAB75;
        Wed, 24 Nov 2021 15:47:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACEF9FAB74;
        Wed, 24 Nov 2021 15:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>, <git-packagers@googlegroups.com>
Subject: Re: [ANNOUNCE] Git v2.34.1
References: <xmqq7dcx1ent.fsf@gitster.g>
        <000201d7e173$3eb3d320$bc1b7960$@nexbridge.com>
        <000301d7e174$1b568570$52039050$@nexbridge.com>
Date:   Wed, 24 Nov 2021 12:47:42 -0800
In-Reply-To: <000301d7e174$1b568570$52039050$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 24 Nov 2021 15:44:36
        -0500")
Message-ID: <xmqq35nl1dsh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5CE89F8-4D67-11EC-A62C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

>> In an unusual situation, make reports:
>> 
>> GIT_VERSION = 2.34.GIT
>> 
>> Instead of the expected
>> 
>> GIT_VERSION = 2.34.1
>> 
>> which we see usually.
>> 
>> Am I missing a step that was added since 2.34.0?
>
> Oops. I have to build off 'maint' not master. Got it.
> -R.

You made me cut my lunch break short to double check, but all is
well if the release materials are good after all ;-)

