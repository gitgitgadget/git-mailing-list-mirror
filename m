Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95215C77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 22:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245684AbjEOWAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 18:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245642AbjEOV7q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 17:59:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2787411D9F
        for <git@vger.kernel.org>; Mon, 15 May 2023 14:59:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6807E196563;
        Mon, 15 May 2023 17:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Sx/exAdWWAHp
        H/bZw6PDCK0C97VaafV/L9JEkIDXsfI=; b=e5DebXUjzCdPbLFkqoiZJv2gJbUn
        dla9iMmstXL7zxXKDP3vJOVkbdHYFjSU+bTEZg1QSPJJeU0ojKw5Bj+LV/Aq88uE
        0LX+uyz64ca8JCh2XTRelTFdr1GH1os8VQo/OWAQQF+wjZTNDL4J8Mga56vQiOsH
        zT5rk5RVrLBaf6A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 617F0196562;
        Mon, 15 May 2023 17:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA86219655B;
        Mon, 15 May 2023 17:59:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] doc: tag: document `TAG_EDITMSG`
References: <cover.1684067644.git.code@khaugsbakk.name>
        <cover.1684181855.git.code@khaugsbakk.name>
        <0e0e592853d272a28fb04c5183784339d7377547.1684181855.git.code@khaugsbakk.name>
Date:   Mon, 15 May 2023 14:59:16 -0700
In-Reply-To: <0e0e592853d272a28fb04c5183784339d7377547.1684181855.git.code@khaugsbakk.name>
        (Kristoffer Haugsbakk's message of "Mon, 15 May 2023 22:29:33 +0200")
Message-ID: <xmqq353x8de3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD2053F8-F36B-11ED-83F2-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Document `TAG_EDITMSG` which we have told the user about on unsuccessfu=
l
> command invocations since commit 3927bbe9a4 (tag: delete TAG_EDITMSG
> only on successful tag, 2008-12-06).
>
> Introduce this documentation since we are going to add tests for the
> lifetime of this file in the case of command failure and success.
>
> Use the documentation for `COMMIT_EDITMSG` from `git-commit.txt` as a
> template since these two files share the same purpose.[1]
>
> =E2=80=A0 1: from commit 3927bbe9a4:
>
>      =E2=80=9C This matches the behavior of COMMIT_EDITMSG, which stays=
 around
>        in case of error.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Cc: Jeff King <peff@peff.net>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

Excellent.

