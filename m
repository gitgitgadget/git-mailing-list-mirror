Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE29820357
	for <e@80x24.org>; Mon, 17 Jul 2017 22:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdGQWMm (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 18:12:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33071 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdGQWMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 18:12:41 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1so316587pgs.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LxuyurtTcm0saTGcbV0TTsXg+Vk0cjntW4X/aLhO2Uo=;
        b=SRLIvu6YKntjF/r8A8rY/3eCD72KHgxAxQGLoXVwUxaBXlYSb9VErRWhX02wkGbp4H
         WtU313WRYiZfLQ9ua5xF7dsV6Lg45IT2K+I+eP5w8anCFApdTOxAOMI7cnrZrPRN6XuR
         VKcj/hr4n7/21/sgWPHjXWtheNHccm13jUoxefpOOUI42W6QZoUehOGaEcA8L16fzM4z
         ecuMYP/nsyyeTTllql5cg0fmGs+LmnLgaV9nC39O694QxZ4yNA3AmMJvNgZoQRE2tmLh
         juRo8v22H+dpz4YcPd0C/iHGbxf1nh6IN1zrvyv18jY6xNs/9sYHT78UZx6jHh75bAxX
         g4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LxuyurtTcm0saTGcbV0TTsXg+Vk0cjntW4X/aLhO2Uo=;
        b=iZyhemCcLsEa+nDXpov8cjeSt8Bq+J9ytukKImyj0o8tllKvo2bMunnyUUjnRJXZ3X
         XDccCHPx5bnKzKcwBUbsQxAPD5sBogcJG3BFJVOC7oTt9k8lqttEiKSolb9VNEYvxLnc
         3gzUKfpP9WrD6BpxkZ/5fzy31jTT/DMlwu92BuNcr2yq0z1z0FqhJctp41kbt5l2NI9t
         aR5L8eetOVxw5q5V/zm4YAcX6bLDYzmOXY7VZYNeF4sdx27KzuNmNtfjL4+zek4Y9fPv
         xytz4pU3D9Fbwr7kMCeH70dGgX3n7MrEwljeC4eqIDcxpc3DL3NsLs4fpwb3d9KmTuCY
         NWsA==
X-Gm-Message-State: AIVw110PXXAXXPfGlrpW0qPSoRWI5p6dsPftIAjvNd3faL6iXWF8dGWd
        r53TA3V7x2aPiA==
X-Received: by 10.99.177.6 with SMTP id r6mr21058775pgf.106.1500329561281;
        Mon, 17 Jul 2017 15:12:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id r62sm464816pfl.45.2017.07.17.15.12.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 15:12:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: camelCase the i18n config variables to improve readability
References: <20170717153900.16666-1-kaarticsivaraam91196@gmail.com>
Date:   Mon, 17 Jul 2017 15:12:39 -0700
In-Reply-To: <20170717153900.16666-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 17 Jul 2017 21:09:00 +0530")
Message-ID: <xmqqiniqg1bc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The i18n config variable used weren't readable as they were in
> the crude form of how git stores/uses it's config variables.
>
> Improve it's readability by replacing them with camelCased versions
> of config variables as it doesn't have any impact on it's usage.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---

Thanks; this makes sense.

>  Documentation/i18n.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
> index 2dd79db5c..7e36e5b55 100644
> --- a/Documentation/i18n.txt
> +++ b/Documentation/i18n.txt
> @@ -42,11 +42,11 @@ mind.
>  +
>  ------------
>  [i18n]
> -	commitencoding = ISO-8859-1
> +	commitEncoding = ISO-8859-1
>  ------------
>  +
>  Commit objects created with the above setting record the value
> -of `i18n.commitencoding` in its `encoding` header.  This is to
> +of `i18n.commitEncoding` in its `encoding` header.  This is to
>  help other people who look at them later.  Lack of this header
>  implies that the commit log message is encoded in UTF-8.
>  
> @@ -54,15 +54,15 @@ implies that the commit log message is encoded in UTF-8.
>    `encoding` header of a commit object, and try to re-code the
>    log message into UTF-8 unless otherwise specified.  You can
>    specify the desired output encoding with
> -  `i18n.logoutputencoding` in `.git/config` file, like this:
> +  `i18n.logOutputEncoding` in `.git/config` file, like this:
>  +
>  ------------
>  [i18n]
> -	logoutputencoding = ISO-8859-1
> +	logOutputEncoding = ISO-8859-1
>  ------------
>  +
>  If you do not have this configuration variable, the value of
> -`i18n.commitencoding` is used instead.
> +`i18n.commitEncoding` is used instead.
>  
>  Note that we deliberately chose not to re-code the commit log
>  message when a commit is made to force UTF-8 at the commit
