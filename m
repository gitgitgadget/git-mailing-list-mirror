Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FA61F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeJWF7H (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:59:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:55977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbeJWF7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:59:07 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWSwU-1g7Xx92J10-00Xah9; Mon, 22
 Oct 2018 23:38:45 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWSwU-1g7Xx92J10-00Xah9; Mon, 22
 Oct 2018 23:38:45 +0200
Date:   Mon, 22 Oct 2018 23:38:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2018, #04; Fri, 19)
In-Reply-To: <xmqqmur8yyi3.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810222306180.4546@tvgsbejvaqbjf.bet>
References: <xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com>        <20181019124625.GB30222@szeder.dev>        <6e4fdcdd-6c50-a07e-74b7-1fcd15c33444@gmail.com>        <5f0fb76f-0774-3545-38fc-b86137f747fa@gmail.com> <xmqqmur8yyi3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:URl1eb86WO8GmL9Lx4RMW2HNy198o+T+a/uiDNBDt4VlJDgw7Jh
 21faplKuB8Vc81oeidgLUWLjWlThqdOwkdwa8MxLTJcog7D4miXRL57TmPEcELAkOPZB6xI
 xWIFk/OX7LS9ucU7zNe8wRlkcj3uK7x8AYvtnaYhhi+Y/SfNHz+myhyoNZj/3fzjAY370gT
 uN0U6r6DRvSEPsZDasR0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9nJdxLySbyk=:OM2bOCGER2BRjXjPu+N1lI
 FhtyD2d/SzO5JuApaALXQLImJkXUfyygw8MKFKrCGm7e/tT8r25ptuUoUuLgaAJXsh1eqlph/
 vduZMRPKwuilHmkVOn/S6PhUH4rtCqEYv4Hb4HmEdP+IxqGxnV5wsA5Ij2usYOBy9IBXuuwsK
 64Oa/1eHua+ZODPvUKtZnHRCBYOC4zhxdR9hYGhT5aQHzlK1WSDg4CzfLJgozFKLXl0Tv/qLp
 zsjmW5FCU28E72r7abd6ZfXNuTlRAA31JB/wM8TXwUNuRD1ZU2LTUWXItP4pyJPEDUW7oPXbu
 QfI+pgPbqosrLJgjDaNAaauJr1WWp7uAiLG3UbJcfEqpa0exKZcvmTueVofAWKxxQIC88ho0z
 1ydgFuEFCPPBd3+Mu/RS7y/ce7w+WO5QpgP4G9I4EfndDpq12Rc0Iktl8c1cwi0yuEZxmhIO+
 yhSrSYsmKehcr5o6zHxBJLAoVokow/r8pZazdkDEH6CEG44z0aNuN1CsJpwpj7ZZfVA5OKaKE
 oFLc3AJG+OYWkp01w9QtEwd8lytL0gRPWR57x39zz194S38Xrg30hEQC0tJEtH7E4yK1krva5
 VS9kH6TYD+Uv4iSpOsJkIsqo1ObjtzFk+9D8VbbStFi4bPz1XajJWko56RRXSUD8cxm/AfV/l
 g/HyVGqHU7Lrf6VZNzKsDtn37UOUBzX4wms5wGYdKOruZjdS0p50y1JAU1JviaNCyOVlu3xBI
 AxaJ95BWdumUzo09tip46+WuCBF+i8MOgSa0uUohxPmU4KxPNfOyDl5KRNtuyTHkyThnKB1Uf
 u0g7D9tEQLkHhwWSgVB0+34I8dCP/E3z5sWluQOYqQ+wSpFhf8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 21 Oct 2018, Junio C Hamano wrote:

> Alban Gruin <alban.gruin@gmail.com> writes:
> 
> > The error comes from the call to `git stash apply $stash_id' in
> > builtin/rebase.c:261.  When $stash_id only contains decimals and no
> > letters, git-stash tries to apply stash@{$stash_id}[0][1].  Thas was not
> > a real problem with the shell script, because it did not abbreviate the
> > object id of the stashed commit, so it was very unlikely that the oid
> > would contain only digits.  builtin/rebase.c shortens the oid[2], making
> > this problem more likely to occur.
> 
> OK, so make "rebase in C" a faithful conversion of the original, the
> code that lead to builtin/rebase.c:261 must be fixed not to pass a
> shortened oid.  I suspect that internally it has a full object name,
> so not shortening would be the right thing anyway, so regaredless of
> this bug, it probably makes sense to do the fix.
> 
> But as you said, even the scripted version that passed the full
> object name had a (10/16^40) chance of using a 40-hex that only has
> [0-9] and caused the same breakage, so such a change to "rebase in
> C" is sweeping the age old bug under the same rug, in the context of
> discussing this particular bug.  
> 
> I agree with you that it is a better fix to the problem to allow the
> caller to say "I am giving an oid---it may (or may not---I do not
> even bother to check) consist of only digits, but do not treat it as
> an index to the stash reflog."

We already have a way to say "I am giving you an oid": append `^0` to the
hash.

I implemented a fix, pushed it up to GitGitGadget, and will submit it
tomorrow (after a fresh look, and after the build finished):
https://github.com/gitgitgadget/git/pull/52

Ciao,
Dscho
