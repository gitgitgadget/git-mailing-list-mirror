Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75D6C4363C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 20:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A43821789
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="evDvMB8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIUUVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:21:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:33005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgIUUVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 16:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600719697;
        bh=EcKuzaiTFveJ4V9E53nQ0ijAcQzNoe5EEtGTgZr9ews=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=evDvMB8bML/x0KmjboorADTam0oSLP7e+uhl83vzdbEFUn+ObWWzlodeo0Vcots7Y
         b588VLR0Glv8J2M3r2ssqU8v9fCwbg8c54YMlBHfd/AQ0B4HqF+hQ2rryaKBdmjWke
         fQjoFFxQ1LD4uEd5Gk7GNloP/CUdztxbHiGRwABw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.93]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1kHlA70ql4-00EwzV; Mon, 21
 Sep 2020 22:21:37 +0200
Date:   Sun, 20 Sep 2020 17:06:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Git in Outreachy?
In-Reply-To: <CAP8UFD1BxnOk4-gaUQb9bY5zhAtD8Jy-x0RC=pNMSQvUaVxRmg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009201705060.5061@tvgsbejvaqbjf.bet>
References: <20200828065609.GA2105118@coredump.intra.peff.net> <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com> <nycvar.QRO.7.76.6.2009072051470.56@tvgsbejvaqbjf.bet> <CAP8UFD0_75zR3xoBzbVZjgTY2+KvORLFNMZ36s8+m6KZyNTXPg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009162206580.56@tvgsbejvaqbjf.bet> <CAP8UFD1BxnOk4-gaUQb9bY5zhAtD8Jy-x0RC=pNMSQvUaVxRmg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5W2k5ETAiPtVX5oRG8jJmOk3KnyoUHTaWlZ5pMG4065kpK96uhC
 defK7FxBM+mEs2lk3KaoXcsMuOxbl35JIxY8O6RzT2ucSY372+qD3QMnaMMoWUHjKYi4Tiq
 dKtgyCxF9IIZF6gZsLf9rV8iH2o1FTpDP0evsKs1YxwfARW31aIc3h+S42UL7+FcWp5BWEG
 VFb3h8rDO5JM4oAaIqfnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dAFhk0jhkkE=:PaO3PfbFSLQmfxvkQBcHUm
 aRe7QJSvCQfgAT/+tMDPOGgTEBrtab+fDk/uVSd6i/TYmNSbWtsjrNQ9PQIwqnV+Vuqw7AA94
 NQMEA6aoI/v20k3duRyHuwyMulXiQqjPWOTvfHYcIv7xrwRs4BU230qbRs8o5fFJZaza7ez3j
 Unvs6DRASTTAFfIqRWiWX4yCU3NfKrPMb1f/wxmw+4OTKC0VenlgfonqeVCp2jEJq7Of+91bA
 ywNC5TDKm31QcfOcwfyuE3XqeSdRgXye5xagoi+n1JRjGrhmOhgOMPNVOEcMFv6IJNKLogjiG
 wafjuQ2xc0hM17md9bg2ht/ytc9a/9bWYr0R5gaQQlT/GkB+0YKjPKWxOSoXCr57Xtr/Iqori
 TlANn22rmPlT+FFRoZLOCq6+8HBVk8xrpOm8uYq/Pbzd7lILcCuBBIYDT7u1YNGQk71wMTIAU
 ONCQ+evoHIGeAsUgK1qiUgiCH401SEF3ZWLY9JR/6vY2lJlgKuSGS6ejNbSRQdX+CFKulSNEa
 nsVHHEmB2SCeuxtvUaIu6Zzp6buMJVQteqb4NXm030sC/6UucPwL/Qk3YyTFo3xo+nZuLQeZg
 N7+VO2Itr0ExCAgiHp6T5vTekyWHlPOz5vrddM9kJJI5UyDvzM14IOaDrq/fqAzw3sLKpo0JD
 PfV2E44WuilR/K2O0rlQWE5v9b2CZiLL8MBjT6hxJOa5tdwUuUQDfBCsqbj/0vZ1v6vh2QOUj
 /eywiaN1XNQzE9Row9/qXbRSkJRYw9nUh82tXpSgbpCs7fgnq3taX9MQHBgblEccxAqeHpH3M
 u3AW+Jqx6/cXJGLczyucQ32Dvbl1PHwV9we+DzU0ng1jt/ZO3hSaUeEL5Sl3g5SFaG2pG62dT
 DZgrWw8N7oxXVnaJt1VLVPAKWD5OiVp6J2+PDw4vkiwQVPW4K/75/XNfavMjU0ZCljf9mi3h9
 W61frh3qjgdvD/EPwrNC4jH3HrpAcRET7OHqHK4U8C56oxMJZ5VVUs4vDMWgxzasjlQe/c+cI
 BrWE8gQoHTApXqo36qiQRLoeU9RMU+tfnurMtk2vd7Irxh6LOKphkUhkdhu4LHuZu72zpnZJ9
 cGU2tZUUpqj9MG/mkrNqbZphOyOATSOjjQLmXtNl6kxVGXTtoVWj/jw8aZVpXtkrPzUCqMsKx
 6X/Bbymltbl1PpAXiTGFWihT53PeEJr170+0+vzvmsdnxKhD7ikXCwePGUMSlqOwVWLLhO4My
 DPvbQ8qckRv3HbetaaS38rhg+2b/T0Tanw4yUcA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Sat, 19 Sep 2020, Christian Couder wrote:

> On Wed, Sep 16, 2020 at 10:27 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Wed, 16 Sep 2020, Christian Couder wrote:
>
> > > To summarize more, it seems to me that only the following scripts
> > > could be worth converting:
> > >
> > > git-difftool--helper.sh
> > > git-mergetool--lib.sh
> > > git-mergetool.sh
> > >
> > > I wonder if they are really worth converting though, as they should
> > > probably all be converted together and we would likely also need to
> > > convert the scripts in mergetools/ at the same time. And then there
> > > should be a way to still easily configure things for users. So perha=
ps
> > > a better way to approach this would be first to convert the scripts =
in
> > > mergetools/ into config files.
> >
> > The biggest problem is that they're all entangled.
> > `git-difftool--helper.sh` sources `git-mergetool--lib.sh` and uses qui=
te a
> > bit of its machinery.
>
> Yeah, I agree this is an issue.
>
> > As to converting the scripts to config files, I'd rather have them
> > hard-coded in the source code.
>
> I am not sure what are the pros and cons of hardcoding vs config files
> in this case.

The thing is: `make install` does not install a Git config. That's why I
want the defaults hard-coded.

Of course, it should be possible to override those hard-coded defaults via
the config. That should go without saying.

Ciao,
Dscho

> My opinion is that config files would make it easier for people to
> contribute what's needed for new tools, while hardcoding might make it
> more easily extensible for us and might reduce backward compatibility
> issues.
>
> > I would then probably try to implement the bare minimum for the
> > `difftool--helper` command to work (re-implementing in C only the part=
s of
> > `mergetool--lib` that are necessary), and only in a next patch series =
work
> > on `mergetool`.
>
> Thanks for your opinion on this. For now I think it needs to be
> discussed more before we could suggest it as a project.
>
> Best,
> Christian.
>
