Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76189202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 00:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbdKUAdh (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 19:33:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60816 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751594AbdKUAdg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 19:33:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACEE0BAE5B;
        Mon, 20 Nov 2017 19:33:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J29PiQs4PfC/HIuYQdz8HxBH8XE=; b=ZjImcP
        SprGOXw+fTCdxsAwnht1R1lagMUdD8rXSjvM0hDQt2wNDy6ugVL2hWUu/RJsHWZy
        IsZIvAR/AxsGoTsGkzvax6a8TjdFXXKC/iJCJBl1MygJPC4+XNkhazH8EEhTyJYZ
        qVunV7xxfnnn6nVVvSA3OAmMCw4o2cXI8ARVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cvFZC8UJs19GNX4aGoOB5o+3DWKxff4L
        ATUR66lGdxQYu/dYeuPh5V6czQJMg1/18kDxPQKZIQ2K3l2t8AxqWIy3JCKmrMbm
        QTifO3NJKhXH+Me8XkM77XuaiOg9SInVP84EAIxZD7wwYoeNnlitLTgQheTRiYqo
        8LsYBMkz+9s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A50ACBAE5A;
        Mon, 20 Nov 2017 19:33:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16461BAE59;
        Mon, 20 Nov 2017 19:33:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] git-rebase: clean up dashed-usages in messages
References: <xmqqmv3hokvx.fsf@gitster.mtv.corp.google.com>
        <20171120152652.9413-1-kaartic.sivaraam@gmail.com>
Date:   Tue, 21 Nov 2017 09:33:33 +0900
In-Reply-To: <20171120152652.9413-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 20 Nov 2017 20:56:52 +0530")
Message-ID: <xmqqbmjwlbc2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BE315C4-CE53-11E7-8747-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---

Thanks.  Two fewer git-foo exposed to the end user.  Good ;-)

>  git-rebase.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 6344e8d5e..2f5d138a0 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -9,7 +9,7 @@ OPTIONS_STUCKLONG=t
>  OPTIONS_SPEC="\
>  git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
>  git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
> -git-rebase --continue | --abort | --skip | --edit-todo
> +git rebase --continue | --abort | --skip | --edit-todo
>  --
>   Available options are
>  v,verbose!         display a diffstat of what changed upstream
> @@ -216,7 +216,7 @@ run_pre_rebase_hook () {
>  }
>  
>  test -f "$apply_dir"/applying &&
> -	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
> +	die "$(gettext "It looks like 'git am' is in progress. Cannot rebase.")"
>  
>  if test -d "$apply_dir"
>  then
