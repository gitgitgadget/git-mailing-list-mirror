Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A03D51F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 20:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfJXU6C (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 16:58:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38671 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfJXU6C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 16:58:02 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so31191201iom.5
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 13:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5bUOxVsnBy2MNsapFU8xbKVpnRYkowSQ3W61QcBbGGg=;
        b=FRzb+fYV7bUwEq7yqO5b0uIkvuXYelES+6ldItvHw5A0FaoDCTF0WVLZTVWk+DpaCp
         3gQTHibNJKSiQy2d3Wro+JwYp4imOXaGEwQdv+8YPspuDf37bgels2YSfn4V8J0FoQ90
         XVZx6M4SLR60BxXOu/r/s7KCBJUQ1RC9RIEXpP4x8rgItKWA+UH/MMp1Y/+PVpM7aKcb
         FOm536EhCjhK9ZlPeDIibFgkz0bXUrpD9/NqkGRXeTgSF0XTgPN4vVa2O2aZjmCu8z2o
         hgl7STaL/O+IFDqxA214dQcpV/XVy4bg/4bI0axVOe4DOhyMmW4s+7Zae0p1T1XlNXNL
         cMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5bUOxVsnBy2MNsapFU8xbKVpnRYkowSQ3W61QcBbGGg=;
        b=FHNHD22TFvl8fGHCk4h8BfwPBWih39bojF48KwEIKZc7vkzncVUlOfUI+P4q5cVBXM
         gOMgrA/rZLArXJWnef4Ch8Z8nddgwzMyrDzihLI3Np749/HStOwr/eQJzeslLUEb8NXM
         C6ZajadzaUDk68BOHHS3iuuOA/Ecdpf8AG24Nm9yihjTJkIr+yH39rXBgpHcnZbGxIH6
         nwRdzDy8L/+lAOQKYRbdxWkuLHVqsYKjczU3futKTqQC7aehTGReeFhCcCnOlUlBSWIG
         G4FPHuMATLBg07hdDWXeZ5s3cPeGnCu+aAYlv84Qyb7IaGOh601ZYSQvx/UtceTJpXjS
         6KBg==
X-Gm-Message-State: APjAAAW/7XL0H9AvYcU4m+5fncb88nlYLc1bt1FwauQ0RtsLSa1AHPru
        VGHaYu5J1ZgTgrDT1FBk3OPzp5cyQoRUFR5S09JW2g==
X-Google-Smtp-Source: APXvYqwy2+nXduNGZUWdoIBrid/9i4JUUMnagklK2SQh/JtB8vjJlIWMv4yJJQOXffi78ESqyYeL/pr7nsSDax1/C+Q=
X-Received: by 2002:a6b:8d09:: with SMTP id p9mr25087iod.227.1571950681096;
 Thu, 24 Oct 2019 13:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191024092745.97035-1-mirucam@gmail.com> <20191024114148.GK4348@szeder.dev>
In-Reply-To: <20191024114148.GK4348@szeder.dev>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 24 Oct 2019 22:57:50 +0200
Message-ID: <CAN7CjDAavVx5n3jwBiwHOt51pNA8u4=Yrc+BWh5aJez0t38Lhg@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El jue., 24 oct. 2019 a las 13:41, SZEDER G=C3=A1bor
(<szeder.dev@gmail.com>) escribi=C3=B3:
>
> On Thu, Oct 24, 2019 at 11:27:45AM +0200, Miriam Rubio wrote:
> > The dir_exists() function in builtin/clone.c is marked as static, so
> > nobody can use it outside builtin/clone.c.
> >
> > There is also is_directory() which obviously tries to do the very same,=
 but it uses a name that few developers will think of when they see file_ex=
ists() and look for the equivalent function to see whether a given director=
y exists.
> >
> > Let's reconcile these functions by renaming is_directory() to dir_exist=
s() and using it also in builtin/clone.c.
>
> Please wrap the proposed log message at about 70 characters width;
> that way it will look much better in 'git log' in a standard 80 char
> wide terminal.
>
> I think this is a cleanup worth doing, but...

Thanks for the guidelines!

>
> > diff --git a/abspath.c b/abspath.c
> > index 9857985329..13bd92eca5 100644
> > --- a/abspath.c
> > +++ b/abspath.c
> > @@ -5,7 +5,7 @@
> >   * symlink to a directory, we do not want to say it is a directory whe=
n
> >   * dealing with tracked content in the working tree.
> >   */
> > -int is_directory(const char *path)
> > +int dir_exists(const char *path)
> >  {
> >       struct stat st;
> >       return (!stat(path, &st) && S_ISDIR(st.st_mode));
>
> Note the '&& S_ISDIR(st.st_mode)', making sure that the given path is
> in fact a directory.  Good.
>
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index c46ee29f0a..f89938bf94 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -899,12 +899,6 @@ static void dissociate_from_references(void)
> >       free(alternates);
> >  }
> >
> > -static int dir_exists(const char *path)
> > -{
> > -     struct stat sb;
> > -     return !stat(path, &sb);
>
> But look at this, it only checks that the given path exists, but it
> could be a regular file or any other kind of path other than a
> directory as well!
>
> So this function clearly doesn't do what it's name suggests.  That's
> bad.
>
> Unfortunately, it gets worse: some of its callsites in
> 'builtin/clone.c' do expect it to check the existence of _any_ path,
> not just a directory.
>
> The first callsite is:
>
>     dest_exists =3D dir_exists(dir);
>     if (dest_exists && !is_empty_dir(dir))
>             die(_("destination path '%s' already exists and is not "
>                     "an empty directory."), dir);
>
> I think this actually means path_exists(): if a file, or any other
> kind of path with the given name were to exist, then we should die()
> showing this error message, but after changing dir_exists() to make
> sure that the path is indeed a directory we won't:
>
>   # create a 'git' _file_
>   $ >git
>   # current git master:
>   $ git clone https://github.com/git/git
>   fatal: destination path 'git' already exists and is not an empty direct=
ory.
>   # with this patch:
>   $ ~/src/git/git clone https://github.com/git/git
>   fatal: could not create work tree dir 'git': File exists
>
> So the command still fails, which is good, but with a different error
> message.  The test suite doesn't catch this, because the test case
> looking at this scenario ('clone to an existing path' in
> './t5601-clone.sh') only checks that 'git clone' fails, but it doesn't
> check whether it failed with the right error message.
>
> Now, that other error message comes after a failed mkdir() call later
> on which should have created the work tree.  So it begs the question
> what would happen when a file is in the way of a bare clone:
>
>   $ >git.git
>   $ git clone --bare https://github.com/git/git
>   fatal: destination path 'git.git' already exists and is not an empty di=
rectory.
>   $ ~/src/git/git clone --bare https://github.com/git/git
>   Cloning into bare repository 'git.git'...
>   fatal: invalid gitfile format: /home/szeder/src/git/tmp/git.git
>
> Then the next callsite looks like it meant path_exists() as well, but
> I didn't try to make it fail or show different behavior:
>
>     work_tree =3D getenv("GIT_WORK_TREE");
>     if (work_tree && dir_exists(work_tree))
>             die(_("working tree '%s' already exists."), work_tree);
>
> And there is a third callsite, but I'm not sure what it is about, and,
> consequently, what is really meant with dir_exists() here:
>
>     if (real_git_dir) {
>             if (dir_exists(real_git_dir))
>                     junk_git_dir_flags |=3D REMOVE_DIR_KEEP_TOPLEVEL;
>
>

Here is my proposal:

- Rename is_directory() to dir_exists(), as it is the equivalent to
file_exists().
- Rename dir_exists() to path_exists() so it describes its real
behavior, and either leave it as static inside clone.c or extract it
to a common header such as that containing dir_exists().

What do you think?
