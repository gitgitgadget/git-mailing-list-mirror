Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9F6D1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbdCMSZC (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:25:02 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34992 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdCMSZA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:25:00 -0400
Received: by mail-pg0-f43.google.com with SMTP id b129so66955328pgc.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kKfkqYEs4QvOSLRR3SjQ/Uh/VxIr2eQPEmg/U+WlP8s=;
        b=KpFp81LtKiSTG7dfjnyC6FJE8purbyJ2sNo/pxUaeZvNkKPJXqBekpB69MGCukhjcO
         9kcgOYMPwllzQPLgH7NvrnLofnCVTNGTJjPVA2PL26/bff5m/+sH1Q20/BHDwXxRQPHI
         qsvgq7nothoyGG/stEgLqUEtnspm2Wo/Dv6O2ZETUE0yoFwtK2uZhSjaki+guKnwSXGL
         j3C/aW/F/Gjvcohc+iw2g9x6ElDgLoqJg3to6+0XavdwWayHkO6MUrVLhSemXsCmVn7s
         sysSsiP8d74zwmvAJc2374gU62ERx/AyCupKyoPGI3IAT1cfA9OvADp+a8qSIkrMQyf2
         nCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kKfkqYEs4QvOSLRR3SjQ/Uh/VxIr2eQPEmg/U+WlP8s=;
        b=kjz0N4I09MZwLa5VfQ4cyoZFTwR8C+QmaqycFr2hb1Jq65Bn4NQRP+ZiPkEqJ2LJFM
         9ywMIEItJvVusHy4vWQkZUnOHkM8pxeHRemVImrxkC2bVQVAq9oDvpWRW6bwY7An0p0i
         +2T3hXSFzZr9vCLkf8KcJ4al7msW/N1uR7DWaK8Rqk1xMBeJx2NTXrTja2bqToIqwTDx
         edDpexQk/M6y4q/U2y20sA/wDLkbkh7/pxszpX9XwKNowezPbQbuBEHPoG34ShSidX4r
         LH++ExqRQWk4tCXSjKGpCrGZ/sgAdn5Pma/6Bh0W/p9K0RUTeT7mWLgzLZxBfzxVNOLo
         Q0CA==
X-Gm-Message-State: AMke39mKyEVdK6Vevl+BR80hJLCvNTGB+HctUGa9roySxBcEWljy2jHE4/UUq3cIExIIOk2BCOc8xpGHMeS+6UlB
X-Received: by 10.99.98.6 with SMTP id w6mr38361093pgb.223.1489429499254; Mon,
 13 Mar 2017 11:24:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 11:24:58 -0700 (PDT)
In-Reply-To: <20170310211348.18887-1-me@vtolstov.org>
References: <20170310193040.16816-1-me@vtolstov.org> <20170310211348.18887-1-me@vtolstov.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 11:24:58 -0700
Message-ID: <CAGZ79kbLr=aSu-g83obmj3XCMMYbuody6Q_FreCmQcqpyX+_rQ@mail.gmail.com>
Subject: Re: [GSoC] Discussion of "Submodule related work" project
To:     Valery Tolstov <me@vtolstov.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So... I thought those items listed in "Submodule related work" are
> considered too small to be complete projects separately, and they
> are just "subprojects" of bigger project (maybe I have this thought
> because I can't estimate complexity before truly digging in).

When writing these points, I was not sure about the complexity
myself, but rather I wanted to produce a lot of different potential
projects, which can be discussed if they sound exciting and are
of good size.

> In your response you talk about them as independent projects...
> This means I can take only any one of them as starting point for
> my proposal? Or maybe I misunderstood you?

Well I think some of them are too small to stand alone for a full GSoC
project. Others have a good size and complexity for GSoC already.

> If it is true, than i'll try to take sh->C transition for submodule
> command,

For shell -> C transitions, see
65e1449614d
b7d2a15b9f5
307de75c4
dec034a34e
as all of them are rewrites from sh -> C for different commands.
You might find common patterns (e.g. what is all needed for a conversion,
such as slight updates to tests or documentation; certainly updating
the build process in the Makefile, and of course the code translated).

Most of these conversions, start out with a patch that is quite a literal
translation and then afterwards add in optimizations.

Another approach for the conversion is outlined in73c2779f42
(builtin-am: implement skeletal builtin am).  I am not sure how
easy this approach is for a submodule specific command.

> and as addirional part of my whole project also this:
> https://public-inbox.org/git/1488913150.8812.0@smtp.yandex.ru/T/

Yeah, that is also a good task :) Thanks for bringing it up.

> Does it sound good? If does, then I'll begin to work on my proposal.

Sure.

Thanks,
Stefan
