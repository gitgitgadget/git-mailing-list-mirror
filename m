Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C331F829
	for <e@80x24.org>; Wed,  3 May 2017 18:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbdECS2A (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 14:28:00 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33930 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdECS16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 14:27:58 -0400
Received: by mail-pg0-f46.google.com with SMTP id v1so82410331pgv.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AZn/gXW9DVulSx/RzUZmgr0SWY7i1h7TbbE0gHeSy2w=;
        b=a0/4+zQOKaEIbbkDgYZNSED7XYURVxM8IrPc0IvpnO7IDY5yjaMhSzx3rTtmgAb3sw
         FbIaif4mJJlEiCzQr7ZhtSCZsYXKPWGZ9peQmm0iT2ostpEHJOUN4VQhDNlAxtNH9O+h
         7aaPSBmt6aEob4TqcAILCfxcE6DGpbZH0BvVTg/BN1x3tCTTNDvPJpS3ZQ4EMxxNAZ02
         i/xmziYoF/pHkWNwOYwLJYJzTYOACGQe126DF+K6MpYaDr8PF3D+oWIADWWCxcqhdDlY
         nUgyQVp/Nj9y8dBn6wWQaH/XVSRryUchMNM2t2lRYPeXV4NIXiNTpD7p22mZ4AlUNE12
         8nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AZn/gXW9DVulSx/RzUZmgr0SWY7i1h7TbbE0gHeSy2w=;
        b=Ck0ZL9XnaXa9z/6b1MPD+oQdrK8ddRrU4j5491qFDTtFz578fVrwbOG1x0DcpU98Sh
         uZsDx2/I74xIjrT8Gd+pOpL1KdNio3IzWwTf8+jPS93ojyLzeoMp7dwSg6cBq8Pun3MT
         0yeOpJFmKto33uFP8/QSphc9qJzD1hrQcDTXn+0DKA/JX6AvmiYOZ5pu0H7eAlTS0V21
         BWVQT7RmC6xkLhbB54vVpSvYInrnj7NL8qfRFoMri2NesLe3vMqhqrNUB1wgLwhiZntm
         /Y+LrHipke2+ekcokvIXKFB6BXdmp9Xg7xfNkzSEasCCwZ3jKjbmmMdmYHVtSQXopgxc
         /f3Q==
X-Gm-Message-State: AN3rC/4ndS/yiy1d+w8u5GmFEEwvG7iV1J8xUBCIEkkKl2+RbK2OGUpe
        eUnVRgdvm8rJmlDN70pJaS1i7i61YV7pf2s=
X-Received: by 10.98.204.87 with SMTP id a84mr2904776pfg.6.1493836077893; Wed,
 03 May 2017 11:27:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 3 May 2017 11:27:57 -0700 (PDT)
In-Reply-To: <CAHGBnuMUrNFv30d+pjheiCAikM89XshQTFuDXBzu+EcxNY_94w@mail.gmail.com>
References: <CAHGBnuMUrNFv30d+pjheiCAikM89XshQTFuDXBzu+EcxNY_94w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 May 2017 11:27:57 -0700
Message-ID: <CAGZ79kb=x38ELzZK3jxh1v6ivWD=D9_=-2nGCwR_m+zN0S0oSQ@mail.gmail.com>
Subject: Re: Cloning a custom refspec does not work as expected
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 5:16 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Hi,
>
> I'm trying to clone a custom ref, avoiding the need to init && fetch
> manually. From reading [1] which says:
>
> "Set a configuration variable in the newly-created repository; this
> takes effect immediately after the repository is initialized, but
> before the remote history is fetched or any files checked out. [...]
> This makes it safe, for example, to add additional fetch refspecs to
> the origin remote."
>
> I'd assume that this would work:
>
> $ git clone -c remote.origin.fetch=+refs/changes/*:refs/remotes/origin/changes/*
> https://gerrit.googlesource.com/git-repo
>
> In fact, this *does* add the custom refs correct to .git/config, but
> they are not fetched during the clone. I can manually fix that by
> doing
>
> $ cd git-repo
> $ git fetch
>
> afterwards, but the whole point is to avoid exactly that separate step.
>
> Is this a code bug or documentation bug?

I would blame the code to be buggy, as it first writes out the config
and then doesn't read the config, but blindly performs some magic
to come up with the refspec to fetch and performs that fetch.

Thanks,
Stefan

>
> I'm using git version 2.12.2.windows.2.
>
> [1] https://git-scm.com/docs/git-clone#git-clone---configltkeygtltvaluegt
>
> --
> Sebastian Schuberth
