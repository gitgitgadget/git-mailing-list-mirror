Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E09C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 18:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0FC60184
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 18:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhG1Sjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:39:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52719 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG1Sjo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 14:39:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 491EBE36AA;
        Wed, 28 Jul 2021 14:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7a0mv5zrDc109etHO0YBmyBzjrnxS2MFWlw7ZM
        BN7VA=; b=PCLWgI+IDVPTrb18r1jrTrNv37OBaqlsWSRs9IYidmbUvwdkPULVPX
        v5YhtZq7uj9m0/4k24I3coRkorEt33lFEUmBjGZKZMRIb0P4kcWp54ZmeARaIUjQ
        KIzDccmZvUU2U/bGgACmHy8okO4Jl7TbyD+JKlkMM1NQnYiRbXp0Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40202E36A9;
        Wed, 28 Jul 2021 14:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFDE7E36A8;
        Wed, 28 Jul 2021 14:39:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Boeckel <mathstuf@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] config: support setting up a remote tracking branch
 upon creation
References: <20210728135041.501850-1-mathstuf@gmail.com>
        <20210728135041.501850-2-mathstuf@gmail.com>
        <xmqqim0u9vnb.fsf@gitster.g>
        <YQGhSTc9NoB4xEGA@erythro.dev.benboeckel.internal>
Date:   Wed, 28 Jul 2021 11:39:40 -0700
In-Reply-To: <YQGhSTc9NoB4xEGA@erythro.dev.benboeckel.internal> (Ben Boeckel's
        message of "Wed, 28 Jul 2021 14:26:17 -0400")
Message-ID: <xmqq5ywu9tar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BDDD336-EFD3-11EB-BCFA-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> writes:

> Hopefully this gives a clearer picture of where I'm coming from.

I think you gave descriptions to a reasonable level of detail to
explain what your expected workflow is, to what extent the current
tools support the workflow already, and what are still missing (and
you want to extend the system to help).

The reason I asked these questions is to make sure that future
readers of "git log" after your contribution becomes part of our
history will not have to ask them (as you won't be as readily
available to answer their questions).  So please don't be content
just because you answered and helped _me_ understand where you're
coming from.  Make sure an updated documentation and proposed log
message explains them well to our future readers without your
assistance.

Thanks.

