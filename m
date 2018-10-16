Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA9F1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 00:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJPIMD (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 04:12:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33045 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeJPIMD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 04:12:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id q40-v6so23749454qte.0
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C99wXu6f2DOOfiLJ+Va13Lol+8KNaWUhVIlFAqjrVko=;
        b=UH1/GwupCctkQHjQyG3lnGbR7xAGYHk/ZjkPZJW1yWF7RPefEU9hicrpwb96ysbkAT
         /04DFi8cLtuNwbODZXk7LGmYeUAstcVmKC8wrJW8KZS7sevaFznHafcQ46I17o6pgAJw
         rZ8/P6sU0qOiD3VgPJQohhMINm/5Y4QV+8g3RRajN1PNl9xPS4EIQKHmqGhmQKoIwhGg
         WQIiFN9rvkdsNsSrSvkgi2ebV+zrAsVI2oQIt0AcqFRereE5SLhNLkc0GZ0mp/M/sstu
         v7xe4dKCWqd0bjQ/IZ/Jygs9BVzDMlvRYocIm/h+359xWdgolu5rHJWbKdmaY22uJYa0
         LWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C99wXu6f2DOOfiLJ+Va13Lol+8KNaWUhVIlFAqjrVko=;
        b=nx0YnwnB3iPg6nNR0QSlqsuyl4pBhsMjmiTYZSeKUBad+oDTC+3ef6R8eTwSrdUc98
         6SVUYS8e4NsaXpdWqk44d7C+szInJsCfyVh1l1RManP+9du5tSO3qspgSeYpCtwpuKpz
         rTeamAI13r0WaM+e5F4IHqgIw407QAC7yZhgY/N4Y9Yv5/i+q07K8dUuHlgAcZnH/nWa
         Yr5CeKYEWuKS4VgHBpaU6cuRrsEQyIJnZi4Lc97U+NV/dXaHwOIW8PKf4nWjwWq+pJcd
         0vtfchEoc1/FfrsOYAZD/IysUYy24mXzOIoGwC87OqsTBRQ7/0ulitmPde4war+tuqFL
         m29g==
X-Gm-Message-State: ABuFfoiwh58kuw9qNoC/nl8LHx6eKOfDyeajWB/eYshWsK3r9jaMxPxw
        8D5LgkxgVWkv4VvfxwBruoajIBtd0lUEVB4ux9RiyduU92M=
X-Google-Smtp-Source: ACcGV60AlGMH2VkZVVpVi684eFnWcFYDRbdj3621xTLJdrWWevvlLErbNIit9QBSV5e5IxCjy08sqWFQ/67Kjmnr9UE=
X-Received: by 2002:a0c:c591:: with SMTP id a17-v6mr19500485qvj.183.1539649462825;
 Mon, 15 Oct 2018 17:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <8736t7dzan.fsf@evledraar.gmail.com>
 <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com>
 <CAP8UFD3cpXpyx-AtTybPirzduFR7TfhFf2woa-_CU46DN3RaXw@mail.gmail.com> <nycvar.QRO.7.76.6.1810152032140.4546@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1810152032140.4546@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 16 Oct 2018 02:24:10 +0200
Message-ID: <CAP8UFD0SAwHMfRN8a=LsbChQhHC=Lsi5t6yvmQ4FuxjDXZtSTA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team Services
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 8:33 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi team,
>
> On Mon, 15 Oct 2018, Christian Couder wrote:
>
> > On Mon, Oct 15, 2018 at 5:46 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Mon, Oct 15, 2018 at 5:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> > > <avarab@gmail.com> wrote:
> > > > As an aside I poked Junio via private mail in late August to see if=
 he'd
> > > > be interested in pushing to gitlab.com/git/git.git too as part of h=
is
> > > > normal push-outs.
> >
> > People at GitLab also have wondered if it would be possible for GitLab
> > to host an official Git mirror, and I think it would be nice indeed if
> > Junio could push to gitlab.com.
>
> AFAIR Junio does not push to github.com/git/git, it is an automatic
> mirror.

On https://git-blame.blogspot.com/p/git-public-repositories.html there is:

"Copies of the source code to Git live in many repositories, and this
is a list of the ones I push into. Some repositories have only a
subset of branches.

With maint, master, next, pu, todo:

[...]
https://github.com/git/git/
"

> GitLab could easily do the same.

Yeah, GitLab could easily create an automatic mirror. I think it would
be a bit better though if the git repo on GitLab could be independent.
It could make things more resilient against outages or security
issues.
