Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D2D1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 12:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeHaQqI (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 12:46:08 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:43952 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeHaQqI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 12:46:08 -0400
Received: by mail-oi0-f51.google.com with SMTP id b15-v6so21334928oib.10
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 05:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mintlab-nl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lrDNxNoCwKOqUfkU0k1iXL/WtWY6vGoTqIZ0TLzN3a8=;
        b=m/BGbxMX+7U3eYHfI6PJnKq2vO2YHGkqyRknG1cvdjdVZUxzZpAsgLfyinEZHgKm7c
         ayDTkj5b1CtKyURQse/n1K9nyvpeYYLoUITJeco1hlrmAYD5+fAMfH0exhq2AWc557Xs
         G0B5UYJz+RM1rNdBZmSa740H0zy4Tr445pTn84v938mwMz72wUo8YKmTmUoq4TR/+E1b
         Igj9zH+50ysfZhK+kxMVZ+AsNmIQjHpt2nHiPEeMHuCD+LjgobJkgKCaVUQiBfD9qc6w
         wEkwIGtmyKLJU7y7lrE9jJaZA/eN8iCOZQ8K/d/govaPKo3Q7Ai1q/FW5Nm6WKeGXhdF
         ZD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lrDNxNoCwKOqUfkU0k1iXL/WtWY6vGoTqIZ0TLzN3a8=;
        b=Yim4tiFLi+ZE2Rs0OkxmlotK2mJiyPvm/cUG1D+T297bAMJ7phfOukvreliV3Q7JbY
         ThWgGPK7EVlcAe8WJHRvorgLxpVjxwGPZw/tAhxNyNk7KJJPXm3PHZIAKBjpn3g59kcv
         /BCE5oq1qKuOJUy3eIu/npuItMuFTyvDvrDZ36fRkyFHj2+3DaGgZTuHIuVcR3lMXnDI
         Opza4VhjaCMZ+lsVqI0s5tl2A/+WVJUHWzp6S5vvX7aXANboZYn723HT+GiCey2fC7ZF
         em94/0wsWRhc3knO1/mdw/Tuv+zskl0Hc/Kz85uZodUqkp8bpG1pvKazGeuTYZa5wG3/
         TaSQ==
X-Gm-Message-State: APzg51ArvKu/HsGJGoD0yOsJFzwxNVkzO11DwIs3uU1rT7f+u2507f1P
        vYxPtnhJE+p7mAv2EDa1tSxzn3EpPIFK+UCmijOMHM39kak=
X-Google-Smtp-Source: ANB0VdartKbxsNasGMafeAEQFEhGBKmRFli7ERTs0Iqo1doaUvMdF8nv2CnmXV0yOm7E+KS06+Zncof3yY3pu0KK1Yk=
X-Received: by 2002:aca:c141:: with SMTP id r62-v6mr1471200oif.179.1535719128734;
 Fri, 31 Aug 2018 05:38:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:1c19:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 05:38:48
 -0700 (PDT)
In-Reply-To: <87pnxzdib7.fsf@evledraar.gmail.com>
References: <CAEpdsiYHri8FJ8VohnwxmPwDM4-0J4J9Zb9wTZjYYRnYqsb=nA@mail.gmail.com>
 <87pnxzdib7.fsf@evledraar.gmail.com>
From:   Wesley Schwengle <wesley@mintlab.nl>
Date:   Fri, 31 Aug 2018 14:38:48 +0200
Message-ID: <CAEpdsiZFMphQTdJnqFYH03M80W8CcrCbr2Uewktm0jy4D+Fz1A@mail.gmail.com>
Subject: Re: Feature request: hooks directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git mailinglist <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hop,

2018-08-30 16:45 GMT+02:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>:

>> Solution:
>> We discussed this at work and we thought about making a .d directory
>> for the hooks, eg.  $GIT_DIR/hooks/post-commit.d, where a user can put
>> the post-commit hooks in. This allows us to provide post commit hooks
>> and allows the user to add additional hooks him/herself. We could
>> implement this in our own code base. But we were wondering if this
>> approach could be shared with the git community and if this behavior
>> is wanted in git itself.
>
> There is interest in this. This E-Mail of mine gives a good summary of
> prior discussions about this:
> https://public-inbox.org/git/877eqqnq22.fsf@evledraar.gmail.com/
>
> I.e. it's something I've personally been interested in doing in the
> past, there's various bolt-on solutions to do it (basically local hook
> runners) used by various projects.

Thank you for the input. Do you by any chance still have that branch?
Or would you advise me to start fresh, if so, do you have any pointers
on where to look as I'm brand new to the git source code?

From the thread I've extracted three stories:

1) As a developer I want to have 'hooks.multiHooks' to enable
multi-hook support in git
Input is welcome for another name.

2) As a developer I want natural sort order executing for my githooks
so I can predict executions
See https://public-inbox.org/git/CACBZZX6AYBYeb5S4nEBhYbx1r=3DicJ81JGYBx5=
=3DH4wacPhHjFbQ@mail.gmail.com/
for more information

3) As a developer I want to run $GIT_DIR/hooks/<hook> before
$GIT_DIR/hooks/<hook>.d/*
Reference: https://public-inbox.org/git/CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBr=
L_PiEQyLmCzLUVxg@mail.gmail.com/

The following story would be.. nice to have I think. I'm not sure I
would want to implement this from the get go as I don't have a use
case for it.
4) As a developer I want a way to have a hook report an error and let
another hook decide if we want to pass or not.
Reference: https://public-inbox.org/git/xmqq60v4don1.fsf@gitster.mtv.corp.g=
oogle.com/


2018-08-31 5:16 GMT+02:00 Jonathan Nieder <jrnieder@gmail.com>:
> A few unrelated thoughts, to expand on this.
>
> Separately from that, in [1] I mentioned that I want to revamp how
> hooks work somewhat, to avoid the attack described there (or the more
> common attack also described there that involves a zip file).  Such a
> revamp would be likely to also handle this multiple-hook use case.
>
> [1] https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.go=
ogle.com/

The zip file attack vector doesn't change with adding a hook.d
directory structure? If I have one file or multiple files, the attack
stays the same?
I think I'm asking if this would be a show stopper for the feature.


Cheers,
Wesley

--=20
Wesley Schwengle, Developer
Mintlab B.V., https://www.zaaksysteem.nl
E: wesley@mintlab.nl
T:  +31 20 737 00 05
