Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2A91F404
	for <e@80x24.org>; Sat,  8 Sep 2018 09:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeIHON6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 10:13:58 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:40107 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeIHON6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 10:13:58 -0400
Received: by mail-pf1-f181.google.com with SMTP id s13-v6so8144747pfi.7
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silentorbit.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hlvpzNOGp0tc7QyN7ywcEViB5BAmuRJp5pasoYpq11A=;
        b=YKmn0Bxp0MaH/cjXOrjzuoCsrJIfx6FsqX6pYnER6/IGniyXenTAlrTPuziTtZ0E4V
         kpG/aioy/9GKKgmhcRvc8cKj2BdUKvWOWSfvJ7qnDHGPyzbGVMp82ZtL4pIU+DpwecgU
         E4fR1yITHqjVDnX+dpbeWl33UrlQ1ejHhGq7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hlvpzNOGp0tc7QyN7ywcEViB5BAmuRJp5pasoYpq11A=;
        b=JOn7OKQ4nn09weZ8A28OFRbp4bJsU9xwdYJ9whtJAynv0ErJ6T9AB1a7DqUMevgcxD
         kLqQEmGjhbJcY8fNJ4BDUYrhyX4jVLkQv7TxKMFuwsfanewW3qQxzXpQsOPBnoaRt+Mn
         8x9iVA9sILUnFxQTYpNAEezFTF2i8TNlLIDQEYRaMVxaM5xYHi5MobX1GzCD421FHzcF
         mktEhFQieci3a7lFfatLU2GFtMEPkUQbZTUExxlxiwSbPewOR12RjW3szjkxpTSPNyNl
         GPEmISna8ZMRt0auCSbplzjNqDDUXX7OGONWqbHl5aAgJFtahGXiKOIcbgsNQOLSe0uP
         pZ4w==
X-Gm-Message-State: APzg51Amh/d8RCjDENhMW3Dqo5ZBKfmJ3quGVVxkJ7lzlCOcuC4qoaOv
        HC2c4fdMNNtraJiv2To7NuEg/w3g7o51VUzuZ7u9Cw==
X-Google-Smtp-Source: ANB0VdaW8hMufSf4MXbPXV/VL1qgvwYRivwU7k52XZ1vnPFLDmS4AbS6Id00pCy0rN/YfVoCrhJiB/CWDKd84LO/yDI=
X-Received: by 2002:a62:5047:: with SMTP id e68-v6mr12815597pfb.157.1536398932379;
 Sat, 08 Sep 2018 02:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJmnt9Yfed1W7F=C+dzac3AEe7nRq2cNP335MepTczboKJNoEg@mail.gmail.com>
 <xmqqbm99xngs.fsf@gitster-ct.c.googlers.com> <CACsJy8DymnKk+Xo6UPQyAsToNpkSX4Ae+jzc04+0qXrZ6bmb3w@mail.gmail.com>
In-Reply-To: <CACsJy8DymnKk+Xo6UPQyAsToNpkSX4Ae+jzc04+0qXrZ6bmb3w@mail.gmail.com>
From:   Hultqvist <hultqvist@silentorbit.com>
Date:   Sat, 8 Sep 2018 11:31:09 +0200
Message-ID: <CAJmnt9ZOCJfGFJ98xD17BYU1P=nRZ=eG16Oj5DjTMaF7H6WTvg@mail.gmail.com>
Subject: Re: Temporary git files for the gitdir created on a separate drive in workdir
To:     pclouds@gmail.com
Cc:     gitster@pobox.com, hultqvist@silentorbit.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bash commands are using a git and bash bundle that was installed
in parallel with gitextensions(a gui for git)

G:\Min enhet> set GIT_TRACE_SETUP=3D1
G:\Min enhet> git st
10:40:28.881927 trace.c:318             setup: git_dir:
C:/Users/hultqvist/Drive.git
10:40:28.881927 trace.c:319             setup: git_common_dir:
C:/Users/hultqvist/Drive.git
10:40:28.881927 trace.c:320             setup: worktree: G:/Min enhet
10:40:28.881927 trace.c:321             setup: cwd: G:/Min enhet
10:40:28.881927 trace.c:322             setup: prefix: (null)
10:40:28.882930 chdir-notify.c:67       setup: chdir from 'G:/Min
enhet' to 'G:/Min enhet'
On branch master
Your branch is up to date with 'nas/master'.

nothing to commit, working tree clean

$ cat .git
gitdir: C:\Users\hultqvist\Drive.git

$cat C:/Users/hultqvist/Drive.git/config
[core]
        repositoryformatversion =3D 0
        filemode =3D false
        bare =3D false
        logallrefupdates =3D true
        ignorecase =3D true
        autocrlf =3D false
...

G:\Min enhet> git version
$ git version
git version 2.18.0.windows.1




Den l=C3=B6r 8 sep. 2018 kl 08:08 skrev Duy Nguyen <pclouds@gmail.com>:
>
> On Fri, Sep 7, 2018 at 6:48 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Hultqvist <hultqvist@silentorbit.com> writes:
> >
> > > Considering that the gitdir could be located on a different drive tha=
n
> > > the workdir wouldn't it make more sense to create the temporary files
> > > in a subdirectory inside the gitdir rather tan in the workdir?
> >
> > I do not think we intend to create temporary files, whose final
> > destination is somewhere under $GIT_DIR/, in any working tree;
> > rather, I think we try to create them inside $GIT_DIR (or possibly
> > if the destination is a file in a subdirectory of $GIT_DIR, then in
> > the same subdirectory).  What you are seeing definitely smells like
> > a bug in the worktree code, perhaps getting confused by the fact
> > that the full path to these places look "unusual" by starting with a
> > single alphabet followed by a colon (IOW, this may manifest only in
> > Windows port).
>
> I agree. Auditing the setup code did not reveal anything though. Our
> code should recognize these unusual Windows paths as absolute and
> while I spotted an incorrect use of '/' (instead of is_dir_sep) it
> does not explain the problem here.
>
> Hultqvist, if you set environment variable GIT_TRACE_SETUP to 1 and
> run "git status" in G:\Test1, what does it say?
> --
> Duy
