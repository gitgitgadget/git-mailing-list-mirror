Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 728A520323
	for <e@80x24.org>; Wed, 15 Mar 2017 06:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751008AbdCOGsX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 02:48:23 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35141 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdCOGsX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 02:48:23 -0400
Received: by mail-it0-f51.google.com with SMTP id m27so60673349iti.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GTYEpRQ5os51cGOl/QDk0y3ffNK3F30r+TpaMbeykvs=;
        b=twtlOPImA9T73TI9OPeFm56mMOO46xhlat0nr8TUpQHMEKlYBYAJbD2lygtkQOoKEc
         NVf5j59HP4pb7LSQWSPhHVB9M6SDEPrjzMjOW5aFyS4QECRoSkE4+gPBzqOkvYeh5kLO
         1EI5xOITTyshCS4n2uFgjgPl35vhPrMh1Z+lIVoDssdbdUJgAAJesl8Mn0F3iOKqHnd8
         W0VcsDiSW5/mQIP0wLtb5w3n4eruDjDUzLxfPHcT70JfY79VdjyTX/+zNrQ+TLDwpSHH
         VOlcVR05lzx+Hz7bfgptXGFWzjQ5478F8bbFvR2OXaQ4gKzO4J1Tj5eSCTsR2d9A6HRp
         wRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GTYEpRQ5os51cGOl/QDk0y3ffNK3F30r+TpaMbeykvs=;
        b=csWuCHZwFTs3giAZEoxHtMSUxttDXpnE1qsoPNeGtn/SObC2BOZpGF3EF3CauJyrvM
         rKQXRl2BVJbH1lNaqEHnAOurK+oXz1I6tv+3cQCYja27/ptdnCONGXYWZrEsZrkHPZZ+
         p30iP66XkDLdZrgut9ySsvCSgC9N0GbFA7wLYfvVLpJiL5lAePRB72TayZmuOAW3CmHI
         DPIMtwV90IXBMwMvYke9yo7xTvyWS6COn5Ef08sxio6fiebdJWlpQY7K5FGz9+QsMLjP
         BENob0HjxJb0CwnMa77lHCB4/eUZGhcmP//jAYnk++wVdqo6HOVSxGXzXDQoTUvOehxh
         +YkQ==
X-Gm-Message-State: AFeK/H0oYSi6mL1HETFyDhBC6nZi14/6O7Vp6QWPRx5IlcCfoahiwlG5aXbfRk81RxCGCVF+Is3GRx+LF4Zvpg==
X-Received: by 10.36.58.76 with SMTP id m73mr20643209itm.17.1489560501594;
 Tue, 14 Mar 2017 23:48:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.38.19 with HTTP; Tue, 14 Mar 2017 23:48:21 -0700 (PDT)
In-Reply-To: <CACHUE0-MyuL+8wvt1BeKMtxNUdg7AK0bDAg4BSeoj5aHjLARMQ@mail.gmail.com>
References: <CACHUE0-MyuL+8wvt1BeKMtxNUdg7AK0bDAg4BSeoj5aHjLARMQ@mail.gmail.com>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Wed, 15 Mar 2017 19:48:21 +1300
Message-ID: <CAFOYHZDEoDrX-R=GOm6VJ9d4x-UuOzVfnCwb0zkPezkoL=WLdA@mail.gmail.com>
Subject: Re: [Bug] Unicode display
To:     =?UTF-8?B?RMWpbmcgxJDhurduZyBNaW5o?= <dungdm93@gmail.com>
Cc:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Mar 15, 2017 at 5:51 PM, D=C5=A9ng =C4=90=E1=BA=B7ng Minh <dungdm93=
@gmail.com> wrote:
> Hi Git team,
>
> Thank you all for create a great tool.
> Last week, I updated the last version of git (2.12.0 x64-Windows) and
> all Unicode characters are display un-correctly. You can see:
> http://imgur.com/a/eriKQ
>

Looks like the same issue as
https://github.com/git-for-windows/git/issues/1087 doesn't appear to
have a fix yet but you might want to keep an eye on the progress of
the issue.
