Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608CF1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 07:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfIEHYm (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 03:24:42 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43663 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIEHYm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 03:24:42 -0400
Received: by mail-ed1-f45.google.com with SMTP id c19so1613538edy.10
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 00:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyN63x8xnMW+oeKY0sdU/h7Wi1+OS2MkIVyZ/OcYR8U=;
        b=ArpcJ6UsFArfLy5GmY9LFp8W75WW/mS7qDlNM4GoAcJA8mSFC3C4KQ0qhmpPQF0weB
         Y0JyhtrzVYz6FCxclAil7aWN27S2bybe3XiQt2acgLXlSsho/kzM+kn6xWPHYikrMODI
         IgHtAXbdUQQcoIn9cKF00QqavEI11wNO2S9coQT4kwgkFNubY9YOLjtuLII4C9fV+DOu
         0+mh293HD8OR/GePUduVAOu4MeB9OBMOJOnlHsHmkWEmiUZ1yiEuBG9+xP7KZEIMSTy0
         Rb0gXToJUBZS8WbheHZ21prxZYZYd+7fD7bGTbkf4ORUBhxCUe3GwHovn6Qr2sFr6iMU
         kjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyN63x8xnMW+oeKY0sdU/h7Wi1+OS2MkIVyZ/OcYR8U=;
        b=h7WTkgLexmJbXPbv4j7iLYo6jM+NzGvf7SVEAm5oOKSec558t78v12dnrd4l0buiYb
         gA92VG8LthoPvDMFs/bxm2TD+RO17QXFHaXuWb7MIvoM7gOsEpqXRbm5stu43NY6ZN9m
         YhXOYF/HtNsyHrMzcsbV7rOOAm7q6GsoTpvqqhPk0zVtVnxEuZXXcDUs6pY4DtXNJZCb
         Cr4/GQGFFL6jctzBh2reiliOJyWGdVgV8eirWyOwIzozhOZg0Q5dKnQvZlbbStcFW0w5
         8/5LN2nBaN+LfjRAfUL+wrTCmmgfkiyaZKQjEg7lXKNFPT73lNM2wPWSX/eipWcAFxwe
         5VLQ==
X-Gm-Message-State: APjAAAWA0YroHHrD9cPvj107kmYkc+1R7qWAA0lzPqoKaWwLVPzR8D5e
        ZqiY9ZJ4/WBcEeIRP9/EJHn49KCwPRmyuLq4hOCiXQ==
X-Google-Smtp-Source: APXvYqyfJdYJcgx6By0H5N3imzdsUouZlT1WGoJHcbOYO2uH3RjRtnQBidoXtoHVVqbBVGyfVT70yO00xVBmTll4Z7c=
X-Received: by 2002:aa7:c24b:: with SMTP id y11mr2147662edo.214.1567668280353;
 Thu, 05 Sep 2019 00:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190904194114.GA31398@sigill.intra.peff.net>
In-Reply-To: <20190904194114.GA31398@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 5 Sep 2019 09:24:28 +0200
Message-ID: <CAP8UFD19Lop7jLsBcN6dEARCNX19asQKTszFpJ51=TEAMzAp2g@mail.gmail.com>
Subject: Re: Git in Outreachy December 2019?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 4, 2019 at 9:41 PM Jeff King <peff@peff.net> wrote:
>
> Funding is still up in the air, but in the meantime I've tentatively
> signed us up (we have until the 24th to have the funding committed).
> Next we need mentors to submit projects, as well as first-time
> contribution micro-projects.

Great! Thanks for signing up and for all the information!
