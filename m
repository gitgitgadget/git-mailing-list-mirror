Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8871F462
	for <e@80x24.org>; Sat,  1 Jun 2019 01:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfFABMu (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 21:12:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43614 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfFABMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 21:12:50 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so9726906ios.10
        for <git@vger.kernel.org>; Fri, 31 May 2019 18:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QKmWrmG2uteOFdK/ZxeDRwW4VfORtAABgRAkkprbjww=;
        b=VEzBJyRQG6CbldLGGTmkqlEXLKeiGNpQYIKGM/1FPalQpSpGSdGdqBV+/v3d3il67R
         E/+oIanISK2LOKqhiGebuE0sxU13rH1NuzrRxa0FCEu8LUEwGYdSdj7VZhjIyUrFmcSk
         tLHkGydWj4EFPIHWyr2TXKWv0sbpjBQHHuaoeplksgkGA0q0/Psic+xIQg9l7yUz/Mdj
         1Mz1uKuhc3zLAfzQXm7jTRYy10bhZUtlpE0MHhNH/3ZkBueK81fk+V4YJnp9MBaY+ubj
         2HPrivIoxvstOqe4vvNpduh5VOenH+waNlJ7K7RcFM/RuGztR1vla2fY7GmUU2wt87m8
         axNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QKmWrmG2uteOFdK/ZxeDRwW4VfORtAABgRAkkprbjww=;
        b=pPSiAzcHeUtJ1zeTZrfSPI3XxWw8bdw1TQHB9lhSHWxTIjSN69FxscMuRMFhpQul7Z
         1yTBEbeRYEsN5Z9++ckDFAsSdTyxQHl5n37G6apHiVUHKqj3GJWVdNjn0b/FMz3rS8kO
         yPN3Y8m0uf3oHdA2+h1RvIsQ6oiczOUTuTFrBU+vxmOFrtz+CRIg40uH13ahfvnMBtT1
         2q9eLA5C5zbroebUTrxE/j/ABzfE5/9O5EqrN2L5tdjUm80nhbLI/PJJ9t+IHUzft50c
         2DDcq3QTC+19WV7laKUA4qFayIBEKOtU4oCfnFM0Qel6DIgWEH/mQBW4q4EIv3ArsaGG
         88Nw==
X-Gm-Message-State: APjAAAXduC8H1WiCkMTFZfC58PXoAcKdXU3bGhfCWED80x3MOpPRnmkc
        SGEoff/kn2JNC/6tF0l0ks3ZtwerfEbpbQr40Ps=
X-Google-Smtp-Source: APXvYqxyWsc0HWhP+qWchBVqHQDrNdvO7ydM8VG6ZCJV6+1lZjSy/paPDdQ4AjSouEoBQPulxxFqtK0AiJ5IfyboIWw=
X-Received: by 2002:a5d:9d8a:: with SMTP id 10mr8595399ion.179.1559351568880;
 Fri, 31 May 2019 18:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.196.git.gitgitgadget@gmail.com> <468be8f85426ccf588ad558fab3c8927ef58627f.1557917642.git.gitgitgadget@gmail.com>
 <CAKO26MsGpEcK74CSdgNGjFdKAMDP5Knm+0_vtcnrBBJjBfjcQA@mail.gmail.com>
 <xmqq36ky1fe8.fsf@gitster-ct.c.googlers.com> <CAKO26Ms6_rJfq6knh14H1O-V2_6v8YxYdjah0vTdvpJTc7hdXw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905291349360.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905291349360.44@tvgsbejvaqbjf.bet>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Sat, 1 Jun 2019 09:12:32 +0800
Message-ID: <CAKO26MtvBRo76TenubyeVNkeA6e5yrS4DZFSLG1ByztP7mMVXw@mail.gmail.com>
Subject: Re: [PATCH 1/1] status: remove the empty line after hints
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> =E6=96=BC 2019=E5=B9=B45=
=E6=9C=8829=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:51=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi John Lin,
>
> You could already rebase it on top of
> https://github.com/gitgitgadget/git/tree/nd/switch-and-restore, say so in
> your cover letter, and send a new iteration.

Thanks for the suggestion. I already rebase on your
nd/switch-and-restore: https://github.com/gitgitgadget/git/pull/196
However, it seems to have some conflict with the master branch and
gitgitgadget refused to submit the patch. So I guess I still have to
wait for the nd/switch-and-restore to resolve the conflict.

Best,
John Lin
