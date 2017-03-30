Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079DC1FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 11:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbdC3LIi (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 07:08:38 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34485 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932541AbdC3LIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 07:08:37 -0400
Received: by mail-oi0-f45.google.com with SMTP id o67so27647201oib.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HWwrrUinAIZzJ9BWeH1neLvBoOUj/pu5vvAhT9jl+s0=;
        b=DHCmC/NKJ7bQy9P8Fi14b7yONIptEFsz11Zbzr3/+Obh0tg46z2LEFgzY4yQMK4oXF
         rdayL/ENrxu4g1iW09UwXqKvVFEuHUa6+nbyIck2ovnYI5Jg7WxERyKPgFhsVNRzaEta
         3t+XFpH9+cj99Xg3AmZ9R1dGdtFabIYnV5F8ePbrmiixDaEFddOIsV87fvlB1uG2arOa
         E8CHVvYuL/3+stXcpXswU1xMA3HUQHP7VqYFyGwWg2rZtafDMVC/js+KZZCCrDkSO4Jm
         1iyKDbRxdp9sEF7ESkU3W7ziTxoPsVyQhiAVtbJir6VL9mUPH+CAmFhNWTYUTVVpTvDt
         efyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HWwrrUinAIZzJ9BWeH1neLvBoOUj/pu5vvAhT9jl+s0=;
        b=s0uxaPDJLSmw1oFqsy/Ks6ntbfg23T2t9e41ncUgYLa3PTfitPdWH+iRc5kfCam7o+
         77fiQBHFTXmYnlvyfcK0lCtFYRbOwbLVs38LliAgPAnlkdFYGj40/IyA4amXlXnfNPBO
         He63XPgi8xVDGI4PiJJSzELPnAh4YRdSgRpNgeG6H9Ci5zAIge7bOj9YZ+/T56NPYtwa
         KIdKInxBBIomSG5ZzwmCHhVgtW7PNFyQro9q/Dtc3589M2++SqA1QrPJrvRuJt75wpB/
         GvRWczUarHepD87xCDLjmd31uEM02dBwqzQ7muTCYFH8F1nUCnGkBqxCZwlrmoxjTQg5
         lbEw==
X-Gm-Message-State: AFeK/H1HRJumFxw/f4hP0nmC5Bn00rDND1QL4cSwbUdBeiDbFSLrbPX1nGBCvp2hodVc5LF7pFiHJkICz6GLcQ==
X-Received: by 10.202.75.140 with SMTP id y134mr2679868oia.169.1490872116023;
 Thu, 30 Mar 2017 04:08:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Thu, 30 Mar 2017 04:08:05 -0700 (PDT)
In-Reply-To: <1751d788-d1f1-1c97-b33b-f53dab78ef86@alum.mit.edu>
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
 <1490747533-89143-3-git-send-email-bnmvco@gmail.com> <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
 <xmqqk278av4x.fsf@gitster.mtv.corp.google.com> <e412ef09-276b-92df-d2c0-0bf2f80238d2@alum.mit.edu>
 <xmqqinmr70uc.fsf@gitster.mtv.corp.google.com> <1751d788-d1f1-1c97-b33b-f53dab78ef86@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 30 Mar 2017 18:08:05 +0700
Message-ID: <CACsJy8DBa-oH3i+5P=iVr9NhJwsicZ43DO89WmvpYEQu90RrMw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 1:39 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> * DIR_ITERATOR_RECURSE -- recurse into subdirectories
>
> would make the set of possible options complete. If this option is not
> set, then the iteration would be over the entries in a single directory
> without traversing its subdirectories.

And would make it possible to use dir-iterator everywhere (except
read_directory_recursiveky). That would be really nice :)
-- 
Duy
