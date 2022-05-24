Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46FFC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 12:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiEXMba (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbiEXMb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 08:31:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A82BC11
        for <git@vger.kernel.org>; Tue, 24 May 2022 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653395469;
        bh=DuXa+ZX7ixclJ8QcM/0iiVsVK4onI4w0dMtPPPLzsaE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jUW74u7s4ByhzN1dLp+pp9HFUkx5NOylcC5wnchWkHM2Nn2TubfTuvpQggJXxfUtA
         pORxI08yt/B2gFXl/bRWY9RaO24+kVs1vAChcSiWQGyS3Y8HaeKTAvQ+1cEpSL/U8o
         nvkVFN70aPHP8jGbeOUB1Gxf7fEel5AJoM3mtqys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zBR-1npib02NNL-0150Wd; Tue, 24
 May 2022 14:31:09 +0200
Date:   Tue, 24 May 2022 14:31:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     neerajsi@microsoft.com
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        nksingh85@gmail.com, gitgitgadget@gmail.com, avarab@gmail.com,
        bagasdotme@gmail.com, jeffhost@microsoft.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: Re: [PATCH v6 00/12] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
In-Reply-To: <fb1f2c8c-b749-85d9-b472-587f51dea8a8@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205241425570.352@tvgsbejvaqbjf.bet>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <20220405052018.11247-1-neerajsi@microsoft.com> <xmqq7d82x8a9.fsf@gitster.g> <xmqqtu9lkxe5.fsf@gitster.g> <fb1f2c8c-b749-85d9-b472-587f51dea8a8@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-375719175-1653395469=:352"
X-Provags-ID: V03:K1:9IfLc0vghJXuCH3s5je/UGxrKRBnMrVsbOAIbVginABXAA38w3l
 qP+qLM7CU+F4Nlwk8G9c4AIoWCxg5EZh9Mr74yanNNx5eLTufJLhlNmBQ/OEtfUhw4G6V8s
 B4Um+TjmiDIY9tkS1gCxaK+QcomvQHKl3ZZ0Y66tPxjzEki9iGb6o8UEI3IxpakCutck3oD
 ebrSbwUltolX0JEoOBtnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qU5hvoI0vAA=:OXV1+flkCaG9iY/V2Hn6Kf
 fE/Ob/Pj/2gG2m/KKBqJF3IOOvlGiGW9BuK6GsOZ61l6bMxKMVnWtdxXQSBUAcBXTvH15yeoE
 7BJDRjHv4ThpkjL3XNIl8u/jiwCGUqx5fDVd3fwyMh8yhvVgJG7P0urDkLTqoaJ8h1xN0/RGg
 G07UPIqEHGlFTcGhG/5uxmQQ2gaE740a0L5ouv9bjpvv+csxiyraJf3FXURt489BYm+a77hax
 Y8a4O3pN25dff8QBjWy8KkONMxsbaWgArUbJ6x3lHPIkACcjLJz00BV7Esz2Urf+XZEHQGHgZ
 fF028OmkChDIpLfQNxVDu/06XfalRBUx9bvpqFYhdroeuQMk45deCB9wIP0QYYFo3qFqI/0Z7
 pqJSHGdQiuesZhUhEgRpj1dMcjQNgYK7q7ktb81oRmelyrcFF8jVtUbiUZWzZUIxpfwJjs5wF
 ok5vN0Pwf9vrR/phjmJmxVO30k+ipOPNTRQhqNHmZYSmXl4nKxYxdSZmaOoFYLMkS8wKWqhII
 vR2ZOTVuR2003xlWx3mbnixgG8uRm86rNea1OnbMcJ25OPNY1lgol6MAKhfk7KfZ7XjNTwPDQ
 HO96Cpny5xlp/acf68bqwbTvP1eGSMRQxbadiGb9KN2PyKT6KfKeMBwMMz386h8K20/czkVyw
 IW3p66NSwhUByOpwx79IGMnX7cGEmQwM+T2n45dcwRAsKB1DjJW7rdbcUXkd6jUXmpl4JDaL9
 R1/WkaiEaaaurl13YmesVeYdL4RLjUpwLF7gA09TI9arklunTCrpcRwCPm6R9XTi2AihbKtwG
 yCbl+pFQkRVGWMxKwn/HsrYYraar0wboiNOy+5ScPeQFUen4BYULfiEpWrYKmm5BfSgoVypha
 /n/8Ty2jDTMKueBD7FJYdhQkSBBq43k0FBqb2e1O9YcLNTRLTcSHaPfIJgpg+A2E1ego7vCA7
 U1b+25hVAkjWeaRY7n9nBmNB36uJKBICvnrueBlh53cTC2sGI+GyRr2vvAC5ZWzeSdDHwoaME
 XQ7zwRMRBD3HTGEfLf9UzEQBO/uy6G9hddd98fxHXkZ9TVWRZWx85RMA9tPYZDzK4890j6UJh
 UPEfn+x9nOqToUfDxGlR+ZU+xS8HxMe/crHYjpAW6mImYcbMIbl3QiibQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-375719175-1653395469=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Neeraj,

On Thu, 19 May 2022, Neeraj Singh wrote:

> On 5/19/2022 2:47 PM, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > nksingh85@gmail.com writes:
> > >
> > > > From: Neeraj Singh <neerajsi@microsoft.com>
> > > >
> > > > GGG closed this series erroneously, so I'm trying out
> > > > git-send-email. Apologies for any mistakes.
> > > >
> > > > This series is also available at
> > > > https://github.com/neerajsi-msft/git/git.git ns/batched-fsync-v6.
> > > >
> > > > V6 changes:
> >
> > We haven't heard anything on this topic from anybody for this round.
> > I am planning to merge it to 'next' soonish.
> >
> > Please speak up if anybody has concerns.
> >
> > Thanks.
> >
>
> No updates on my end. I'll keep my eyes out for any reports of regressio=
n.

I asked a colleague to have a go with these patches and the only concern I
heard back was that with ext4's new `fast_commit` feature, the `fsync`
seems not to actually flush all metadata. They indicated that they'd be
happy with merely documenting this issue, and also pointed out that the
`fast_commit` feature seems still not to be considered ready for
production workloads.

So: =F0=9F=91=8D from my side.

Ciao,
Dscho

--8323328-375719175-1653395469=:352--
