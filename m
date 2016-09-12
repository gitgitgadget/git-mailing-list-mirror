Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4631FCA9
	for <e@80x24.org>; Mon, 12 Sep 2016 02:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbcILCTw (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 22:19:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33388 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932258AbcILCTw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 22:19:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id b187so11593908wme.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 19:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Zyet0I9gzdmUF7cpZ90DbiUPm9sJqD0JrbeYjZMGag8=;
        b=cjQPXLzAl0yny7Bomnin6k0Avx0gWrb2MitFehGZ6XnXr10ca7bZRgcblUvR1Dh5Xk
         qIDVDB/2LC5clsvyqC/WEX/as0RDGUD9vMPMK5mXiLo4BKu/LWHNznGOSmWYh10CYwQm
         VVOCjx7JrHN3ick6SD8I5INPF3fZKGDIqSTqUdMsayVN3V0UNFAEIaCzMBnza9j9SrtJ
         cfaArGjQ10RkgCVPRJdt7HNANSTCDDQe9hJ+j0EXww8GMeUw/yBWeNHManDIT+FyacaQ
         3TFSz3h/XrOxROjukw1S2yTCY23WcXO/SOtqBoLbxbgVCHn1KGVd/sr04/KEMHO/FO+4
         OVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Zyet0I9gzdmUF7cpZ90DbiUPm9sJqD0JrbeYjZMGag8=;
        b=L7bgcx4bwmjR1oR3hcd9qnfvADj9W5eWgNKELvtMLwssNN1hRO+O3MxQwGaIKDv5Yq
         4xs0NQyfYqjOwlE4GYUPE4yXfGRwii3LFfUgI/lH2816mMXrPZwC0FyW0e+MC0hFWelQ
         ChEOnXF1e3vXZQTPhHJFX2f/UtIfKTFadJDcncdMV7QI3iPJEL4wnDsJ+Sq0nalamS7b
         BLeRYYYRIdwdn1zQ+gCRelrCqdPso4aqOfut+haa2t8Tu0llxDrXEe0whe1oEdTb4iYi
         GlDXH9K7RiKzUeR6tLm0ejyUy3wQoBWGjlr21BkriIbGCQc8V8ATtvqbrmfA542v2evO
         4yBg==
X-Gm-Message-State: AE9vXwO4AHzdASyPswkGSHueAgeLk6LkoiWfOHKWZ42mEETnAGW97P9rwG8vgu0r/5bkGGm2jz76EwvJappsHQ==
X-Received: by 10.194.184.78 with SMTP id es14mr12100361wjc.85.1473646790449;
 Sun, 11 Sep 2016 19:19:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.91.244 with HTTP; Sun, 11 Sep 2016 19:19:30 -0700 (PDT)
In-Reply-To: <xmqqeg4p6fxb.fsf@gitster.mtv.corp.google.com>
References: <CAN7QDo+S21T=1zjBEM7rq3epzvVx7GhmTZ5+sgV0BPvNYhvvUg@mail.gmail.com>
 <xmqqd1kzwegi.fsf@gitster.mtv.corp.google.com> <CAN7QDoJOzVvCzM80v=jP7RTB0od4exFLMZGkvPx9Uz6Lkm16Tg@mail.gmail.com>
 <xmqqeg4p6fxb.fsf@gitster.mtv.corp.google.com>
From:   David Glasser <glasser@davidglasser.net>
Date:   Sun, 11 Sep 2016 19:19:30 -0700
X-Google-Sender-Auth: 8iOmIamk_hapJoIZ9Ec1v7rzOx0
Message-ID: <CAN7QDo+9QN6QVqqeZh9_0h0=MtZik_HLQLnCOFabrAYFgHcANA@mail.gmail.com>
Subject: Re: [PATCH] doc: mention `git -c` in git-config(1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2016 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The patch that was commented on in that exchange should be part of
> v2.10.0 already.

My mistake: I was accidentally searching for the paragraph I added in
config.txt instead of git-config.txt. Thanks and sorry for wasting
your time!

--dave

-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
