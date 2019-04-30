Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1747D1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfD3Wvq (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:51:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:44995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbfD3Wvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556664700;
        bh=dTWF3vo+kf9AaNKrBtBca1G6sEtL7XZICTAp1Z+TVio=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EiUmWEwk2Qy/DY9deKi0Z7emdk/ohUC/Nsg56tIz0SIbj/NLLiwpzi0zBTv9LPZnx
         ijA7C2l2GNzBYbIrKkRNa0jCl24H2H8TveY+16Jp20vzWX2wu5RkJ0AD90n+EM5s/4
         0Ml+PayJcv1rhu3Yf6XTknNol3KcObNaiJ46tyVk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mdvqg-1gnvXW0cas-00b3b9; Wed, 01
 May 2019 00:51:40 +0200
Date:   Tue, 30 Apr 2019 18:51:38 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -r: always reword merge -c
In-Reply-To: <a226ffff-212b-d81c-11fd-bb496b84a78d@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904301850310.45@tvgsbejvaqbjf.bet>
References: <20190426103332.9036-1-phillip.wood123@gmail.com> <nycvar.QRO.7.76.6.1904291208210.45@tvgsbejvaqbjf.bet> <a226ffff-212b-d81c-11fd-bb496b84a78d@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3Z37LxEnA2zcR30IYOWKQbAG8JFfwoUN6vvSDQVkpBEPShcuRz/
 XPP9SqQYmm6YYzjVrqQ4dTpCPS/WY1ndZ5DvjNIxGJaLiiv7JmDKyVRSws2+XwsqDyHqGCp
 S0DLt/+NV4L1TZzDXQbPQfV4y6zoFYDwXmxRQXti56cLzvELSYFoVIUG8nK9sIPk+4D1Jhb
 ChtD6O1TyKWCOqh8VBysA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mfoR/9V+xz8=:xzsdej7eR/egMImRjSfnqC
 7SMMIGnC9ZYi13/S4cwIaBwUs+nHWKt2k39kCkAr3AQRUM4lJ67dN+ST69h2pBb6e3TWTMCCg
 FYIpSQ5ePvT+BX/hAfZFaWgnTGw2OincQ2OoNu/eLtpuDbqGnvl6I9m3/Mm2eYYuwHqW3Id1n
 nf32p5d6Th1km2snX1+TKlP6IoeDj993gJOW2Y5VQdcNZ0p22JUZMA7SojC8k1oi8KjgVX/DG
 Ta+z9tTZnBt2tOG5qhKUH/uXfyRe6x9sKt0hVdSbNAxTt8SifODhbjHZxdy1vXP4P/ELrBiZK
 8AX3LyuDWpVSqOTmq4p+w40nkvruOmx3Zf0v7WemSm90I2TWF9hTdFpPQJrhpo8gB1KKSFVnl
 zvQ/m+i/dg+nC1gMhZJ94Be42VWIEghKpBi6M/eoQYtlitCn0Ao9sRczFZFKWdMOXK/ikRjLW
 ZjmW9LLGT+6fx23vlL6LmDNpxQUYpPJTRaRQiBN63qjMvZHWDBfLO99uUqT2Zt+TKlrNUra+Z
 RX4aR2XAQhkjlC82enOrOW87VKO/GT9mfhrbgrCAI2wC0NVMeisHmukuwMB1Ve88D7hN+l+TH
 yi+m9912Hi2+Hw7giQQelCVaA1J078aKFyKBjEdL/v58BxzVBjtydhE6x2r+MKOJ+FwPr8jX4
 t0NhavMd22RLpz/XdXuDMUSRMBzlQyT1XNd5f+RmZlfsqN69/qSpPXy/yxblaljJ6Z8qX924w
 h7TmSScInNmJwOK3Ma3vlG8JWQnexgCJnQl83GngYAvv91AwKLwGze/iFC1tR8kvstK7vVIJ/
 frAQjZqQI/B2amsuW7beBhDx4ddnn9jzDkkjmi9SOHw1gq0zIJfp0WsYE5HKntsmZcfuJrrk/
 P32nf8OgFHuyvmtFn0tq52y8Pvf4TthK4bwUOczx2vJ1juYEtouz9LY2u77WaOX2FzNR9c+zo
 SSyloGO2KBA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 30 Apr 2019, Phillip Wood wrote:

> On 29/04/2019 17:14, Johannes Schindelin wrote:
> > Hi Phillip,
> >
> > On Fri, 26 Apr 2019, Phillip Wood wrote:
> >
> > >     ret =3D !!run_git_commit(r, git_path_merge_msg(r), opts,
> > >              run_commit_flags);
> > >
> > > diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> > > index 4c69255ee6..3d484a3c72 100755
> > > --- a/t/t3430-rebase-merges.sh
> > > +++ b/t/t3430-rebase-merges.sh
> > > @@ -164,6 +164,16 @@ test_expect_success 'failed `merge <branch>` do=
es not
> > > crash' '
> > >   	grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
> > >   '
> > >
> > > +test_expect_success 'fast-forward merge -c still rewords' '
> > > +	git checkout -b fast-forward-merge-c H &&
> > > +	set_fake_editor &&
> >
> > set_fake_editor affects global state AFAIR (setting and exporting
> > `EDITOR`), therefore this would need to be run in a subshell, i.e.
> > enclosed in parentheses.
>
> The other test files are not very consistent about that. I'll re-roll. N=
ote
> that I do not export any FAKE_* variables, so later tests should not be
> affected even if the fake editor runs.

AFAIR I tried my best to avoid `set_fake_editor` altogether and instead
preferred `write_script`/`test_config core.editor` combos in t3430.

Ciao,
Dscho
