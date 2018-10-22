Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0A71F453
	for <e@80x24.org>; Mon, 22 Oct 2018 05:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeJVN6X (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 09:58:23 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34017 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeJVN6X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 09:58:23 -0400
Received: by mail-wr1-f47.google.com with SMTP id l6-v6so43014011wrt.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=T/sF4gZwOnmCuCxTj/665a8T6deT48ONh7NVwLMIVZU=;
        b=rotVfq8V5rrVrkUBSdFE6cIbbRu5liFNmsH7JJlEVCSkgqdS9vcN+Vx3eGgdi3Qc30
         EAjxlQS6C1YlJuF0J1NrUHsixvVdI8fxrmooZN6iA3galP2puxjl8L0PFxJcc/gp3/1W
         d9uFOjTcRk6m2POGT/gFnq04ZLIe557vrmewadJCxu4RVaan9WB8Kav+H5NPlcSJ1xD3
         pcNWneJqI5wGB+nSravzjwN+tuZ+zhzzEFsILIe3a7zxb02tp1Zb2RVOYDNSZ1Bf2jaF
         spDo0459yrOZDgKwUN8WBRbU4gNp/wQNcdnW6VEaRHTKrA8ocO1m4O9h+HswwLQYONmf
         2EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=T/sF4gZwOnmCuCxTj/665a8T6deT48ONh7NVwLMIVZU=;
        b=gi2b7Q/T9Pknu0FuHa5U8YfL6DgIULengTFWnez0yjUZ7YvcsI3PB6ZW9cDVibMtkP
         5lXodcsEXuC1PfAUNw9eMdUiBdcMLJdSdtSQ+YgaRmWh51wdt10RmGjbEMldS0PIdZwP
         bSoMciTIzc6LamaFpDnPIKh5EGTxeTDue+9LrcwK9cdTXcLsu/HpcGfjfk+ZiOMxzwEx
         VVdof8vxqUfLcqetoaWCbufuNGWllEJLWa9eLV58KeiPOy1XitOGhGHovcB2W6zmllU4
         u0oK4aeU90/CFtE8rBuLjc5hK/hQ5CV1x+T0m+oaYdkVlrtALSwFAH6iyH/oTF4e+faW
         XShw==
X-Gm-Message-State: AGRZ1gJXql5+1Nem+9LiuGOx22Qnam/R/u4qnGWvyqr+L6akFawQt+Nf
        UUdYatOoOm3PY5AJL++neLU=
X-Google-Smtp-Source: AJdET5eh155LmBONLFOYU59ew3SKYBxIkWTISksPdyDqC2IejiZ2gen97JNMXbsa0RX3He4rr3S/3Q==
X-Received: by 2002:adf:f6c1:: with SMTP id y1-v6mr2584784wrp.261.1540186881648;
        Sun, 21 Oct 2018 22:41:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 90-v6sm47071005wrg.86.2018.10.21.22.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 22:41:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Mirror of git.git on gitlab.com
References: <pull.31.git.gitgitgadget@gmail.com>
        <8736t7dzan.fsf@evledraar.gmail.com>
        <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com>
        <CAP8UFD3cpXpyx-AtTybPirzduFR7TfhFf2woa-_CU46DN3RaXw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1810152032140.4546@tvgsbejvaqbjf.bet>
        <xmqqd0sa1omm.fsf@gitster-ct.c.googlers.com>
        <CACBZZX59vT1CTiUPfPZDJUSRH=NSzmWiabux=KRdTUFa1R=5bw@mail.gmail.com>
        <xmqqo9bsvwn9.fsf@gitster-ct.c.googlers.com>
        <87k1mecj96.fsf@evledraar.gmail.com>
Date:   Mon, 22 Oct 2018 14:41:19 +0900
In-Reply-To: <87k1mecj96.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 19 Oct 2018 12:40:05 +0200")
Message-ID: <xmqq1s8iwnb4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I've set this up at https://gitlab.com/git-vcs
>
> The /git namespace was taken (and I asked GitLab support if it was
> stale, they said no). Also tried /git-scm and /gitscm, ditto. So I
> settled on /git-vcs (version control system).

Squatters X-<.  Thanks.

> As an aside, I noticed that
> https://github.com/git/sha1collisiondetection/ has never worked in
> combination with git.git, i.e. it's cloned at a version that pre-dates
> the initial introduction of the sha1collisiondetection submodule. Our
> other mirrors don't seem to have it at all relative to
> ../sha1collisiondetection.git from their git.git.

I do not recall who cloned it or forked it there or what our longer
term plans for that repository would be.  I think we are using this
thing: https://github.com/cr-marcstevens/sha1collisiondetection.git
and there is probably no reason to have our own copy.  Perhaps we
should just get rid of it.


