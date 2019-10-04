Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360151F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 10:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfJDK3x (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 06:29:53 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:37179 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJDK3w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 06:29:52 -0400
Received: by mail-ed1-f41.google.com with SMTP id r4so5364684edy.4
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 03:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FMfNh5+W+6gph4k5TIIcBMzsU1yyb3AQ5DbgW0fk9Y4=;
        b=Vjycr8FZnalBU6IDTyrhzLVaBsaWRK5hjy7UXIe/5e7i32Lutms6dDKcr8Qkb6JoPn
         KCsuK5niBBcu9vLUxN2m+zsbskgYu+PnBGIRdXzZuiGiKJwFXfecufIbWsugTY04rmcW
         5szYLJukGorB3tm4th37CJ+zQ+K66E+e2izdjVayxPOCCI2R+NN7qHyhfi8OX2CiPXKK
         0wni73bxrVbJXuLzDhe3Dy67JEZmSo6B69Np8CFvzIlfwQ8w0uOkq0tBbC0gOZianTNp
         loiU6Y+AH6rH0zd2YtodwY3xd8W/6mOp+ZWoAoq+QuN5LYPBPUaJfpZn7a13jUg0n3tJ
         gK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FMfNh5+W+6gph4k5TIIcBMzsU1yyb3AQ5DbgW0fk9Y4=;
        b=pQ0RLd58LgHN43BCFpjdWaUECU/ka/UuuB48JqY/8zDUfAtqSdFnO8poQ8JTAfYFdM
         NKDwYmEhvyQqohT2KybX66tcTvOPsWt1W6/UVKoXWcz3QszXTTqbNQWfV0yg4HC3s1Cs
         I5DvWv9RihGR/j2WhRaGaC8FO0IPdy0q6ChtOoLG0XclXPcz1+mAy0pTDyXWRJ6tLuDY
         1VFwVquQQax+7AEc4T6R0cdZ31pzu2pPmQNL8jBfw0EosDo6zNUDrRlqcOtIVjB4dfL9
         2yJ1cklKHgw5Z38sTPumnrzaZLmJ2Kn4zSBbgV4WEn6z+XO6yymMtz9h7QZ5KA2ETqeI
         uPNw==
X-Gm-Message-State: APjAAAXlKsRxlfmWgRafTDY73NDB/6j6bG64CF7nbUZrR92uslaVz/K7
        DqPYaYOSS0ROkIx06tuCaUrNZsUcgMfG60941qPMme+zank/FA==
X-Google-Smtp-Source: APXvYqy7ukeYjDcUp0x8HJy+Ajdr/L9py7EUN1CRauSKBRKIyayn0JvinXlg/WII6zsffa1td9C6KtECasJx0MPTM3U=
X-Received: by 2002:aa7:cd18:: with SMTP id b24mr14261732edw.181.1570184990691;
 Fri, 04 Oct 2019 03:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <763118BC-2142-419D-A48F-9CD48865CB06@gmail.com> <c7e85712-4be3-2684-c5f3-210d5a48aa56@iee.email>
In-Reply-To: <c7e85712-4be3-2684-c5f3-210d5a48aa56@iee.email>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Fri, 4 Oct 2019 12:29:24 +0200
Message-ID: <CABUeae-oq4edQvrrPF3vmaPFaJV-dChVABqXgOKA9PkBfABg0g@mail.gmail.com>
Subject: Re: Git Basics Episode 1 GUI
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 4 Oct 2019 at 12:14, Philip Oakley <philipoakley@iee.email> wrote:
> On 04/10/2019 08:19, Colin Agnew wrote:
> > Could you confirm which GUI is featured in the first video?
> > Please advise - thanks
> Dunno,
>
> Do you have a web reference for the "Git Basics Episode 1" and then
> which video you are watching?

I guess, Colin's question meant to be this:
What is the GUI presented in the "Git Basics Episode 1 " video [1] at 3min40sec?
[1] https://git-scm.com/video/what-is-version-control

Colin, I suggest next time you include all the necessary details, links, etc.
to not to make anyone web search anything for you.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
