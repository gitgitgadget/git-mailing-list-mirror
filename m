Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4B21FADF
	for <e@80x24.org>; Tue,  1 May 2018 20:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbeEAUeh (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 16:34:37 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:42350 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeEAUeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 16:34:36 -0400
Received: by mail-lf0-f42.google.com with SMTP id u21-v6so17776531lfu.9
        for <git@vger.kernel.org>; Tue, 01 May 2018 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HEnweCvXN3cgjJt/9QhAVSjToxkNhlWpHFyaG7VC4zs=;
        b=PUYJOKDFGVkex+xVmnT13gG+l+fdvie/zIa5DUlZoi+cQquelYgHklf7U0qJWbZoet
         NpiP+RVOdCnoVS/WBwsZAS59VzUomn7eZ75o8I9xiN6xf7lpedILbmPJ/kQyPET9ZC+j
         oD5HvcLnR2vWjLl4rAsGSNXVdBOoQAHjovtNYlNYGdg89QiP/qyjIoRmmM/Oe8VyrPyj
         N0dmXZHmvEEBnFXrkXGlAghHsw1Ts5J5gD28KrJH+aMKhZRzuifZI9FIS5yGuJ+A3DIr
         difsoBgNlQnvK5o5KcmpZDvDiG86TX8TcoZCWAITOa0jPmnkbPQGY4Bytl0vDUvqyYQM
         9SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HEnweCvXN3cgjJt/9QhAVSjToxkNhlWpHFyaG7VC4zs=;
        b=rZnw7pWD9NM8kENoo345gGxx8UdfJphzU1HA8Ib30raH25eSXxhm7fQMOVIaQey68R
         QPRjulC2jM93Bm+vARq57uqjs+rK+2z9sjsT3Ek508TdwUQ+4WW+3J6XxVoBfwdayuNI
         HHbtRYy4820oQ0wox4kaMLSo8FLUzQIx2WmyE/HsRfg8miMPZN17Ntwhp+uVhuUjcgTu
         rQKm4FrjWXzHyGeVVLyqxw4Q/ArzoTsA/QNf54V9d6RdV4ZiUTjBL7XVKcACNshmb7RT
         KJUR+lsa46nF4/akg0VcDeP/G5YorYLc8R4PBxyUcxe+fkmVaz9W5OMQf6sC4fW0l0qm
         HlgQ==
X-Gm-Message-State: ALQs6tD8Oon6nbC82+ivzn+/dQlywkDRATyzTUVida85Bk8PJNKBJG5q
        mI6OAf4gKYTpokzyC9mf8KumQ9Kyy6Poz+jlEUttQw==
X-Google-Smtp-Source: AB8JxZpPt62vYmRvmeNqZGziKKS2dERJeFYzPQczCewQWzJ9l11AaCcH3SXQ7EZwUanFBTF5k/A3ZkqL7/TGHOvY6M0=
X-Received: by 2002:a19:4f5e:: with SMTP id a30-v6mr9946350lfk.97.1525206874606;
 Tue, 01 May 2018 13:34:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9ecc:0:0:0:0:0 with HTTP; Tue, 1 May 2018 13:34:13 -0700 (PDT)
In-Reply-To: <CA+P7+xry-dE0-TMtRzNjiJpR1ZVmGXDy5ObfMxKyWA+eR8XMsQ@mail.gmail.com>
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com> <20180501165931.25515-1-wink@saville.com>
 <87zi1jxjqn.fsf@evledraar.gmail.com> <CA+P7+xry-dE0-TMtRzNjiJpR1ZVmGXDy5ObfMxKyWA+eR8XMsQ@mail.gmail.com>
From:   Wink Saville <wink@saville.com>
Date:   Tue, 1 May 2018 13:34:13 -0700
Message-ID: <CAKk8ispQD-HNDTq4J0hNiDro=eRrJSM18t6_A=Ej6LNn+xxHyA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/3] Optional sub hierarchy for remote tags
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jake & =C3=86var,

Thanks for the great feed back. As I mentioned previously,
I'm going to be on vacation until May 17th, but will be following
along on email as connedtivity allows.

I'm all for moving in the "perfect" direction so hopefully you guys can
decide on a solution and start moving in that direction. When I
get back I'll do whatever I can to help.

My only criteria is that when a "remote" is added and fetched its tags
are put in a different namespace and can be referenced easily.

Here are some suggestions for naming:

  refs/subs
  refs/sub-repos
  refs/repos
  refs/externals
  refs/imports


Arrivederci,

Wink
