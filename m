Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D454D1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbeGQSVQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:21:16 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:34791 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQSVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:21:16 -0400
Received: by mail-yb0-f176.google.com with SMTP id e9-v6so758466ybq.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUxYpikzmgmm4mheJjjmF1kQJVB+jIWz85kWKlAsPEo=;
        b=Z//1uHEs+2knpKYyxIfzPh+w8HSDsWRqZr93t9QvaeFWW0CQ1AYeL0sb95TdHV4U5w
         oC1ujLffbXtt5/OUyshJA6xq5u76OXiylrGeXFJl0SaIjWcsNuJHVmKQLx0oB/nOJXcc
         gR0Hj0EE6MjDjwt/UKePpy4EB201lFviFiXpzzt09vszOQO2FRkWxgx9tIdOtZzp/1la
         DVov1h1fEx1w+AmYAw9yVzwO5IKa+D2NaZxxpObna77kqk3Uc76WsJNSKgZ+mszvPYpt
         EyptQV87fNdSUnJuRvUZfQqA5dZ4X+WJ+9Ta4WzAyIMUoG2Qg/+ZPaacmEzgPR3T+6an
         hAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUxYpikzmgmm4mheJjjmF1kQJVB+jIWz85kWKlAsPEo=;
        b=eMQF1y+KO8c20ruVka+pR6sa1mAXzH2bmVckJ6kE/ZGe/dMAxzbdKsMQKv5oy/OyZp
         uzy7+frLAr0XRAuXZm3wmq9NePjEViWR08Q93E/fhpDsZlN7lY4MIN1ifJ99u+bBWRoo
         Ez1RZaADuc/ahwCPnKBt1BN+c/Pt1zncPBQPt6Pv8y58+KCCWQ7G8hq16df8XDqCUihy
         poHjtKUaTOYg9ZGPDHr2/pPM4CfgZD4VF3+8ToLi7MyzpKE5csqAHbC+RgZKzqBk4vVf
         KbCoTkQUsuskJN439/acWoxmyPDYuSTRgRGPAZJ4P/tERIq+dpPHqJ6KFFC98Dj2m+hG
         7wkw==
X-Gm-Message-State: AOUpUlFH3HdCWex18MtTQ0dka6FPQ4Bv8pjb4BoZ5U9VgyzsPTtW62NI
        FgkY1oAtF1KoAHow5xtzQ7rskDiEkEBBtjr5/ZD4LA==
X-Google-Smtp-Source: AAOMgpc5vsDpfIQJ7E5SSG7NGIULS5RO4KKxY5NwuyUFGJP7Mbb4JPbyeODp159x3gjNajsxtbHyu/WGHZ6qHOTpdRU=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr1446964ybp.352.1531849652377;
 Tue, 17 Jul 2018 10:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <6b31cbf72c4752771965de333b3cb6e82cf90b2b.1530617166.git.gitgitgadget@gmail.com>
 <CAPig+cTnRi=HuyZy+bMKeU9qutZb3K5C4qTb7gCQz7GyGN=FRw@mail.gmail.com> <nycvar.QRO.7.76.6.1807171306380.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807171306380.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Jul 2018 10:47:21 -0700
Message-ID: <CAGZ79kaft-8pHGwyqAK0yNL3p5sP0VyKNn29dxoZ0wFGWGEHPA@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] range-diff: adjust the output of the commit pairs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

> > It's nice to see that the bulk of the range-diff functionality has
> > been libified in this re-roll (residing in range-diff.c rather than
>
> Can we *please* stop calling it "re-roll"? Thanks.

Fun fact of the day:

First appearance of "reroll" in the public archive is (09 Dec 2007)
https://public-inbox.org/git/7vy7c3ogu2.fsf@gitster.siamese.dyndns.org/
which is predated by "re-roll" (05 May 2006)
https://public-inbox.org/git/7vr738w8t4.fsf@assigned-by-dhcp.cox.net/

Stefan
