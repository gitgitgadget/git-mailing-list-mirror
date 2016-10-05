Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25FBF1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754909AbcJERr6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:47:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61405 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752617AbcJERr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:47:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E152942AD1;
        Wed,  5 Oct 2016 13:47:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vePBhxbb8tQyUfBO3UBgAgtB1lc=; b=iKqdfS
        vfxoGvGm4fXQGpBkyuFDrQhYtkJqVCbepyeLg03IHnZzZkP6+WmdFXlK4+2VX89J
        OwR6Lvkzbq28UOCJ1OB0daj8KYH+2Z8xbahqO5xs0uvKD1y4TjCl0qKyq2IEPUz3
        6USn5SBdpXKrfIuSBZF3pIIxOsuFTkqoinT4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WytqHFJh0BMH99G2dv7+juNDsLm50AXU
        Utvr8oHjgWyM1b2qmpG9nZKngz1R+i3EzvmoTI1dmUh58E/R712llVr+Mc8GL4YF
        fkSWTw1x4Lp5IfZfwkjYvK0XKJDY2hmtwRjUw+srfUOglem/eyum88bG9AU8YGAV
        ZU4CMc2AYL0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA42D42AD0;
        Wed,  5 Oct 2016 13:47:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 51FA042ACE;
        Wed,  5 Oct 2016 13:47:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     sorganov@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] Documentation/git-merge.txt: remove list of options from SYNOPSIS
References: <cover.1475678515.git.sorganov@gmail.com>
        <fa4e150ab54f9a01b4b7ca496dfe514d5e106ff6.1475678515.git.sorganov@gmail.com>
Date:   Wed, 05 Oct 2016 10:47:53 -0700
In-Reply-To: <fa4e150ab54f9a01b4b7ca496dfe514d5e106ff6.1475678515.git.sorganov@gmail.com>
        (sorganov@gmail.com's message of "Wed, 5 Oct 2016 17:46:20 +0300")
Message-ID: <xmqqeg3upu0m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D87B9282-8B23-11E6-8A85-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sorganov@gmail.com writes:

> From: Sergey Organov <sorganov@gmail.com>
>
> This partial list of option is confusing as it lacks a lot of
> available options. It also clutters the SYNOPSIS making differences
> between forms of invocation less clear.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-merge.txt | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index b758d55..90342eb 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -9,10 +9,7 @@ git-merge - Join two or more development histories together
>  SYNOPSIS
>  --------
>  [verse]
> -'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
> -	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
> -	[--[no-]allow-unrelated-histories]
> -	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
> +'git merge' [options] [-m <msg>] [<commit>...]
>  'git merge' <msg> HEAD <commit>...
>  'git merge' --abort

Same comment as 1/6; as we'd hopefully be removing the deprecated
form soonish, it would probably make sense to leave only two, i.e.

	git merge [options] [<commit>...]
	git merge --abort

in synposis.
