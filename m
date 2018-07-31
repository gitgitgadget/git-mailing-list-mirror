Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1461F597
	for <e@80x24.org>; Tue, 31 Jul 2018 15:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbeGaQoO (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 12:44:14 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35548 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeGaQoO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 12:44:14 -0400
Received: by mail-vk0-f47.google.com with SMTP id p12-v6so7666151vkf.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DNdPhPESmS9HPB9yqYW7P2cDoMaMiLb2kED4/grd2pY=;
        b=EB3wmZJMuDVLrn1lL9jVSnY/+lKDE/bVCzsXCePkJV0c0R9S7mX/CjDqPYSNXcXeTD
         MOSOU/yqJmFbgCDTcCDn3cR6kEg+xg1UhGa00a9kkjq5T96CycnnZ7TJj+gswLw/y/ZO
         6AYHoryKJluxv4Ch6VTN0aBksbVwfHhPclCcBg25l3xh9NMLlaVDf786zYYIedjLEJz+
         7/yxe/e6v4ZGfqFAQ3pumvwasHUVJkEUST+V1Uk/MWkZurvtmtO4Cd948Xxp9H+viAYV
         TZ4UvzCkJvKA05JhZUECp1c9hqxszhywZO4M0ElEpR/qL3UUTaIe5RFC097yDupbrkce
         8V9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DNdPhPESmS9HPB9yqYW7P2cDoMaMiLb2kED4/grd2pY=;
        b=m5odh7STYke7PJRkfb0ZMM2DpqrTgZO7uTCksiKiq4sHFzNGiMxkKwYPeQFRx5f+ii
         /C/10aWI7eAUQGDhnBmLiGzRqQ0EoX2CpFlK83vHYK+QTp0y7hZeIfiLr4sW+02JcI4F
         WZ/ZrWiXifrM5vmYtIAkB86fPnlFF0VLL1/a8CmxyGzEp9pWYRxIZOIiyHJBkXVotdhS
         Cmrk19AGJfquonCMX2ghKKdmMJ/KE241MribG7VnxgjU284wozA6W3Nfe8Kdnx22MNHB
         WPU1jERpaBAeozzyEAi6VDpcsxgGK0wWUxQJfHPp2WmMcySuXYHRXZDshu57DPPnjFJl
         mcAw==
X-Gm-Message-State: AOUpUlGENuecOSqYDRWrTG6pHZXd0Czn7OHtGfo4Tu1bBHM/sIS3HKlr
        qqhqVqYEmodElpehrGyKo6Lw8s6DNdGD7akp+NeRDSC2
X-Google-Smtp-Source: AAOMgpeaYQrwE2uiOBsLqImsVo1OpmW1cKU1Qd/plxA/Jc0iS6rZAVrVVnAUkwkukKWtI6M8hxT2XdT2kirMLdUYhUE=
X-Received: by 2002:a1f:e0c3:: with SMTP id x186-v6mr12557890vkg.91.1533049408409;
 Tue, 31 Jul 2018 08:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
In-Reply-To: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
From:   George Shammas <georgyo@gmail.com>
Date:   Tue, 31 Jul 2018 11:03:17 -0400
Message-ID: <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
Subject: Re: git merge -s subtree seems to be broken.
To:     git@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000006959c805724ce16d"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000006959c805724ce16d
Content-Type: text/plain; charset="UTF-8"

Bisecting around, this might be the commit that introduced the breakage.

https://github.com/git/git/commit/d8febde

I really hope that it hasn't been broken for 5 years and I am just doing
something wrong.

On Tue, Jul 31, 2018 at 10:09 AM George Shammas <georgyo@gmail.com> wrote:

> At work, we recently updated from a massively old version of git (1.7.10)
> to 2.18. There are a few code bases that use subtrees, and they seem to
> have completely broke when trying to merge in updates.
>
> I have confirmed that it works correctly in 1.7.10.  The 2.18 behavior is
> clearly incorrect.
>
> git init
> echo init > test
> git add test
> git commit -m init
>
> git remote add tig https://github.com/jonas/tig.git
> git fetch tig
> git merge -s ours --no-commit --allow-unrelated-histories tig-2.3.0
> git read-tree --prefix=src/ -u tig-2.3.0
> git commit -m "Get upstream tig-2.3.0"
> # Notice how the history are merged, and that the source from the upstream
> repo is in src
>
> echo update > test
> git commit -a -m "test"
>
> git merge -s subtree tig-2.4.0
> # Boom, in 2.18 instead of merging into the subtree, it just deletes
> everything in the repository, which is clearly the wrong behavior.
>

--0000000000006959c805724ce16d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Bisecting around, this might be the commit that introduced=
 the breakage.<div><br></div><div><a href=3D"https://github.com/git/git/com=
mit/d8febde">https://github.com/git/git/commit/d8febde</a><br></div><div><b=
r></div><div>I really hope that it hasn&#39;t been broken for 5 years and I=
 am just doing something wrong.</div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr">On Tue, Jul 31, 2018 at 10:09 AM George Shammas &lt;<a href=
=3D"mailto:georgyo@gmail.com">georgyo@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div dir=3D"ltr">At work, we recently updated f=
rom a massively old version of git (1.7.10) to 2.18. There are a few code b=
ases that use subtrees, and they seem to have completely broke when trying =
to merge in updates.<div><br></div><div>I have confirmed that it works corr=
ectly in 1.7.10.=C2=A0 The 2.18 behavior is clearly incorrect.<br><br></div=
><div>git init</div><div>echo init &gt; test</div><div>git add test</div><d=
iv>git commit -m init</div><div><br></div><div>git remote add tig <a href=
=3D"https://github.com/jonas/tig.git" target=3D"_blank">https://github.com/=
jonas/tig.git</a><br></div><div>git fetch tig<br></div><div>git merge -s ou=
rs --no-commit --allow-unrelated-histories tig-2.3.0<br></div><div>git read=
-tree --prefix=3Dsrc/ -u tig-2.3.0<br></div><div>git commit -m &quot;Get up=
stream tig-2.3.0&quot;<br></div><div># Notice how the history are merged, a=
nd that the source from the upstream repo is in src<br></div><div><br></div=
><div>echo update &gt; test</div><div>git commit -a -m &quot;test&quot;</di=
v><div><br></div><div>git merge -s subtree tig-2.4.0<br></div><div># Boom, =
in 2.18 instead of merging into the subtree, it just deletes everything in =
the repository, which is clearly the wrong behavior.<br></div></div>
</blockquote></div>

--0000000000006959c805724ce16d--
