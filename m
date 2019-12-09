Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42462C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34922068E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pivPMi00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIUag (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:30:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53623 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIUaf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:30:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8ED083F418;
        Mon,  9 Dec 2019 15:30:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8eU5kCBLcGFUDgleB6Sj2CvBlR8=; b=pivPMi
        00pkziohaUEZDGMsywzKz/MX/vwa9xYGG2a+sgGle1vLDMn4qwS08sW9gFoI0nQh
        OmV0fxdu0LeQmCIGtkHJQJGpB5BAuN1VuOpoYOl8TYjY/OJk+j6kpTJnkw+CPx0M
        ZAK7w0Ols7J20ZNrBO2fBzw/Q7VGJLFQUWXO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QLWdOPVkJeYaeBsdomyEyPFxWjVti7z0
        7icP5o+4SgWZi/BGUKLfOqUfv16tR1QUOQwZhPjdlWop5eGfbk+9DL1w2sRCNjFF
        Sx01imKffaexPdhHdSppXdBWjI4k5GJv1/6cOnbUR4qJf4h/FUQ73qi5Z5bT2sGb
        wGUhAmIwYm4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 869733F416;
        Mon,  9 Dec 2019 15:30:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEE823F415;
        Mon,  9 Dec 2019 15:30:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] l10n: minor case fix in 'git branch' '--unset-upstream' description
References: <20191208092647.7588-1-dimitriy.ryazantcev@gmail.com>
Date:   Mon, 09 Dec 2019 12:30:31 -0800
In-Reply-To: <20191208092647.7588-1-dimitriy.ryazantcev@gmail.com> (Dimitriy
        Ryazantcev's message of "Sun, 8 Dec 2019 11:26:47 +0200")
Message-ID: <xmqq4ky9utqw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFA29E22-1AC2-11EA-9FCD-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com> writes:

> Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
> ---
>  builtin/branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 2ef214632f..d8297f80ff 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -624,7 +624,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
>  			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
>  		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
> -		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("Unset the upstream info")),
> +		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("unset the upstream info")),
>  		OPT__COLOR(&branch_use_color, N_("use colored output")),
>  		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
>  			FILTER_REFS_REMOTES),

Consistency is good.  Thanks.
