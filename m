Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE9E1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeHUWoW convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 21 Aug 2018 18:44:22 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35322 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUWoV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:44:21 -0400
Received: by mail-qt0-f172.google.com with SMTP id r21-v6so21593027qtm.2
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tmQuStSbAaQOqmYThO7KrMz5FWyKBBLT4lernF8LL6c=;
        b=tpFkNYFBeBQwmIMPp7MUTtjZCNITq5WZ7rRp9l0ZDljkD8NTDhNOkphMSxNXtuOleZ
         vBYTCcVA2eDNYUVsyZty2uyIKauM8X4I8jQybDM416L6rxCMa0aWW9g3LNXm4Lf5al++
         0okcXdGz922PfEoHilpCTozz9o7x8VLoXhf0j13fgGd69l4RtlaocAfsh8eloNEatHH8
         mlbzyLnG8F97wWEXyrYNXcAAwnpwkR5FmZ3M19VZJxGJjUBWejKU9xRVQGekgwP0Go6m
         mr7fluMfeVxRVjHlB+oxqtiKtcsFt+sW1Lm32ZKOfo9jSiu/bSGMPqsj4jvHb0N6ChDZ
         6flw==
X-Gm-Message-State: AOUpUlGU6Qwx0P+RoUK0kxU1cLysr7FG4P8QIPPjppijFORXYUfoATDX
        k8gE40vekZmO7WrY89yxivFYWNCnYBvpuftQ3h4=
X-Google-Smtp-Source: AA+uWPxs7X9SMBl4HKy9n1wtRpMIhbIzXlzA+BoKHri1SO/lDVB/HcKncJZdewDnTY5d8gP1rg4QLyeRf6ITfyUo2xg=
X-Received: by 2002:a0c:b458:: with SMTP id e24-v6mr47176013qvf.82.1534879375983;
 Tue, 21 Aug 2018 12:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <"https://public-inbox.org/git/20180730190612.GB156463"@aiede.svl.corp.google.com>
 <20180730204646.32312-1-sunshine@sunshineco.com> <9a96cf8f5254446fa244e4107cef4f3c@BPMBX2013-01.univ-lyon1.fr>
 <1760070169.15343864.1533744622227.JavaMail.zimbra@inria.fr> <87zhxf5z38.fsf@curie.anarc.at>
In-Reply-To: <87zhxf5z38.fsf@curie.anarc.at>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Aug 2018 15:22:43 -0400
Message-ID: <CAPig+cQVhacEuMmKbB2VMkrga900a97pENRZZbDJ2KUHx3n7gA@mail.gmail.com>
Subject: Re: [PATCH] mw-to-git/t9360: fix broken &&-chain
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 2:55 PM Antoine Beaupré <anarcat@debian.org> wrote:
> On 2018-08-08 18:10:22, Matthieu Moy wrote:
> > "jrnieder" <jrnieder@gmail.com> wrote:
> >> (+cc: some folks interested in git-remote-mediawiki)
> >
> > In case it still matters, an obvious Acked-by: Matthieu Moy <git@matthieu-moy.fr>
>
> I seem to have lost context of the original email, and can't find a copy
> on public-inbox.org... Is there a patch we should merge back into
> git-mediawiki already?

The patch is here[1].

[1]: https://public-inbox.org/git/20180730204646.32312-1-sunshine@sunshineco.com/
