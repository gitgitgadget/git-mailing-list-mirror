Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965B6C433E2
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AA420707
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WAjclFw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393652AbgFWVc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:32:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:41305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388972AbgFWVc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592947935;
        bh=I56h89nlS2pC2x9K9jNH0Nv0WiVhj9WyyfX4sH2gtng=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WAjclFw8ihNd+w50gm+LIwcMU9qhzPJozEbrwoexP4dwlM6eQfZzxnqlNREM5r+OX
         jMSErL949N/X9UOKqgnISFzIS18QsoyUNzB1K6N6C/l+ubX4qfb5TDaiH+FI8g8TdM
         jS83sJcoNNhTAfIzh6JiRwuLBWMPECyfe99gEQRw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwUm-1j0QCJ0jGu-00uIhu; Tue, 23
 Jun 2020 23:32:15 +0200
Date:   Tue, 23 Jun 2020 23:32:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] docs: adjust for the recent rename of `pu` to
 `seen`
In-Reply-To: <xmqq5zbhd1em.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006232330550.54@tvgsbejvaqbjf.bet>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com> <dc6f97129019e9176d91c77576a84549c00a74b5.1592924655.git.gitgitgadget@gmail.com> <20200623153106.GB20455@danh.dev> <xmqq5zbhd1em.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1867953520-1592947936=:54"
X-Provags-ID: V03:K1:rfQOv6D2YoD9J3PrAuRT89HnGijkLis0bNK/as+dbLdSZC9Sj17
 rUZKuU5hKYL3jjPcwB2gWmSjge00CD9TzbQmNghNoNm1lnhQBiZhkVYKvIMDeeUjVGJZs3F
 bB/UzNC+/UgfBJvTHr8DxMrwl+e2EI34W0x/vOH4pJ0sIhM05/FDmAl3tog7G7RLTx3lrvP
 WVBTm4I1DdclPUZZZo8yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Wc4ZF211lA=:PBcg87QRKxP9IaaHO0MHLh
 GfSYtzHXkq8xCaKL8n2dLksRoK0vSWCLIYGPCToDx2UTyxP6k+Ls+dwTMGv4JG/BmJRtjcPtg
 EcPyz6o1ZpDt2uUiZgB3qd4E3FaHsYgMnfynEtQ0mA4VDjPreFDQ4Vb6ljxv4kXSONplJqChJ
 hhVnS+bCCH2OgSnO4FZGbWy23W24qfAtX7EwkRCaCXqmvy7UxitvLPaBuYyhogwVmydfN0HgM
 guD3t5B8/9+mL//M0PQmOXSUdsL8ddo+6FgGfzI6GJ6lRvlDUOVR0ZlgLcMIkPoPjCcCF3whw
 rU+1Z0PEkZazAiHQjZzjj+F89ZKlAOh3ypg9wzuNRVIgG4dvEFYs4Z0O976eIDrBlneqATNY2
 AAZmx5YeiAtL+zB+GdLVbV+v/G8c7/SNCC6F4LAJamNWdl6YVvSt8tS3knRlP3ZFe+d3rhlrC
 cYobG9lUHNSLQ0240j0lkJ1ZX64ksxXNIZVJlv2qJ1Avbyt4iPs540+UZIupwbNj4p0OSrf/k
 EfxCGaA9i688W4osyWnY8g/igTFg+QHMlSsknbG4QWCBvlmeSjSsePuetZadSTW5emZyAXhP/
 bDqonSxqkBM7aHPK8WximIUUqngT7okmEmXDlVHhKZHAOxY+9Ar0WOUw3nBYEcmVBa0lgXyOG
 NKqkU/5uwrnHkV+yDGAoIgzKE9T7dfLrHAeH6V8NlIR9Lm/2Zi2927niC8J3JIYylIQmkyf+C
 Z8KvyCNwAnYZpfSpeeYX04Juu5ywTTEnCxSiFTXmCnHTJ76j/9gEL+iwTDoYMS2D4Z0fNUQ1V
 YE4VFRKJhUYcKj8kLUWmV17S9ULmuIBt6HECxolbrp3NFlRq0+0qrXRMmOAmC12BtVvNkHPeQ
 rHeXYa96No3loxaLZarsBJiEbPXoYSA+OSzj63+896GNuYH2Ebcig+9qS28i90JeCKY5pXuLm
 oHNgPkulqWFqB9pOwbVJmGnGMXEsi8f69drhQ7L7MTRsNM6r6SMlVdrKOqb3A+ZhiVgrl6G7F
 1n88tyoegKnvn5xTOgmBh3dkmKE5+BIi+Vnk7vcFPBipv8wOFOdrFOrux5QaInUaJf/mnYY2B
 PAN7eACmST+t69OZjADi3cYOoi3LlDKPPgPp2lUTUaVMP2n1dZrlHg59sDKYMRMAPbw/4SoRI
 ytZK16e99Gp6EhtStfo8GdGyqNk1oDdRZEhpKO8fR8/o7trl2ejwQ9pr+YpK7uuCDCdHomIuu
 JEbaiFy451D38w0BM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1867953520-1592947936=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & Danh,

On Tue, 23 Jun 2020, Junio C Hamano wrote:

> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> write=
s:
>
> > On 2020-06-23 15:04:13+0000, Johannes Schindelin via GitGitGadget <git=
gitgadget@gmail.com> wrote:
> >> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-r=
emote.txt
> >> index 0a5c8b7d493..492e573856f 100644
> >> --- a/Documentation/git-ls-remote.txt
> >> +++ b/Documentation/git-ls-remote.txt
> >> @@ -101,9 +101,9 @@ f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tag=
s/v0.99.1
> >>  7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
> >>  c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
> >>  0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
> >> -$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu =
rc
> >> +$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master see=
n rc
> >
> > rc is not with us anymore.
> >
> > Should we replace it with next, too?
>
> I do not think so.  I think we never had 'rc'.

Indeed, and the context given in the patch demonstrates that no `rc` is
shown, so I assumed the same things as Junio explained here:

> I think what the above example is demonstrating is this.
>
>     SYNOPSIS calls the last command line arguments <refs>; they are
>     actually mere patterns (which is how these command line
>     arguments are described in the documentation).  It is *not* an
>     error if no refs match a particular pattern.
>
> And because we have no refs that match the pattern "rc", we only see
> "master" and "pu" (now "seen") from the command.

Precisely.

> I see a couple of possible improvements here:
>
>  - The "<refs>...::" documentation should explain what kind of
>    pattern match is performed here.  I recall these originally were
>    just tail matches, but the rule might have been made more
>    flexible over time.
>
>  - The example should first explain the setting.  The first sample
>    depends on the current (./.) repository having these tags or it
>    would not work (showing the sample upfront and explaining the
>    outcome shown in the sample would work well in this case,
>    e.g. "we can see that in the current repository, there are tags
>    X, Y and Z").  The second one at least needs to say two things:
>    the sample repository does not have a branch called 'rc' and that
>    is why it is not shown, and it is not an error for patterns to
>    produce no match.

Those sound like wonderful #leftoverbits to me.

Thank you,
Dscho

>
> Thanks.
>
> >
> >>  5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
> >> -c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
> >> +c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
> >>  $ git remote add korg http://www.kernel.org/pub/scm/git/git.git
> >>  $ git ls-remote --tags korg v\*
> >>  d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
>

--8323328-1867953520-1592947936=:54--
