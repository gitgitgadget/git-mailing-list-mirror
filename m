Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7126C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 18:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7211120674
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 18:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ttYKzPeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBEStS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:49:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52583 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBEStS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 13:49:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41678B63E9;
        Wed,  5 Feb 2020 13:49:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+m7s8jXwBhir/wRbOdxyB6MAKYw=; b=ttYKzP
        eAb4vzrvjWreFcQjNNgtTbAixP4+XFX2QSoDTbQTzv8YU9XfcaWGDLFy3hkRRUQp
        9uRhdNTNnJu5S9QP3alUZufkoYOPEpJjXlDC6NdMcOCON2DIAdjLg1Xxq+zErmWy
        8mG8U3N9MyEUAYWu+FW0Q5PuJfzkecN3b7ru0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jkkBiEFQc7/fkCSarjT/A05cyh76uxrb
        9TgO68mZwoOT0mK4LAgmLbzwhr13TY+etkiAG6ZqUIAfYevBfR6RwG44+ET9rQCS
        u2PkrV3V7nRBHtjYUMq8BOwkuQqUpVNHrT5oX1+iLNficKVP6qkTagiqYmK97ZEz
        PDcsobMSL7U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39429B63E7;
        Wed,  5 Feb 2020 13:49:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5A77BB63E4;
        Wed,  5 Feb 2020 13:49:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] parse-options: lose an unnecessary space in an error message
References: <010201671ebf523a-da55f2d8-876a-4b3b-a6fe-29d790bed2c1-000000@eu-west-1.amazonses.com>
        <0102017015765b98-e2e26f61-dd07-4a32-a72f-2d7b2159fffe-000000@eu-west-1.amazonses.com>
Date:   Wed, 05 Feb 2020 10:49:10 -0800
In-Reply-To: <0102017015765b98-e2e26f61-dd07-4a32-a72f-2d7b2159fffe-000000@eu-west-1.amazonses.com>
        (Jacques Bodin-Hullin's message of "Wed, 5 Feb 2020 13:07:23 +0000")
Message-ID: <xmqqv9ok6fa1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33E73330-4848-11EA-B80E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com> writes:

> Signed-off-by: Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com>
> ---
>  parse-options.c          | 4 ++--
>  t/t0040-parse-options.sh | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index b42f54d48b96c..71dbe84d896b4 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -420,7 +420,7 @@ static void check_typos(const char *arg, const struct option *options)
>  		return;
>  
>  	if (starts_with(arg, "no-")) {
> -		error(_("did you mean `--%s` (with two dashes ?)"), arg);
> +		error(_("did you mean `--%s` (with two dashes)?"), arg);

Makes sense.  Not just there is an extra SP before the question
mark, the question mark is about the whole sentence, so pushing
it out of the parentheses also is a good change.

We might even want to lose the parentheses altogether, i.e.

	did you mean `--%s` with two dashes?

Hmm?

Thanks.
