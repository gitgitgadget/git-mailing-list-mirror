Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A5A1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbeJAWfC (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 18:35:02 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:36186 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJAWfC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 18:35:02 -0400
Received: by mail-it1-f170.google.com with SMTP id c85-v6so12168134itd.1
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 08:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aXUpmdUWgUJYqd1xc1vAiVWR3/pCpWbXkwxE7L1taMM=;
        b=U7iWD25NPnOj20mUGoTm+YuODFvFGkr90XoAcpED5JX1awoYNA1aj/BenoJSgLt47q
         nbfjc2avydb2TXqifEiYf8hFSAO3EIf7uiSDVvhouOQa0JupPoDpY/WmWLNUmwA+zovj
         r8SWYMNhcGc/pmE+g6MUVuR1ODkGb1yFIf96m0xdf1H52Bazrldvj0tYzDYmNX3HfG92
         pieMrWcqvUuwMbupkzJSJIiLcE0s2SYb6Dx4+jwLtn54CDFkFqKwJqfd3XZoc/m43mMK
         MJtqN6nAwYa93un4v8y59kIMIWy2GpgPLspMOVl3F5DdpuvdvQ0dMiYH6qLdJdZIUslX
         yr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aXUpmdUWgUJYqd1xc1vAiVWR3/pCpWbXkwxE7L1taMM=;
        b=aLupkM1HGmpVcd+NiQR7w9DpJet0X5yYbgM1FDJ8v8cJEMmOoao5m09VFWKJ3P9tOK
         I+CU9udtUoG8enbLXnCsUxD51RSAC9vKWhlRepaipmpXVndOzPMn0rTtmjD148T3lS95
         H8Kx5DsIn+oGLc3MR/3mfBBYHirRWhj40g3gpAtzaKjFHud5LEZ+RRcfQNf9HnB9T8t7
         8LTx1/P+vPqynY3evK2fOJXDQK4xFBdmw8iGVJLldJ+sQlJ8vX1BAtZ05M1Se3Ckzr9S
         9gEo8raIzn1o2k4CK262sWoSvBPxg2M518+mlJT+AAoSOOiB7TMgrDhxjopGkXx7Nq1Q
         GsaA==
X-Gm-Message-State: ABuFfohRQqN4BjTWA4raJMWP4uAEtpKcpHT55KQZJYMx/ansE6YT5hHl
        HRJQB2JRDtbtZT3DZ28ygabus6U45Lekh5DZMXQ=
X-Google-Smtp-Source: ACcGV63r+7mXEjI7jfPk/kPgBeV143YfedmbkfRG0TTiGFj6gdsyGMOOyy7X4z+zxrluaXtiqy6IUpcEv5mX9PC4Hds=
X-Received: by 2002:a02:1211:: with SMTP id i17-v6mr8622386jad.47.1538409393880;
 Mon, 01 Oct 2018 08:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAEdN-uV6giCp6FbC=J3B--6_kEzFkG8Yq4VXgGnhoNjERsXSQw@mail.gmail.com>
In-Reply-To: <CAEdN-uV6giCp6FbC=J3B--6_kEzFkG8Yq4VXgGnhoNjERsXSQw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 1 Oct 2018 17:56:22 +0200
Message-ID: <CAP8UFD0D5pu+6e25KeHFUKAFHf966tJ3j-3bhigFcSfr_UmVzg@mail.gmail.com>
Subject: Re: [Outreachy] Introducing
To:     giovana.vmorais@gmail.com
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Giovana,

On Mon, Oct 1, 2018 at 4:04 PM Giovana Morais <giovana.vmorais@gmail.com> w=
rote:
>
> Hey there, Christian and Git!
>
> My initial Outreachy application got accepted and, looking through availa=
ble projects, I was really interested in `git bisect` one, since I want to =
take my C skills to a next level and, of course, have a deeper understandin=
g of git itself. I think it will be a hard, but awesome challenge. (:

Great!

About possible projects there is also
https://git.github.io/Outreachy-17/ but only the `git bisect` has been
officially proposed as an Outreachy project. I hope Dscho (Johannes
Schindelin) will be ok to submit one of the 2 others soon and to
register himself as a mentor or co-mentor on some of the projects.
Please add him in CC, like I did in this email.

> I took a look at the patches already sent but I'm still lost of where I c=
an start contributing. Can you guys give me some light?

We usually ask Outreachy and Google Summer of Code applicants to first
work on a micro-project before starting to work on a bigger project.
There is https://git.github.io/SoC-2018-Microprojects/ for that though
it is not up-to-date. Some micro-projects we propose might have
already been taken by GSoC students last winter/spring. Sorry we
didn't update the page or create another one. Anyway there are some
micro-projects there like "Add more builtin patterns for userdiff"
that are still valid and still good small tasks to get started working
on Git. And there are explanations about how you can search for
micro-projects (especially how to search for #leftoverbits on the
mailing list archive).

Thank you for your interest in contributing to Git,
Christian.



> Thanks a lot!
> --
> Giovana Vieira de Morais
