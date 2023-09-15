Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D285EED61F
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 18:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbjIOSBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbjIOSBK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 14:01:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02935AC
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:01:03 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B29691BA056;
        Fri, 15 Sep 2023 14:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=WsRwGKA06p1mEnILRQPoAjlJKX2B1uFQtXcrSB
        MpRgQ=; b=lPuMkM2tFn//+mV+ITnveSIHeXo0W2hcHwBTKlFXyBdcNpx7+7DI01
        3+W8Af3RXo0QTURN1Sf8KZljxAszn9WMUoRZ5Q7dt8TvQRDFwsbrvdOfLb2YWw4f
        s1BlPqvxizccNhC5An3RjIyC224zTUU3TMI6e2g5UUol6veUnafw0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93C401BA055;
        Fri, 15 Sep 2023 14:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D56551BA054;
        Fri, 15 Sep 2023 14:00:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [PATCH] doc: pull: improve rebase=false documentation
In-Reply-To: <xmqqh6nvfi2p.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        15 Sep 2023 10:43:26 -0700")
References: <226cc3ed753ee809a77ac7bfe958add7a4363390.1694661788.git.dsimic@manjaro.org>
        <xmqqzg1oinq1.fsf@gitster.g> <owlyedj0jok7.fsf@fine.c.googlers.com>
        <xmqqh6nvfi2p.fsf@gitster.g>
Date:   Fri, 15 Sep 2023 11:00:58 -0700
Message-ID: <xmqq1qezfh9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3B191EA-53F1-11EE-B790-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>>     Supplying "--rebase" defaults to "--rebase=true". Running git-pull
>>     without arguments implies "--rebase=false", unless relevant
>>     configuration variables have been set otherwise.
>
> Phrase nit.
>
> 	$ git pull origin
>
> does run the command with arguments.  What you mean is "running
> git-pull without any --rebase arguments implies --no-rebase", but

A nit of my own: "--rebase arguments" -> "--rebase option"

Sorry for the noise ;-)
