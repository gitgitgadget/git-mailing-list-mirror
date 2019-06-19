Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1CA61F462
	for <e@80x24.org>; Wed, 19 Jun 2019 11:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFSLaA (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 07:30:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:44133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfFSLaA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 07:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560943792;
        bh=5SZve2mKrAfR4PBOp4Npd0kQb2Xa006nZ8J8Xk3Dbcw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JKlohqmywcr28OpJdXL310AMyGiH7V0HD+P/7WsSJnG65L80pYFwvZoDUzs2WkKbG
         Mq6P752slosilc1ftRPXpnK39T//irraiJ7HmXhotOCMHWBoWQcSwJ0yaWOdek+joS
         WoqMbqgUVRrirNryCBgXpsMZlqfVy5huqrys7+Lw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6DWi-1hfja33Ta4-006gM4; Wed, 19
 Jun 2019 13:29:51 +0200
Date:   Wed, 19 Jun 2019 13:30:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] t0001 (mingw): do not expect a specific order of
 stdout/stderr
In-Reply-To: <nycvar.QRO.7.76.6.1906191325130.44@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1906191329040.44@tvgsbejvaqbjf.bet>
References: <pull.149.git.gitgitgadget@gmail.com> <d551cdeafbf2953ba340aa16554fbd5ac6194a6e.1560860634.git.gitgitgadget@gmail.com> <CAPig+cQaoRBnH0JrUwXTo1hSwjrZ1vJHewjCAkKPeCrRwo=P2w@mail.gmail.com> <40cfbb30-c632-54da-62d9-9b31bc878806@kdbg.org>
 <CAPig+cTTAgYia6DUOrg7AuLmGSbqn5u=iy3wx-=--NJuyULwaQ@mail.gmail.com> <nycvar.QRO.7.76.6.1906191325130.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bPHXzKTLaW80X74JHzOz0QQd6KPp9Y8BO+C/F62+gEf48RICHhA
 xT3Ca17nuZMvNlAixhOEFyfkeEXAoZNddY+JMSalW8SnU5gBVsJEzhK4eLaO/VNu16cEmao
 S+Cf8wuKsNaDipz5N0RriFXwqbNumrYwTDG5YXIID6iDd1mXTJMzAqDrPXrhSX3jwPCUhub
 wr0UFBT/do5jA3tArgnHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1+GcokYEpLs=:Qm6BECsvv5f7AdYwQ1QX04
 uvNPHphHp3rjRaiY0YXK81+iZ0M52ANaUR+sN94Lf1VsKQf8Zew+5ymInw+C47uhcMlZOAavn
 rB/DwsvucIpC73ygUIs1UhFNKyTDE4ar9oTojY0u3eCyCpvjsdSHK5bEIV3hjO7Gga1hVdvJ7
 ICokH+7eTBl5ViEZP290McOcMxAvaA9W0LGhOa8T8/yWDgqVKucRccs1uyilESzagA9ch4z7J
 jz1ClKR15iJKbJAN7UfFttdM3MCChuqU3ByCVPEXDazT0y0c3OsdWkr4XZ2rUdYomR1ibmCLz
 NKBJDFYjpjNlDWEXfoOHRa5w0p5ha8EwWPWVu0cZN8s+i0NqBiQGFrXs4a1hROgy/oh51shNf
 bHD13oFEV/wdyy+3D0TFx6GRL/dgGahHNFpZBY2MrQat0bKj4XdV/LFKjuimY2Vn6bxLD6uBz
 9VNms81IssBzt3xMgHZUrWmPLqnzHUk5jFzrcngDj0YTKuy0Tp/2JPDD5EoHn+G/hEC0zW9Mp
 LKV5FMmdpjzVPYlenreFRt/TGtqdhMhSEsZ+rcEuBJGnzF7E7e6bbGIBx6n/lWOCXNM1AyI59
 VF4/+bD9ry8YVUGKBVHU7FrEDWYoGlsngDJvOAOljnsiWWjg0R8+zjo/0dnTnRjI8xpqzrnFb
 Jrw/DbKV3O/AHZfB4mMVNOmJfiqCmgnUA9iIh7qF17lZvwPhBlb2q/N+bq6T5GaHcNHbtParg
 BlmgP76ciNbrtvWp+tIj0VToyITQ4TbTz5rOf28GBPU3GOFJojUqaB74Ad9SdKLyUTloT3x1L
 TvoMyXbMI0vkITgvqvbTErpXD4Jnmx05ar0Mf7Fyf1MbW0Z49ESiVJWEM/6Sn2/mOUe9bHJ1F
 RHyAVLgnGLYECEeaRtzXNw/NO9ODHw86jZtCCPe+x0FSyGRIbCMrlCTyLoVBDKVRZR57Jz8Ff
 3jzrK0TrshT58c/EQcNLfYaRx2U/H7yPwHRfMmShlXSps92SnOXp6
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 19 Jun 2019, Johannes Schindelin wrote:

> On Wed, 19 Jun 2019, Eric Sunshine wrote:
>
> > On Wed, Jun 19, 2019 at 2:19 AM Johannes Sixt <j6t@kdbg.org> wrote:
> > > Am 19.06.19 um 01:12 schrieb Eric Sunshine:
> > > > On Tue, Jun 18, 2019 at 8:24 AM Johannes Schindelin via GitGitGadg=
et
> > > > <gitgitgadget@gmail.com> wrote:
> > > >>         printf ".git\nfatal: Needed a single revision\n" >expect =
&&
> > > >> -       test_cmp expect output.txt
> > > >> +       sort <output.txt >output.sorted &&
> > > >> +       test_cmp expect output.sorted
> > > >
> > > > It was quite surprising to see this sorting only 'output' but not
> > > > 'expect'. I see now that 'output' is already "sorted" (in that sen=
se),
> > > > but it feels fragile. More robust would be to sort 'expect' as wel=
l:
> > > >
> > > >     printf ".git\nfatal: Needed a single revision\n" | sort >expec=
t &&
> > >
> > > Following Dscho's recent objection elsewhere that tests tend to chec=
k
> > > for much more than regressions, wouldn't it be logical to write thes=
e as
> > >
> > >         grep -F .git" output.txt &&
> > >         test_i18n_grep "Needed a single rev" output.txt
> > >
> > > without an 'expect' file at all?
> >
> > I considered suggesting that, as well, as being more obvious and less
> > fragile (with the exception that "Needed a single rev" isn't currently
> > localizable in builtin/rev-parse.c, so plain 'grep' instead of
> > 'test_i18n_grep').

Interesting side note: I just realized that t6050-replace.sh does indeed
contain

	test_i18ngrep "Needed a single revision" err

so I wonder why that works.

If anybody has an answer, I'd be curious, but for now I want to focus on
this here patch series instead.

Ciao,
Dscho

> Valid points all around, thank you so much!
>
> The next iteration will have the two `grep`s instead,
> Dscho
>
