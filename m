Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F25C420958
	for <e@80x24.org>; Sat, 25 Mar 2017 08:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbdCYIkQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 04:40:16 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36601 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdCYIkP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 04:40:15 -0400
Received: by mail-lf0-f53.google.com with SMTP id x137so3570206lff.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YDt8AXxdt4nRJu4YvVuQguw+sCYVzXVttogmTAUo670=;
        b=X/chVwj6msBa+BxnZtZe4t9hOFsMizsiU8pz0TDXdhlllKhzCDGkp0wLh8hOVxTqxV
         vGdXcbFWqiGenV7dyucx2KpInn1LHFAcbBygROCHG+74PqWwqEFOMpuCNwe1eGDmf/Dy
         eX0FAvYJ6Fnws6/0xopc6G1PnjDvCbLNjdirUt782geunlvS0EvlEORkvQiVpRu/9tD7
         0VFN6jt2xFzsh3KFacHqrvboCXNftkG10qNZG2OSqBTS+02LipFSpcmlLRDw1/3d/qaa
         cikeH/Ogeq374vIQlcHeNcRFht8/27JORrLba1WNAOYjyQ/OFeorXMmCCtjHte0TBcgW
         AShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YDt8AXxdt4nRJu4YvVuQguw+sCYVzXVttogmTAUo670=;
        b=oP+uanA+KhmHzCJwul5Wl2JfNHHuMUo37S+1PIK6b5hOqS03JYyBLtj+Hm2k0jIBbg
         ISs5Vyu/xwN0PaAKuoU2rtcd1lTx6nrMsWIrE5b44evjtQGvQlMsuMgL2IxVT+ZMHVew
         RpLYyZf5lMjCFtwh+mk6EGU9/KL9A/gFecJFskSt3nH0m4LeQ0tnK14NoDXc4bw1HLJ7
         Mwy+x9LjZmFTYPBCTAeYQxvS3S9DWkmXoNN8fXJTdDXXSmVvzHVzKcjFRA5NmyyFpH2u
         J/kUQiTvC1AyScyuom826dYf2sle+8e0Xeyop9Ef92rhrvbmcsidoBQ/1Rafxmw4PNzZ
         2lVA==
X-Gm-Message-State: AFeK/H2i5d6C9lW61phbY7xm0Z7gut/n3PDFJLOOkNUyFWAeRvXIAf9kde4AHZCXueV6LMny2LWSQwKjg1K6dQ==
X-Received: by 10.25.227.70 with SMTP id c6mr6471745lfk.106.1490431213504;
 Sat, 25 Mar 2017 01:40:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.160.208 with HTTP; Sat, 25 Mar 2017 01:40:12 -0700 (PDT)
In-Reply-To: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
References: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Sat, 25 Mar 2017 09:40:12 +0100
Message-ID: <CANgJU+UCJ9qR-pi9w3+oYjEwDdhbtNX9Nv6brj31VXvt-k-3Lw@mail.gmail.com>
Subject: Re: Will OpenSSL's license change impact us?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 March 2017 at 00:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
> They're changing their license[1] to Apache 2 which unlike the current
> fuzzy compatibility with the current license[2] is explicitly
> incompatible with GPLv2[3].

Are you sure there is an issue? From the Apache page on this:

Apache 2 software can therefore be included in GPLv3 projects, because
the GPLv3 license accepts our software into GPLv3 works. However,
GPLv3 software cannot be included in Apache projects. The licenses are
incompatible in one direction only, and it is a result of ASF's
licensing philosophy and the GPLv3 authors' interpretation of
copyright law.

Which seems to be the opposite of the concern you are expressing.

Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
