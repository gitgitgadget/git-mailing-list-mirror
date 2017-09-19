Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27F72047F
	for <e@80x24.org>; Tue, 19 Sep 2017 00:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750882AbdISAIQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 20:08:16 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:48884 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdISAIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 20:08:15 -0400
Received: by mail-wm0-f52.google.com with SMTP id r68so912158wmg.3
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 17:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PLF+Tj2oMAs0bPaSATQTPULWJcrnQFipyVSW4jd6flU=;
        b=IMhbQqyD9E6E03m9Nf2Wv33k4bTdsCEaI0VAjnT1TWacysEGdYRSAZsXVjQqhbcgRR
         gpdKbECjunyGqU+xQFj+l/p69fB6z+N9w5b4CZTj7jNROg6DVP2oMit6WjUmL7U8Ju9+
         ee6qoOSa0ho1mPffRaV8RCMqMFpIOoDpeVaSFFbls3+6O2x0Eb9f6AQbYEVj44MN7QYx
         4JoHPbiPFi/9bkTF9BCfBUKDTb9eIG6Ahnd/GJDb/WY7jmjbfb0QA4vYQr7NrKDZVP3A
         inGZmUHPXxmG4FP1mzHkSEvJ5TRPLPVUYniJb8Iy7k+BeN/Q4+ysDQw0geuZuUMf1p3z
         lADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PLF+Tj2oMAs0bPaSATQTPULWJcrnQFipyVSW4jd6flU=;
        b=nNpi3o5/X7NaiOHpFf9W5dvXC4M+xdQX6+k+xFFbKY3JP9ZjRwxvzIJjLiET+tEgUR
         yagCXh6UIPvABXPVFsOwHyq/t5qnKPSapkYK5cQoffMUVbbz87Xi/EtKlRFwA/fmS33s
         YTdsCnX5Sxq3526YOPAv6XG9hVgPi3OkevmkFzfWOLitc5JbC6/EUA6anHvZLPShMoej
         e94IuyusUkM9E31yK9I+pZcqIhdhpum5DvfK4/swri8H+CXASu7VDaXHf34jLJsMLXgz
         dJDgOsp0lostkdmLKHscGBd/BFoWdpXrwv/0L5aeV9CcTpm1igwGZlMuYzytVq+KXCZF
         iZVw==
X-Gm-Message-State: AHPjjUgW6YU2aQVz2Ri6VuWzrgJH0iuQuCJqnTYUHFS9VzJNb4nTbs3K
        w9HxhejR5aXmO3xBd0+5u8sZibhoWDj3AnbQFIxpIA==
X-Google-Smtp-Source: AOwi7QDreJoQdxOyfNyPbcTwFjbKnRRT42TDDph54hefddbZgZqzY/9D2E+BhyCeNeAOz4yjwwVadz5VVoICYf30ouY=
X-Received: by 10.28.73.133 with SMTP id w127mr9082789wma.55.1505779694547;
 Mon, 18 Sep 2017 17:08:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Mon, 18 Sep 2017 17:08:13 -0700 (PDT)
In-Reply-To: <xmqqfubku9iy.fsf@gitster.mtv.corp.google.com>
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <xmqqefr6uolr.fsf@gitster.mtv.corp.google.com> <5c86b55e-20f6-df8e-b01f-66876c3a5f46@alum.mit.edu>
 <xmqqfubku9iy.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Sep 2017 17:08:13 -0700
Message-ID: <CAGZ79kYXDhcVXd2C-x6e=o7jYdKqV22DY45c7E2TeuhKLfn26w@mail.gmail.com>
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty list
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I am hoping that this last one is not allowed and we can use the
> "same condition is checked every time we loop" version that hides
> the uglyness inside the macro.

By which you are referring to Jonathans solution posted.
Maybe we can combine the two solutions (checking for thelist
to not be NULL once, by Jonathan) and using an outer structure
(SZEDERs solution) by replacing the condition by a for loop,
roughly (untested):

#define for_each_string_list_item(item,list) \
-       for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
+    for (; list; list = NULL)
+        for (item = (list)->items; item < (list)->items + (list)->nr; ++item)

as that would not mingle with any dangling else clause.
It is also just one statement, such that

    if (bla)
      for_each_string_list_item {
        baz(item);
      }
    else
      foo;

still works.

Are there downsides to this combined approach?
