Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13C5C4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8851B61027
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbhFHTXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:23:45 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:40502 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbhFHTVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 15:21:43 -0400
Received: by mail-pf1-f179.google.com with SMTP id q25so16485815pfh.7
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YZOc7weAt2iHDJ83KRIKR8MoCmChqY3e0q0I6SKUDIw=;
        b=EyyGTcbuMgVLGiTGXelQHL3+nS4nB5YYtyTEIUNMmGySrhDsiukX5D6X0pvw1OOjg4
         RNmFg+RlbSMqYTEEyzrvh9T+qN6n4qXEUYv2BsYjPUNaL7/x2vem7HcRMWDcg2DHhR1e
         rfWCP3m5BNeGnc6+eOMp0dxtSGfZgcbP5QIOWnO7MH7gjSI3jF/AcIT0encElmyYHk8p
         aZq4fzaoj8oeoZDzRrB2f/uTiCNOc4bOd1Jt3Emz19CbX6vBM+VZUDF+fzrPqrcQCNQ3
         G/zYzh0EFXfQzvboY4qvews2/QPhzu3xRw9jBJNXZCB9WEQ38ex5hWr4ch2bQ1A7x2eo
         kb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YZOc7weAt2iHDJ83KRIKR8MoCmChqY3e0q0I6SKUDIw=;
        b=TUVn+AUPHN4W6/Jb5IYxR4gV2Uaiy9dbJTmTmDb6mHPW8yClxocFn+j0meULIPr2Rd
         ExNEgMar21vLcY2Ic2iiattcvDNcRChxAwQsToUCKrY/I8ybuj3nLTl06Sq6MMlFdYA8
         aw1yhRw7b1Gf6mSu0FjN1TcEuaxvW71Lc4ucGl1hOS/Pn3e1J7k416Q5VpF5rwjufmrH
         8MI+ZqWkxvDsdUuN+Au4DNd8JkB3oEpRbnAruQ5LVO7RRWqk8AGWTf7UFoginlffGZOU
         Hw96eJYQY7DJnW9/sutb0GUGMId8w1mrJU2D1GdPqUG8zuLDUFk7Y/5vTc3l6stLNInj
         FfxQ==
X-Gm-Message-State: AOAM531JEO572UGExeK+e14p6Ms3YMiHpyEBVFoq8VlirrafOCxIe6aT
        kTHyFKz9FAo5PUDDE3a6S4REGb7m7K65eNq2
X-Google-Smtp-Source: ABdhPJzAKNWrO+gSFuSOLd5OlE5TfKicBco2l9LifLytfFplecps5TAKsnOZTBLC46gNv+DCryYr3Q==
X-Received: by 2002:a63:f00b:: with SMTP id k11mr24327607pgh.154.1623179929773;
        Tue, 08 Jun 2021 12:18:49 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id md24sm2990277pjb.43.2021.06.08.12.18.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:18:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3] MyFirstContribution: link #git-devel to Libera Chat
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <20210608190612.72807-1-raykar.ath@gmail.com>
Date:   Wed, 9 Jun 2021 00:48:46 +0530
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0E61233-572B-4226-A035-67F102EF6EAE@gmail.com>
References: <20210608180624.72135-1-raykar.ath@gmail.com>
 <20210608190612.72807-1-raykar.ath@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09-Jun-2021, at 00:36, Atharva Raykar <raykar.ath@gmail.com> wrote:
>=20
> Many of the regulars on #git-devel are now on Libera Chat, to the =
extent
> that the community page now lists it as the IRC Channel[1]. This will
> help new contributors find the right place, if they choose to ask
> questions on `#git-devel`.
>=20
> Relevant discussion on the IRC transition:
> =
https://lore.kernel.org/git/CAJoAoZ=3De62sceNpcR5L5zjsj177uczTnXjcAg+BbOoO=
keH8vXQ@mail.gmail.com/
>=20
> [1] https://git-scm.com/community
>=20
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---
>=20
> I'm sending it again as my v2 had one line crossed 80 lines in my =
edit,
> which broke the local convention.

s/crossed/cross/
s/80 lines/80 columns/=
