Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B83D20281
	for <e@80x24.org>; Thu,  2 Nov 2017 19:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934355AbdKBTss (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 15:48:48 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:51880 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932547AbdKBTsr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 15:48:47 -0400
Received: by mail-io0-f173.google.com with SMTP id b186so1506857iof.8
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JOVOXALotPeuo2QmsEbPtg6YLC/XsXx9pclyjZ7dWtI=;
        b=trBYIVI/ifTcwNw2bY25vbvS1ONHVJUTc8CCVsIj6554VYBNHln4Y+pkpWAfE1YvcP
         s1R1Ky+1DQ60nhW6djFC9Fq2ptC0ewf4nn9j24czZ6sBCta1zLKhK//+5wsNL5lsVGqi
         kyxvNjHiFYAtlpCG3oC2LnsuWOAQ3bCMNOwTe7aqwWLak0wlS3m6yH4OnUo4Cui9Nubg
         ISJVBSg/IN2hnfLu+viCFHPBuqy0dVPud7j3ayoHrkMLVvg+z4hJdJcnKS/7BGw381G0
         WA3MnE4zJY0ygOgklGoHAhM4+pLdROCuR1AD1ZG0kCWrxCYk0VB7rIS5SIgfZF1P+N/A
         RiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JOVOXALotPeuo2QmsEbPtg6YLC/XsXx9pclyjZ7dWtI=;
        b=rYSZfO9yxgz4N/KgWVMeUfvzzbknAB+j5IgMcuje5iTYESmT8h2rlUpyCYE2wdz+OC
         joLTp/c3fdm437flRq55Q/otSLTyJt8FfbItCB0gR+YHnor8WiU2PE1IwiE4Ym2SufZD
         vwdGnVxxirTcULcMuslQdjGXzQ9n4Js80grDw84F5f61G2GNCUWt+g1vH7D8FF0R2Uot
         vRzbkHM+3yedXitF8unnoHrLjtCw32S8Y2ynQGnUsRlFxWTHNhdPSSvtK0nblsIY56Ro
         m9xK1rlC0xdl6gLYD/IpZzK8KmQq7QSEHQ1AanXq6F5AKjwEq0tozvZBpaHrKHsQ0iVw
         10fw==
X-Gm-Message-State: AMCzsaXRpdV9ncjnoti9HEpxdPn1q6TvQ3kmx+zsDVHzr+ysOcwcPIdF
        GOfjaVcCmJforzaj2Qe21pHrR68Vv2rac5v5P3hr4g==
X-Google-Smtp-Source: ABhQp+QxF35x9jhQV/xZMnNKwnggItRp7Z0DVdVLxJj5pqfUXgGVKr2Gxhk4tPtctGr3ma8RMWZnipLfuzLS4Ki/Q4Y=
X-Received: by 10.36.2.19 with SMTP id 19mr4253889itu.76.1509652126163; Thu,
 02 Nov 2017 12:48:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.22.15 with HTTP; Thu, 2 Nov 2017 12:48:25 -0700 (PDT)
In-Reply-To: <1509648929.1838.1.camel@kaarsemaker.net>
References: <CAOAxMp-vAM7mCWuanj69coM09zF-Sxe=G=-XMd_RmaAne8qFvw@mail.gmail.com>
 <CAGZ79kaDB+nnTZVw-7msVa12RQa3sHn_zFKQ2-5i2eosuHutxQ@mail.gmail.com> <1509648929.1838.1.camel@kaarsemaker.net>
From:   Yaroslav Sapozhnyk <yaroslav.sapozhnik@gmail.com>
Date:   Thu, 2 Nov 2017 15:48:25 -0400
Message-ID: <CAOAxMp9H6M+t5RvYiem+kXrY920ZDYvyyYt4GZ7ZnkpXVA_c0g@mail.gmail.com>
Subject: Re: Git libsecret No Unlock Dialog Issue
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've tested the code change locally and seems like it fixes the issue.

Yaroslav

On Thu, Nov 2, 2017 at 2:55 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On Thu, 2017-11-02 at 11:35 -0700, Stefan Beller wrote:
>> On Thu, Nov 2, 2017 at 9:00 AM, Yaroslav Sapozhnyk
>> <yaroslav.sapozhnik@gmail.com> wrote:
>> > When using Git on Fedora with locked password store
>> > credential-libsecret asks for username/password instead of displaying
>> > the unlock dialog.
>>
>> Git as packaged by Fedora or upstream Git (which version)?
>
> Looking at the code: current upstream git. Looking at the documentation
> for libsecret, this should fix it. I've not been able to test it
> though.
>
> diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
> index 4c56979d8a..b4750c9ee8 100644
> --- a/contrib/credential/libsecret/git-credential-libsecret.c
> +++ b/contrib/credential/libsecret/git-credential-libsecret.c
> @@ -104,7 +104,7 @@ static int keyring_get(struct credential *c)
>         items = secret_service_search_sync(service,
>                                            SECRET_SCHEMA_COMPAT_NETWORK,
>                                            attributes,
> -                                          SECRET_SEARCH_LOAD_SECRETS,
> +                                          SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
>                                            NULL,
>                                            &error);
>         g_hash_table_unref(attributes);



-- 
Regards,
Yaroslav Sapozhnyk
