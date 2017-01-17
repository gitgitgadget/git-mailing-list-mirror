Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF5720756
	for <e@80x24.org>; Tue, 17 Jan 2017 20:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbdAQUm5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 15:42:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54333 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750830AbdAQUls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 15:41:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00D4A616A0;
        Tue, 17 Jan 2017 15:36:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4imLzHlwmS4/ufARXPtSN6FtwZ0=; b=b3Xbpz
        iLspuLrpuGPTgMT6lEBnKc0i93zD47pcsSaTbHuPR765fqElfyXSLZJSKAmwcGLq
        TaY6dGeEUIM/uz+H3qyeS+al671OKRXtCdYe3SRWxxHbeKK3nt7wcH8JodEtaOMK
        PJLTcVNJ+H6SuLA2M4ZiteMNiHB3WcuCjiSAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gEZ+Bp3n42xanYL/t8jTjRZxbWBFYrzQ
        TYKSdNRAJ+9Iv1PS7jArGDjzJb6kXsdfscOx8nS695rab/LjaxvoatI/O1w3v4hc
        iNF9vln15Whke4VhapJcvtsbSHGmu33n4n1cRFg7kqDuXKaEw45WD9lpN1wRxLIK
        jH2eJUGPXeM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED60C6169F;
        Tue, 17 Jan 2017 15:36:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3DE3D6169E;
        Tue, 17 Jan 2017 15:36:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] documentation: remove unfinished documentation
References: <20170117200147.25425-1-sbeller@google.com>
Date:   Tue, 17 Jan 2017 12:36:15 -0800
In-Reply-To: <20170117200147.25425-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 17 Jan 2017 12:01:47 -0800")
Message-ID: <xmqqpojle85c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98A840C4-DCF4-11E6-90F8-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When looking for documentation for a specific function, you may be tempted
> to run
>
>   git -C Documentation grep index_name_pos
>
> only to find the file technical/api-in-core-index.txt, which doesn't
> help for understanding the given function. It would be better to not find
> these functions in the documentation, such that people directly dive into
> the code instead.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> I run into this a couple of times now, so I put this out tentatively.

These placeholders are meant to encourage those people who dove into
the code to update it, so from that point of view, I think removing
it is backwards.
