Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B221F461
	for <e@80x24.org>; Sat, 18 May 2019 12:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfERMSQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 08:18:16 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:56010 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfERMSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 08:18:16 -0400
Received: by mail-it1-f177.google.com with SMTP id q132so16056039itc.5
        for <git@vger.kernel.org>; Sat, 18 May 2019 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARiKllkzgTYis5POQxHLl3Y3t1KagU6E1blcO4nZb8o=;
        b=lqh32NRQCg6pjdFBx5ebbzAaEI5/1q274gnYkRPvkwGQWbEP3UXjLipdOr0ayrhQcX
         EBXFHp3O58RwXhYu5CTN8i0M1Fgu3Q0ullMgmQnADRCcOYi4V2FE7Ip+9BsHl/7tAsD0
         9+YLi5W0EwrSCD2BUq298GEh8bMH7xilxLo2ZGhBK7J6w115Z3BFx4AAyAtfA2jedp0g
         5DL8vETh0SFb1X7A0cO91wDUG5tO55/NrTqpjCgj/y0/XEZuxcCM0pS3tz/eIHelrDiL
         mGAnbPxPiBIN20KxPhwa+3sSwkuSbotbX9n1uu0aWKpu8nYtgi4jpd2IMk85Au6zZJj9
         UJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARiKllkzgTYis5POQxHLl3Y3t1KagU6E1blcO4nZb8o=;
        b=Gz0bNjNpx+gGK6pILHAS+eHe6aXiUehI+QnBH6lhmVYwyhKeLkTwNsPeESoRItgF0+
         PGQTe+8LIWnvuczVN8DxqGzGUUch1xeaUiIJfT6q0II1/nK7WwKlvbJoyNDzVSGUYoOD
         Se97ifXzfQJdPF/z6oDeZNgbRgIjyIlqpiADR67Xwpz1FWl8Nq/DcHA2yPqipQilYP4a
         pJ0XinaSsHai+G6nCvilaPORqfnOpD3/nH/Yj8oQGw/Al8WJ3FU56uveqPTZa/1cAUoI
         FQiGbzk6CWSDpY2H47wwhbcHpJ0QKUZswsLCbAqgJ2lImQ6YQg46uVF8q6LQzchcoQFR
         vvqQ==
X-Gm-Message-State: APjAAAWxYQZu9kE4iMBgCC11EwszvXHPHCfiFn/vvO+hub4+EI1y82JI
        6va8IU2eymzYELtyHoD/v1yUG6rUNmHPem6utOg=
X-Google-Smtp-Source: APXvYqzDGkswPWgeJcuTYqHXjkqdg4EaAdDZo1zNDetbkmMeBqZelIdybmZMz12D5mZYTNaFUJ1lIkjlsHKE6FSWFAU=
X-Received: by 2002:a02:3002:: with SMTP id q2mr2228533jaq.30.1558181895765;
 Sat, 18 May 2019 05:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
 <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com>
 <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org> <CACsJy8D9wDiTOfKP4sdMFQrR66qa4cLZuqqn32yH83_q0XjKRg@mail.gmail.com>
 <aeb83b28-3db1-f37c-6cb0-6be5622da114@iee.org>
In-Reply-To: <aeb83b28-3db1-f37c-6cb0-6be5622da114@iee.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 May 2019 19:17:49 +0700
Message-ID: <CACsJy8Cc+cj0kC5=N+6AGB2UGDWA3uK946vgdhg9Cpx9a7w2wg@mail.gmail.com>
Subject: Re: Missing branches after clone
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 6:10 PM Philip Oakley <philipoakley@iee.org> wrote:
> >> It is a 'branch which tracks a remote', and it is has the 'last time I
> >> looked' state of the branch that is on the remote server, which may
> >> have, by now, advanced or changed.
> >>
> >> So you need to have the three distinct views in your head of 'My branch,
> >> held locally', 'my copy of Their branch, from when I last looked', and
> >> 'Their branch, on a remote server, in a state I haven't seen recently'.
> > What I was looking for is this. I don't think we have something like
> > this in the man pages (I only checked a few though) and not even sure
> > where it should be if it should be added to the man pages, git-branch?
> > git-remote? git-fetch? git-branch.txt might be the best place because
> > this is still about branches.
> >
> At the moment its in `git help glossary`, but could be improved, and
> references to it given in the various man pages.

It does not look easy to link to a specific term/section between man
pages. The way user-manual.html does it is to embed the whole
glossary.

I suppose we could still do something similar after breaking down
glossary.txt (like we do with config.txt) the only include relevant
terms. Not sure if this a really good idea to pursue.
-- 
Duy
