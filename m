Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA194C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjHASaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjHAS37 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:29:59 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FEA2698
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:29:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93A701AF773;
        Tue,  1 Aug 2023 14:29:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KiVSV6psPkJYBdGx0+HqZizrspT38f8MzaVlHF
        xiuis=; b=Aldt+iZHFHRBRiy8X0s6RrAljmwtKcwMjXElri2opnDBGEWW8i48RA
        b2PjH7FvMF313hnUYCvpej72eohjffnrJPTh/kRJBNTxZnIv/cd4SYCKJrG7TBKo
        VF6A7Vop5IaOJE55WRsAPc1yD6vn3RuPg+ef3NS8t3JWjlW0wwzUA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8ADD51AF772;
        Tue,  1 Aug 2023 14:29:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0CDA1AF771;
        Tue,  1 Aug 2023 14:29:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/RelNotes/2.42.0.txt: typofix
References: <ddd69d9a423e02218916cf647f4f167959f48326.1690914016.git.me@ttaylorr.com>
Date:   Tue, 01 Aug 2023 11:29:41 -0700
In-Reply-To: <ddd69d9a423e02218916cf647f4f167959f48326.1690914016.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 1 Aug 2023 14:20:18 -0400")
Message-ID: <xmqqh6piboq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6228BD80-3099-11EE-B490-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Fix a typo introduced in aa9166bcc0 (The ninth batch, 2023-07-08).
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/RelNotes/2.42.0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.

>
> diff --git a/Documentation/RelNotes/2.42.0.txt b/Documentation/RelNotes/2.42.0.txt
> index dd73b28d19..1105b148c8 100644
> --- a/Documentation/RelNotes/2.42.0.txt
> +++ b/Documentation/RelNotes/2.42.0.txt
> @@ -171,7 +171,7 @@ Fixes since v2.41
>     been corrected.
>     (merge a096a889f4 jk/cherry-pick-revert-status later to maint).
>  
> - * A few places failed to differenciate the case where the index is
> + * A few places failed to differentiate the case where the index is
>     truly empty (nothing added) and we haven't yet read from the
>     on-disk index file, which have been corrected.
>     (merge 2ee045eea1 js/empty-index-fixes later to maint).
