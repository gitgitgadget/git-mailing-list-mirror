Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51731C1B0D8
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1783023DE5
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgLJXGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 18:06:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:57915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732810AbgLJWcI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 17:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607639432;
        bh=f4eamYEvUhWyapNsMLVwKkGX7DANrAUDXld5a6d4RM0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OY3uJTSU04unmmnUBfC8tzYRj5Prgjkz7DyW5KasL84Ecra9xW8e76GOx7PfgLXGD
         MUd9xaKfXLy03qCX3xZxPmisWtSBDJWeWbPF80nrQt/2IDHdk8koeyvu0M9L623hOi
         jyWivHYKCjN6atOHdHlaP8AOuLslDqcoRnLdGY/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1kiYmI0zH0-004yG3; Thu, 10
 Dec 2020 23:30:32 +0100
Date:   Thu, 10 Dec 2020 13:12:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] init: provide useful advice about
 init.defaultBranch
In-Reply-To: <xmqqblf21v9e.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012101309590.25979@tvgsbejvaqbjf.bet>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com> <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com> <bccef953913da629057b3e9b211bc54081fa4475.1606173607.git.gitgitgadget@gmail.com> <xmqq8sarljfn.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2011240648160.56@tvgsbejvaqbjf.bet> <xmqq8saqjx2n.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091513540.25979@tvgsbejvaqbjf.bet> <xmqqblf21v9e.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RQj04nr07E655VaDXyKpQAuLWf8Amk3F7U2DieoXwzwJt+c/WVT
 5qk85jKMZqM7gcMywGsw/pGXcVFhbWXqSm8SlMwz2IibwvQQX/DtGUNZCTP8WuLXmV3CIUY
 Ugv4Qw2re3e28lpsuA2VjbQwRBWZj+23xz760cD/5qVftKlclG+OwCinwaIKsR+7EXkdHTR
 IA49gXAfEMjIYSRbfjBDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zghRDAlaJkQ=:VaPIXycxZAwUI7WNJFTRTZ
 XbLJe6yVOb3MOILBytMxiLYHbHG/xKFDDlUlO+TLqrE0E9/NDlz27r0UdMc6v11Vy+49uOWRM
 1BmiEXCNgXehJVg5AINBUPc92P7Vvgdwh2vE03X1MdIojMgorvlpbjsPgB4rISAsw0LsG5lyP
 CDrZVwl10UZ+whzSQOW0FrdIAj5BsqIb/kjcRQJpzUb/Zt3lm+NlQMQfepevpHU3z3ZQpLZ/O
 qXozgOEi2cfoN4QrNX7k700eBuE0uHtWFk/dCeg4jJZzmNRe02AqXFbARqs80W2KictZ4J4Pf
 YVl7ekn5C0ChJ5mskXnxDLWnT3CDQoS+SuocBm02ddcUkba0jz5vA4yaJPqmdp8WaRo2fffdA
 RzNIfefBICcaSgaZ9WNKONzMJP52ZiSV+Fix+UVYukCBzPvJiNq89Dsm4ix71u26YO3vs42UF
 lOIa+eYcX2Qax5hRaB4TAIE7XymolS1dUfeYjtuY+OEaqCuF8zA2oxh8knvZ2NnhmkaXOPolz
 AIGbhZ04D2wsGDGJIqg/W4IbrALhM/yRs1Iv5f+DdCX3mdTBQrUrEdWU8PaS1PSj/ovjIiso7
 NTvzpjlHJjdNWxUXumFykAxV4iFVCWx1lcDJg5NEjhjraPDEl1DsEYPVvlnzhGCD2jR//50An
 Hw3M/KWQscACVxq/IfUvbZLFZ/TApTI6JkBlR3ItBd6sWDH7OuoiFp5DJB2O7Oxtw0/jKWM1d
 AOZMY7STlCdriwi0MnfOFjm2Ly+A/8m/rXBEn/poSKRKfhjrfWLs26AQiJkz7qrgRFrpqKohR
 gKmangRfRybAru1S/vaGQvC03utHyKPpUnxg3NLafUAnl9ppOdZ1rU9ATl/Tsm6qwOP19kC+9
 OOD8BfuNUDKq8FJx0X/nTOzw2E2mOnAdPnFfSp/8U=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 9 Dec 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 24 Nov 2020, Junio C Hamano wrote:
> >
> >> I am not saying it is a legitimate need.  I just wanted to make it
> >> clear that we deliberately chose not to grant that wish in the
> >> message.  An advice flag in this context means that the users can
> >> choose to let their distro and sysadm to flip the default silently,
> >> which is much worse than having to see the message every time they
> >> start a new repository with "git init".
> >
> > The distribution already can add patches, so this objection is a red
> > herring. The sysadm can pick a different value for `init.defaultBranch=
`
> > and dictate to the user silently what initial branch name to use, so t=
hat
> > is also a red herring.
>
> The "setting init.defaultBranch is the only way to squelch" approach
> means the ~/.gitconfig will have the settings soon after the user
> starts using Git and /etc/gitconfig will not allow administrators to
> force their will over what the user decides to use.  Distros adding
> patches to strip configurability by setting init.defaultBranch in
> user's ~/.gitconfig?  Is that the kind of possibilities worth
> discussing?
>
> So, no, your counter-argument above is nothing but a red-herring.
>
> If you want a counter-argument, please explain why "I am fine to see
> the default flipped to whatever the tool picks and having no control
> over when the flipping happens" can be a sensible choice for users
> with what kind of workflows.  The only folks I can think of who
> would be fine with that are (1) those who do not create the second
> branch in the repository and will stay on the primary branch
> forever, and (2) those who immediately rename the branch to what
> they want after "git init".  For other folks, such a choice is a
> disaster waiting to happen, and it just feels irresponsible to offer
> such a choice, at least to me.

I'll make this short.

I talked to a couple Git users whether they'd be fine if `git init` used a
different branch name by default, and everybody I asked said essentially
"yeah, whatever, I don't really care".

For that reason, Git for Windows' installer has that option, and will keep
offering it.

Ciao,
Dscho
