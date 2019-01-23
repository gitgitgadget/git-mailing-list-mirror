Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AAAE1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 19:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfAWTgu (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 14:36:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55884 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWTgu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 14:36:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so603750wmc.5
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 11:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=yEvFob9DVqzicefEQmcf2gYYHFXSJPtP+C7gcwCZhw4=;
        b=S32YRU2FueUn3zfbxLXkPDedk8QZrzMTKBAHP5bJO1W1hca9aTmhUgTZyl1NotEAGF
         7YY2yyaMZO73xSA2JepHPOTva99CC1WiyWV0+S/BFcXgt1B1FZPwRKeCEiljki5ovn/l
         /Th3/EoY53mxz0zE1MH17JXAwDeIC4bh3I15JLCLlmfDrmm1Nunyr0/prdsWtkiQL/de
         NRZrohPaVCfxkK+Jei4rszeATzzmGZnChlakEJ4/nVtd+6PVn62gUtstbXN2MAb4iUBE
         XVV1OrX+2P6aiAEVLINr81ZVRCnkZSzPnyTbScfDpEp2yp1eTQa4IleRsSeyz6ABJLfd
         jYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=yEvFob9DVqzicefEQmcf2gYYHFXSJPtP+C7gcwCZhw4=;
        b=EWaDyWwlEuhWeR8m0DD7ZvNtx98GGbKvZo3rEL6YnwdGP+zBbHKfubYo5smx3qaK96
         IpPD5vxMrmk9ntNiYcSNajqrk+gJBBPOCKpsffcfzvcFAop0pLWxhx8HO80UV5boaA8i
         USBfORKaqu9ER63gX4ePpN1HiBDk8Xx60QqD3fEUXdPBUsf16QnDzqI3PLtitE384WUP
         8/Rn6JJmP6AbO0lTlQDRnMlVDR73vS58soX8Q10Cjf/UWSpDJ62lVw610iSqFVvYcS0j
         lWyUpt8DNPbK/pqOBiZBmqqV4UFV6QbOUniFCvim2B2kgcqtxtr9LiMwnDxUuTvKwWnA
         IVKA==
X-Gm-Message-State: AJcUukeB3JD2GBvAOEk0EAuJGxAK+BHPXY/ty3e5TF+yxsafLVMDiwGk
        ozYa0N+s7VrbuzXAQG9xq5DYHZLJ
X-Google-Smtp-Source: ALg8bN6XbI2eEjW24r5uO9/rCxJaOjk+RVT8ebMLGJKQ0pAjSlmzhnUwB9PFAMbDlQAOMrDQHojMKQ==
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr3747772wmj.91.1548272208087;
        Wed, 23 Jan 2019 11:36:48 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o81sm90672945wmd.10.2019.01.23.11.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 11:36:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: tidy asciidoc style
References: <20190122201635.15961-1-jn.avila@free.fr>
Date:   Wed, 23 Jan 2019 11:36:46 -0800
In-Reply-To: <20190122201635.15961-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
        message of "Tue, 22 Jan 2019 21:16:35 +0100")
Message-ID: <xmqqk1ivb1yp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël Avila <jn.avila@free.fr> writes:

> This mainly refers to enforcing indentation on additional lines of
> items of lists.
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---

I somehow misread the title as "tiny asciidoc style (fixes)".  This
is a huge clean-up.  Thanks for working on it.

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 45652fe4a6..37bcab94d5 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -58,9 +58,9 @@ OPTIONS
>  	specifying `dir` will record not just a file `dir/file1`
>  	modified in the working tree, a file `dir/file2` added to
>  	the working tree, but also a file `dir/file3` removed from
> -	the working tree.  Note that older versions of Git used
> +	the working tree). Note that older versions of Git used

Good.

> -	to add modified or new files but ignore removed	ones.
> +	to add modified or new files but ignore removed ones.

For those reading from sidelines, the difference here is that the
original has HT between "removed" and "ones" ;-)

Two questions.

 - Does this affect correctness in formatting?  I thought not.

 - How are you finding these?  

> @@ -206,7 +206,7 @@ EXAMPLES
>  --------
>  
>  * Adds content from all `*.txt` files under `Documentation` directory
> -and its subdirectories:
> +  and its subdirectories:

OK.  Just to make sure (read: not an objection to the change), this
does not affect the formatted result, right?
