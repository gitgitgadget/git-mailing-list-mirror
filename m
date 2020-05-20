Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD2C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 15:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EC72070A
	for <git@archiver.kernel.org>; Wed, 20 May 2020 15:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bLHZopw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgETPyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 11:54:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54265 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgETPyu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 11:54:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47EC55E18D;
        Wed, 20 May 2020 11:54:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PpaYqhO6dhTCs6fQ6l++PgTNkw0=; b=bLHZop
        w3GE1kBtmTlHuJXN6g5PUOEetht0d9t3E5Ir8Mxdmtb5/sVtykZSMGJKoeBvpz3W
        hQkanG3b1/1xQXhsCgb00RdcGpgN5RJEmnoJZ1KdJB8alQR/V4sFHC1A/y/2eKUF
        8kUbwHwntGrNmDhVqnsZl7l5DB675mPpzA23k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eBd7MO8yh3pGbFQjVg3S/awplQ1tm95K
        dufgD3+aDFnyCTKmLJvWtfVnL3tmCfGpW+VO8sQA1nYk3ygGF+329y4PTuXBlPRG
        hTW2MqR61+L6xRf0p1U2Wanc7KiJBLMFFWTgt0DE1HlU7NtG+nqJAW/CMezlKpl4
        TPzIsjrTNzA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DF565E18A;
        Wed, 20 May 2020 11:54:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 995405E188;
        Wed, 20 May 2020 11:54:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] command-list.txt: add gitfaq to the list of guides
References: <pull.639.git.1589985889076.gitgitgadget@gmail.com>
Date:   Wed, 20 May 2020 08:54:48 -0700
In-Reply-To: <pull.639.git.1589985889076.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Wed, 20 May 2020 14:44:48 +0000")
Message-ID: <xmqqimgqwqif.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C691F48-9AB2-11EA-B796-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> When 'gitfaq.txt' was added in 2149b6748f (docs: add a FAQ, 2020-03-30),
> it was added to the Makefile but not to command-list.txt.
>
> Add it there also, so that the new FAQ is listed in the output of
> `git help --guides`.

Thanks for sharp eyes.

Will queue, but it may be post -rc1.

