Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819EE1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 05:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJTOCd (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 10:02:33 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:43494 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeJTOCd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 10:02:33 -0400
Received: by mail-io1-f54.google.com with SMTP id y10-v6so24222570ioa.10
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 22:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dana-is.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NHDmko2GHrbuat3Fx7QdrpOwsCtsgBKz1+Zmr7fLFB0=;
        b=jMfTqydyxxfHEh5HylfzIisNaOkjsOix3+lcKvAEXTo59/rdVvUlIF4uXye+2+AqI4
         eeiks4hQsuPZ4FCPZ/pGs5pvra0y122oqNXfdHDRXbmu3OqZ4PT6qxpDNdp53toxj05Q
         Zvz1FHBBkAiNYmbs3hLdjkJFjbbEbL0mrTZJcstVo4srrLR1PvQeRcJU9uac7K1HmtCC
         CXkN+l5EvewcBe5oy8bDUsWfe9bpAJOJhmzZoEC0HJ1bWFpB+GRUF04FqrY3efv95Dwr
         CsGV2lUbbug1E/EtTqlr3sDAEJYHN8Hx2uB1vL9LuPEtsgb0K+aDZVsmwNY4FriXkQxo
         J/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NHDmko2GHrbuat3Fx7QdrpOwsCtsgBKz1+Zmr7fLFB0=;
        b=mL8w+y8K0QU3PoTi+LpbHaPjXya8M+JPqa4HixnzV7CEeFGYA/mDTcgLko7rL8sxoy
         poVbVeJIuA89LZzWmFHY0pPCyjejokHkIgDCKALufx7pnigyyu3oJFLlQQALHksYIP83
         DXCsuCIuPJGOVlRz/coTTAY4Nz/RcwQ6AbN0w0nyYm8oJtIJFIz/FzJPpEMzluti5TFh
         J1FA6MA2fyUmGY8UBjDkY/UHOgswgNtt41c3IrE1VbLWm4tRFBie9fkttqA3okbHaMw9
         Ipn/tFzm0iKQWjEPFn5JIu+zFqAGpu80O99gYFbwYrFNVD7DAlUeZB+TxQ94jhtxmvL9
         2jFQ==
X-Gm-Message-State: AGRZ1gKfolFgCmuuuhDwNR2cfkfZIQkKwWQb1yfo3xTibJlbgRdkERX6
        QR/tiwpcFIKepdncCGaV0JoVpw==
X-Google-Smtp-Source: AJdET5f67KC7FhlXtJ8y+Il4E2XsSPG9ewIYZ9tkRN4iaD9joo0Z8tP6pPkTxHOFaCTIcZhkkVVxKA==
X-Received: by 2002:a6b:610a:: with SMTP id v10-v6mr4865065iob.107.1540014798321;
        Fri, 19 Oct 2018 22:53:18 -0700 (PDT)
Received: from heartswap.lan.dana.is (173-21-17-19.client.mchsi.com. [173.21.17.19])
        by smtp.gmail.com with ESMTPSA id z11-v6sm2685903itz.26.2018.10.19.22.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 22:53:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [BUG] gitignore documentation inconsistent with actual behaviour
From:   dana <dana@dana.is>
In-Reply-To: <20181020052624.GA31433@duynguyen.home>
Date:   Sat, 20 Oct 2018 00:53:16 -0500
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Andrew Gallant <jamslam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFFFEB92-0CFE-45BA-8BE3-105E8963A121@dana.is>
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
 <20181020052624.GA31433@duynguyen.home>
To:     Duy Nguyen <pclouds@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 Oct 2018, at 00:26, Duy Nguyen <pclouds@gmail.com> wrote:
>Which way should we go? I'm leaning towards the second one...

Not sure how much my opinion is worth, but the second option does feel =
more
friendly (from a usage perspective) as well as more straight-forward =
(from a
re-implementation perspective).

There's a third option too, though, right? The 'rsync' behaviour =
mentioned
earlier? It wouldn't matter either way in any of the examples i listed, =
but is
there ever a conceivable use case for something like `foo**bar`, where =
the `**`
matches across slashes? (I can't think of any reason i'd need that =
personally,
but then again i don't understand why these people are using `**` the =
way they
are in the first place.)

dana

