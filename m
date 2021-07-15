Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D2C636CA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 19:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3C4613FB
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 19:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbhGOTHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:07:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51981 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbhGOTGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 15:06:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3D63D3990;
        Thu, 15 Jul 2021 15:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3fK63Fr1dFYq
        JT2BxzbbPpHsiZSWr4/f3iPQ02DcQKE=; b=LSAQdIgMTNSadcnc5w6q1CmiftNH
        NCY3xLDc0O5a/suxN0FDoGYgsDcdzFHVQt6payW+XAwZyxEmBM/D5Y87JWUMbbJH
        7MEBYLx9SiRZMOT99GAq8FIME/bxscviDJ1ybVnDyo3sOSznkWJI/RWpqvXuOrjt
        3stNXfPV1/dEWrs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA12CD398F;
        Thu, 15 Jul 2021 15:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53372D398E;
        Thu, 15 Jul 2021 15:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, emilyshaffer@google.com
Subject: Re: [PATCH v2 0/3] Push negotiation fixes
References: <cover.1624486920.git.jonathantanmy@google.com>
        <cover.1626370766.git.jonathantanmy@google.com>
Date:   Thu, 15 Jul 2021 12:03:47 -0700
In-Reply-To: <cover.1626370766.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 15 Jul 2021 10:44:29 -0700")
Message-ID: <xmqqtukvs8ks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 62B5D9F0-E59F-11EB-909B-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks, Emily and =C3=86var for your reviews. There are no changes to C=
 code
> in this version of the patch set, but the tests have been updated
> following both your comments.

Thank you all.

Will queue.
