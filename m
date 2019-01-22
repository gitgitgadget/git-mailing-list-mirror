Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A5C1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfAVV3P (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:29:15 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:45978 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfAVV3P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:29:15 -0500
Received: by mail-ua1-f44.google.com with SMTP id e16so8595720uam.12
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cdhXHwv9+lcYkIixlW9SrBWWLOj92warNXPcs7EjivI=;
        b=UqnNALrKM2zQAGDKWnvd0MOmsXFN9y3eJloNfFru74GXdLlOk+oZKy7Ih3CSvUPnLf
         ta/hUtGqE6WIFblsLmT2lmcu06qfO9XfM0trHGS/r3FmXxSS6EzK86eBfayf+HPWkp4x
         4gm94uT/SizeprFEjwtMoT+81A4pCA8nsWFt3ZUvdW7jXvvRCtWyQX/q5GUzRtfVNoNa
         7DLLOwL1AhNT90zMbVZ+eGN3GCDQ61QJzOA4wWV7brA32zVPsiBwH4k6rJ9+mGC+3Fec
         MKJJEN/DsI7Y5DwF+tYIxIZh0buP0FhPRGQtuv9rbUIVSwkSdVdeypGXZrbEKXYDzbw6
         BOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cdhXHwv9+lcYkIixlW9SrBWWLOj92warNXPcs7EjivI=;
        b=XbpT/5WCHHAH/IN6R2Qg6Cfm7FJtlAMq9FNXW+6lwc/D9RG8NNOB9XhAAVVdMKptvi
         Aa5gh6Hix7+QxTpKzUpEVJDDQIwJFfStYcF0dftz3O6krZF+lUdnEostx6kYtY+SJ+iK
         wLT422MtVo66RyoDs0VX+/yOyO8U6N51zADK6JK8NVADwVi1/dmd5l4/+5WcZx7M0cBU
         dcLGP8RaJFdsqRWM8cq2cpz5KA5cAJLjUUhu48NNr4kAxx7VEXhyUVAVEhFoqRpJGQNd
         NVz5zSvSA9vPkHc+dRVnYNjMB1gAzu6RxW/wd+UmdDBTaQY7Q5u6Nsz8MlX7WLRTlp2X
         FIBQ==
X-Gm-Message-State: AJcUukdOggMOZrSlKtvPq0M5y44SUwNdUFONrZRVoeZD9k8Kq1HqjKzc
        aOryGLQ+yaLMnBjADA5Pg2jhVcQLhjuZ+2GwQr+Mrg==
X-Google-Smtp-Source: ALg8bN7uylrpn88kRlqbv+jlbgbWkhvBMeDTu9U6iIYKdppQRorfw+MALpLR/ZMH/9dTOdHTC1LkmQ7cD1eKxE4bAHA=
X-Received: by 2002:ab0:60da:: with SMTP id g26mr13997829uam.104.1548192553767;
 Tue, 22 Jan 2019 13:29:13 -0800 (PST)
MIME-Version: 1.0
References: <5C47833C020000A10002F499@gwsmtp1.uni-regensburg.de>
In-Reply-To: <5C47833C020000A10002F499@gwsmtp1.uni-regensburg.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Jan 2019 13:29:02 -0800
Message-ID: <CABPp-BFGfWPAwKLMMMLdLu856UvrrSMYjYWXeVUxEqpspBxbsA@mail.gmail.com>
Subject: Re: Q: What happened to "--no-commit" merges?
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Tue, Jan 22, 2019 at 1:05 PM Ulrich Windl
<Ulrich.Windl@rz.uni-regensburg.de> wrote:
>
> Hi!
>
> Using git version 2.16.4 on OpenSUSE Leap 15.0, it seems that "--no-commi=
t" no
> longer does what it did before (AFAIR, but I mostly did --no-ff merges in
> SLES11):
> Like this (sorry German):
>
> > git merge --no-commit local/f-linux-firefox
> Aktualisiere 520aaae..c11e3da
> Fast-forward

Ah, a fast foward, so there was nothing to commit; it could simply
update the branch to include commits that already existed.

>  bin/fval.xsl | 133 +++++++++++++++++++++++++----------------------------=
------
>  1 file changed, 57 insertions(+), 76 deletions(-)
>
> > git status
> Auf Branch f-linux-firefox
> nichts zu committen, Arbeitsverzeichnis unver=C3=A4ndert
>
> ### "nothing to commit"
> git log indicates the changes were committed already

Indeed; the changes were committed before you ran "git merge"; they
were all part of the local/f-linux-firefox branch.

> Reading
> https://stackoverflow.com/questions/8640887/git-merge-without-auto-commit=
 it
> seems that without "--no-ff" this ioption is effectively ignored.
> If so, I suggest to tell the user that --no-commit is useless in this cas=
e, and
> let him confirm that he/she wants the changes (merge) to be committed (de=
spite
> of --no-commit).

--no-commit, to me, means don't create any new commits.  But you had a
case where there was no need to create a any new commits: your branch
(f-linux-firefox, I think?) had no commits that the other branch
(local/f-linux-firefox) lacked, but the other branch had at least one
you lacked.  So, merging could be done by just moving your branch
pointer to include all those existing commits.

If you want the branch to not get updated, then yes you'd need both
--no-ff and --no-commit in some cases.  But that's always been true.
It's possible in the past that you just didn't run into those cases.

Now, if you're suggesting that --no-commit should imply --no-ff,
that's interesting.  However, you are fundamentally changing the
operation at that point by making it so that a merge commit will be
created when the user runs `git commit` at the end -- it's not clear
to me that users will see a merge commit as wanted or needed and
having --no-commit imply that option might break expectations.  I'd be
more inclined to tell users who want --no-ff behavor to use that flag
and/or set the merge.ff config setting to false.

Alternatively, we could update the documentation to point out this
special case under --no-commit to point out that when an ff-update
occurs no commit creation is involved and thus --no-commit has no
effect.  Would that help?


Elijah
