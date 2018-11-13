Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A2B31F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 20:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeKNGhq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 01:37:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41244 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNGhq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 01:37:46 -0500
Received: by mail-io1-f65.google.com with SMTP id r6-v6so7223993ioj.8
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J0knZwD8UQjjXUfUlyiD+3SjcMXYIAmxy05INBo8428=;
        b=I1qf4zBW/OZvXKPi7Vdh7OnxYGAmwe4IVh4tAotm9WsUqVc5rpe5AniQzOSugImO67
         J7RPVHxazr+oqiwuifI0P+awfe2vUgoI/qm0/YZVKmOudPeIrsZjxcij4/7LNUDb0EPw
         xn9EHzmenw5+43HEJVVV5m7RD130PTGKkKt7NpL9H9XR04ciTKbg8WU0QVb0Fzo+zbmx
         f85YDPhv10Mm5PLr7PHtK64Db7cyh3AL7NGqjgmgzxNqsglpVGoMxchaLLXR/G1ChG09
         D1ofkQ0N6jMEcZmu6lgIX9sSc0NGEzx2vssIWpdVNFR2eLpdYNnYRoMzvDlHUtoyXfxI
         p7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J0knZwD8UQjjXUfUlyiD+3SjcMXYIAmxy05INBo8428=;
        b=pR0Qur2TjbPWuLqhxFdrzJOaKIlifxCscwOD+qDP+n8OcH6BeLF6QKkro53OP4VDaQ
         dzArp39LPJP1FOWqG8emE7PS4HZARyMuGAkLh7cp+657Ag31QEzXuhXvdw0M/v5J33Ab
         Bbsvx1Zg+4vqecyQzcKTcKCDnZ8fpMi656MweOXcKW8nS5z0sRT6Z8AZLvrWM2t10Sji
         jwFK6sUGXozMuQ5DzLx2kdFKT5bhaZb8skLM7VKWa3cFM0Wckz49uLggbisXmGw6TqrV
         CqhuASjmVHd+9zuS+3wp1zLbEZ7WACoKtC4UoyKSb9thRvQTSIEm5UodyqOX3KGZ9yy3
         xCKw==
X-Gm-Message-State: AGRZ1gIZO2uq1no4s/MtS8M5zPDsiHOIuuD7Eg6exiBJ8xJGTaPmOfLG
        vkN7PCz6HHetCcsaNNzqGt2DOxoebyHIlWF34SG2YX+1
X-Google-Smtp-Source: AJdET5c31LpEpf4G6hdymv6qk64uyqp1NYEfObK5ZeUqxZHz9wW4l8HHoD9UOHc28MuEDyKW0JimlXDHfeRGa2H6P40=
X-Received: by 2002:a6b:b417:: with SMTP id d23-v6mr5418478iof.227.1542141475841;
 Tue, 13 Nov 2018 12:37:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.79.git.gitgitgadget@gmail.com> <6276372ad3dc6fa4b9b352abb2b0192a6d010528.1542121775.git.gitgitgadget@gmail.com>
 <CAGZ79kYR_mQmtOuW7SEZ92K_o0f_C2enJJ1Yt=V3tyvi-A53+A@mail.gmail.com>
In-Reply-To: <CAGZ79kYR_mQmtOuW7SEZ92K_o0f_C2enJJ1Yt=V3tyvi-A53+A@mail.gmail.com>
From:   =?UTF-8?Q?Ga=C3=ABl_Lhez?= <gael.lhez@gmail.com>
Date:   Tue, 13 Nov 2018 21:37:18 +0100
Message-ID: <CAK8L4uhL4Z7nsZKha59vePHiPR6FtRgbp6WjB8eL8WOcsZRDnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] bundle: refuse to create empty bundle
To:     Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I don't know why I receive these message (and especially now given the
time at which I pushed this) but I suppose someone (Johannes
Schindelin ?) probably pushed back my original commit from git for
windows github to GIT git repository.

If you think "bundle: cleanup lock files on error" is better, then no
problem with me. I'm not a native english speaker and I simply
expressed the reason for my problem but - after reading back my commit
- neither this mail' subject and my original commit subject (see
https://github.com/git-for-windows/git/pull/797/commits/0ef742a1a92ae531881=
89238adbd16086fabf80a)
express the core problem.

As I'm not accustomed to pushing on GIT 'git repository' , please let
me know if I have something else to do ?

(Sent back in text mode because HTML is considered SPAM or Virus by
git@vger.kernel.org).

Regards,
Ga=C3=ABl

Le mar. 13 nov. 2018 =C3=A0 20:28, Stefan Beller <sbeller@google.com> a =C3=
=A9crit :
>
> On Tue, Nov 13, 2018 at 7:09 AM Ga=C3=ABl Lhez via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: =3D?UTF-8?q?Ga=3DC3=3DABl=3D20Lhez?=3D <gael.lhez@gmail.com>
> >
> > When an user tries to create an empty bundle via `git bundle create
> > <bundle> <revlist>` where `<revlist>` resolves to an empty list (for
> > example, like `master..master`), the command fails and warns the user
> > about how it does not want to create empty bundle.
> >
> > However, the `.lock` file was still open and on Windows that means
> > that it could not be deleted properly. This patch fixes that issue.
> >
> > This closes https://github.com/git-for-windows/git/issues/790
> >
> > Signed-off-by: Ga=C3=ABl Lhez <gael.lhez@gmail.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The code and the commit message make sense, but by reading the subject li=
ne
>
> I would have expected a different commit. Maybe
>     "bundle: cleanup lock files on error"
