Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B1FC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC3A61053
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhKDAk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:40:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:56469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhKDAkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 20:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635986286;
        bh=2Is69GLewasMXFJfXZ/iAOFp5S3PTRxLF/afkseZtsw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AizHmBFPhgJimGmtJxdbHHvyD3xTk+svUU4IbEWCZHnc8n/zsug73H+q94PdY9SvJ
         SWqePU0IY5hyfWFB8+ATQeGwmHBEzVXWCU9wqNhzRm9HjcTOMJikOhJL7cApC5Y20R
         eNsFHRRiSfepgtFDpPTOO1vuKw07f7H8kIv/bzys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1mlAqu1n1K-003vDy; Thu, 04
 Nov 2021 01:38:06 +0100
Date:   Thu, 4 Nov 2021 01:38:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
        "=?UTF-8?Q?Jean-No=C3=ABl_Avila_via_________GitGitGa?= =?UTF-8?Q?dget?=" 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Eli Schwartz <eschwartz@archlinux.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in
 placeholders
In-Reply-To: <xmqqlf258aq3.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111040134110.56@tvgsbejvaqbjf.bet>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>        <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>        <ee376004-a4dd-539d-28b3-3fc5baa6fe00@archlinux.org>        <2803948.JoDkH9avOM@cayenne>
 <xmqqmtmocqz4.fsf@gitster.g>        <0b404448-cd4b-8614-2c49-c4683b56879f@gmail.com> <xmqqlf258aq3.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-50210553-1635986286=:56"
X-Provags-ID: V03:K1:gVlKoOj2k3r8fUfFn3KYfMH31ZMSjV6WuMcewV2OA160Kskah4v
 Lsqx/qXJNYz7wloXB2wbTtJoOEwJy59TmYrBZI6l9Ezr/EgdMS+JLLixx21OZ2aucCiS0W7
 T5MGa6NVgAoWccoMONeuZ/8PmBXWtM0rjslJiaEPQNVysB+TZjbSveGK8JuCr+MWO7laHRK
 xNQiyYLkIworMOAsN2gLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rt/xOA87dXk=:Wf26T2Ym01J+X/f8Uahk1R
 Oa/yB6JOaERxEwLkyJD1XN1m9e2W+pl6EJVgOYp6U7Q4fAUknd6RBDZSsGaSj3kWyVSB8yiQN
 m63Js/IAydUrR5CdtMTz8FaPkcmVKKiJZv2FL+q4QDA+eAPEd7B+Mv63Rtl/gBpnqrwO4Bi4d
 pCetCfhIsAnZxac5wjWhjOGI+c2LkwmaX6v0bfhci6kC7XVZD0+5MgWzi+PX2304V9Nr1FUYe
 eTGz4NIr57VVGGdM/ViYCzjIfXJWaB+QziGQ99r3Zbz9FiiZ53LQPMNKKsGJg0ZdBHrzQziYo
 quxVbhj6jTHUPyO9C2izIi46PuPvvVW6UvYIuhTrTHeZv3Al5XskfHs8nc4HvPaq8L8KAq0oB
 OUnn7y0ziCQ7fPudHjL5x+QUng41y/c0E4DMgdQI8NxXKIZy2O0cl0Ii8uDwwL0QcK52pUQxh
 WOvxT8JB6hTP+NgvNv+w38kr8wnClJ3nIb7OvEbWr+OjQqkZj5scFM6+TewOTAInpaWalT/oG
 RdhN+mfuyYkGG/GRw64M5+Su6v2/r/W/AFYj1tyKB7LXE/C2c/FxFjTHPzG0SyV1dVCxNkEbq
 4QItIHyd4NBYDIq5YxD7oxeyZ6L5DwsZTnWJzC7UQOp1rsJvInNq4Xdvbq3boy8qKE8TT0Uut
 janlnr7+h3EVxSb8YDHnp3wpJNsqrTBVUITaHD6bmKPNCXLpxNwf5MMEBzjNXtDsGKXXURRdZ
 Vj646k9yqFhz9WHImSF96uyvZ0DpFUd4Fh8vEDl1cx0aLGtiHjgb97E2Uqyzg7EqNxcszp5mL
 Ve6FfGXwvzqhqpqzUzyr1k73Vob4LMR/giL7GltYngwVNbmwKGRCRTnkfh9yREJyUNJB0Lj9a
 u2QIHPDjfECCLbv8JUJyxCaaHLRNLa4u1pREuuuPFkidg/pE9F+1i/1skxC8igdH21xexPCf+
 iJjy1rNA68fTosmObWu6UF51aztfYKDtouIEP7+rwgItqsepX8oag6lbs93I//eADQ+iHTcnm
 lLPJcstmP2hBrldjZGfWxvuCqPv1Fey+ik/Jf3Ku452lkblb5XVmiCnX1rsW9wVVoXGlA0TQ1
 TSM44veqt69ee0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-50210553-1635986286=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 3 Nov 2021, Junio C Hamano wrote:

> Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:
>
> > Junio C Hamano wrote:
> >> Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:
> >>
> >>> The choices here may be awkward; no problem to propose even more des=
criptive
> >>> names.
> >>>
> >>>>   Similarly "the 'format:<format-string>' format" feels highly
> >>>>   redundant, I expect the reader knows that <string> contains a for=
mat
> >>>>   inside it as it's mentioned immediately before *and* after.
> >>>>
> >>> The fact that it is a string doesn't tell you much about what you ca=
n do with
> >>> it. For me, this isn't a problem that the explanation is redundant.
> >> I agree that --format:<string> is quite poor, as type alone does not
> >> give readers any information on what it means and how it is supposed
> >> to look like.  Calling it <format-string> does make quite a lot of
> >> sense.
> >>
> >> It is a bit less obvious how much value we get out of <bool-value>,
> >> though.  In --opt=3D<arg> scheme of things, what comes after '=3D' ar=
e
> >> all <value>s, so <bool-value> does not clarify over <bool> like the
> >> way <format-string> clarifies over <string>.
> >>
> > Agreed. Should reroll the patch series?
>
> I guess another (hopefully the final) reroll would not hurt (but we
> are not in hurry---this may be among the topics that graduate early
> in the next cycle, but not during this cycle).

I fear that it won't be as easy to send the next iteration as one might
think: GitGitGadget works off of open Pull Requests on GitHub. And the
branch for the Pull Request corresponding to this series has been deleted,
thereby permanently closing the Pull Request (it cannot be reopened
anymore): https://github.com/gitgitgadget/git/pull/1066#event-5541689437

That means that none of GitGitGadget's convenience can be used to send v3
with a range-diff. All that can be done at this point is to open a new
Pull Request, generate a range-diff manually (which could very easily
differ from the actual range-diff, whether by design or mistake) and put
it into the cover letter, then send a "v3" (which is actually a v1).

Ciao,
Johannes

--8323328-50210553-1635986286=:56--
