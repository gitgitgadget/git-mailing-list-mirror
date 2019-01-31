Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B4C1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 06:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfAaGLT (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 01:11:19 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:35289 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfAaGLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 01:11:19 -0500
Received: by mail-ed1-f46.google.com with SMTP id x30so1635378edx.2
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 22:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ew8Qjeq9ytJSYZWjgQWQbFSPfj785z+/UEdrXw+fSVc=;
        b=sV1k5MNtbknmHk82+JXeCuUeYEx8c75RXQxEwg3PTqkhj+LLyaJZ23QRRWzuHvQQST
         VaCtfoi428g2hfYko2bYc6PlcVkMQboQjZ2Kj7YyTdnHul7ivqS47k87HCFeBYI7nAex
         QMvpZm1aNPuvKWhAg8pxflzGONbCX6KT0Rnw37Wf6DBAVz3vrPMWBvm9CVk69WAhrm5W
         lumW6XgkXaB2xmGaqPPUmDKB/K8X0rBIK4Vz+OIOSitDDI4f8gSIxJY4F176Ehxx5KbF
         RLfTY7euWfTB//L5VGQj4ZXJoi2x5b7vWXOYw4BnulNDk8lgfYBrBa8uumSeD4F/6cfU
         RGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ew8Qjeq9ytJSYZWjgQWQbFSPfj785z+/UEdrXw+fSVc=;
        b=BlQtcUvNOn19aQTEB5QBkgR2QpieojAvDLofO4XHlvnybdvl6fQvMENuY4gTfc7rbI
         nNub522g0NXESCDMh8ft2NTbyet9skjbw7MRLTco3PkJosjmmCuu0aojOwToOcqpLwx5
         1Y/WWjWHE4VQLUwaACPf4nErjHaKzd0c9WvUsnkMzHg3IXIQbVtAhjMioolxDiJWRvVG
         mU5hbQD/QBwvOJ2PgsU6VEQOaxuKFiG8t44d7o9yuVZE/gHL6smCS9FbbC1jEhAJELf7
         PjZxk1Tn4V01gn/s0H0bIwIiUGaKskKLWc+PWv82/mPGHwAEV96+czACFP47DJAxaxDO
         ZtCw==
X-Gm-Message-State: AJcUukeFeIH0l9TwyyzvTnOt8pvh61TFLOTOIEIVvyy83VMtxcPh5kng
        131BTJx1VqG/zsmA6VYrPwMz1DHalmNNGZNdgQY=
X-Google-Smtp-Source: ALg8bN7TGwdumwazkFwKz7FkGy31t9PnkXmPnApBhOtq9m6QFxCtyUaeqSH+OJTEWgY9CqQDOENhWzzfLTWfx/xZOFA=
X-Received: by 2002:a50:a3d1:: with SMTP id t17mr33652814edb.238.1548915077321;
 Wed, 30 Jan 2019 22:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20190122075027.GA29441@sigill.intra.peff.net> <20190122082647.GA31608@sigill.intra.peff.net>
 <CAP8UFD3Kt3dreMnfAdLiP2yc47kBLoVYCk-2yDw67OkujVY=Ew@mail.gmail.com> <20190131020233.GH13764@szeder.dev>
In-Reply-To: <20190131020233.GH13764@szeder.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 31 Jan 2019 07:11:05 +0100
Message-ID: <CAP8UFD0kxvpjdMRcuprPonunCdN5ONTB=OYHaHvnbTb+s0rGzA@mail.gmail.com>
Subject: Re: GSoC 2019 (was: Contributor Summit Topics and Logistics)
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 3:02 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> I think we should remove most (all?) CI-related microprojects.

Yeah, I agree that they don't make sense anymore.

> Ok, after suggesting the removal of five microproject ideas, here is a
> suggestion for a new one:
>
>   Find a test script that verifies the presence/absence of
>   files/directories with 'test -(e|f|d|...)' and replace them with the
>   appropriate 'test_path_is_file', 'test_path_is_dir', etc. helper
>   functions.
>
> The good thing about this is that there are plenty of those test
> scripts :)

Thank you for this suggestion, I will add it.
