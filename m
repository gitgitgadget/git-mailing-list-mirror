Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A656F1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 15:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeJOX3D (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 19:29:03 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39278 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeJOX3C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 19:29:02 -0400
Received: by mail-it1-f193.google.com with SMTP id m15so5002975itl.4
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uj/4KvveZK6n1FDjRtaCS0/OgXRbAeboOcy+xiyRR4g=;
        b=MlczrAGL4TVhNNQfJd1vZXLSo2FkaOspm9spcv5ej9omy1waGr9Zk5QDojyxqStiLV
         C5rldF50fO/l5Dw7W6qQzvn+tq9heyRAJZedbEsUokKhH/HpWqt1oMZb7zX4Tq0d3i/M
         GbXQt9ReNT8XDxiPa+ZIPOpg4QRX42uPNyI5k9/3gSlHgHNjqC9bRz/LPybnezj7WS8q
         FNEkYayeqSrxMx/s+KkMgbg9LIFaPxgtIl4UyfuUYnOmKuSyslOqfVmwg1ZV6gxYo+RQ
         LhdUn6Ek+xkYztemAgm0H3xl6/osv2MnDP2AKVkWFJjvEKHHdXYEIIj6uB28D9euc72G
         KJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uj/4KvveZK6n1FDjRtaCS0/OgXRbAeboOcy+xiyRR4g=;
        b=oTznshq8ZJB6YSzynfTrkcor3gv4AYIgF0KGDfMTMisdCNomC0+MFDr9EAdrAXNyVZ
         qSfFdBFgRI14C9sUFHakp/1xrnBHUH9/593TJjR9KZop/15k/dJa1om9/hNIvHFBFnjK
         J0MTsRmMCUswarpARw4XclYxy8VkaKrkZCB5lzVXM8bQu6z6LRy7s4kbl+iPj8DeM6Fu
         Qt9n+lH1JZP4p+OP7DPDXKP+xuChYpXI9olKZCCMWn0TLcFpcXr7iASh1gFTbkDQnJQn
         AmkCiQIoj/khWFLqfo1WfB+Sec1sZTWFO8DIoexNzPcpcZ10ia138s5cZxZORPa6bWxB
         HcNA==
X-Gm-Message-State: ABuFfoh0LvIsns+udVadssWStOYw56WP2TUBrMwGR+3D1Ab8Rm3rIvXU
        be6jWtluYUSkS0YE5SIjZSsmwHrPAxev53WTcSM=
X-Google-Smtp-Source: ACcGV63qi6+mcfnLg93t2WV4z2ohh7f0SkV4/t0wtdj4cYiOtt0zE4FQW5ewcDKmrTT9sglqlESRA++B9zZtFjju2kg=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr13011250itc.123.1539618195444;
 Mon, 15 Oct 2018 08:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <8736t7dzan.fsf@evledraar.gmail.com>
In-Reply-To: <8736t7dzan.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 15 Oct 2018 17:42:49 +0200
Message-ID: <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team Services
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 5:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> As an aside I poked Junio via private mail in late August to see if he'd
> be interested in pushing to gitlab.com/git/git.git too as part of his
> normal push-outs. One neat thing that would buy us is the ability to
> have a .gitlab-ci.yml in git.git and use their CI implementation.

That would be great since it allows gitlab forks to have CI support
from the beginning. But gitlab ci has time execution limits if I
remember correctly and I'm not sure if we'll use it all up before the
end of the month (or whatever period that is), or do they offer
something special to git.git?
--=20
Duy
