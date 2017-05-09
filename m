Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAA91FDEA
	for <e@80x24.org>; Tue,  9 May 2017 13:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbdEINko (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 09:40:44 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37535 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbdEINkn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 09:40:43 -0400
Received: by mail-it0-f44.google.com with SMTP id g126so1600055ith.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oype+gMUfa6tJflmjYZEbs7yzJNcugK4VYP82Vg5POk=;
        b=l6sPrfWMNosLpHTVlPYlZ7m9V5FSx4/cqjZHedPgKLlJUttS9izdgQ7GEC1o9anBv7
         09B9meS6L3TtvE0VL5UXsbZzvoPmFgyBNywXFPvBVwZOwmb4tCPfmti+T2yQXXF9Lkf3
         bwQlOCIvMZ88FcPTwXhGvLXRv7NwHIxoPkknm/7g03EmHW79/KtDhHSGXnoRwXFGTEij
         Nsab4JJ71FnlPwSOoDv3XpuilP8ZQo/coEq5TJnrCKXv0vxcg6Vp81OaioHs38Oepz7r
         ATCVvMkus+k/WuGr4KtJIw4sC1qxZG8PyKIWUWC7YSD3fQ9Q4F9LCgtST6nyw5qVVFiH
         W3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oype+gMUfa6tJflmjYZEbs7yzJNcugK4VYP82Vg5POk=;
        b=N005x3B516tJEj13v6SHPnKv/aPfUSLhe29iyZ8fXiOHCBfGqLkcd10AZ192PVqgui
         98rtKx/asbiFHgQg7KFCJSWX/4FUwOWa1S3Ea0Pj+KVOEsn4OXB5wUAqmEaibDVS3y32
         uRXg0EEcQX4QV80/uw054SCMXrvRY3NDqkIraPONKLxyzdiLxCdPWimmM4bQ79J0K/Ih
         J7blz0oW/EQbtyPmTJ3Cgk2J0Eg1UBdTATyM4HZAwC7yehapbynfNpFzkx7p/GlUDfYI
         0gxwCq46clMHSwZOd18XS8kPJ6kBeLjrWmoh1PFuo1q4Iv3g5xaAgI8fohiGGF5ffkaN
         k+bA==
X-Gm-Message-State: AODbwcAzNVSM/iMh0Tv+dwTqwFqQNZ5GO/PdzwZmG01mEJHodO1dVCfd
        WIsaK49im5VLA3HGytLDaMz7ReXTs1AXzJU=
X-Received: by 10.36.37.78 with SMTP id g75mr266224itg.94.1494337242755; Tue,
 09 May 2017 06:40:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 9 May 2017 06:40:22 -0700 (PDT)
In-Reply-To: <etPan.5911baaf.74b0dc51.6b4c@MacMini>
References: <etPan.5911baaf.74b0dc51.6b4c@MacMini>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 9 May 2017 15:40:22 +0200
Message-ID: <CACBZZX4p=h7G2F+khZL6X2LSccPBpa__Op+ouO4mPAY9=2r7rQ@mail.gmail.com>
Subject: Re: Would this tool be useful - encoding repository data into single URL
To:     Sebastian Gniazdowski <psprint@zdharma.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 2:48 PM, Sebastian Gniazdowski
<psprint@zdharma.org> wrote:
> Hello
> I wonder about usability of following tool. Quick-start:
>
>     giturl https://github.com/zdharma/giturl -r devel -p lib/coding_funct=
ions.cpp
>
>     Protocol: https
>     Site:     github.com
>     Repo:     zdharma/giturl
>     Revision: devel
>     File:     lib/coding_functions.cpp
>
>     gitu://=C5=AC=E1=B9=BD=C7=9A=C7=ABo=C5=92=E1=BA=976=E1=BA=8F=C8=85c=
=D0=AD=C3=91=E1=BA=A9=C5=91n4=E1=BA=A7=C5=98=D1=97=E1=BB=87=CE=B1=D0=83=C8=
=A3=CF=9F=E1=B9=88=D3=9B=C5=80=D1=97
>
> It does Huffman encoding and base-1024 encoding to pack given data into s=
ingle URL. The Unicode characters selected for base-1024 encoding are lette=
rs, not symbols, so double-clicking in e.g. web browser selects the whole c=
ode, making it easy to grab a repository data.
>
> Decoding:
>
>     giturl -qd =C5=AC=E1=B9=BD=C7=9A=C7=ABo=C5=92=E1=BA=976=E1=BA=8F=C8=
=85c=D0=AD=C3=91=E1=BA=A9=C5=91n4=E1=BA=A7=C5=98=D1=97=E1=BB=87=CE=B1=D0=83=
=C8=A3=CF=9F=E1=B9=88=D3=9B=C5=80=D1=97
>     https://github.com/zdharma/giturl / rev:devel / file:lib/coding_funct=
ions.cpp
>
> I can also encode commits relative to given revision, e.g. bits 10011 are=
 commits 1, 4, 5. Easy to add to the g-code. Selecting 10th commit is only =
1 character in base-1024.
>
> However I wonder if this has any uses. Could be patches sent this way? Ha=
ving refs/patches/<name>, encoding <name> in URL, sending it instead of inl=
ining/attaching a diff, selecting e.g. 3 commits via the bit-mask mentioned=
. That said, it's more about easy-grab of repository data and storage in we=
ll-defined, consistent format, not in language "the branch is ..., commit a=
7a35cb". Does this make sense?
>
> There are 2 implementations, in Zsh (uses Zshell like e.g. Ruby, not inte=
ractively) and C++11 (mostly because of std::regex):
>
> https://github.com/zdharma/giturl
> https://github.com/zdharma/cgiturl

This looks really cool. Yeah patches can be sent this way, see
Documentation/SubmittingPatches in the git.git repository, online
version: https://github.com/git/git/blob/master/Documentation/SubmittingPat=
ches
