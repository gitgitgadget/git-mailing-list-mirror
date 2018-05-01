Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A30215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756387AbeEASqK (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:46:10 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36990 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756295AbeEASqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:46:09 -0400
Received: by mail-wm0-f42.google.com with SMTP id l1so20398527wmb.2
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=H03Z2APZ64rJrClOApdeH4ngdedKn20B5KWABud67hE=;
        b=nGqFgILVpRRuhG9RisWQVpEn1YfFQ8Bn9+Uzy8If8HOzWDfwLYUK1JsZ1v3LYbdoX7
         AXHkmXc+4ZR0p8EUzGgbYwvjg237tDQG8orlFwh1XwW/q/jQQIuzI5uH5++bTrhQoqjm
         gadyfyq5SYQby/CVZxKO6ALk2gqvHpFeHq65j7X14fZovbk/AOLY3vgnCsYjTcyyvgkl
         RE/mSbo5aT5oK9+BLbMoF4/ml9AUs6p+8bbdCEqSUKIe0xn70XbxosLweujoUpBLkNhs
         gEyLhwJAzBKBJe6nCEdYhbRJycEzwsEgTfEMJPWjHP76d6MMqSzEXt7KAWhPfpA+YBdm
         SHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=H03Z2APZ64rJrClOApdeH4ngdedKn20B5KWABud67hE=;
        b=Vs3wpfh3VPUsX3YH/9ZL/24iSDSGptjx96BHKto20BHeulUEOI1iaAMnO4XJZXlkHY
         V2Devc96yEqZ3rOP9SkYRQ8tyfRWTU5Ig0ZoEPA8kXRL6Rnblh0fls3agqNAeGZEkYLx
         /moy+LyOos+lrhH+HmST8GXjPizvEhaQVVij8h5OmK3KINUblFfE+GLAbnuzjckljTp/
         9IjOutA7NUByrEcKWC8a15TbHjlXwRF7A3BNyQvgraQep/uXuzgyZgsgpeCdkB55Xu2U
         0S2p0MpmV3l9p/V8Kwa1YH9aAhkcZeWzViAL5FOP/9Er/2aJCotp7Gv5L2HZ9GcXjH12
         +3UQ==
X-Gm-Message-State: ALQs6tDtbj4d1RxBWfuoDVGtyJiIErSf18S7YBNrrVbVU0PQ96eZ96D2
        0h0dLqcuf/rat1X8VI9KZDU=
X-Google-Smtp-Source: AB8JxZrYauokC4trze4wgT5vGa4B8hU0wRZkoa7ziWkeWXMDHIbOptezOuxNXSLpW5nCWhWpzIbbig==
X-Received: by 2002:a50:fd12:: with SMTP id i18-v6mr22869532eds.158.1525200368367;
        Tue, 01 May 2018 11:46:08 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id h64-v6sm6005872edc.19.2018.05.01.11.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 11:46:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: js/no-pager-shorthand [was: What's cooking in git.git (Apr 2018, #04; Mon, 30)]
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com> <918c69be-89ce-c66d-92ee-4821e9412793@kdbg.org> <nycvar.QRO.7.76.6.1805011351330.79@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1805011351330.79@tvgsbejvaqbjf.bet>
Date:   Tue, 01 May 2018 20:46:06 +0200
Message-ID: <8736zbz029.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 01 2018, Johannes Schindelin wrote:

> I wonder whether `-!p` would be better/feasible?

In *nix shells `git -!p ...` unquoted will turn that !p into whatever
command you last ran that started with a "p", in my case `git -ping
8.8.8.8`. So there's a reason that's not the idiom in any *nix CLI
program (as opposed to +p which I think was mentioned in a side-thread)>
