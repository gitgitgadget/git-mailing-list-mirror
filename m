Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06700211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 13:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfANNgk (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 08:36:40 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:55812 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANNgj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 08:36:39 -0500
Received: by mail-it1-f182.google.com with SMTP id m62so12977199ith.5
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 05:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WzfGs7n1xxmGdHrk7rfebXM6EvDGHpw+1Y2oRrh6hsA=;
        b=BH01LyM0NpRyo9JYjaWphv+Qyvn8IMcOk5hc5vFY4qSbBgaCbrG/HqR6g4gUPSFZvn
         peVK8yv7K3zdunKtjn2ADsrBAOFYbvpSe/gxr32F4clM4+mnZC6rZIWpNYfLX6UoIfF7
         +fI7MBOii7MPBVKJWTwZZSk9a4UtWGnlT4Wov/DcADN70uvnJAY6x5Y/cqASXa8gdTnY
         7MIAd1i9ZameQD/YfdCFIKsAupoL6k+60MhQANoVFzk+fcoLrYEkV+E7YoZQr10Mc/qE
         Gl8SX9tmU4rTB2hpsogY0l74LIqm7sUSDRnCAgxKJt+8xxzoham3KtE5WIm9ArcDFxAO
         vTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WzfGs7n1xxmGdHrk7rfebXM6EvDGHpw+1Y2oRrh6hsA=;
        b=mM9M4TG32TkrUVtzUxWb304WOaMFcWZKq+FIJc/bzHs0g/ICHgdbEzPD9pUL1nEDTP
         +sn1dS728suTBRuljZr5PtRpejfDqC+0AX1UQcItq2IomB+iX3kJAlbJoZVBbJJnHIMK
         iZK25tnEf8VzOZg0fiWjHn1f4SigCAGuxZy+ROsdlfH6YqneSF1TNPr5KOs3B+90WcsU
         qYrkyOjQbKcd6rxGdanoR3i/1Ema/Xn5IBKVmfOdOkTQEvHEUTnL8y/P9tZuluoG6gNY
         3jIyxmqA2LfMyUrvqmhFTG57wQdvQ4nRZMhD4/2b+shNjRlzkNwLcc2dVbOxj63ppNoA
         qqcg==
X-Gm-Message-State: AJcUukd8Wgrx2RcWIEZak75guS3vbNHFaU/px1T4+5WILmNRo25du0kk
        +WTns9PF5BTKWNuueyi2i86UTwlNeV7D5Pdhp9kMiQ==
X-Google-Smtp-Source: ALg8bN5hqT+JaA1mTHuXcn0LSrm/9TttRIMiS1l7g2V9p4q4hkjV7ndRatEP89Srg15I12dMcGGvn+gnh7ML/NLfnaA=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr7924593ith.123.1547472998933;
 Mon, 14 Jan 2019 05:36:38 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxXyB=1KW6Hx7cs11Ltf3X_wuaQNfaYPmcnr946y4phXsA@mail.gmail.com>
In-Reply-To: <CAHMHMxXyB=1KW6Hx7cs11Ltf3X_wuaQNfaYPmcnr946y4phXsA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 14 Jan 2019 20:36:12 +0700
Message-ID: <CACsJy8Ac_Z1jyBhH1vvYnS_d6tTv5u1j+gjpiGDFE8np-bJ3sQ@mail.gmail.com>
Subject: Re: ls -files missing from git-completion-list
To:     =?UTF-8?B?zp3PhM6tzr3PhM6/z4IgzqPPhM6xz43Pgc6/z4I=?= 
        <stdedos@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 14, 2019 at 7:19 PM =CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =
=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 <stdedos@gmail.com> wrote:
>
> I have install the latest git version from the PPA:
> $ git --version
> git version 2.20.1
> $ lsb_release -rd
> Description: Ubuntu 16.04.5 LTS
> Release: 16.04
>
> Running `https://github.com/git/git/blob/master/contrib/completion/git-co=
mpletion.bash#L2898`
> does not give ls-files
>
> $ git --list-cmds=3Dlist-mainporcelain,others,nohelpers,alias,list-comple=
te,config
> | grep ls

This is expected. ls-files is a plumbing command and will not complete
by default. You can however add it back by adjusting config variable
completion.commands. See "git help config" for details.

> $
>
> =CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82



--=20
Duy
