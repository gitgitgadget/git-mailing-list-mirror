Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682DF20372
	for <e@80x24.org>; Tue, 10 Oct 2017 00:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755566AbdJJAoC (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 20:44:02 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:50941 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754707AbdJJAoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 20:44:01 -0400
Received: by mail-qt0-f180.google.com with SMTP id f15so46809130qtf.7
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 17:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mCW/xUUwOIDi2WVUvAeUnEtx1HKJ6Wm2/oSC0RdkCmY=;
        b=Ket+KhG6Zpaj88+1+Avl5P0cU4nvWfs+Xn48U1idPk/VQxwfE8CmUiunpubTcxfjJZ
         vhSxbdRfcciubf9go2LWN8sX15UQawtqDVAcI0mE/u5qTVP/RcWkUhQXWIoXPw8AGdiF
         GD0rM+mwv4yl1ncBYJ0IYZVJyCwwzeUZjTYiKhLX+9yd/84slXI5qfKgsxtBDwo0BTyM
         Cct4hQ9Ggarb/cBR7pBpe/OcPxw/AbCHwOgXBB6vopHhbhpXBWZhPOEYUf7KtwQoyqVM
         sXA0/99/UAFYEbXXeWew4oR4OnJkKKStkKX811nMpItRHXODcTWW6zn+IZjGyrOCMyqN
         jadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mCW/xUUwOIDi2WVUvAeUnEtx1HKJ6Wm2/oSC0RdkCmY=;
        b=b+9NXfxmM9aOuouIdscWiOIfUbHFUE1VwYcbTzJ8QPPiaKsl0OuH3CHgpukoBw/hGG
         Ysvpf/Guq6Di/S8xUCyiRl+LIMYvYsbnswmNmGaQKVEnVi/P3k6Bwe0Z3nFk60V+Dhfj
         lcqTBU00v7EQIftm+9pmDgFWk+fgK1rkr2cHni7ypXAGZ6LpA86RCCbrufRsc5Un57R1
         QRZFJT5A+l9smIa5P41lCmWAB1s+lFErEF70c2KnpnIPtHYpdR/CkN+/zSew57KtV6ay
         VfuPgFLLDK0Zm9N9c3QburPpzjWuPZhL1wavp+YzWL5a8MWDNwGpGWrqM68hDEDYuJS9
         9IEw==
X-Gm-Message-State: AMCzsaVb6x9buxF6+DukTj/OM0dnCUwasMlRpVnjuQa7P+ku7BcXo7yV
        qGjKUtxF2F8A5NqGR9Uf7Tz9j74QF0pRWEqn3g==
X-Google-Smtp-Source: AOwi7QBPb2JYEoB0qUE86wI9C2IUqUCmcD6KykPy5+zkXszC4EilP+nHyQNfZKs7LzxXKRlp6GDxv30dGc22LHeZdVc=
X-Received: by 10.200.4.29 with SMTP id v29mr12108039qtg.76.1507596240963;
 Mon, 09 Oct 2017 17:44:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.19.8 with HTTP; Mon, 9 Oct 2017 17:43:40 -0700 (PDT)
In-Reply-To: <20171010001619.GL19555@aiede.mtv.corp.google.com>
References: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
 <20171010001619.GL19555@aiede.mtv.corp.google.com>
From:   Nazri Ramliy <ayiehere@gmail.com>
Date:   Tue, 10 Oct 2017 08:43:40 +0800
Message-ID: <CAEY4ZpPj3=+gL_wBW548qzAuS=aC=qswuPx-4H9DS=X10iJWVw@mail.gmail.com>
Subject: Re: What happened to "git status --color=(always|auto|never)"?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 8:16 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Nazri Ramliy wrote:
>
>> I used to work before, but now:
>>
>> $ git version
>> git version 2.15.0.rc0.39.g2f0e14e649
>>
>> $ git status --color=always
>> error: unknown option `color=always'
>> usage: git status [<options>] [--] <pathspec>...
>
> Which version did it work in?  That would allow me to bisect.

Sorry. It's my bad. I must have confused this with `git grep`'s --color option.

I have a perl script that shells out to `git -c color.status=always
status`, and I wrongly documented that the perl script's
`--color=(always|never|auto)` is "similar to git-status' option".

I verified this down to git-2.1.0, git-1.7.0 and git-1.4.0 confirmed
that `git status` do not support --color option then, and mostly
likely not in the versions between.

nazri
