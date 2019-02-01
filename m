Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097181F453
	for <e@80x24.org>; Fri,  1 Feb 2019 09:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfBAJvv (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 04:51:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39284 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBAJvv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 04:51:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so6726243qtj.6
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CmgCoQbFaz23YRSO66fW4S6YlKkj2Zxq7AJ1eeY+6yE=;
        b=DT0uW2sFPq9qKdfx2xm2yk//TGGAxvPKHXHAcPYPIlgZrkx+NXf4oTnn8ppGtI+e7z
         Hv4J14vFiQiSCbCt5vOTXGGMM7IBq81ndY9MknecyNm0fgmVSR9ETGYvH4ZfXrALMUTv
         DQ5QeDMrEdAa1r9qXvjyJ4j0VG+bwknpSL+N2JcFre1orYrCxP4l70i6xaAlfZoC2Khw
         rDGpbBhocIpIPgHnU1kAJ7e5FUogJEfAuhbw2SgQ7/uDKXvwT1k8CekoZR5/zooZRPbt
         SPt3WhBdsL3xyoL2Cyo4qUq6/hxWsuPzUJ8ivpU16MCVa1mCpbGg0HJwObXkXPsTokcj
         k3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CmgCoQbFaz23YRSO66fW4S6YlKkj2Zxq7AJ1eeY+6yE=;
        b=iwD9gH6G03t11uhpj/hfCFbEDmptllFIr0suwRd66fubJ3IWOGtsSL2nY59Munuch0
         Z8juB9ioQUsayTeapxi8fQuJmiIqiYRs+3gaHctGUaX5BNu4gt37bpaGbf+GVUlQoRhV
         AMdKsD2yu332pTVRydDPB9uOxOnEluHYHPcxl7VHFvR+doLAIVJWtlv/LgEK1eqj+ymh
         7JtAA++L7UkeITH/yL3c+Zpw1C+mapJ+o+yWKp4ABbvJl6QcXFbt9RS+jkZGWprgdGf3
         iQqWY/qQwP7cap94GnNum7woGSyWaIE2GCbg9/D0obtXg4MbQRYVb8GSUqznRtTHKAOG
         DZ5w==
X-Gm-Message-State: AJcUukddXyyCOibJWLh+zkk5xAbn8oOUiDSWKcHQ2L98PCbYTJYQYEnp
        ADE0bH9xB4DgFNc3qtkL1Tb/Efijzp8I8A9ya9A=
X-Google-Smtp-Source: ALg8bN6aNkMv2ARagLmTXoRtURkjrxLRtA7FhwThlkIs2ugiE43RY4KerlMPf0OsYGy1I2IpQoaAAFAlZoFM6XmewFU=
X-Received: by 2002:ac8:f6f:: with SMTP id l44mr38932441qtk.158.1549014709986;
 Fri, 01 Feb 2019 01:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20190112091754.30985-1-worldhello.net@gmail.com>
 <20190130114736.30357-2-worldhello.net@gmail.com> <xmqq7eek1ozm.fsf@gitster-ct.c.googlers.com>
 <CANYiYbG5vbV1bqbHu-u19XFy7JTpcopg0s=JWAhJBRNGvP7j3g@mail.gmail.com> <CAPig+cS84BOPdrZ+e1Z9ystx6SDyON0MJxVySQyxYE=LYcNRdg@mail.gmail.com>
In-Reply-To: <CAPig+cS84BOPdrZ+e1Z9ystx6SDyON0MJxVySQyxYE=LYcNRdg@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 1 Feb 2019 17:51:38 +0800
Message-ID: <CANYiYbGtXnhLdFCHFfQxT=tWyXGaq1gfuKuhxe1D7crXo6LSHQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] t5323: test cases for git-pack-redundant
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2019=E5=B9=B42=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:11=E5=86=99=E9=81=93=EF=BC=
=9A
> > Everything below will be done inside master.git?  Avoid cd'ing
> > > around in random places in the test script, as a failure in any of
> > > the steps that does cd would start later tests in an unexpected
> > > place, if you can.
> >
> > The first 10 test cases will run inside master.git, and others will
> > run inside shared.git.  Only run cd inside the two `setup` test cases.
>
> That's not what Junio meant. It's okay for tests to 'cd', but each
> test which does so _must_ ensure that the 'cd' is undone at the end of
> the test, even if the test fails. The correct way to do this within
> each test is by using 'cd' in a subhsell, like this:
>
>     test_expect_success 'setup master.git' '
>         git init --bare master.git &&
>         (
>             cd master.git &&
>             create_commits
>         )
>     '

create_commits should not run in sub-shell, or variables set are lost.
I write a commit_commits_in function :
    # Usage: create_commits_in <repo> A B C ...
    # Note: DO NOT run it in sub shell, or variables are not set
    create_commits_in () {
           repo=3D"$1" &&
            parent=3D$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null) || par=
ent=3D
           T=3D$(git -C "$repo" write-tree) &&
            shift &&
            while test $# -gt 0
            do
                    name=3D$1 &&
                    test_tick &&
                    if test -z "$parent"
                    then
                           oid=3D$(echo $name | git -C "$repo" commit-tree =
$T)
                    else
                            oid=3D$(echo $name | git -C "$repo"
commit-tree -p $parent $T)
                    fi &&
                    eval $name=3D$oid &&
                    parent=3D$oid &&
                    shift ||
                    return 1
            done
            git -C "$repo" update-ref refs/heads/master $oid
    }

and use it to create commits like:

    create_commits_in master.git A B C D E F G ...
