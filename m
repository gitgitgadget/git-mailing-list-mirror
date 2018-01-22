Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15FE1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 13:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeAVN0y (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 08:26:54 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:36101 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbeAVN0x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 08:26:53 -0500
Received: by mail-it0-f43.google.com with SMTP id p124so9709690ite.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 05:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=IM8vIvcC8krs/exS7jZPnFD+4qBjNn/kx6Y5pfhcpCk=;
        b=JCeoLOxqVGTaveHNlCrDBM/6LWVr+ztK/Xi0LfOxaOjj1cumHOSEIoi0fZeGZOT55u
         UK8unI/fUkO9jL+WxHyReFqZndIPPcFqO32BvHE/rEF2aMHNXQAOSs9h+mUp84TML0+B
         v8Vpf1rMsUgQojHepXg+NMOhSOnMsPJK+p6aWDofzkI0QOGEZMzYQE0tfe6SZlL2sLzk
         7bbz/qH5BFC4ywbZ59hEPzlzT9ZQbdtKtdLvNYNCQ/mz+zgQldwnr0a2672LONv7WM0o
         o2tjUfpb5FnUlO5Gh4yvQIouMh5pdoLWl7n8kB9mJxb4NRUT2s4WzczulISlOWcpT3Yj
         HgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=IM8vIvcC8krs/exS7jZPnFD+4qBjNn/kx6Y5pfhcpCk=;
        b=sPxpRkGgAim/eJ6+eTpr7PKfWBZ0RaVVWaUwJxdyqnShUMFlR4Wpm5TOtiUURFlTmp
         +zWNbOb0mEjXLTMA8q8wfIy+wUlFO+wROg/c1EBSfXsTe81dcb/2nKIu+VIF9RlXVXkm
         PCC9mk5SB12PQxJlwVVKoZx/xZwHFpDUhlerM4nqxs4NgAaC9z1uOBR6nQA2c8S3MWS/
         KGCN3956ZtCWHefBh9A4+hzoxXax1UFATmWuQkZsqi0Iho6w+tn+GTXIXoyDFMD5TOcn
         rwuDTD0BDbm5whu108PBbDt+H+6goUgVKSWrOlgFaVzYBBTHezwYZHn+f8DCAMLWPRc7
         D6EA==
X-Gm-Message-State: AKwxyteCA1I6KmKQaGVXyoVT9JKuRAQ0G1uCY9/GPgnkzcRO9uYlWu4s
        j4Hp0yAIEmsMEYPfbW4Cfc6a+xOKc+/H48jdTo0=
X-Google-Smtp-Source: AH8x2259g9hGaSf3mgaiKwrOYuPX4IXWjKVPcl1P//lPDJ9Zj9/QKanBZRh/tUKgul84Y7DjSjRIXNuOnyHSDhRnql4=
X-Received: by 10.36.34.74 with SMTP id o71mr8634131ito.46.1516627613072; Mon,
 22 Jan 2018 05:26:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.206.140 with HTTP; Mon, 22 Jan 2018 05:26:22 -0800 (PST)
In-Reply-To: <20180122121426.GD5980@ash>
References: <cover.1516282880.git.patryk.obara@gmail.com> <cover.1516617960.git.patryk.obara@gmail.com>
 <20180122121426.GD5980@ash>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Mon, 22 Jan 2018 14:26:22 +0100
X-Google-Sender-Auth: p3AWgQ47S20fAcPmqAxsVy15bGY
Message-ID: <CAJfL8+Sfu_AzyWQVJJwfReLjgz0kE+2EnhJ1c0dV03sQSf+8Fg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Some fixes and bunch of object_id conversions
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Patches 1 and 2 should be sent separately though.

I hoped they could be piggy-backed, but since there will be v3 of this patc=
h
series... I'll wait for Junio's opinion.

> I look forward to seeing you deal with the object reading part =E2=80=A6

Yeah, even reading of loose objects does not work on my test branch yet.

Turns out some functions (*) depend on each other during conversion to oid =
-
so they are either refactored together in one BIG commit or I need to deplo=
y
some temporary hacks to make it possible to split work into smaller batches=
.

(*) refactor of sha1_object_info transitively depends on lookup_replace_obj=
ect
and the other way around. verify_object and verify_tag will also cause some
problems.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
