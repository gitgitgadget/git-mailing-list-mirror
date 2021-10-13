Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E83EC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0181560ED4
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhJMSHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:07:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58250 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJMSHO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 14:07:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5B65EF1C1;
        Wed, 13 Oct 2021 14:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=blQiH7ShGnhHIm406TT0NSPaA36axZMCI+uPTT
        NSsXU=; b=uU+PruoNu7IIdRV9q4TM1tyl0a1war7i9TaOz8xeEnpab0lXNa98tx
        q83r55la+ROTyzxc+4aqNlakPi6yuNIkoNworbs5yryaLmXzsdEm3UA40ewrikhN
        jwvKFsYcos/HMtKvsPcE5PLiWAhyjTVhq0w892qaLi0+Khols5hqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCEB2EF1BE;
        Wed, 13 Oct 2021 14:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 453B3EF1BD;
        Wed, 13 Oct 2021 14:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] doc: add bundle-format to TECH_DOCS
References: <20211013032852.959985-1-tmz@pobox.com>
Date:   Wed, 13 Oct 2021 11:05:09 -0700
In-Reply-To: <20211013032852.959985-1-tmz@pobox.com> (Todd Zullinger's message
        of "Tue, 12 Oct 2021 23:28:52 -0400")
Message-ID: <xmqqh7dkhkbu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AF6F93A-2C50-11EC-BC6B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> A link to the bundle-format was added in 5c8273d57c (bundle doc: rewrite
> the "DESCRIPTION" section, 2021-07-31).
>
> Ensure `technical/bundle-format.html` is created to avoid a broken link
> in `git-bundle.html`.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>
> Hi,
>
> While building 2.33.1, I noticed the link to technical/bundle-format in
> git-bundle(1) was broken.
>
>  Documentation/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index f5605b7767..2021568cd5 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -90,6 +90,7 @@ SP_ARTICLES += $(API_DOCS)
>  TECH_DOCS += MyFirstContribution
>  TECH_DOCS += MyFirstObjectWalk
>  TECH_DOCS += SubmittingPatches
> +TECH_DOCS += technical/bundle-format
>  TECH_DOCS += technical/hash-function-transition
>  TECH_DOCS += technical/http-protocol
>  TECH_DOCS += technical/index-format

Thanks.
