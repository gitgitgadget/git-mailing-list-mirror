Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0912DC55185
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 01:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1F8206DD
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 01:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgDZBvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:51:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56049 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgDZBvd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 21:51:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id e26so15625198wmk.5
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 18:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzXmX3FFZolejkVbkmv5oRm3ASfOTvB6jVARXZRBkVc=;
        b=LF9vsFGLNTNtmiNvQiTaAY/IKWJlJdqipUEMLBB3orsGdmsef/qualsHtzSH/2VY32
         fValgmi7KOHlNWFXXBKulB+8OmgCZzkAag/dxpqFz5w1mNo0WvG8FZuHdOxXz4IfTr9d
         PtWMLdVOGDJT9Pqxfv5eatVgHKwxrw+6mfAXNlCkeu9yL305o9IUELMJVK8p8LD8oMy4
         oCEbEmuSkDRYkOJ2AkUgUk0S5qQTcdQOBceYH3Vpeh0hnr8Cjcvgmmfah8UgtT79ZZ0T
         H8jXFpteqz5QjY9htYx6TnDnaoNCsAiGL4VQqDwj2tF/GXzQZXCnH5kCj+6ZlvpG4qoK
         8kwA==
X-Gm-Message-State: AGi0Pua+vPFp+kwohFgJ6a1pdPkX/ZFGFc4YSKbR+TZ2YIZrPyZpeGMl
        USgZEdriWDc1/dQg+sJNI07Gy6iscJxw44FreL4iUT24
X-Google-Smtp-Source: APiQypLgt+xe92M4sjAT3bCaZRs8BUOioyHGhCczUFMEatK+uR/hv0FQbwxSpqsvbF6orK0bxbWkH/ah2h9a+OnEQeA=
X-Received: by 2002:a7b:c213:: with SMTP id x19mr18196792wmi.53.1587865890413;
 Sat, 25 Apr 2020 18:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200421225837.GB3515235@coredump.intra.peff.net> <20200425213215.71674-1-sandals@crustytoothpaste.net>
In-Reply-To: <20200425213215.71674-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 25 Apr 2020 21:51:19 -0400
Message-ID: <CAPig+cQW1qLRgQg=yR2Uv5T9vQG-8zWyfBLzTh6=YU943Ayb+Q@mail.gmail.com>
Subject: Re: [PATCH v3] redential: fix matching URLs with multiple levels in path
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ilya Tretyakov <it@it3xl.ru>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 25, 2020 at 5:34 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> redential: fix matching URLs with multiple levels in path

What's a "redential"?
