Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3C71F453
	for <e@80x24.org>; Wed, 20 Feb 2019 16:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfBTQak (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 11:30:40 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36847 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfBTQak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 11:30:40 -0500
Received: by mail-ed1-f67.google.com with SMTP id g9so9868826eds.3
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 08:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Nj+LSKWBzi+PJMmwRKeH6eh8WhZ4EVN/2BAzma3hjMQ=;
        b=B8ZlEANi/rxMDH5wlOr4o/fT4dr2B5lweqdy0bBbX7JEoOOwoUmJtZFqd0UlEsUczz
         cvHdwYP9ZGuNOSwXNkJsrySGlSjrwNAvyTr4cPZX1fhfkSf4MnKig2SOiN/3BATtGI8s
         f6wC9wQ9t1SiCxH74jFDAP7tB+f/+6SfjOIXZxcvX91xp/TSGaaFHmsBov63GD7TFMTP
         IPCvF4xlsLHJcpwOuDzn2gTq7+JMzunQV86xd7W0Xfr2y5WI6v4EgMYHtus0LMHAaD3Z
         IOFVI3qkcxz6ay4FGjdiFUUtVjPxNhW7l0EDUtlfypcyh6ihz/Ll9DUwpUDDeyCtKekO
         hTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Nj+LSKWBzi+PJMmwRKeH6eh8WhZ4EVN/2BAzma3hjMQ=;
        b=o457hiT3vWBllJNDnjfbqTBq00IvIO555NYKlWH43IQDeFq1ELS4kGg4k+YrkjmWj6
         IEp2jDaUHuyDTdhabsa4sj5XtjvjIFA898MvQid5w3Z0o4ZZc7yjWdZK33N++1EYAl3M
         +NgUu4MGc+klGKmjc4SegKup427/3DCeTkyAyElf28TkNQHiM82V1L/wp7iKRGeTHvWT
         hF+4+j60ckbKfVTSRI4/VdkrIjQN3x+4o9aCxZkXO7sGs9+O9LY2JztbgAEBp5D0SqPU
         N8mM3NbpIbmlP84T/4u4HnKakUpOMIJPmgSezUaXq0LvBKz38Nhjn3tPxmutocgsmeRM
         IyVQ==
X-Gm-Message-State: AHQUAuYQqDGqDQBuVgDj1koHIuym3x2HiDMGfsD84UCTC4U08N3fkb+S
        QcdfApPsTSt8hO9cxPK16cPTAhToXBYW0Cn+fsycqZCCq8E=
X-Google-Smtp-Source: AHgI3IZENjyZGD4QZa+y8yan2bKA6U5R09esB6NeJrdKhgZZ3OmrGx0RDV6b+iRNHsJYzMcC/mB0lJiib8AxQWUOOmk=
X-Received: by 2002:a50:9622:: with SMTP id y31mr26444097eda.248.1550680238468;
 Wed, 20 Feb 2019 08:30:38 -0800 (PST)
MIME-Version: 1.0
References: <CABUeae_N3NFXn-E1+LHORL3RDf5iTCFn=zyuOo3c2Aot2QF7pg@mail.gmail.com>
In-Reply-To: <CABUeae_N3NFXn-E1+LHORL3RDf5iTCFn=zyuOo3c2Aot2QF7pg@mail.gmail.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Wed, 20 Feb 2019 17:30:12 +0100
Message-ID: <CABUeae9vyjWszUkfUJ7-JNmrX-7dAQDcvn9488zM4Lcr3VGwqw@mail.gmail.com>
Subject: Re: "Submodule registered for path" output with config aliases mixed in
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hmm, sorry for pushing, but no ideas, really?
Doesn't it seem like a bug?

Matz

On Tue, 19 Feb 2019 at 17:51, Mateusz Loskot <mateusz@loskot.net> wrote:
>
> Hi,
>
> $ git version
> git version 2.20.1.windows.1
>
> I'm running `git clone --recurse-submodules https://...`
> The command seems to run well and completes with success.
>
> However, I noticed strange output from git:
>
> ```
> Submodule 'Binary/A' (https://...) registered for path '!f() { ~/AppData/=
Local/Fork/Fork.exe $PWD; }; fBinary/A'
> Submodule 'Binary/B' (https://...) registered for path '=C3=80   =E2=99=
=82=E2=99=A6Binary/Intergraph'
> Submodule 'Binary/C' (https://....) registered for path '!sh -c 'git log =
$1@{1}..$1@{0} $@'Binary/C'
> Submodule 'Binary/D' (https://...) registered for path 'ls-files -o -i --=
exclude-standardBinary/D'
> Submodule 'Binary/E' (https://...) registered for path 'mergetool.Tortois=
eGitMerge.trustexitcodeBinary/E'
> ```
>
> I managed to identify where that garbage injections come from:
> from git aliases I've got configured [1]
>
> Could anyone explain what is happening here?
> Is there anything wrong with my ~/.gitconfig [1] ?
>
>
> [1] https://github.com/mloskot/wsl-config/tree/master/git
>
> --
> Best regards,
> Mateusz =C5=81oskot, http://mateusz.loskot.net



--=20
Mateusz Loskot, http://mateusz.loskot.net
