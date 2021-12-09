Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DD4C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhLIWsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:48:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59610 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhLIWsP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:48:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EB35168B13;
        Thu,  9 Dec 2021 17:44:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=KiOBWYhuOrhUe83S5GnfXU02e4ojP0QXbwxetC
        1B1GA=; b=JoHw+HHBjLXPxhAxmFeua6jEYVXOZawoUkEdetX/5+qQPQJd7Bu96k
        Ye/vscfGPZWXob2XaaBM/eL4nuVNwm/6T+2TLAlzuXXJirBdvz42fR+WctXT3Nns
        3VfXsiJQroTsIsQS2IlsD5zcsnLDPduLlq+ngnEBM7AdJGlgRitMY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8747E168B12;
        Thu,  9 Dec 2021 17:44:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2A96168B11;
        Thu,  9 Dec 2021 17:44:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] git-p4: Removed support for Python 2
In-Reply-To: <20211209201029.136886-4-jholdsworth@nvidia.com> (Joel
        Holdsworth's message of "Thu, 9 Dec 2021 20:10:26 +0000")
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
        <20211209201029.136886-4-jholdsworth@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 09 Dec 2021 14:44:35 -0800
Message-ID: <xmqqh7bho0to.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96C2C9C2-5941-11EC-A43B-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> Subject: Re: [PATCH 3/6] git-p4: Removed support for Python 2

"Removed" -> "remove".

Losing unused/no longer usable code is good.

> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
>  git-p4.py | 89 +++++++++++++++++--------------------------------------
>  1 file changed, 28 insertions(+), 61 deletions(-)

In these 28 new/replacement lines, there is nothing that deserves
any mention in the proposed log message?
