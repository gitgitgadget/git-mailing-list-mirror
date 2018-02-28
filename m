Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120CD1F576
	for <e@80x24.org>; Wed, 28 Feb 2018 09:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeB1JkT (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 04:40:19 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:41486 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeB1JkS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 04:40:18 -0500
Received: by mail-ot0-f171.google.com with SMTP id w38so1642177ota.8
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 01:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YwU7h3eOmePHyeO4aeetpq7OtIF4EmcfSqhO4luop6A=;
        b=B6Kze0Omvbml6TbsE82zUovrDKuK2Zqh0MYJXYMEUZIKlYD+lDQ/I0dyfsOhP11uz6
         Fr+3H0Ts/+CxGke6kRubSi8e2GB+++yrIL4QyGxoum3MpIF77QINw2/y4WUb1IcwA4X4
         YtpZL7Bpc7nPuQOD7AM7DVcl6s3uQw0WE46hQ2+vpYsglSyWeqdR65cxe7+u35TLnfPt
         CYlAl7fWujNVfnYHwrC9kd/bBAcqS8iQ1UbayHJix4SbntS9l6Kpy275f1rAICLYrqyc
         P6/g3j+6e0RJSFDmKIpnSpqMToD1KbEihHCsVfRrFpUCKkLeEMoPMGPyYXBXC6n42qOJ
         13Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YwU7h3eOmePHyeO4aeetpq7OtIF4EmcfSqhO4luop6A=;
        b=pxn6Y4PF8p+sPp9O94pvmZs+2duJIohNpREKZc43TijTtgayhPbpl1x5jv/zVo8yUI
         hNujKl+2P0sVLh6WM9fCRaBQk6rh3vyH++YbUinjcgjoovbSntYCOD9yIMQahaeFO/vQ
         rM3whNGeXyyTFrJgbLjYTg45aLGNm1TjkLaRyDkcizO5cgiffXI7qb1/Kp6iCnJ490TZ
         xBSufVtGyqL+biHHPfchh4cx+yJs/pMY+bD9py8Fqoz17J2rXc16qsZH/tjynrhEpRZr
         MZVKJoDucIWa3sCck4703PDnvQg19npHrlZHUK7+hBQTqwuUyYV7yju5f+c2uvtqRrq1
         gpzQ==
X-Gm-Message-State: APf1xPCCLO481DOop9PheJ0RaztxLOLuWmGp7bDlHyHRas+upx3MQmyj
        KK891Nu31/C0VN++Q34/naPFR5z7ZGk1405b+KQ=
X-Google-Smtp-Source: AG47ELuCQwZj20GsOa95VniRmYk8Ifx/aLJAEYhQwOqPvMh2XT/cFDJH9M4CAQ6INz3JlZayA9XZLhyCNuwNv29/KsE=
X-Received: by 10.157.85.214 with SMTP id z22mr13034802oti.75.1519810817566;
 Wed, 28 Feb 2018 01:40:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Wed, 28 Feb 2018 01:39:47 -0800 (PST)
In-Reply-To: <20180227202423.GD174036@aiede.svl.corp.google.com>
References: <1519762664-16889-1-git-send-email-marten.kongstad@gmail.com> <20180227202423.GD174036@aiede.svl.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Feb 2018 16:39:47 +0700
Message-ID: <CACsJy8CnxYyH2-diTXJXxkNH5i8MkpgK+6xQ9yrXro+bc_bgfg@mail.gmail.com>
Subject: Re: [PATCH] docs/pretty-formats: fix typo '% <(<N>)' -> '%<|(<N>)'
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?Q?M=C3=A5rten_Kongstad?= <marten.kongstad@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 3:24 AM, Jonathan Nieder <jrnieder@gmail.com> wrote=
:
> M=C3=A5rten Kongstad wrote:
>
>> Remove erroneous space between % and < in '% <(<N>)'.
>>
>> Signed-off-by: M=C3=A5rten Kongstad <marten.kongstad@gmail.com>
>> ---
>>  Documentation/pretty-formats.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Looks correct to me.  The space was introduced in v1.8.3-rc0~22^2
> (pretty: support %>> that steals trailing spaces, 2013-04-19) and
> appears to be a plain typo.  Thanks for fixing it.

Yeah definitely a good change.
--=20
Duy
