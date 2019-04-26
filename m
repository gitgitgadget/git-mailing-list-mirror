Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25061F453
	for <e@80x24.org>; Fri, 26 Apr 2019 20:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfDZUzj (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 16:55:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42601 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZUzj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 16:55:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so6105285wrx.9
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=91e0llKjMEwQWyb2LpTC+aYeGWzwnfggyusyInFoyK0=;
        b=RBMneU9ZkIzX7FQ3ytlQN5+94Jx60yIxYkvX3sUHwxRgN9UHonKsgWQ0lrxGgFbJUd
         6kRirFQkDQ+x5a0cxh/8qaOUMRatXNV1g6RSDp9xS0nT9j4YfodtYzst30Gur7OX9/A1
         IdwBVDSm/NXCw2SKPo50KS9IXc1n19+BBdzts/vg9SPTjCWpuzc1vBMwGHGdMEoApKIR
         B8Nir054zmjEOJi7MOGETVVPKB6icZ5llYvCS5CdIyVMp2fg9z0vJzz5biHBcYU0zOaO
         TGHYDCuKLtBsjLsIShlAOeYkLWv0v2OfwrAeRpTICWczBowPpYMyCxZciGK3jXbVgnWC
         1orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=91e0llKjMEwQWyb2LpTC+aYeGWzwnfggyusyInFoyK0=;
        b=hi5hP/uxR5AB2LFM+Q/K9s2Qx2woOJWGrBkXxPINF9fDrKeGlxUlxWcwcVE49MnU55
         xPXOrAPuxHDNt/GXAl0DjU7DztQd3hZPT8syvcKdflN0OvZ65jwg+Zeg+QBYCYl8HTio
         Vx8qPBg/W7cpPhWU0uxQv7SAR4cH0d/Te57nWQXojZ32txKKYBIlPMRxu0ZxBwSUBtO4
         l8lRf66Q0a/av537mB7/bzJhGQOeByMHJcflp5eml3x6Nca1B8BFHUOcirK5TknbK/bT
         a04h+q1M0vAHdo5DiNGRkRgnYXHpcMBi/IvU5M3NnXhtapTVQyvPstc7CwdwZNjIGdNW
         4oXw==
X-Gm-Message-State: APjAAAVy5kA4eiq6l7dVPgZ32ndM2csz8sS8w/+eF2c6mnEK8C32ypQu
        ZZjsyVNzsjEeJgeguiAqPjgce13n
X-Google-Smtp-Source: APXvYqw7anDUE5tnsfXzE2H56RuwcDf2o+6YSXc4ITSXtAbMsMZLHEiZkJJIXJgtbezA5LYJTHjO+Q==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr13612488wrv.131.1556312137695;
        Fri, 26 Apr 2019 13:55:37 -0700 (PDT)
Received: from ?IPv6:2001:a62:437:4001:9d99:7c59:8ca4:b1b1? ([2001:a62:437:4001:9d99:7c59:8ca4:b1b1])
        by smtp.googlemail.com with ESMTPSA id y133sm29762331wmd.2.2019.04.26.13.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 13:55:36 -0700 (PDT)
Subject: Re: [PATCH] revisions.txt: mention <rev>~ form
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <1d84c3bc-4e18-450e-edc6-96ac34f61c7a@gmail.com>
Date:   Fri, 26 Apr 2019 22:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.04.19 um 08:12 schrieb Denton Liu:
> In revisions.txt, the '<rev>^' form is mentioned but the '<rev>~' form
> is missing. Although both forms are essentially equivalent (they each
> get the first parent of the specified revision), we should mention the
> latter for completeness. Make this change.
> 
> While we're at it, the brief form of '<rev>^' makes it seem as if no
> numerical argument is accepted. Update documentation to make it obvious
> that an optional numerical argument is accepted.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/revisions.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 2337a995ec..4ba7b4416a 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -131,7 +131,7 @@ from one location and push to another. In a non-triangular workflow,
>  This suffix is also accepted when spelled in uppercase, and means the same
>  thing no matter the case.
>  
> -'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
> +'<rev>{caret}[<n>]', e.g. 'HEAD{caret}, v1.5.1{caret}0'::

This

>    A suffix '{caret}' to a revision parameter means the first parent of
>    that commit object.  '{caret}<n>' means the <n>th parent (i.e.
>    '<rev>{caret}'
> @@ -139,7 +139,9 @@ thing no matter the case.
>    '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
>    object name of a tag object that refers to a commit object.
>  
> -'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
> +'<rev>{tilde}[<n>]', e.g. 'HEAD~, master{tilde}3'::

and here: These would be the first and only places in revisions.txt
where [] denote optional syntax. Since *exactly* this place is already
riddled with special characters wich are either part of the syntax
(e.g. @, {}) or not (e.g. <n>) this would be confusing.

In other places of the file optional syntax is *displayed* like this:

       <branchname>@{upstream}, e.g. master@{upstream}, @{u}

in that spirit somethind like this:

	<rev>~<n>', e.g. 'HEAD~, master~3', master~

would be better to read.


> +  A suffix '{tilde}' to a revision parameter means the first parent of
> +  that commit object.
>    A suffix '{tilde}<n>' to a revision parameter means the commit
>    object that is the <n>th generation ancestor of the named
>    commit object, following only the first parents.  I.e. '<rev>{tilde}3' is



