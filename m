Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BC4E1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 18:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeH2WNw (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 18:13:52 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41956 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbeH2WNv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 18:13:51 -0400
Received: by mail-ed1-f50.google.com with SMTP id f38-v6so4621085edd.8
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JFLqYx2Gmpl6+wtNlmJ2EVxO2apTaMJVVobYr0N+LpA=;
        b=MMVIajGijWNg/vNOeOt9XctwUj3Nyqk7pX5djp/OGl+D7zkyyc74kGcF1FpuLqKxOY
         QO/+Mv5/v+iP44gncE11Y/ODggEKGHZ56lZh9uz5R1wdv82ZPCoCo0wjjOcUWyvOHRL5
         2HfjOLXoRTfy2o95nAs6yvH0oqKnWlxAH+HsIWX01jBBNz8jpqMnFaaqHquz7siybF5T
         2SYHK5r02DyyZCgIMEmSJtJrooiZXI70ChuFAXijufHO9Z0aipXh7Dftmmp4h9cSoGY0
         3quVUVMsR75ebO9NYiCR7fODh0G5OKGBUgCSx1uPyFRK/es+qSNUC5MSRKy5E0ld5taT
         cNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JFLqYx2Gmpl6+wtNlmJ2EVxO2apTaMJVVobYr0N+LpA=;
        b=nZE16fnpwvq4qg/DuJ8mWTEQDE7zlXGBnY3l3a4frWnbSz7W8Kuya86wu3PX+aPKbe
         9eeEvtmEYkQA9oVmgcP2QT4bfIDNIbXoVdOoCSHCt60v9NAqgl0lUffrgSzWVFaKh4TX
         a4WDOQ9aCXRWp4PLa0Ayzj0tL4bVNJMtHbEnNrdoXGLAJI18csOUpUrEJi2jikQq4IAb
         PEMKUIfUPpaePrsYgbhujJmg3jbhaOnv0oi0cSwkZKIZfyJ0w/1mc0k5x/GGdDCjubK/
         TIh22Z6ZM8s9bzp7C0G/cQQSdxzYkBA9Ect3DNvAnaToYR5kUTlY2c8kpWe1LqotGpdv
         q+MA==
X-Gm-Message-State: APzg51CMGA00i0tTcs0x0CueD40TPN046D+WZSvgjv2cZhMFM6B9x3es
        +PVmaS3Z4P8NmzMmv0Z9+mZiIqScu3S14mbZVDBN3Q==
X-Google-Smtp-Source: ANB0VdawBFBI5lXaHkUSb9JjM/A1Aqf4Z0S3ELuhj9c6ezHdMd31mPxdEcX2YOPxVvcf2W9WGK3p0t4zJvx2++HD3UE=
X-Received: by 2002:a50:d083:: with SMTP id v3-v6mr8847211edd.243.1535566544840;
 Wed, 29 Aug 2018 11:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAE3VKEp3PJLCy3tL=K51nNzGry-HySb57QHemZzMtg3RkBmzUw@mail.gmail.com>
In-Reply-To: <CAE3VKEp3PJLCy3tL=K51nNzGry-HySb57QHemZzMtg3RkBmzUw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 29 Aug 2018 11:15:33 -0700
Message-ID: <CAGZ79kakEYc954nQDThAZ0fSwbNp2-GGwthnevoQ4DxEUu4gZA@mail.gmail.com>
Subject: Re: Git Unrelated Histories
To:     me@tomaszubiri.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 9:49 AM Tomas Zubiri <me@tomaszubiri.com> wrote:
>
> Hello all,
>
> I have recently joined a team there seems to be a couple of  issue
> with the git repositories:
>
>
> 1- A branch created from development cannot be merged into the
> production branch.
>
>
>
> (production)
>
> git merge development_feature_branch
>
>
>
> fatal: refusing to merge unrelated histories
>

See the git merge man page for the
  --allow-unrelated-histories switch.

>
>
>
> 2- If there is a file that only has a 1 line difference in production,
> a git diff will return that the whole file is different:
>
> git diff production:folder development:folder
>
>
> =E2=80=9C
> diff --git a/folder/file.py b/folder/file.py
>
> index 9bfd6612..20cce520 100644
>
> --- a/folder/file py
>
> +++ b/folder/file.py
>
> @@ -1,245 +1,245 @@
>
> =E2=80=9C
>
> I=E2=80=99m not 100% sure what happened here. But it seems that changes a=
nd
> added files are copied and pasted into the production branch and
> uploaded indepenedently as separate files, contributing to a huge
> difference between branches.

It sounds to me as if there would be line ending issues or some sort
of whitespace issues (tab vs spaces).

>
> How can I confirm this hypothesis, and what steps can I take to solve it?

git diff --ignore-all-space
or --ignore-space-at-eol

Look at gitattributes to set your flavor for files so you don't have
to pass these flags all the time

Stefan
