Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6DD21F667
	for <e@80x24.org>; Thu, 10 Aug 2017 22:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbdHJWsj (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 18:48:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62576 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752135AbdHJWsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 18:48:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54CC6A2CE9;
        Thu, 10 Aug 2017 18:48:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KirC+MPO7n884kY4zDLq4KGr/Ig=; b=CyOarD
        OY53cyknBiSOArMaiTwfLRPlnu7C8x3yPQEr11DqmtsvZgy7neTXMELF9dOAA4hp
        RZ2VA7ppba+KuA9V6iSdNo4HBS9HVCduFnoJ+yGWs0w0zY+2zdQOh3zWVfSYzas9
        tgZ+nkCFpbk1WRJ/2FzEHX9Y+CLq0nX9Opnvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sICJNBtVyaoiWNJIWDiE+T7dH9Xd4Xp9
        ZMrBcXj+mztOukZRc56im06iZ5nkYtTTK/0P0PZWnzED0HM/X9knAcP5n/D5b9Ar
        FT8g0rWap6R4tAQdU0wsYZacwJrQnWDE2w33Lax/oEQzkQLrOMyUkudyUGOlxTkU
        6LXX1U4pMM4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ACC6A2CE6;
        Thu, 10 Aug 2017 18:48:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAA8EA2CE4;
        Thu, 10 Aug 2017 18:48:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 0/2] Add progress for format-patch and rebase
References: <20170531150427.7820-1-kewillf@microsoft.com>
        <20170810183256.12668-1-kewillf@microsoft.com>
Date:   Thu, 10 Aug 2017 15:48:31 -0700
In-Reply-To: <20170810183256.12668-1-kewillf@microsoft.com> (Kevin Willford's
        message of "Thu, 10 Aug 2017 14:32:54 -0400")
Message-ID: <xmqqbmnn11kw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 093BBFEE-7E1E-11E7-BC9C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kcwillford@gmail.com> writes:

> Changes since last patch:
> 1. Use start_progress_delay so progress isn't shown if generating
>    the patches is fast enough
> 2. Updated to have text of "Generating patches"
> 3. Only show progress when the --progress flag is passed
> 4. In the rebase script check stderr and the quiet option is not
>    set before propagating the progress flag to format-patch
>
> Kevin Willford (2):
>   format-patch: have progress option while generating patches
>   rebase: turn on progress option by default for format-patch

Do you have a pointer to the previous discussion handy (if you do
not, that is OK---I think I can dig the list archive myself)?

Also, your patch messages appear from you at gmail yet signed off by
you at microsoft.  Please make them consistent (I can fix them up
while queuing _this_ time, but I do not want forever doing that for
future patches from you or other people).  One easy workaround to do
so without convincing your mailer to put your microsoft address on
the sender's From: line in the e-mail is to put an extra

    From: Kevin Without <kewillf@microsoft.com>

line, followed by a blank line, at the very beginning of the body of
the e-mail message.

Thanks.

