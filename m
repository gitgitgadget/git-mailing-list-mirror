Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BD4C433E0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4C464E3E
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 15:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhBTPQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 10:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhBTPQj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 10:16:39 -0500
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 Feb 2021 07:15:56 PST
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C27C061574
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 07:15:55 -0800 (PST)
Received: from postfix01.mail.de (postfix02.bt.mail.de [10.0.121.126])
        by shout01.mail.de (Postfix) with ESMTP id 98AF41002EE;
        Sat, 20 Feb 2021 16:09:47 +0100 (CET)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
        by postfix01.mail.de (Postfix) with ESMTP id 7CDD3A005C;
        Sat, 20 Feb 2021 16:09:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1613833787;
        bh=MTzaJfr18ezT31CCTvmTOo8ULlA79H/j0s5HoXZszO0=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=2+fO1MKaRawOZSS0NpXxqhHopwGt9F912e6bMVnrb/IN1tw1nTlVSzYE2Y5I2qDvj
         40RqdPjltV4HWbDwhdvY3QyQQNhT38QrNEXm/CIebJOpDhjaen98wcsiiklY2QQdBB
         OuDk//g7DAShup75piicVof4J3pqX1muWTRC2aaHNb7DhBsS6TGEyDfVYZleT3iYgt
         ieRmD3HGCVIcO6Ue0ASUVc3FNvzZYh6HvzbFx4QSD7CvpJadv8/JsC1wZpgl8sFTcK
         SCmvco3IAYlLY+uwT0bqwKnN0p1dQDH2Nm0CCq167h5zDFLX9tNWujtZyUDStcp5rt
         9xqnBByu4pLFw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp01.mail.de (Postfix) with ESMTPSA id 1721B1002DA;
        Sat, 20 Feb 2021 16:09:47 +0100 (CET)
Subject: Re: [PATCH] Documentation: typofix --column description
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqczwvbgqy.fsf@gitster.g>
Cc:     git@vger.kernel.org
From:   Stefan Moch <stefanmoch@mail.de>
Message-ID: <ad9c16dd-3b8f-a438-791c-3d20592e85e2@mail.de>
Date:   Sat, 20 Feb 2021 16:09:32 +0100
MIME-Version: 1.0
In-Reply-To: <xmqqczwvbgqy.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2549
X-purgate-ID: 154282::1613833787-00005B1C-B546AC74/0/0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> f4ed0af6 (Merge branch 'nd/columns', 2012-05-03) brought in three
> cut-and-pasted copies of malformatted descriptions.  Let's fix them
> all the same way by marking the configuration variable names up as
> monospace just like the command line option `--column` is typeset.
>
> While we are at it, correct a missing space after the full stop that
> ends the sentence.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-branch.txt | 2 +-
>  Documentation/git-status.txt | 2 +-
>  Documentation/git-tag.txt    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index adaa1782a8..5b4b2135a1 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -153,7 +153,7 @@ OPTIONS
>  --column[=<options>]::
>  --no-column::
>  	Display branch listing in columns. See configuration variable
> -	column.branch for option syntax.`--column` and `--no-column`
> +	`column.branch` for option syntax. `--column` and `--no-column`
>  	without options are equivalent to 'always' and 'never' respectively.
>  +
>  This option is only applicable in non-verbose mode.
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index c0764e850a..83f38e3198 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -130,7 +130,7 @@ ignored, then the directory is not shown, but all contents are shown.
>  --column[=<options>]::
>  --no-column::
>  	Display untracked files in columns. See configuration variable
> -	column.status for option syntax.`--column` and `--no-column`
> +	`column.status` for option syntax. `--column` and `--no-column`
>  	without options are equivalent to 'always' and 'never'
>  	respectively.
>  
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 56656d1be6..31a97a1b6c 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -134,7 +134,7 @@ options for details.
>  --column[=<options>]::
>  --no-column::
>  	Display tag listing in columns. See configuration variable
> -	column.tag for option syntax.`--column` and `--no-column`
> +	`column.tag` for option syntax. `--column` and `--no-column`
>  	without options are equivalent to 'always' and 'never' respectively.
>  +
>  This option is only applicable when listing tags without annotation lines.

Makes sense.

Reviewed-by: Stefan Moch <stefanmoch@mail.de>


