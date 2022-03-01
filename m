Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E04C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiCAKVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiCAKVg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:21:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC449F1E
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646130048;
        bh=k1xtuAKNUpXIOWLMIgXnUVMzltG1kEzvvMBywRllUeY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R8StOSNgOaAK3bKmGBm2z5i/CVFIy2EIHSjx7b7krUFFGPhHN5BiIqLugmqd0pwx0
         thODTVuoHiwzVaIaaWwNPIFOutFmVHDXXJVKssErbuudE55hqqDyMzApRKkkc7+0j7
         kBq1B0QebJy44+zpcwp7HbasYNJ/efqHhHufMx60=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1oOLeS1Npo-00znrh; Tue, 01
 Mar 2022 11:20:48 +0100
Date:   Tue, 1 Mar 2022 11:20:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     phillip.wood@dunelm.org.uk,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <xmqqv8x2dd7j.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2203011119000.11118@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet> <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet> <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com> <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet> <xmqqv8x2dd7j.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-791238658-1646130048=:11118"
X-Provags-ID: V03:K1:7j27Jp72ElOX32oIqy8LSz40f6tRJGSHacMYMqtD5dKtCGH8Pnd
 fC1VyoZNoIJdWU2EtWU8gOLOoPqxlUgE5DWcR46R1jTuy3siHDOMm0DxWTLoka1JpgkBG9a
 MlLH1S7YdOED5DmXhiHzgAUoEoWzXSB9FV/I0mqJCRVQ9r6qpDa655g5YPunkBUVGuIxOhI
 VHobm3UJP/j88NfO/nppQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uiL7CG3WyWU=:xJPnA7kWVMtb0QCKiTYYsN
 YLayQn5C36BsA/uVUjG8bRE5HPhbaq0hXq3xpwrFkPKIgGbQt5IOSKT1r1tgvB+sOST7k/EdU
 Cuo2QFAxRcBLakq/avAx2mjmKGNvJwJMLpFjenb+kA72JEsRUKpH3sDUDs1FzPAvYsr4qeSds
 0REw3D8ENhqwiAtmIM8NRhUNnyCY2QFu1GodR5eeKrbA1TUPf2SAmWriJUHnwP1PhG87RUWZw
 DnpALFPwfpkXpLQyQL9i4YmmeTrk8+fym5kMEfPQgoGAefyuz/ezghQ729LnyZr1X2lJ5b7/+
 XPZCwAqZ3LEAyvXge3+ePQgRCLXjwakSCu9M+fhueEis/kW6sHyJfKCVNVPu0Bfpi6xd5olIr
 kREEEv5cvqbPUAxA4U/x/wMKx3/uNodQzR6FR8dS+ECeIkfHejQp0sIcc/50qTaJ0WyoSAane
 48aRe3ljDVSbQ1oADSGvTkostU/aDSW5NMxjYu+phUIv5GPXLhoxjpq5eIKfxQ5X9LicfSDQX
 HvqKZ3m3LCK3/QUQr7gBfdVZ292PZGh4At+MTaYgHqhmHcDz1IT15PDsBr0w98sSz5OzG9yDd
 GZqU4I3y0fOOn05pZ91IId0NP1RSHib0fV0Agf/C9SWswnuc+U11Ej2UuoZOijz8gKP+3n401
 IWnNuRY+0HrGBfTdJqtdFj+EWmer5QPurA4B+z2bZo20+ZakfXwd+iwzjLJ/V2s9p2taaMa5A
 /Zf0QffXZlM9isfU7E8i+cSZOnBA/9MPioDORJovY0vv5MJq0q5FKt2PNp+XK8C5DQt+uCpc1
 F5jknjDhzJcQRguC4qe44kIXtsfRw5AigXP3pZyZZWz6BEmL2WczkWHyKgqJ38+S3fffX9daK
 ujNfqxZWj2GmQ+zdjYh70YLPuEUXgzWIAJBUTMxnwNkOzi/zCpazQe+adq8r6CjlkvKInb4cL
 9eQdYMGLmFu9NLjSJGPrhb2P9HzQTPrvJNpjxnw9veCY8HjpHOAG8q80lQW/eneySfCTQu6jE
 Ky+EHAHNJPojIyjBML3EdQgw2Wu+4+jNpKP6PWmuWYlEEzRYVS3P9sOGmskxYxBSJvfY/dBcD
 aLJQBhrEY5MEj4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-791238658-1646130048=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 25 Feb 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On that page, you see the following:
> >
> > 	Annotations
> > 	50 errors and 1 warning
> >
> > 	=E2=93=A7 win test (3)
> > 	  failed: t7527.1 explicit daemon start and stop
> > ...
> >
> > 	=E2=9A=A0 CI: .github#L1
> > 	  windows-latest workflows now use windows-2022. For more details, se=
e https://github.com/actions/virtual-environments/issues/4856
> >
> > In my mind, this is already an improvement. (Even if this is a _lot_ o=
f
> > output, and a lot of individual errors, given that all of them are fix=
ed
> > with a single, small patch to adjust an option usage string, but that'=
s
> > not the fault of my patch series, but of the suggestion to put the che=
ck
> > for the option usage string linting into the `parse_options()` machine=
ry
> > instead of into the static analysis job.)
>
> It is not obvious what aspect in the new output _you_ found "an
> improvement" to your readers, because you didn't spell it out.

True.

The difference is those added lines that clearly indicate not only the
failed job, but also the precise test case that failed. All in the summary
page, without requiring any clicking nor scrolling.

Thank you,
Dscho

--8323328-791238658-1646130048=:11118--
