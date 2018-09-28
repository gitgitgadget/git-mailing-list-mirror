Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08631F453
	for <e@80x24.org>; Fri, 28 Sep 2018 21:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeI2Dq2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 23:46:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40138 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeI2Dq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 23:46:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id n31-v6so5307310pgm.7
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EDhskakqtTiFEdTi3m6aUgoU6IK++gPy5R6w75WeR4w=;
        b=SyBOKYm0gAS3eTtOu/5iIzwLcjxdzihyvNXtachWv2B5z/0tzkDjmU9DXI13a9RYom
         MLpNCTiap2Vb8O6xB6C872wqDgFtGnLkS7vAn7qtrTGsKn6ST8+fbC1gZDwtBpavaD2Y
         3+rFqC/PjETqyGKmC6FYIivTkEuCl5CncU1gSBJ5OleiBf1rcyk5c8Oc0at114W5yPHF
         79hw2t2P4kyeZOA1AnolrY2uhS4r6bRA/13ULBixQAytJmk1tZgZXsSu9I/Rhijwos3C
         tV1lVVUONmE7JM+m52SFzjRpBQYtB2MF0OVNI37PK502J4du1a9tjouc0EimDEcBmV2j
         Pgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EDhskakqtTiFEdTi3m6aUgoU6IK++gPy5R6w75WeR4w=;
        b=mw4/xPXomxYo2vRGDe0qX66Yy3Llvq7pLqIl+bGVUrEihypyV7xryQ6VrixoKkfPzj
         h5X+H2ez8J4YjvGt4B75oaLGSxvJS5W6ivn2uwCuYNNCgAVNfOtQ5wtkBmVu9FcKykPk
         DtS2y3TEjpd/iWop9yvjHwuJABKLeJrRw3SqLiaWiXkQ3JQyykknuTuNpRLKezYxXCVQ
         dJ/p9VL6yY1bGFYqeMOa6uhY/0ZXqGnHCDjUGk0jmMwWtilOu8r0EpQoM7xroQkjczLX
         ECPKwkqEEIyt7tAn0qBVCW27MvFW6QsyOruDj4myPERgAsIaaLnybUVGjCQsUPuPzmMn
         J9kg==
X-Gm-Message-State: ABuFfogD/LV72bT80bbilapuTXJkN+ROxwR8B3dUoqNNnYnYxsICqKsr
        CHcrUavDsGGcEmL5fD2OBqo=
X-Google-Smtp-Source: ACcGV61ZeVSisUAgZn+IAUCgJGMWoDMMcmrmbX1+NCdDwlqRG7H42Rg6eoUGlAwcYxQf6y3nE04OLQ==
X-Received: by 2002:a63:2f81:: with SMTP id v123-v6mr340115pgv.223.1538169652744;
        Fri, 28 Sep 2018 14:20:52 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v2-v6sm8614743pgf.58.2018.09.28.14.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 14:20:51 -0700 (PDT)
Date:   Fri, 28 Sep 2018 14:20:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] git doc: direct bug reporters to mailing list archive (Re:
 [PATCH v2] git.txt: mention mailing list archive)
Message-ID: <20180928212049.GD193055@aiede.svl.corp.google.com>
References: <20180926134717.GC25697@syl>
 <20180927055018.6683-1-martin.agren@gmail.com>
 <20180927063735.GC220288@aiede.svl.corp.google.com>
 <CAN0heSpG2jewXuzcZQAeFydW4zanzymSGVqVz2u0myW3Z7Wcrw@mail.gmail.com>
 <xmqq1s9def2p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1s9def2p.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: git doc: direct bug reporters to mailing list archive

The mailing list archive can help a user encountering a bug to tell
whether a recent regression has already been reported and whether a
longstanding bug has already had some discussion to start their
thinking.

Based-on-patch-by: Martin Ågren <martin.agren@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:
>> Jonathan Nieder wrote:

>>> Hm.  I think this encourages a behavior that I want to discourage:
>>> assuming that if a bug has already been reported then there's nothing
>>> more for the new user to add.
[...]
> Yup, in short I think any one of the above three is good enough.
> Let's just pick one and move on.  Unless somebody sends in an
> improvement that can be applied readily, by default I'll just "git
> am" the one Martin sent, as that is the easiest thing to do ;-).

I assume this is meant as a nudge, in which case nudge successful. ;-)

My experience is that bug reporters are very sensitive to hints the
project gives about what kind of bugs they want to receive.  I'd
rather make use of that lesson now instead of waiting to relearn it in
the wild.  Here goes.

Thanks, both.

 Documentation/git.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 74a9d7edb4..8e6a92e8ba 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -858,7 +858,9 @@ Reporting Bugs
 
 Report bugs to the Git mailing list <git@vger.kernel.org> where the
 development and maintenance is primarily done.  You do not have to be
-subscribed to the list to send a message there.
+subscribed to the list to send a message there.  See the list archive
+at https://public-inbox.org/git for previous bug reports and other
+discussions.
 
 Issues which are security relevant should be disclosed privately to
 the Git Security mailing list <git-security@googlegroups.com>.
-- 
2.19.0.605.g01d371f741

