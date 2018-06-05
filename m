Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EBAF1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 01:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeFEB14 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 21:27:56 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:44990 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeFEB1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 21:27:55 -0400
Received: by mail-qt0-f176.google.com with SMTP id l33-v6so741001qta.11
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 18:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=57nncZSh/yC5uITi8j/q5XxQSaMlKm3quU4D7IApHjc=;
        b=Ydzc1tqPIiYOSkR1v3kzzC36vvO13fwWmX1vqlslHl0u19fWe4vDsbJ35ENqc/6OUu
         eSxrvlTFV3iDg+bJunLEfZVfPVq9PokZwAL5Dibzc9z3jnaAjshLTf7ljqU2vMxicbuB
         O7Jh492luMI2BMtAYNRd2bqeU3BQPUYCAfUA6rvAyBpBbRC4IzlrxscbqEUenv+KcOB2
         8AMndZquM3gdZBaMuCZIxL8yBZDFDalhFs4+AHaj2SlCQS2oqlV3lu62Vjtm7SK+Wyqx
         cBLwtt6DeWhRPk7wyaNncjhJGEDo23bmtzSTtMJgS6IxzBLP8MOek5nDsgJfLoMPr+df
         Tl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=57nncZSh/yC5uITi8j/q5XxQSaMlKm3quU4D7IApHjc=;
        b=CyHUdar1+EN1uMKKvihHVyEjbo6ZYaGwTdxV53s6SXDqSCw5y8E3g7CjRDbl1c5QQ4
         xkkZaokIpOfurhZ7AmWhsLX6gZWUWi0BPImOJ5AHCRWnfnYKsmuEqNSrVnuDghwA6gcL
         Rp+gzDg3/U49Ydv+huhrSDY61fg2PiqwpNTBgiULsx3aGBN+p1QFLpBzRyWJZ9oobsbn
         BvVbVjrcAgzXPvdlG8jf609EL8UIQqBvtlgpQEMI+0eiQgVOHbXZJUVsgzaxjyILlEyW
         RFi3Epd2uMgU/4jH0qmeeteeeO3ZFFuf4olWpqLPJpl5rFBNdH1wlohqpTi3+2lIgzRR
         OHgw==
X-Gm-Message-State: APt69E08x2eYbnj9RJS/IuZeVAtNJfRawCmM+Nw4NzsPMl4uB83C68eo
        CyypZjh5R0DVXkHSneQSvdE=
X-Google-Smtp-Source: ADUXVKKurs1aZ65LrAMZhBUCDXSXxSCG1RMRq2bWgyKzsbLT8LyTLvPmR9M3aBQ370pGCqn/9fBc3g==
X-Received: by 2002:aed:22cc:: with SMTP id q12-v6mr17358821qtc.226.1528162074491;
        Mon, 04 Jun 2018 18:27:54 -0700 (PDT)
Received: from [10.212.147.17] (50-206-9-2-static.hfc.comcastbusiness.net. [50.206.9.2])
        by smtp.gmail.com with ESMTPSA id l73-v6sm20376431qkl.78.2018.06.04.18.27.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Jun 2018 18:27:53 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [ANNOUNCE] Git v2.18.0-rc1
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqwove4pzo.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 4 Jun 2018 18:27:52 -0700
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <781A6400-477F-4A7B-8C17-65BFD280B331@gmail.com>
References: <xmqqwove4pzo.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Jun 2018, at 06:53, Junio C Hamano <gitster@pobox.com> wrote:
> 
> A release candidate Git v2.18.0-rc1 is now available for testing
> at the usual places.  It is comprised of 842 non-merge commits
> since v2.17.0, contributed by 65 people, 20 of which are new faces.
> 
> ...
> 
> * The new "checkout-encoding" attribute can ask Git to convert the
>   contents to the specified encoding when checking out to the working
>   tree (and the other way around when checking in).

Did you call the feature "checkout-encoding" here intentionally?
The attribute is called "working-tree-encoding" in the final and
merged round. Shouldn't we call it that way here too?

Thanks,
Lars
