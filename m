Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0CEC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7B760FD9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhHKQo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 12:44:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58335 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhHKQo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 12:44:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D325D2198;
        Wed, 11 Aug 2021 12:44:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tDvC5EAQ7tXbBatZ/2sNWcPqt6QCD6QvtyOSa9
        M0K5w=; b=tubcAaAJebdGSIG+Hxy1XZedJDyRW2U5hZ+KL0YM61Nthy0gLvNphw
        I/bRQxIRub45YF5tGmn3VZrcjTU6vGXPT7VadAAxXRNlHEHxk74nf7/lUQC8dTch
        w4zfG9B151zZt3Qw3mJte5PovTewNO3Zv6bYK4fTohjC+DPM2L+l0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65317D2197;
        Wed, 11 Aug 2021 12:44:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAE67D2196;
        Wed, 11 Aug 2021 12:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
References: <xmqqh7fwbx86.fsf@gitster.g> <YRPAsJSfVbNmYh3v@ncase>
Date:   Wed, 11 Aug 2021 09:44:31 -0700
In-Reply-To: <YRPAsJSfVbNmYh3v@ncase> (Patrick Steinhardt's message of "Wed,
        11 Aug 2021 14:21:04 +0200")
Message-ID: <xmqqh7fw9bio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66FE76C8-FAC3-11EB-B46F-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>>  The revision traversal API has been optimized by taking advanrage
>
> These descriptions end up in the release notes, right? If so:
>
>     s/advanrage/advantage/

Thanks.
