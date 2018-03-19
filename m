Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38C51F404
	for <e@80x24.org>; Mon, 19 Mar 2018 20:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030800AbeCSUOi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 16:14:38 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:44956 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969087AbeCSUOe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 16:14:34 -0400
Received: by mail-lf0-f50.google.com with SMTP id g203-v6so12915740lfg.11
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=CQQZYw4Umcw9rCy6pXNH+KJZSXSH4TwonOh7kNxe52Y=;
        b=tA9A2M/9pvAFWTWv96t1gS/73Mh68uzxPt5CGsmuUbiI6s+wb5mZRqcoDehZavMgfW
         m1+2zsfMYivFhT37lUAdzPqFyR2aIokzzzkpK24o/RZMBjhJIK1Pa6Rra58aYGOkEOpS
         jS9P7RkALaoZxG3jhM8JEIA/XD9rxMLa4DxOoYPQ3fQ6zBHFoSusvE+BJEvZgwYGRsRB
         P0Zv8v+ihSXaFdicy3hDdwh1mMafJM52V5XtEBaEs7m+iJLalA+0J3U1wOiLICdiwGxe
         LE2JXtlQndvcoXBnokVtEQJgtW9dO6TGIFpERsTQ9o7PKp9rEe3N8oOCLHN1nY1MQL/v
         1sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=CQQZYw4Umcw9rCy6pXNH+KJZSXSH4TwonOh7kNxe52Y=;
        b=uMtnDyZo7e3ePvBBr9TK9dtWYk0vgeV/ovasibw5iT/kT9nA7hHlhkpyGMPFXoJGNa
         fyluY/SL0JUsrA4v4LfC87WqiSnzOdw4Ao6LNy+YCOmKb5AHoWHWPblFbh+l5hOoMV7D
         fK131Kg1d27rIGyLfPGHGqP+xY3dZSZ6iUtU8wPJ7xsVxYPA88TnQ2e37AbYHY/I99+0
         sfrnyPMLqBBBpoOMBQ3eYuGaEQ/UgmMWr3bBD07JHfygV2ob3pvWP1I7ZpXtb+CRjli9
         SxMlr1c6otAntu84ICUEX4c0Y8oHSrnnjWFK3wgwP6Z71bEbshQ73Y8hv9qxO92lxa1+
         9+ow==
X-Gm-Message-State: AElRT7GM2o4+bG35G7eeeEZ6MN0gHtqMHEkNmV6tRO7+UB0b886WUkz6
        Ss/WRwYfG+5y+2bRBwGTK0Y7k9T0WjrCMaXhdtXkzg==
X-Google-Smtp-Source: AG47ELuPxP0t4yoLLP4zvOeA9WVnFQcinzU0iFSS4bn26CBNu1WT34TokWf7l2COCWOUUkmD/8bpe3TkFTMR0mqblnk=
X-Received: by 10.46.155.9 with SMTP id u9mr4170027lji.54.1521490472380; Mon,
 19 Mar 2018 13:14:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:4412:0:0:0:0:0 with HTTP; Mon, 19 Mar 2018 13:14:31
 -0700 (PDT)
In-Reply-To: <CAJ-HmiZFpGbe_kLUFoOibMgc2dtf=n5VXb=ReZjN2wNsja1Lrw@mail.gmail.com>
References: <CAJ-HmiZFpGbe_kLUFoOibMgc2dtf=n5VXb=ReZjN2wNsja1Lrw@mail.gmail.com>
From:   Nick Hunt <nhunt11@gmail.com>
Date:   Mon, 19 Mar 2018 16:14:31 -0400
Message-ID: <CAJ-HmiZtHZ0qR9KdZ5mxzok18Ad6R8zLd3xwrvt+GQHu-qDrGQ@mail.gmail.com>
Subject: Re: Potential git bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

oh, wait, switching branches didn't vaporize my changes, it auto-committed them.
which is still weird and possibly a bug?
Nick Hunt
nhunt11@gmail.com
404-988-1845


On Mon, Mar 19, 2018 at 3:13 PM, Nick Hunt <nhunt11@gmail.com> wrote:
> i committed my changes, then ran
> git reset --soft HEAD^
> at this point everything is fine
> then i switched branches, and all of my changes vaporized into thin
> air. uhhh, is this supposed to happen?
>
> anyway, thank god intellij saves my work for me as i go, so i didn't
> have to re-write all my code.
>
> my bash/zsh commands are attached.
>
> thanks for the help! :)
