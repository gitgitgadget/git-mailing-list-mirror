Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E4E920323
	for <e@80x24.org>; Fri, 17 Mar 2017 03:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbdCQDdf (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 23:33:35 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34473 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdCQDde (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 23:33:34 -0400
Received: by mail-pf0-f171.google.com with SMTP id p189so10288413pfp.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X2CGkQdQ0yewWuh+ur2TIq2+hK9Bwcsa01bWZoKUKj4=;
        b=l3tYsfFeeaHWbMeQYoU8ZgIMeo37EDHsBGIUDr8EiCmI092NCBaA/epQE+TbGv2JyE
         bdy7WOUwWTCXEXwHYjF1+48CvwWb43pFxpm66K+TyiSHXyXc3MtaoRg4jREuVFNuXtdn
         VK0BKzPQsEK/+d2xhz/f/BFoxTVxubSGfcKn5z9qYkjePy3UDGZieTIkI+5CpbSXSLO6
         8xbkjjS9pt2lI0ohcSwhxcQDnUQmBRG/TSf4SBDLhu4f7LJXnXIl9RNvDpntIfhfzA8a
         qEi0FpPXLpYRDsgmxM5SCBS3r6CmR1VNZe/fb0lJ9XsmLZKmvRcGASua+siiaXRWgjpK
         1VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X2CGkQdQ0yewWuh+ur2TIq2+hK9Bwcsa01bWZoKUKj4=;
        b=XwGRHlVXEyqrCbVK+HQT5buABimvINzoBJujkpUWlEZqGifyjZgwHmVUHQfbojHgtj
         0rUt57jEWqzKPKpMOuLd74JNpTSHac5WuX5xY9j89N3BBSserE23h9438AGooe3IGbcd
         YP5A7G66bfndUPYieCi3Ky1LtCbl5VAC0Ytk0E33d5bCrWiPC1+Qm9gazEvXsHFkT2dq
         6mYkDWjvkMdthopW605x5JbAd8Lkbs5ldu0qbaezY4Dd+aTQvTw2BNkE5T/lRtIHDPTK
         UOqR7Km2o1OeNmu5rIdXLI8M6jAOzDRcvmqsvDzKkMy/wxcLjdDPRd1IDcijDGMsEzZl
         0drA==
X-Gm-Message-State: AFeK/H1h1N+Wnla3E2mvpFJlblQDSTbWeX9CYnB0ouyo9AGK920xWutFEnRB/MqXhNTYYw==
X-Received: by 10.84.232.131 with SMTP id i3mr17352734plk.172.1489721526906;
        Thu, 16 Mar 2017 20:32:06 -0700 (PDT)
Received: from [10.33.249.33] ([132.188.112.190])
        by smtp.gmail.com with ESMTPSA id 128sm13110308pfe.23.2017.03.16.20.32.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 20:32:06 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: USE_SHA1DC is broken in pu
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com>
Date:   Fri, 17 Mar 2017 11:32:03 +0800
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com> <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Mar 2017, at 11:18, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
>=20
>> On 17 Mar 2017, at 03:22, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>>=20
>> I think there's a semantic merge error and it clashes with
>> f18f816cb158 ("hash.h: move SHA-1 implementation selection into a
>> header file").
>>=20
>> Suggested possible merge resolution attached.
>>=20
>>                  Linus
>> <patch.diff>
>=20
> Would it make sense/have value to add a job to our TravisCI build [1]=20=

> that compiles Git in a few variations with some high profile switches=20=

> such as USE_SHA1DC? Running all the tests for these variations would=20=

> probably take to long but just compiling would be less than 2min per=20=

> variation.

... or just run individual tests instead of the entire test suite for=20
these variations (e.g. only t0013 for the USE_SHA1DC variation).

- Lars

