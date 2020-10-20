Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0994CC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91AA121BE5
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 18:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dXI0sJRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437774AbgJTSwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 14:52:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60677 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437760AbgJTSwt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 14:52:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2807185CC4;
        Tue, 20 Oct 2020 14:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8gBPUCVCky5Zeh4rGzU33wvDoSo=; b=dXI0sJ
        RVDbnIfYYvDPqTVEJNRQxwbSLVkr8hTz9KjQCeaWHARaiv0rH4HImlBo6Edt9c/M
        v7leqY+njP6cOQPiFF/IwJ1QLH4Iwg7cCfDuYLj2XWNnl8uqBIdy68TukR5upf35
        beCpnlt7Evs2l6T3AfRpca2UbjRGrj3rZ2Izc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hawsr5FLXbZMaiy3ZGGkxqhjsnJjw4BA
        Rt7PK79GufJr/yeNJ72h+ixWMo2bSgjiBMiOx7+JhJFCtO7mopc19sSG1SEeGP6W
        /sjZ5mcxpzxxeArDbOLIoXwxTKlrvLY76MFRIiu/Uuo6whwHfXw7YuYnhd5ODtoj
        lXDQhSywSFM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E66585CC3;
        Tue, 20 Oct 2020 14:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0B0385CC2;
        Tue, 20 Oct 2020 14:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
Cc:     git@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 4/4] Documentation: stylistically normalize
 references to Signed-off-by:
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
        <cover.1603155607.git.bkuhn@sfconservancy.org>
        <448b9d464eafdb0ee8faa8cd41ee08f844e27701.1603155607.git.bkuhn@sfconservancy.org>
Date:   Tue, 20 Oct 2020 11:52:46 -0700
In-Reply-To: <448b9d464eafdb0ee8faa8cd41ee08f844e27701.1603155607.git.bkuhn@sfconservancy.org>
        (Bradley M. Kuhn's message of "Mon, 19 Oct 2020 18:03:55 -0700")
Message-ID: <xmqq8sc0d91d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 723482EA-1305-11EB-8675-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Bradley M. Kuhn" <bkuhn@sfconservancy.org> writes:

> Ted reported an old typo in the git-commit.txt and merge-options.txt.
> Namely, the phrase "Signed-off-by line" was used without either a
> definite nor indefinite article.
>
> Upon examination, it seems that the documentation (including items in
> Documentation/, but also option help strings) have been quite
> inconsistent on usage when referring to `Signed-off-by`.

Thanks.  This must have been a lot of proofreading ;-)

It seems the patches [1-3/4] are identical to what has been queued
in 'seen', which is a good sign.  There was a reversion of a typofix
in the log message of one of them, though.

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 0a69810147..b7bbbeadef 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -313,7 +313,7 @@ Automating
>  	the value of `sendemail.identity`.
>  
>  --[no-]signed-off-by-cc::
> -	If this is set, add emails found in Signed-off-by: or Cc: lines to the
> +	If this is set, add emails found in the `Signed-off-by` trailer or Cc: lines to the
>  	cc list. Default is the value of `sendemail.signedoffbycc` configuration
>  	value; if that is unspecified, default to --signed-off-by-cc.
>  
> @@ -340,7 +340,7 @@ Automating
>    except for self (use 'self' for that).
>  - 'bodycc' will avoid including anyone mentioned in Cc lines in the
>    patch body (commit message) except for self (use 'self' for that).
> -- 'sob' will avoid including anyone mentioned in Signed-off-by lines except
>
> +- 'sob' will avoid including anyone mentioned in the Signed-off-by trailers except
>    for self (use 'self' for that).
>  - 'misc-by' will avoid including anyone mentioned in Acked-by,
>    Reviewed-by, Tested-by and other "-by" lines in the patch body,
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt

Did you hand edit the second hunk starting at line 340 to
git-send-email.txt?  I've fixed it up manually, so no need to
resend.

Thanks.
