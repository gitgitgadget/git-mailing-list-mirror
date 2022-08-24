Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC593C00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 06:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbiHXG1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 02:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiHXG1q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 02:27:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF857969C
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 23:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661322461;
        bh=SKbsRejCRfghPJTumTLiXbbgJ7C40SJZ9LMjp8Wg8SM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lfc3P5tg0oaZ/X/sqY6o9LEbjJ1jKu7fa1QJKRWXulZ/P7C+OE+h39r4365Jn+ODw
         xaZaq5mV0eVO2PJi8SayGN46NB7ew+LnaN/wq5i4pUK6UrwXjIEwKWUFIiSDGCZDep
         ZUe2vQMb7SWIfhKWyR0swqumOxDXeTuvBEBbHtVg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3il-1otaac31tj-00TW92; Wed, 24
 Aug 2022 08:27:41 +0200
Date:   Wed, 24 Aug 2022 08:27:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] built-in add -p: support diff-so-fancy better
In-Reply-To: <ab012782-1d02-b90b-9a4a-179ecc3f8e9e@gmail.com>
Message-ID: <1r3pq48q-s728-8r2r-r4q3-72413r5483o1@tzk.qr>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com> <ab012782-1d02-b90b-9a4a-179ecc3f8e9e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1581742711-1661322461=:205"
X-Provags-ID: V03:K1:8BAuZJuJZiAW5DjB/fEVpvXA/9pk53sbr1MpjC9z+Oh2T8a8DaK
 fnsbGDrKCEu1T7UHERyoSB+fXWlTNZlDqzohmPI4bjp783P53T4JYpAFbts3ZSIXiHxNOhy
 3PwKCFFSUpvHRv/kwX1+2LThKDhRJRWSMVLZoNtlxnZz4Go6vJXgofxu3E0D+ssBKCwWXAm
 g22VCLTxBFQ0IP36BBBlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jT4Px3pEIzw=:5Goy2sr8CfcOmZrz/woV9/
 zdOZEVtb5N9Owcqo5bO32pfLuUqHwa4Ea6vYQFoUJBzJKRPKtQJKhGWtNJcowhs36HoeDHuLA
 k+vff46lIDzXYd+McGBnsD8Y/zePDMSLySOqsc1CwDtObDJ2ZL7roQ04TEN4zhRmsDwnLcD3v
 KwwT0KqQ84ELAU2vgJ56iB8ep+xjlFvpgv6qzBbKModzE1/7mpTjRjcI0CTgfcHEtMjLCqtOB
 /QLl/I6ccbtibJ9DRjvUwVPZJ+HRNaiPqgaL4hjp8lCGULmcqHj9pUOFVzbps5eQvC7O30qtr
 flUQgA6BYl9iGRQKtcmSQRoTvwXSLp7zUZriSN0MH4FyrHk+aYGbu/r/qzWDIOPbXhTE/XtGV
 TBgxAA8r/QfPubwcxOsTY8ZVsodWs8HN5uw5coqvJ1fgALAsx7ZLdFRzxB0fLC/hJXSdyShKz
 WOX1EA9ShsiquUt8OZzrjqGZVaeo0FPgMHBXF1SW1SmOHM49cd/tTJZw7h2Srf/14L5UcoIj6
 E32/n2mVEjhUjsn/6iq8aJQbN5dW+ZVZjbrVHui85AF8Z0vxTiUd4x0Lds+XyGnZVuy7dGQa5
 OYyJKfriPUrbDz+TdiqHZTdXC0YVeAxajPTIPNGXhvQ+FIlBC016TgNkHWG2AW8t7MRTrPdhg
 qZXYqQVCk6G+uMo0yHQOma5dwnGfFcB3L4HzlRNkCH1RqXdYgmO13oAAu9PaBH5jJDYRdXaQX
 4nN7kMUifrikyHFX4glNMEXjyhR3p6YaZ3jI+xMcRn6GFZNnNUsFg6Vg1Ck8AUVw4mmIjvY6P
 Mb2+ycrbB+t5FeCDxTC5M22JUNeI+wXFVgOyu8ViWREorX+XlpOTyv25Bhkk53Sc5la225cwL
 kGN0Mz50MQCsm+7/Pc86icoD3ZoJCg4+hC4IxaNj2fVa7Q2noch29KiKJdUEQJcGjQPceLJl0
 nTYQcNDcc1B1XgKN1SuYbxk406q7D5+dLTbDlw9mNM/11hfbeL/qCiiNgIRKc8oStQbT3tWWu
 9eyuGAnAIb1zDLK/f5EUITxZS81bHlioazLWumKGE/3OIx/0DuFq76PQ5mqKvWNHKlPovmylH
 nzDTtk/MCEhilxG1rlu13JNVL6SZ6+GR/e0NA3eSmaZrEDrq7tvuBrU2w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1581742711-1661322461=:205
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Tue, 23 Aug 2022, Philippe Blain wrote:

> Le 2022-08-23 =C3=A0 14:04, Johannes Schindelin via GitGitGadget a =C3=
=A9crit=C2=A0:
> > Philippe Blain reported in
> > https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail=
.com
> > that there is a problem when running the built-in version of git add -=
p with
> > diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colo=
rizer.
> > The symptom is this:
> >
> >     error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ f=
ile:1 @?[1m?[0m'
> >
> >
> > This patch series addresses that and should fix
> > https://github.com/so-fancy/diff-so-fancy/issues/437
>
> Thanks for the quick reaction!
> I've verified that the patches fix the example in my reproducer, and the=
y also fix it
> if using "delta --color-only" as interactive.diffFilter. Delta is anothe=
r diff colorizer
> (and more) that's facing the same issue as diff-so-fancy [1].

Great!

> However, I've tried it on a more "real-life" example, and then I get:
>
>     error: mismatched output from interactive.diffFilter
>     hint: Your filter must maintain a one-to-one correspondence
>     hint: between its input and output lines.
>
> This is despite using "diff-so-fancy --patch" as interactive.diffFilter,=
 which should
> keep the number of lines the same.

Would you mind sharing the example with me?

Thanks,
Dscho

> This ('--patch') was added in [2], about a month after Peff wrote the me=
ssage
> you mention in https://lore.kernel.org/git/s40ss309-3311-o08s-38r2-9144r=
33pq549@tzk.qr/.
>
> Again, when using the Perl version with this new example, it works corre=
ctly. I'll try to come up with a new
> reproducer for this... But this new example does work with delta with th=
e builtin version,
> so it might be diff-so-fancy that's the culprit...
>
> Cheers,
>
> Philippe.
>
> [1] https://github.com/dandavison/delta/issues/1114
> [2] https://github.com/so-fancy/diff-so-fancy/commit/13d3f8949e15dd62f6b=
49bc652fe94af6a9bfc79
>

--8323328-1581742711-1661322461=:205--
