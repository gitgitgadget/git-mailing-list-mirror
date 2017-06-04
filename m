Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676BA20D09
	for <e@80x24.org>; Sun,  4 Jun 2017 18:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbdFDSps (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 14:45:48 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36682 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdFDSpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 14:45:47 -0400
Received: by mail-qt0-f181.google.com with SMTP id u19so3816855qta.3
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BuD0sSlAUITmTn8pCHLqBUh003G0A6YYMhs8F74hlQo=;
        b=jADFa3H/1RKp1+kR+EcuarAmyZggoqbRWY7QVPIaZykETcHCNcT4BbXzmBj0UoWvpd
         MAis+oK+hFDrRs3mRM6m5MX5jApnwhcPnA4WNnUJvvp5wTCWXVkyXdGA/t59f/c0KRQ5
         Ihxfe2DgW4DTTTlEfXjETsWuToxxsQDSVkFpKusEqmJ4YyRa47TRK2YdXn4geSdRvLKi
         qR4vJsiYrpMwo2k8WKYYTTd7nNhQRAAAizmd8jWZ696q2OOfgxJUUypfU0Tew8Y8kiB7
         suK7jfUMJ/xWv8NCSjlAP8rGAcAHDpnYLNCdtnpfpWgJGtkRhpzwD64DIff1Wk3k596n
         G2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BuD0sSlAUITmTn8pCHLqBUh003G0A6YYMhs8F74hlQo=;
        b=cuQ+/iTJl4BuE5odtI0QIknC57PvNDr0TqS6j3fvAUd5ag29PqezMfHnGWQwWe9UTP
         6CRMHKDR6vkVdLhA6FGpiinA+tvX/8gzXhuE5iX39ttZLOyijZW0yo8rO7fl+GIC6lH6
         Uza8b91Akmqrje2854x5NPtNqfcQPprVamt7NGEaniPSSezR173+/hmv3a/0WzV0267p
         rrmSqGenp9yMUiyB1sovCp6nmJyKA35Q9NJ+dAZNr9THlxC1BSjTk6EBS4EUEjinTWOM
         f30f4OsmYspBn1GIDF/8xEmSigTDErtf/o43mZnaXfBwUFKa0joPeQof8+N6PvYkSezW
         y7gQ==
X-Gm-Message-State: AODbwcBwipKYhHArjUQwgeGuLj51/xxHeVlFsVRhi6+tSymE7UeTL5Ju
        OFfeRjjoyhoWzlVzPwiJ/L7p2bTb2jk/
X-Received: by 10.200.52.113 with SMTP id v46mr9055850qtb.214.1496601946278;
 Sun, 04 Jun 2017 11:45:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.162.85 with HTTP; Sun, 4 Jun 2017 11:45:45 -0700 (PDT)
In-Reply-To: <20170604173636.GA27719@alpha.vpn.ikke.info>
References: <9AC6BDC64AEE4E76B505094B1BADE2D7@PhilipOakley> <20170604173636.GA27719@alpha.vpn.ikke.info>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 4 Jun 2017 20:45:45 +0200
Message-ID: <CAP8UFD08ckHsduwVBaGRr9WPALXjzOd-kc3zHZrHxo-HgGZ4hA@mail.gmail.com>
Subject: Re: Git Merge 2017 Videos
To:     Kevin Daudt <me@ikke.info>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git-users@googlegroups.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 4, 2017 at 7:36 PM, Kevin Daudt <me@ikke.info> wrote:
> On Sun, Jun 04, 2017 at 11:24:17AM +0100, Philip Oakley wrote:
>> While looking at the recent .gitignore issue (the need to use `**`) I came
>> up against a comment in
>> https://public-inbox.org/git/CAGZ79kZQsauBfoTjyqm+-+LjyyEc2Ykj5exUY5KdErEzFH0GMA@mail.gmail.com/
>> noting that the Git Merge 2017 videos were not available at that time.
>>
>> Well, a search found them on Youtube on the GitHub channel :
>> https://www.youtube.com/results?search_query=git+merge+2017+videos
>>
>> With a playlist : https://www.youtube.com/watch?v=tvymSWfvkjw&list=PL0lo9MOBetEGRAJzoTCdco_fOKDfhqaOY
>>
>> Enjoy the viewing. The first few have been good.
>
> Thanks for sharing this.

This was in the last edition of Git Rev News:
https://git.github.io/rev_news/2017/05/17/edition-27/
