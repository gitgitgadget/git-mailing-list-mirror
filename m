Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E650BC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiBVK1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiBVK1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:27:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCC779C70
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645525597;
        bh=YnyTq7dKvp2wnQXxtfH5Ty0T58m4hWQv9Ze1U/wFRzo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hECZUDpKtLmp7isAjZVaiQ7qRk9VmtWRenU1QNM6TJtmiXJ6HJLG7tF8ESF5fwhF+
         NnoEFIAPyc006xrIbayJ2UPWyoV/JN8NVWAELW7fRJz/KUXcNGld2DA4t81f7ZbAPI
         iLpu3TUMH9oJXZwrtrq+uX0zjv4GBMAUlLDOVTLo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpap-1o6Cax3YoZ-00mKJF; Tue, 22
 Feb 2022 11:26:36 +0100
Date:   Tue, 22 Feb 2022 11:26:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <220221.867d9od48e.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221124070.4418@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet> <xmqqtucuw93i.fsf@gitster.g> <nycvar.QRO.7.76.6.2202201623500.26495@tvgsbejvaqbjf.bet> <220221.867d9od48e.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-337720355-1645525596=:4418"
X-Provags-ID: V03:K1:IjVCntctvC9qjJqmhcQSzR8EtVopV0yJZ5GmxF00kpdVQUIx/yy
 cjpaFpqlKfKiRKBFc2DWRVM9INcyQ3ZrfuS10iPmyBgcU2VUXJm0wVfikftYPBv47AiqJqr
 wXRBro0xWyciVEszkgQdL90bR4Ff924tumGb1DSB4MKKa3XlRy/m0dv3JSB9zYieaxQn0mH
 hpuFU3qxp6U/AEk0f/s8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mFn2QfcFl2U=:JET5ZUOf5sYhaNaHH1GS9L
 8fTNYUoFd2+r80ObnRafgSLNHASwcZvgWOGKdBS3icl592VXnMiDu4ErXAk6eKhCJgAS2Fyc2
 3/hAhSib20khEt4XHZhGr0qy2KKEa1sAEAT5pIVIRL2Mnfsg9YOt+l9Rsl7i8uHhuieJYHSkK
 rcc3Wbch1PvqIZ4Be1abqm+a7tzs8NIN1HFq7k0KbJoa7ghIDZKOBZbeHcqzXyG4o1b0tEq2s
 7uVo2ckZfJhGUkeFoNSpJfKRyhy+fh/PFlrYF2hd4IBBKY3shT9YNBLsm/5kuGB7CnEijK6Y0
 RXEfMz+DflB8TfFsX/hOF1i/KqDCNRL9jeog8M19JMr++CzyuhvKTy2fOcT2ahV4aRuWwU8Fz
 Fm3qkP2CmNyIGVz0SgqOlyz7sPcQLVjgNzQyYZDuRH14enR9RMqFIPAPe0PFoU1gzpxSJpqtS
 gFcyFBJ8t+tYC7UWBqsapojy2Dn+qeTjGuVtGeLg0Bcfa7GNvVSVWZ95RPnaTOddSS1LPP22A
 p6C84fl/DZ0I2nTJ7a8JDU340rT+58NjnOr0jLD7LQhRb7jhgaoVb93kiJ9+fYR7QBdBDjXhx
 xmX3YTNx9NCJ7eImA6su/ZRCOoqA3K+bpQn9oEPfMQGn+BfhWUgrxnHUjMhHemVDYtrLIJgST
 /WWQfrFhGtu/6ndWHOgNNenuIWid+5Xu6HjK3NfFFRltEHQZ1EI0fPhDCdx39okLSKjbvOFU0
 b1AOFm/VFjUfLVsGntqyU9+F01pKoQKJqzyvUbMqUqNWBIGitpfByS0DVINvA/XbAGT+MR7bI
 vGfI3qd1wBbFmXWm+akNr0jydisnoAmNGHWVnNkZm2BZ2GhkiCg6KAJ/SfKWNRx4UgRId9Zs0
 sEYs+LKbbyUzvE3/KvjzcZFbmw4KZpbrK8AH97lwuF7Rsu8BHe63ZB4WwVH2tO8kxvh7xMRlO
 ++C74o24sauK5n6f5YgIOzKOls3gv2/ApjLIQP0U4x61fCzUC6rKroYwYNCrGUSe/Q8fG+e/v
 N9ra9rfL85Y+/kAkUQjyE97S4gskvDqMIhxXKP1DUV1eUmeLOhe8L8f5cifB4UR2ZaSbDW0t/
 5jpiga+DecyqEs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-337720355-1645525596=:4418
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 21 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sun, Feb 20 2022, Johannes Schindelin wrote:
>
> > On Sat, 19 Feb 2022, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> > I notice that you did not take this into `seen` yet. I find that a =
little
> >> > sad because it would potentially have helped others to figure out t=
he
> >> > failure in the latest `seen`:
> >> > https://github.com/git/git/runs/5255378056?check_suite_focus=3Dtrue=
#step:5:162
> >> >
> >> > Essentially, a recent patch introduces hard-coded SHA-1 hashes in t=
3007.3.
> >>
> >> I saw the thread, I saw a few patches were commented on, and a few
> >> were left unanswered, but one was replied by the original submitter
> >> with a "Good catch!", making me expect the topic to be discussed or
> >> rerolled to become ready relatively soon.
> >
> > Yes, I have local changes, but I had really hoped that this patch seri=
es
> > would get a chance to prove its point by example, i.e. by offering the
> > improved output for the failures in `seen`. I hoped that because I thi=
nk
> > that those improvements speak for themselves when you see them.
>
> I think it's a good idea to get wider expose in "seen", "next" etc. for
> topics where the bottleneck is lack of feedback due to lack of wider
> exposure.

Having this in `seen` will give the patch series a chance to show in real
life how it improves the process of analyzing regressions.

Ciao,
Johannes

--8323328-337720355-1645525596=:4418--
