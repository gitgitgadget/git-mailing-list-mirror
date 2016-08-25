Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9B71F6C1
	for <e@80x24.org>; Thu, 25 Aug 2016 05:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757473AbcHYFZH (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 01:25:07 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35785 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757070AbcHYFZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 01:25:07 -0400
Received: by mail-wm0-f49.google.com with SMTP id f65so222866142wmi.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 22:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OxWXPmw70Rf1YainHRrTKBgze9OipLzNHS8HbXHGT9g=;
        b=t9I4EvS30jImsQV6LfKInrrgaWxtfVDRU3I1kmNzU4WvYTWPlTCZEc/FAgVuq9MVUf
         Etb8dSR++dB+4mcT4PLc4LzIdbxhoNdEVEAzPkeKvCrnBRyPdOHu8dhyoQ4CNFZ96T/t
         n4Sq7+3/1C2MqFy00aS9VhUVViIbzieGcpD5jaQedGFqp+nr4s9oAvpU8IjKuOvsiZxw
         MPmmzNRmHbaue4vQM1N2G5V6KRuKD2FTOE02rFTY6SfQs2Y8+i/a/fG0pzGVpdCEUK0o
         gegvorZXwMGaWXHMAfPIVXnj6mQdyHY75XTWKvgjYVETT1FqCx7lIcZ2UNBPIjpcmvB2
         62TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OxWXPmw70Rf1YainHRrTKBgze9OipLzNHS8HbXHGT9g=;
        b=SUm11/G+JL/fBkDuQodh/6u+JqTddj0ImYTzeFXL00blkO6U7HZQI64/qpZ1Tv2jqp
         +c+J5Cqe1lm70oDpWiZTXTVvNXVFZaUEikNxy8GqDUfD+FRROC3xOMu2rZY8HjYG2KYt
         f/6IrW4gAnwWikEGDLOEHa+sCmsDEN6W1cw1ZiUVE1zHsBF1g0f7UVucbuYqa5KSycK+
         K64sHyytbXtyd8l/iyggNnVan/KP6rxUSqjOXO3Q/2cfG/HM00HcqcigRodqd+CxGjFI
         WMdsHrdXDmuYW25ZaiB6prxWqAWvU8B33z8XaQim6VFH6GxcKxjAGJ4Y7EA20XzXYb3i
         hr6Q==
X-Gm-Message-State: AEkoouuDF+zstvaBLidcMEjeIxJ0yTi8eOU/LrlGwvGuH3Uma4x7nc8CeNPpq+mZTT/qJ5s5kXQD1mEqZ/03QQ==
X-Received: by 10.28.222.8 with SMTP id v8mr28380007wmg.55.1472102705642; Wed,
 24 Aug 2016 22:25:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.62.10 with HTTP; Wed, 24 Aug 2016 22:24:45 -0700 (PDT)
In-Reply-To: <9262712.D6TC1VHfMN@cayenne>
References: <CANYiYbGL+GVRNuhszp1UShaN_oJgm3netsQxZfbW74pVK0gOYQ@mail.gmail.com>
 <9262712.D6TC1VHfMN@cayenne>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 24 Aug 2016 23:24:45 -0600
Message-ID: <CAMMLpeQwUUWVUQv_1a9+WbbncHVxX2vUV6NQxB0ftzr3ghCtJQ@mail.gmail.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.10.0 round 1
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-08-20 10:01 GMT-06:00 Jean-No=C3=ABl AVILA <jn.avila@free.fr>:
> 2.  in sequencer.c, there is a mistake in the original string to translat=
e
> "Cannot revert during a another revert"

There's also "In both case" in git-rebase--interactive.sh.

-Alex
