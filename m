Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54BE1F89C
	for <e@80x24.org>; Mon, 16 Jan 2017 00:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdAPAXF (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 19:23:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60344 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751122AbdAPAXF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 19:23:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA31961ED6;
        Sun, 15 Jan 2017 19:23:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PKE2zD6G4WTWu2LjGNwfwo6KL5Y=; b=pMkS4M
        T6z7CtTlvnH0N9ABuQqfH4r9FOPGmurYJVBVACXXfJTynUtMSP7T+5c9YvbcuQ2h
        Nr120gtkvJ3nV2VVJowzgiF9dMOE8hASAdJz1NL55jOGZCB1YRCqzKpeCNADwGD7
        o0ZyVNGrFG03bNv8hVQM2SSFC1FT4Gi6plf1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pXzS9/lUBdra/ZBrVesTwbKMyLZGWNOm
        a6X7hIT97QAnhYg+MySlqj1GEHW/UJAWuNAlrkTEDUSCZXkVQTMAg8s+KufeaidJ
        LFkQOpdgWP1Y09/OJeAJ2OgWl+nxq6NS4XoobS58swVghs+Hwd7iTjuOSAwaQZFP
        db1RGjTGSkk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E161B61ED5;
        Sun, 15 Jan 2017 19:23:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 507D761ED4;
        Sun, 15 Jan 2017 19:23:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] request-pull: drop old USAGE stuff
References: <20170115174635.2422-1-wsa@the-dreams.de>
Date:   Sun, 15 Jan 2017 16:23:02 -0800
In-Reply-To: <20170115174635.2422-1-wsa@the-dreams.de> (Wolfram Sang's message
        of "Sun, 15 Jan 2017 18:46:35 +0100")
Message-ID: <xmqqr343c0pl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1AF3EBC-DB81-11E6-A50A-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> request-pull uses OPTIONS_SPEC, so no need for (meanwhile incomplete)
> USAGE and LONG_USAGE anymore.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---

Makes sense.  These are not used anywhere after we switched to use
parse-options.

Thanks.

>
>  git-request-pull.sh |    3 ---
>  1 file changed, 3 deletions(-)
>
> Index: git-2.11.0/git-request-pull.sh
> ===================================================================
> --- git-2.11.0.orig/git-request-pull.sh
> +++ git-2.11.0/git-request-pull.sh
> @@ -4,9 +4,6 @@
>  # This file is licensed under the GPL v2, or a later version
>  # at the discretion of Linus Torvalds.
>  
> -USAGE='<start> <url> [<end>]'
> -LONG_USAGE='Summarizes the changes between two commits to the standard output,
> -and includes the given URL in the generated summary.'
>  SUBDIRECTORY_OK='Yes'
>  OPTIONS_KEEPDASHDASH=
>  OPTIONS_STUCKLONG=
