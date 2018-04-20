Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC02C1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 20:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeDTUok (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 16:44:40 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:46492 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeDTUok (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 16:44:40 -0400
Received: by mail-yb0-f179.google.com with SMTP id z16-v6so3463205ybk.13
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nEKeDQDiKLk93reRYowaFBVKf50rIu1WFR4oJ6pcXg8=;
        b=GKClVTtbItqnuSgmjIm/umtxSPkaBe10gwBLTBCjagvUmaFOqG8JiyDwpwWbOfriAj
         iC1WvZPfD85KPRQPYbAUsxOe3Z223L3kLZlY5uJaf1tMxhAtr81E8HqIJm3nRC+991Dj
         ElgO44GsdrVd2tEBH0yp+PPYkIA8y28CVeS9xw53nNUcqOAsc3xjVYHpDLA7fPvuKF3t
         BaGolWPtkKC3BowDKsrt5y8GvQegFdWSJmHKdOlVquHnSjGKo6Uu16WguR9npVyorIEW
         dzsHcEk3erZanogw+OnYNo+BVsLc2ycK85BijpgmrnrUM2jRTYnW0kVbaCxSxTV6ae9W
         EgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nEKeDQDiKLk93reRYowaFBVKf50rIu1WFR4oJ6pcXg8=;
        b=JHJTBYJkUp5xVme9nLfgNXRWWeBFDTvLpCoo4CtCGxlF6/MlqwG/gNmLBWkAb9z9Du
         kgSMJn6cTW1bbc/V5fhU0/1r5nX9x2yboN4Ytxor67EUdaNJV1HUleKEw6rnoUNPaI13
         VYebol+gM0o2cBY0kZWAgh62wsNiK8gGJX0IWnBpb9DI93083s3B0VoJV0TSJO+MTWrF
         BB0Q6efhhgu/+A7N7ZZFI6AAQefkjLNNS3G4XD1LRtc+S//YgjtZZJev9aa/0bY7vebB
         JbGj9GaMuOoMZh+wS8WbE0GVShvwDrfL6w4Dt255q90Oc6ngIbnxTp3W3CEP+0vBbUay
         D2JQ==
X-Gm-Message-State: ALQs6tBuoO8EtVhQFPzqLos607hMJiCQhh3LRz8q6O2/PGMG3VPmqYPb
        SOsynfF2efRCabj8vUT86Yzu1zyGU4wRKq9I79+Dmw==
X-Google-Smtp-Source: AIpwx4/QZs/QuWw+y/IsOTSFIVVFoEBw4VVn5hP3Blv5ikLp3a5v2l7hsvATwQyFWsly7kR1jNem9lT1ZhRvJqjJ4mY=
X-Received: by 2002:a25:8e09:: with SMTP id p9-v6mr7226529ybl.352.1524257078907;
 Fri, 20 Apr 2018 13:44:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Fri, 20 Apr 2018 13:44:38
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804202149260.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524226637.git.johannes.schindelin@gmx.de>
 <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de>
 <CAGZ79kZONQ_xuDYJ5Z8cUnF0odwz3+Sh+ST6g+5Tefav-QXEBw@mail.gmail.com> <nycvar.QRO.7.76.6.1804202149260.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Apr 2018 13:44:38 -0700
Message-ID: <CAGZ79kbQCQPx01uFacxMWLdfJurn4jVcc+nvdnWHNVJNE3resw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: demonstrate bug with fixup!/squash! commit messages
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

> Funny thing is: I tested this with GETTEXT_POISON=1, and it succeeded.

I actually wanted to review the code leading to this commit, and to find
where to start reviewing I had 'git grep "This is a combination of"' which
lead me to the translation files.

s/grep/test_i18ngrep/ doesn't work as the syntax is slightly off,
s/ ! grep/ test_i18n_grep !/ would work, just pointing out the obvious.
