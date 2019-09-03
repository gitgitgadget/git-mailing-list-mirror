Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36DF11F4B7
	for <e@80x24.org>; Tue,  3 Sep 2019 14:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfICOMQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 10:12:16 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:44435 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfICOMP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 10:12:15 -0400
Received: by mail-yb1-f175.google.com with SMTP id y21so5883227ybi.11
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lvfEGxLhZQ5eWNrSM1mlA7qVXkcDLDSTi/kheREBql8=;
        b=A3rNepZnfGvwzQ0T6JVfafL6E4Urm+QK9v02YES0WdVi2+VRJPqDCdm0zJS6RjRCkB
         bGRTUW1aQ6mVBK5HyHhKUZWw6kjLQ4vKVp+AAWSC7EF8Oj8nHv0f+WWxOR83WkD76nq0
         TcNPhT7U8SC6zjjpJjeynUgPMl6n9SgFAuHbeqCFq4eWoqMWA32P//wXPOUnxZFbDn7b
         uOIrom8J9D8ySS+jSdJthCZ/LR9Rhg5XAc+c1x9RfIsiGq8HrOSyGlLq8tcy0lP13BD8
         +MyN5lt9ro4TlDZCo2Q2a4wRP+il/zrIcTbnH9Rw3iZlJbqUQxvcDg1Xt3+7NLghmHNv
         s58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lvfEGxLhZQ5eWNrSM1mlA7qVXkcDLDSTi/kheREBql8=;
        b=isWQiKp5hp8tvZL1S15lQZslPsaCYX09xeLeKApPd4MX65WctcvhYy7s/Zdu1PHbm9
         dpV9v1G+dr8eculiqBN5jkMC16HyroZlTz9WMnc1r90O49ngWpY9Sxc0Kv+VgwrxDbvm
         NBFTUx6ay5HXv7ZjbY7Kgbg7oBOzJFyQV215dPKlYAVPe6gXGv65b9k5047ZngkPXbjd
         3mxKn9s0Tj8kLyrHM4WaUE8ec9lAjqf+FitwYO6BX9MKL51cH8u9wEFZB3Fm20L9GORB
         DW/N+zbQVLSjmhO8YS+ygqWH8DiCw9S+fnUCdeA3gsPui64qhSp1ro3Te09K6Ign9BO6
         aXwA==
X-Gm-Message-State: APjAAAUwG8Oh2yzBfM9JiZ4WP9btyCFUVrml78x7+mE3rVE3Q5Yp0fgT
        APyAU8zOh1OBShJxasFaW4afTlUDUZGXh1KelrwoqNAopeE=
X-Google-Smtp-Source: APXvYqyy4ZW9k/NFdXF1dUiZtEJsePcQH4OOR/aJw83NBzB6s37s3V+2c4nVb2k+LF9oxgHJgl4eAtuwnDZycEMwglY=
X-Received: by 2002:a25:d751:: with SMTP id o78mr25984115ybg.101.1567519935030;
 Tue, 03 Sep 2019 07:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHMHMxW4-6AZEDaJU8KOy2kRSLXjdC_RTH528=nnhVLXh=ADUA@mail.gmail.com>
 <20190903133422.GA51158@syl.lan>
In-Reply-To: <20190903133422.GA51158@syl.lan>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Tue, 3 Sep 2019 17:11:38 +0300
Message-ID: <CAHMHMxVy7Ud+pOHbfWXX4jzPoPng8TvR2zNgm_B56Srt64BrWw@mail.gmail.com>
Subject: Re: Git does not recognise directory named '${sys:DATA_ROOT_DIR}'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Taylor,

This was happening on a (much) more massive repository; I simply tried
to dumb down the example.

The original folder did had a folder structure 3 levels deep.
Unfortunately, I don't remember if the leaves were files (or
directories themselves). However, since I "replicated" it, I went
ahead and cleaned up my main repo (sigh).

Thank you for reminding me of the empty-tree case :-)

(Reply-all missed the list)
--=20
Until next time,
=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82

On Tue, Sep 3, 2019 at 4:34 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi,
>
> On Tue, Sep 03, 2019 at 03:44:14PM +0300, =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 wrote:
> > Hello there,
> >
> > While the name is obviously a mistake, git refuses to even acknowledge
> > the directory.
> >
> > ```
> > u@h:~/$ mkdir init-test
> > u@h:~/$ cd init-test
> > u@h:~/init-test$ git init
> > Initialized empty Git repository in /home/u/init-test/.git/
> > u@h:~/init-test$ (master #) mkdir \$\{sys\:DATA_ROOT_DIR\}/
> > u@h:~/init-test$ (master #) git status
> > On branch master
> >
> > No commits yet
> >
> > nothing to commit (create/copy files and use "git add" to track)
> > u@h:~/init-test$ (master #) git add
> > .git/                    ${sys:DATA_ROOT_DIR}/
> > u@h:~/init-test$ (master #) git add \$\{sys\:DATA_ROOT_DIR\}/
> > u@h:~/init-test$ (master #) git commit --signoff -m'a'
> > On branch master
> >
> > Initial commit
> >
> > nothing to commit
> > u@h:~/init-test$ (master #)
> > ```
> >
> > Is that expected?
>
> Git does not track empty trees; that is to say 'git add' on an empty
> directory does not change the status of the index.
>
> Try for example:
>
>   $ git init repo && cd repo
>   $ mkdir -p dir
>   $ git add dir
>   $ git status
>
> And note that 'git status' says there are no changes.
>
> On the other hand, 'git add' performs fine even in a directory named
> '${sys:DATA_ROOT_DIR}'; simply create a file (even an empty one) within
> that directory and then run 'git add'. It will stage your "changes" as
> expected.
>
> If you wish to keep this directory "empty", but stored in Git, a common
> convention is to create an empty '.gitkeep' file in the directory. This
> file is not special in any way to Git, rather it serves as _a_ file to
> keep the directory non-empty.
>
> Hope this helps.
>
> > =CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=
=81=CE=BF=CF=82
>
> Thanks,
> Taylor
