Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00CC1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 12:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJETQf (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 15:16:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38706 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeJETQf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 15:16:35 -0400
Received: by mail-it1-f193.google.com with SMTP id i76-v6so2387874ita.3
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 05:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9NiMoXVfEECcyaJsRqOJuWS4t0j6jg7hUWd5Dj4Kusw=;
        b=OfuuTmnod5yEt1yaOfBJojOFqM2i+aMjaUmOAYA+8rXI/0lRs5T0CiD6DRb3wSUB3o
         SJdXzdAngep9iYLOxJDnG3EgeoQYjum0GhWW4gz1K9zVhch2G4idU3fQT8Lhji+aTGhy
         0nBXocTDtDBVFF7P9vo1RVxw78CgwWEZa/XqS7UKEQiFhqmQdBCzgMxAm2nlKLR+YHSO
         70Jxx5ay0M3JC2nsMlmqcsaHbNEi4WEgcReWh7f5qB3golg4aFyFEbygdDNQmcSMnBxJ
         ERTFAIAZLIL132wD0shZcf95mPn2srUvL05J3j96Gz3Ol2HIqWQJJ/ccaQyXzlGstkRc
         aSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9NiMoXVfEECcyaJsRqOJuWS4t0j6jg7hUWd5Dj4Kusw=;
        b=ehZ52tLt51nUCMYbSyQ7HbbMc95ROX+myi4w3JO8YpioxfzRrVPy0VYSR1JIaUPfrk
         wtoV9bhqmLP/OVimoqTdXFSsfJx992ASvPlxFaZTAsoWHd1lEZfC11ChUKQ9Ri+pfKir
         SQadVmh+grhu3MuEx2QgkjT7GvTLicpK+LSX0HjH/rbUi8Sn2DnVyY2QYC12fF0vv6ul
         /Av+sz8QTRKNVAdZMFbMlvWkhuHgREthO/cAkXYea0MOJLkgUxUe0efLkbugt4UjyIXt
         VSofog0srqLzCKfEHeW8sZ2HvuXsMk1ZsyS07miomDm2FNIYNRT196ppxDQkPIjdX+Hp
         CCpw==
X-Gm-Message-State: ABuFfojX/Nd/ZsFlm1NUc71rnlHQUH6d5cfB8mZsIN6hfiPlIu4hZjBx
        kS4oKJpqBw/WQUXGexPRY7KzpAoECYZLNGsILi4=
X-Google-Smtp-Source: ACcGV61EoSk5GksProNQpeyp+dHZfg4Hf4Tlf/hrdn6DSV/NMci8eLmR12sJuPK0BEvA5nqfHP1oalZs5293bj8rqO4=
X-Received: by 2002:a24:141:: with SMTP id 62-v6mr8164914itk.97.1538741886350;
 Fri, 05 Oct 2018 05:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxccB1VnDV5BjkcFcoPVmegJSg6iN_tD3o0e9G2XKXaM_=4KA@mail.gmail.com>
 <20181004214533.GS23446@localhost>
In-Reply-To: <20181004214533.GS23446@localhost>
From:   Eneas Queiroz <cotequeiroz@gmail.com>
Date:   Fri, 5 Oct 2018 09:17:54 -0300
Message-ID: <CAPxccB2B2Cq=CQZ3D8rmvqc63pUV3f1hc_Ngt5nWStR-getpjA@mail.gmail.com>
Subject: Re: [BUG] Error while trying to git apply a patch; works with patch -p1
To:     szeder.dev@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Em qui, 4 de out de 2018 =C3=A0s 18:45, SZEDER G=C3=A1bor <szeder.dev@gmail=
.com> escreveu:
>
> On Thu, Oct 04, 2018 at 06:01:11PM -0300, Eneas Queiroz wrote:
> > I've sent this to the list 2 days ago, but I can't find it in the list
> > archives, so I'm sending it again without files attached.  I apologize
> > if this is a duplicate. One should be able to reproduce this with the
> > current PR files, but if not, I can provide them.
> >
> > I've hit a strange error while trying to apply a patch from github
> > here: https://github.com/openwrt/openwrt/pull/965
> >
> > 965.patch:452: trailing whitespace.
> >
> > 965.patch:559: space before tab in indent.
> >              -o $(SHLIBNAME_FULL) \
> > 965.patch:560: space before tab in indent.
> >              $$ALLSYMSFLAGS $$SHOBJECTS $$NOALLSYMSFLAGS $$LIBDEPS; \
> > 965.patch:564: space before tab in indent.
> >         -o $(SHLIBNAME_FULL) \
> > 965.patch:2334: trailing whitespace.
> >
> > error: package/libs/openssl/patches/100-Configure-afalg-support.patch:
> > No such file or directory
> > error: package/libs/openssl/patches/110-openwrt_targets.patch: No such
> > file or directory
> > error: package/libs/openssl/patches/120-fix_link_segfault.patch: No
> > such file or directory
> > error: package/libs/openssl/patches/1.1.0/100-Configure-afalg-support.p=
atch:
> > No such file or directory
> > error: package/libs/openssl/patches/1.1.0/110-openwrt_targets.patch:
> > No such file or directory
> >
> > If you get the patch file from
> > https://github.com/openwrt/openwrt/pull/965.patch and apply it with
> > git apply, it fails.  If I apply the same file with patch -p1, it
> > works fine.  I've tried it with git 2.16.4 and 2.19, and they both
> > fail with the same error, and at least 2 more people have confirmed
> > it.
> >
> > git apply fails even when using git format-patch -13 --stdout as a
> > source, so it is not github doing something weird.
> >
> > The file is a series of 13 patches.  If I split the series after the
>
> So this is no _a_ patch, then, but a mailbox of patches.  'git apply'
> is supposed to apply a single a patch; apparently 'patch' is more
> lenient.
>
> Have you tried 'git am'?
>
> > 3rd patch, it works.
> > Also, if I use https://github.com/openwrt/openwrt/pull/965.diff, it als=
o works.
> >
> > I'm not subscribed to the list, so please CC me.
> >
> > Cheers,
> >
> > Eneas

Thanks for the reply.  Is that expected behavior?  git apply seems to
work in most similar cases.

git am works fine--although it complains a lot about whitespace errors
when patching *.patch output files.

I know they're just warnings, but perhaps git apply/am should suppress
them when creating/patching a *.patch file, since context lines in
'*.patch' files all start with a space.

Cheers,

Eneas
