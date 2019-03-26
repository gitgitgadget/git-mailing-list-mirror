Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA5E20248
	for <e@80x24.org>; Tue, 26 Mar 2019 13:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfCZNl4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 09:41:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:36041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCZNl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 09:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553607697;
        bh=cFLJHTb+TWDNtwKr2mwe7GH62obV91nWoXEP8cx07xI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=S4vNnxvV/ZUPJzx7FAqFI47IhJkhpaEU1ytRuuXcRWVBj9jka02yBBigP3kAZwF3x
         gskX5FJNqlphOSB7WYLDjaQ00FBxWqKKB/sC+cxLECPlajdMl6WptH1PNw/vA3kRbA
         fBYZDFR/qtSc3zuTWPifIvolHBIWGkPkeuc1zswQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.144.175] ([95.208.59.4]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MA91t-1hFby547k9-00BJJF; Tue, 26
 Mar 2019 14:41:37 +0100
Date:   Tue, 26 Mar 2019 14:41:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] ci: install Asciidoctor in
 'ci/install-dependencies.sh'
In-Reply-To: <20190325214603.GA1343@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1903261439090.41@tvgsbejvaqbjf.bet>
References: <20190324155219.2284-1-szeder.dev@gmail.com> <20190324215534.9495-1-szeder.dev@gmail.com> <20190324215534.9495-5-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1903252221300.41@tvgsbejvaqbjf.bet> <20190325214603.GA1343@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1282476916-1553607697=:41"
X-Provags-ID: V03:K1:W6nHc/i1vmD9jKSbmwiGY6lgOCc7kC6jKbprI8/AcDXmprU8IB1
 StK+3ByVeEhiT4g1BMHHbekKY4akrYirmIh5cYmnejOQuaxVOtemVWabUT1Z2x1Jzzvn/7N
 DBvB174P5S2+I87NjpsFQKhv0Huw8WgojSlzovrZ/K6fh21nQ8APKR4cb5hsO8+dlTIw/Fd
 AKpl61Z8b4kqkG6jDl2mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/iDhvRwat3s=:yvEcwPh5Ka5GGhEsHmKqn9
 S9CO3sTVG/7X0G+SOwfEhrxAYaaSyQXtwGuOgeUfz5/MwwcHrhLqFBRmDHcEgvUNxVbhKfB9P
 2JbUVcxUDQMulIu95P1vfdPGyCGI69yBuWdN07X0ipURAxI4GLk9sGVkMpisZ/rK2KQloy7oO
 bPJ0kiPXw6m9ZXW+XSMWZ5tu6vIZezTAtK5XzsCD+ui0o3UhUIoohHMw1CM1sAY9uzYK5KVXb
 aI+UbOLFPJXVUA9KVtrPKkE2J6DJ/yg8kgn+WJirD/L1T9TdejLGVTcUMuhK/LeDub7JDub/J
 cye54CxcC5XIZqP35qGSbxiYVqDyCja+/UkcHeZxlSHYjk69cDIhVcxsFXMjFBmtrNf4gJJij
 hWymISqYR7YZxsNbaphkkCkvT91IQg5q2x+R5Kg5N/HdWLSfdoRvYLnf54dZkFvMujIDzL7iZ
 3qrFUmCJS9L1hjaWUuUcQdf7lu7PU409hlbOtF+BHTOhXoJaAjeALYzt9GpMaT8WfK/wSuDLd
 r6pEs01NWB+ZeUTFhrGA1N6i6oww6mSj1nNLkWXKoxOYbtV9HVxEnu9fxoIDaH776y3vqihut
 rdHOehKH1zzigspnw0GZnfyC2tIJbyDzwI8omCM4nan5UZKkUvtByOYKNOOKbKWR3ceXFPien
 oXCxOiO3ctNjXuDATxXQoJ9epm0UG5TT7Eg79w4pv6hIsRURT7LEKorKznmvvIo3BGMLLba1j
 niBkQNhx+t35s7Og77ygdLIVdaBvWkjxbP9s67vYkZW3JT9bjTMantkdjuxtCaf5OHsM1h5Q0
 jM56z/oinbL0H+juMHmHIWEyBHDlmfk5A/aZcDj/Hw6OjHUCihmCCEZ0eYeRX7Q7fYior5WNQ
 gRHZPVzhlDQH48aRL6NM+cIt+3Mjv91lZiuEWNAbexTWaElY7N2mgSp1tmKQ6qmTcGMiVEttA
 TpWffuv/IraGTLOTs3Ld0ScJ/10oCHY0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1282476916-1553607697=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 25 Mar 2019, SZEDER G=C3=A1bor wrote:

> On Mon, Mar 25, 2019 at 10:28:21PM +0100, Johannes Schindelin wrote:
>
> > I like the rest of the patch series, but this patch, I am not so sure
> > about...
> >
> > On Sun, 24 Mar 2019, SZEDER G=C3=A1bor wrote:
> >
> > > When our '.travis.yml' was split into several 'ci/*' scripts [1], th=
e
> > > installation of the 'asciidoctor' gem somehow ended up in
> > > 'ci/test-documentation.sh'.
> > >
> > > Install it in 'ci/install-dependencies.sh', where we install
> > > everything else.
> >
> > The big difference you introduce is that asciidoctor is now installed
> > with every job, not only with the Documentation job that actually uses=
 it.
>
> It is only installed in the 'Documentation' build job.

Oy, you're right!

> > Even if it affects me very little (because I don't pay much attention =
to
> > Travis, it's been too flakey for me, and it does not test our Windows
> > side, and it is too slow), I'd rather install asciidoctor really only =
when
> > needed.
> >
> > So I'd like to recommend to drop this patch from the series.
> >
> > [...]
> >
> > > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > > index d64667fcbf..76ec308965 100755
> > > --- a/ci/install-dependencies.sh
> > > +++ b/ci/install-dependencies.sh
> > > @@ -54,6 +54,9 @@ StaticAnalysis)
> > >  Documentation)
>
>      ^^^^^^^^^^^^^^

To be honest, I think it was kind of easy to miss that. Maybe the commit
message could talk about this, so that future Dscho will have a helpful
hint when looking at the commit history and stumbling over this move?

If you could add that hint, I would be most grateful.

In any case, based on what you taught me I retract my objection to this
patch.

Thanks,
Dscho

>
> > >  	sudo apt-get -q update
> > >  	sudo apt-get -q -y install asciidoc xmlto
> > > +
> > > +	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
> > > +	gem install asciidoctor
> > >  	;;
> > >  esac
> > >
> > > diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> > > index be3b7d376a..8f91f48c81 100755
> > > --- a/ci/test-documentation.sh
> > > +++ b/ci/test-documentation.sh
> > > @@ -5,9 +5,6 @@
> > >
> > >  . ${0%/*}/lib.sh
> > >
> > > -test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
> > > -gem install asciidoctor
> > > -
> > >  make check-builtins
> > >  make check-docs
> > >
> > > --
> > > 2.21.0.539.g07239c3a71.dirty
> > >
> > >
>
>

--8323328-1282476916-1553607697=:41--
