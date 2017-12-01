Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F0920954
	for <e@80x24.org>; Fri,  1 Dec 2017 12:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbdLAMp7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 07:45:59 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34037 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbdLAMp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 07:45:58 -0500
Received: by mail-wr0-f171.google.com with SMTP id y21so9953326wrc.1
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 04:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZTsHoqeQwuD2zzlHpZBrVutErY3F/EO/ZXdMHICyoXo=;
        b=mt7nRIigAe5OO7s4m92Y+7AKv0MEcBScTDbDGGWWxaUPvYQVEYNKY/27gTkDnl8QQh
         fl65uZl00PIVwNj8DrRzspSBS7fJZqR6CMxsAajNslM467mpzHKcm9KYj5+A9UUPXeci
         mHEfd1muKOlWwk3n7bHTiw2K1yjL0socOR24+4K7fre2/mGZOyz2cZrF2K/v5/0fcCOF
         uq0TkDukhOLJOWXv5YFO+zFP49ibId+5s1sjutPr9aO1ViRAh9IO0jtM6d9Gi2kOVn8f
         rTMSb37VoEWDeW77DdHSKWjZvLa5YLGxPlsqG8ACgtj94AaJa0LU2GnCOoMMvHN2p5k1
         AP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZTsHoqeQwuD2zzlHpZBrVutErY3F/EO/ZXdMHICyoXo=;
        b=bBQ3t8bpuGUd+xBLqdIVJeAWwZYe4yIc1dv7zR/Mu50esHz4cyufwOqe8omPlCfwUH
         yCHeek25XIn3yLjjEB/CEmKO3NDR/s8FnjxYmfcCp54S8lXrPJrJ0DOwihN3ETDCAOy0
         799RsAQmHrgjs9lih/E5qRAIcm6pzftieL2dVtdwtAazyHaBwGMT4X8n2kqmBsDcVFZe
         1F6tI9JlrWmf07PzETTsYaA/yMs6GbfcaMdbpDfUTnVd8gxN+2UBzChuxq33qe1JQTn2
         FUJOleAHbQz9nVAKks41qtPrLQvcEloMPr4JMj4tNJg99ehfopDmClTT6zwqbRdrQze5
         ZbIQ==
X-Gm-Message-State: AJaThX44X3sUQUUt3smOvUMasDWH04Fs97+bol8IxkYDeKkwlXunk2z4
        rMWR0a41Ap8dl3oB5AbNbwDZh5Sv
X-Google-Smtp-Source: AGs4zMb2vX1oYdojh602dexDJrsjxlSpMXnWt1jLZOABhB+RlgDhLrh/jJ2gTiObozf0pB25dX1heQ==
X-Received: by 10.223.182.19 with SMTP id f19mr4881519wre.81.1512132357102;
        Fri, 01 Dec 2017 04:45:57 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id l142sm1050165wmb.43.2017.12.01.04.45.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Dec 2017 04:45:56 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git-p4: cloning with a change number does not import all files
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAL1_K8C3bNMae6PFk73c7n6AvnbO=5Sujz3oqL_jBj=DpiEO1g@mail.gmail.com>
Date:   Fri, 1 Dec 2017 13:45:52 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6F43B7B-F0AF-46E7-B34B-7D54493E2C8B@gmail.com>
References: <CAL1_K8AYf1jKDO8+czcqkUxDAuOODgKv9avaiikWi+4zpqenMQ@mail.gmail.com> <57A92686-9161-4234-8341-CD6FAD7AE049@gmail.com> <CAL1_K8C3bNMae6PFk73c7n6AvnbO=5Sujz3oqL_jBj=DpiEO1g@mail.gmail.com>
To:     Patrick Rouleau <prouleau72@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Nov 2017, at 04:48, Patrick Rouleau <prouleau72@gmail.com> =
wrote:
>=20
> Hi,
>=20
> On Mon, Nov 27, 2017 at 7:52 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>> what is your goal here? Do you want to convert the repo to Git or do =
you
>> want to use Git to interact with a P4 repo?
>=20
> I want to use git to interact with a P4 repo. I am used to git tools
> and I prefer them to
> P4V. Visual Studio is also slower with P4 plugin and I hate P4
> approach to check out
> a file before modifying it. The .sln files always get check outed for =
no reason.
>=20
> I am working remotely. The P4 server is behind a VPN. That one reason
> I am trying to
> clone from some point in the past. I also want to have some history to
> see from where
> come the code and from who.

Oh, I am with you. However, I only used git-p4 for a very short time in =
the=20
way you want to use it. Therefore, I don't have much experience in that =
kind=20
of usage pattern. I was able to convice my management to move all source =
to=20
Git and I used git-p4 to migrate the repositories ;-)

Here is a talk on the topic if you want to learn more:
https://www.youtube.com/watch?v=3DQNixDNtwYJ0

Cheers,
Lars=
