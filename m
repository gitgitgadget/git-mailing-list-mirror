Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB5320954
	for <e@80x24.org>; Mon,  4 Dec 2017 22:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbdLDW1H (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 17:27:07 -0500
Received: from mail-ua0-f170.google.com ([209.85.217.170]:40817 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdLDW0x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 17:26:53 -0500
Received: by mail-ua0-f170.google.com with SMTP id i92so13757216uad.7
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 14:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OpIGw8l/sfEAz67WTjWzVTPO0SFroL1XO+E1OQKqEbw=;
        b=ZxdmZ1IYo5OmdZf5VJUAegoLODr7yTdazs51PO7Kg05jiLiWaBIWVkwRkC9ZT+LYok
         EEF8dO0SMg3PgwjtswrwCxO2NlJoMfKjM1trIqiQXLrf4xlwtnxuQMhfEaPyQ0eQkDKF
         PqRy+ADSb8W4Ak6N83ilSZqG2CnzlwRdx3mHxhhRUJxEBCMX3LwDzsWMXDJ+wpMbdc/j
         6qBVJ6MVqtpjyL4TRLSoaSGYDRCrHqg6YQopssnslABnzTijZLT02tV6AJq9sYdZrFSB
         0nJ2zBpy6UuPzAiaUSTaF7x0ByoR5+rtRJYY2G2/4SoiIP13AdIUyWx/RVLIQMb0OP0s
         ciWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OpIGw8l/sfEAz67WTjWzVTPO0SFroL1XO+E1OQKqEbw=;
        b=OAIHHhiuO+K4TvhAKu5UdtLTjJ3Vx9/1wks0JyxhmWi5aAevAulwHYJ8a78LZ9TmYh
         Wb5iECRP3kfDPufp9SkB/RfVLlL/2w2qKLMnYkzpzpE6EGSfokhw/Og0xkDe9JzRs6M1
         /DHFn46Lxu4L5AESbirSK713GKZVe/7tQL30GMmnDt3plDQRyRKY+jty/f1+hHjWGFab
         kIptXwbhdnxgBWjy2NPJBv9wgls2Z3sms8QlpIH+MHPMgO6/9+1WrEt+yelKM1Zgofkg
         65HXnouJpuk7XH1Euo09Heb47IfcW3mecuPod+5LkilIlhqddmaQy9TOHaf+F/0i0usm
         AaUg==
X-Gm-Message-State: AKGB3mKRhgzmfZdKme8px8NHTvogs0NOEcV3Z7+QXSyqNkRu4r1QItyR
        Y+9j0MHzkJ4dfEVAEhXKOY0u1khpUl5l30Bbq10=
X-Google-Smtp-Source: AGs4zMZvY7G2bPy6SOvBKFzIT+deKDHFRBcvLCsdX1uiWJoqTtXlxcNXwJmFFTRiCf/+KC9J8jEmev8UQMIeW7ZW9+Q=
X-Received: by 10.176.65.135 with SMTP id 7mr1168098uap.127.1512426412420;
 Mon, 04 Dec 2017 14:26:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Mon, 4 Dec 2017 14:26:51 -0800 (PST)
In-Reply-To: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Dec 2017 14:26:51 -0800
Message-ID: <CABPp-BEoiCrMwKf9u7pdaOkYzE5Q6daJs7N2U05pGjERHzu2Gg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 4, 2017 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * en/rename-directory-detection (2017-11-21) 33 commits
<snip>
>  Rename detection logic in "diff" family that is used in "merge" has
>  learned to guess when all of x/a, x/b and x/c have moved to z/a,
>  z/b and z/c, it is likely that x/d added in the meantime would also
>  want to move to z/d by taking the hint that the entire directory
>  'x' moved to 'z'.

It appears that you're still using V3 of my directory rename detection
series; I got some feedback from Stefan and Johannes on that series
(including compilation failures on Windows) and believe I have
addressed all of it in V4, which can be found here:
   https://public-inbox.org/git/20171129014237.32570-1-newren@gmail.com/
