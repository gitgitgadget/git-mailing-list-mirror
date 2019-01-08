Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0813E1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 18:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfAHSyM (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 13:54:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42953 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfAHSyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 13:54:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so5127577wrx.9
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 10:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9woTbRzJdy6IwxLFkOEbqG40MC09tN5fn/bTxR226RM=;
        b=SxtgMw2q2l25hk6hv4Vw8hAJa6wmrGu8IJ8h/GstoN5dERndvx24rsmXGmBQTOwuUy
         i9WP3BBb8RjVAx7ZzrGKop80o3MDF5VyOpE4afrCHV1VCpDmKjX9wzCTV8xLOV2ZS6iJ
         44XoSiebrOXdiSt7Fto9JsPn/z4F4o6D921qQFbaLE+ogeVAVTQ1bEBC7d6N3JRwf1fq
         gUdlBF9ZbDovKDxxfFTnPd0voQCCHeWUs6iFaKIpgwo9t9B+PLU/e/EGMAPysuCw5/7L
         W6tF18m4nV1FyGowO1+GcO5M7UlyCmFGQ/52mhN0j7AYcA7LWmlzsnEqvSf5LsUJBxl1
         WdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9woTbRzJdy6IwxLFkOEbqG40MC09tN5fn/bTxR226RM=;
        b=pP7mtbUuKehA1i6GQ+fp1nRgXmUDwmXokaz7QFFwvFZfDsqqJRaP+9Ao0uBIj4jKoZ
         5TccEuBJqsCMsapeSv4pqNA8/IRXqJdKoow5bCpgrfJhf7PPww0g2oeYnCh4Wbr/uQdG
         qS74u/Mwc5vbK2JCPzJKEdU/gLnNXdB41V40emXJGlQfKzYT3XjPvAKaE79Hj2MNwTzj
         jRBmBnsvYshEglDTXLZo6m4NsS+Isn0Tu9UZ3a0LTl9y8w5dFr8c1apCnnWTbdHtvkL+
         OunWFqsevgiY+TjzULc8L13RAld5Ni+HxSDYtNjkDrWF7/Fv9GbSuFfztccxfI2saSs/
         sHjA==
X-Gm-Message-State: AJcUukdEspPyIMTf8FZNPBELLlPNSnNh8AZLuI2nt9QxIiNbwMwdnM41
        T+u9RF8plAlEpzt84Sk1AbU=
X-Google-Smtp-Source: ALg8bN7d49ZLb1dnlDv238mPrrwuzh7aTMfnt3iCzdHB/EgpR8TF8jATPyhNOWShJwkmNMp+QWyqyQ==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr2242068wrq.69.1546973649713;
        Tue, 08 Jan 2019 10:54:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l14sm132817542wrp.55.2019.01.08.10.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:54:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] git-gc.txt: fix typo about gc.writeCommitGraph
References: <pull.105.git.gitgitgadget@gmail.com>
        <e628fefa41feec008fc4e19a5be5622108391bb3.1546966339.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Jan 2019 10:54:08 -0800
In-Reply-To: <e628fefa41feec008fc4e19a5be5622108391bb3.1546966339.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 08 Jan 2019
        08:52:20 -0800 (PST)")
Message-ID: <xmqq4laj56b3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Reported-by: Stefan Haller <stefan@haller-berlin.de>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

Thanks.

>  Documentation/git-gc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index c20ee6c789..a7442499f6 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -137,7 +137,7 @@ The optional configuration variable `gc.packRefs` determines if
>  it within all non-bare repos or it can be set to a boolean value.
>  This defaults to true.
>  
> -The optional configuration variable `gc.commitGraph` determines if
> +The optional configuration variable `gc.writeCommitGraph` determines if
>  'git gc' should run 'git commit-graph write'. This can be set to a
>  boolean value. This defaults to false.
