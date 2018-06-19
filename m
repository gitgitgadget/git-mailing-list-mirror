Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB631F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966671AbeFSQ3G (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:29:06 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:51722 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965953AbeFSQ3F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:29:05 -0400
Received: by mail-wm0-f54.google.com with SMTP id r15-v6so1408155wmc.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=68R8FG8t2DwJ3zfQZ0TnzrTRck8DKkg8mrbVkXAgEjo=;
        b=o151l/QzbEp2dOdKPQjb3JkMEXqR0uVTGBby6C8Zp1lnx0LUikWkNZEA47duY5Z3oo
         Atrt3T9LS/b4Rn0526SN0mudpwNfHz6On+fLMn+NfyBhflxG1RZv5TWHQlah+AhxrTDI
         bw180GnLJIvow5NDxRxdIPTuoVOrpVbeFe7246TwgeSkubx0/Fly82GAYM5nlykOb0ut
         dKPX6vqRIwB/YwDL3i41prQomVBKGwj3t3UfcWFidxJjDIcDRq86MspAT769DYEa6vDz
         QdwDEfq2OV5QD6ljfpHH+5Odv/lnKXRJ8CKk9TpkGYTPTb6Yj3xxDAxk0NvEBn9SiUrP
         W0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=68R8FG8t2DwJ3zfQZ0TnzrTRck8DKkg8mrbVkXAgEjo=;
        b=LOadD081S/L8PScg/xXN9VhuOsc4D+n3yP/Z4tQw05m81DTl0pZ1MbA2aIVrn4JwMI
         lx6LpW61JsGDJhXDDiPZk20CI5RObRdoDL/oU70xxoA6C6HUbAftvGkN+JkQOLmgtWHU
         Y2pumCoDu7RaOH+Lz9yJD+7llHoju4DC/ZmsbQ747nsilYGTGbaD5YWHNWbhWMKWIOi+
         jobH0kHoJfuwF+iduWHzzwh6ql0QK8eK+HIsc0gnJQrZgcMv/Pp6jOCFFrW8KoTtLq6I
         Dq8XnHJ8/DbvqKO52cnHktJATBPOwWJtFjolZ6v0wambJ/usOvHMlxAFBYNW0iXNJR1b
         sUyg==
X-Gm-Message-State: APt69E2NS6A6PRo7ZD3FQLjGgSVwCh3YDekWdtrOHKObK2meA9U9PWW8
        S5VfKrqkZQ8PO1D9CGap7Ts=
X-Google-Smtp-Source: ADUXVKJ5uNLNYAKAYkbB6lEDgaxx1Eoz70Nr5Uq8UPLZs2Z5QRDTkEQa1rVKRCD1qvHI57hZ8JtiKw==
X-Received: by 2002:a1c:8409:: with SMTP id g9-v6mr13501107wmd.90.1529425744389;
        Tue, 19 Jun 2018 09:29:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y8-v6sm158572wrs.0.2018.06.19.09.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 09:29:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>
Subject: Re: [GIT PULL] Korean l10n updates for Git 2.18.0
References: <CANYiYbFx7O3y8e_VHU33HhoC_hyXAwfOb02ntSHeWuqez6ErFg@mail.gmail.com>
Date:   Tue, 19 Jun 2018 09:29:02 -0700
In-Reply-To: <CANYiYbFx7O3y8e_VHU33HhoC_hyXAwfOb02ntSHeWuqez6ErFg@mail.gmail.com>
        (Jiang Xin's message of "Tue, 19 Jun 2018 09:36:53 +0800")
Message-ID: <xmqq602ewxip.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> The following changes since commit fd8cb379022fc6f5c6d71d12d10c9388b9f5841c:
>
>   l10n: zh_CN: for git v2.18.0 l10n round 1 to 3 (2018-06-18 00:31:45 +0800)
>
> are available in the Git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.18.0-rnd3.1
>
> for you to fetch changes up to 4898dd2513360bd0cb32ca67ca07c70787c81399:
>
>   l10n: ko.po: Update Korean translation (2018-06-19 02:19:42 +0900)

Thanks.

>
> ----------------------------------------------------------------
> Merge Korean translation for l10n of Git 2.18.0 round 3
>
> ----------------------------------------------------------------
> Changwoo Ryu (1):
>       l10n: ko.po: Update Korean translation
>
>  po/TEAMS |    4 +-
>  po/ko.po | 6083 ++++++++++++++++++++++++++++++++++++--------------------------
>  2 files changed, 3553 insertions(+), 2534 deletions(-)
>
> --
> Jiang Xin
