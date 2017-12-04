Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1441320954
	for <e@80x24.org>; Mon,  4 Dec 2017 19:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbdLDTIh (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 14:08:37 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:43146 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdLDTIg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 14:08:36 -0500
Received: by mail-qt0-f170.google.com with SMTP id w10so23513021qtb.10
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fTIfxFb6SJan57EC/qXmmpMhF8VVLX/KKoqsfO55+64=;
        b=ddXV7q9eiF0plIqQZBhuuT5fBYzInlxQzO8e7D/WWpYCKK2BkBfsv8BzN8yx+EGQEg
         eUNKaHvS+0+mQJJ/1ZpvvN2dDRb7TwXvaKwZCueRdLSTeGt4jg+XD1uKZrcwnpV+Z0t9
         dsAIazs/HzCy+WBNU7Q31Lwd9EP0jJCMA43a31ouedE+LdhY1BZ0i1kRO+g+omePuhrr
         vVBOBMVMJj39/iItIBfE4ZqKumqsJmi45qBI16xXIsoOCvVVkE1kZ3NXJcl1v0rDRgMD
         si4BAqc/lU8wub/WLw4OuWuIcmshu/h40Wn5ak9apsEFlIg3xBNwkyQH6COez4lV9Sje
         TFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fTIfxFb6SJan57EC/qXmmpMhF8VVLX/KKoqsfO55+64=;
        b=tIEE66hisXYL1aNRUVKLA2TpTfX5pE35z44bdiSPmzJ3ZF+sNinwxvaWhq3W7UhoLq
         igLXakOya4E2MqGe4xi0jnHFUM3JW2X4Q8sCGGerEws+hcjZo8O92pjjHkkaOvT641j+
         WcwO/UbnrAY7cp9WzxTyHbzOrNlSBGfRyPT4L3Y4RxW0ACLfXvBeqD4c+Yc+HGBKxzLq
         1Et/cJ0f+Ur+MFCMaE+eO+ROOmui0R82sWuCjLSxMRbmyxi/1Bs91VWoz/lU1SZ1C8Xa
         nsJY4X80b/PCx44GvSZ8WI+pEoBd4NV92dbNlbBmEtiVFw8dAfhp47Q6wHUyjFt1e6wf
         V4pg==
X-Gm-Message-State: AKGB3mJ81g3ynNhft0lP07XgDCVPNMoboSNLmHITQaPV2jH69DrhQYS6
        7z6qmzwdRy+bYzx8vhokUcLC/UYAT3VsG/lAwEj+sA==
X-Google-Smtp-Source: AGs4zMZ3Ygf9zhuvZ/7iA1mnVby5MPxUWDydzAtva7XZo1XxfvMzPrr/XbWvQ49QxDio3O7a+KDmsf9iSnGbpAi92B0=
X-Received: by 10.55.203.156 with SMTP id u28mr21121901qkl.353.1512414515750;
 Mon, 04 Dec 2017 11:08:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 4 Dec 2017 11:08:35 -0800 (PST)
In-Reply-To: <xmqqindojrw1.fsf@gitster.mtv.corp.google.com>
References: <466dd5331907754ca5c25cc83173ca895220ca81.1511999045.git.johannes.schindelin@gmx.de>
 <20171130030727.GA24732@sigill.intra.peff.net> <xmqqindojrw1.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 4 Dec 2017 11:08:35 -0800
Message-ID: <CAGZ79kbDevUjjAzvfa-Un6=fnFZu+kLx7bF3vuheXZdxJWvaRw@mail.gmail.com>
Subject: Re: [PATCH] hashmap: adjust documentation to reflect reality
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 2, 2017 at 9:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> My second suggestion (which I'm on the fence about) is: would it better
>> to just say "see t/helper/test-hashmap.c for a representative example?"

I think that may be better in the long run, indeed.

>
> I also had the same thought.  It is rather unwieldy to ask people to
> lift code from comment text, and it is also hard to maintain such a
> commented out code to make sure it is up to date.
>
>> I'm all for code examples in documentation, but this one is quite
>> complex. The code in test-hashmap.c is not much more complex, and is at
>> least guaranteed to compile and run.
>
> Yup.  Exactly.
>
>> It doesn't show off how to combine a flex-array with a hashmap as
>> well, but I'm not sure how important that is. So I could go either
>> way.

We could add that example to the test helper as then we have a good (tested)
example for that case, too.

> In any case, keeping a bad example as-is is less good than replacing
> it with a corrected one, so I do not mind taking this patch as an
> immediate first step, whether we later decide to remove it and refer
> to an external file that has a real example that will be easier to
> maintain and use.
>
> Thanks.

Thanks for taking this and building on top,
Stefan
