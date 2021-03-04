Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E243C1551C
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223F964E99
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354495AbhCDBDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:03:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58545 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453068AbhCDAoU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:44:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4095CBF0E6;
        Wed,  3 Mar 2021 19:43:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BtICHjEGQ//ReqliIqOgEJfhAcg=; b=plEBYD
        dMSN36GhuwvHyoPrRCqfiOaso/rV/8pIhJuVKwKyfZWcUtsMH3FprzUEBUq/pxeH
        I08pw8nj5332uR4j2SbBZb6sxkXlu511YetbdgLlTNbfqUifMFSJGTkyaFxck3qd
        e5l43a7UAspZgFEzhpIWD1y4WlNa02eNOF78I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PDCdgtleKe6H8bJhdUPfeEW3wq5IL1NC
        aKwGRK12dH5hl6X71tWwoFmtyPvPBwP97vXfZzgCSgSfPxgkFSlnxpiXk27ZK76O
        NCJmaVNcjWgZbnI9YOLPJRTji7jwquBSDsWvKVp7AyjIoHdcIfPZYWAqAiSPaV9X
        zrdK3MpJ//U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 314BFBF0E5;
        Wed,  3 Mar 2021 19:43:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6BB1BF0E4;
        Wed,  3 Mar 2021 19:43:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/2] git-cat-file.txt: doc cleanup
References: <cover.1614062288.git.liu.denton@gmail.com>
        <cover.1614763281.git.liu.denton@gmail.com>
Date:   Wed, 03 Mar 2021 16:43:38 -0800
In-Reply-To: <cover.1614763281.git.liu.denton@gmail.com> (Denton Liu's message
        of "Wed, 3 Mar 2021 01:21:54 -0800")
Message-ID: <xmqqzgzjg345.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9956768-7C82-11EB-A5AE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Denton Liu (2):
>   git-cat-file.txt: monospace args, placeholders and filenames
>   git-cat-file.txt: remove references to "sha1"

Thanks, will queue.
