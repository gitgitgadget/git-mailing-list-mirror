Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DD01F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfJ2UOc (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:14:32 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42543 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJ2UOb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:14:31 -0400
Received: by mail-il1-f194.google.com with SMTP id o16so36568ilq.9
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZU+UizC32SUMX+0OAAaqX7WTjdWo4g4UXJ27B4z+XVo=;
        b=pxQ8QCK+DW3yHXPv5yc2jEnKd9sIH3FjCGqTnCS+LFNxsv6oS1fUhTBT8OI+Ls5VEK
         00dZ1tCtCzuG+zeqGKO5YN3IW55D0EXztQC6aOaU7LUmzQWITPyvx1tBjE/FWipJXPJ7
         PD3PL6853ceIo1FC2YG0zTmQ5mIIyy0ztArYhRBhMUTy7mAqW1fBktOi1qZVOmBXRT+i
         xJb5o7PbdquwPNMdMqSzTtbL3Aox5tWh6In9RwMcn2PVnZA9NC6Pt5xCNVXEGjVbaxk7
         8fRqMRk8hoAyzK7AllTYrb2ph3DNr8Yf0h9miIKVR1jh6eyBPObbwZEOg9mQi9Co/a/F
         Is3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ZU+UizC32SUMX+0OAAaqX7WTjdWo4g4UXJ27B4z+XVo=;
        b=lbO3EHxyo7xlaXsCp0vFW/ap9l3tXRv6j24Lu/IXHPh6Vbi9YM3bIlI3IiimFsXe/l
         Pn3gZS8/0aeloY20pNsjoSiwX8oWl+p5pOuDxRLfZZRKKO9qgKem56iauS0NJDoafQW1
         Fmmmyrbx+xKDKRtioK+pZlT/cBTsDguUBEd9USJT98U9HT+DfuX7AFaF5IrpG/EknOAw
         JGgjqAyDgHMzgmzneVYWgNNKGT8kIY8ijt4p+jEZ2gIVcO8Jqi1fzZfJEnr0fSm5h7Z2
         k5+eZ4WNqepLzhiZWYP/JMMxoCkk/Y6MQJ0PJ7+xa1Eov02Txwue0oXhaQjFdnCHATXA
         T42w==
X-Gm-Message-State: APjAAAVMWhtT6aCMiyvt9ljBx8lhQcIZRLaIhPvxAuGrp50b4dLHKtjX
        zjsP7kP2CUrBoUSSn799ytsUNNx350RNovO/MY4=
X-Google-Smtp-Source: APXvYqyep3zE+BbpLFqe0hR5JUFABHA+SOU+CdFndtZNN7gSFgl38qskKoRmqUy2i1TjpaV2t28hSh/9cQLNxBFg/iw=
X-Received: by 2002:a92:9ecd:: with SMTP id s74mr27872291ilk.188.1572380071034;
 Tue, 29 Oct 2019 13:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191028165523.84333-1-mirucam@gmail.com> <xmqqimo86yon.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimo86yon.fsf@gitster-ct.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 29 Oct 2019 21:14:20 +0100
Message-ID: <CAN7CjDAWvKXOp+z=d8g-7QRBxwSExNCmqnU87fXN_vsDhteOZg@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH] clone: rename static function `dir_exists()`.
To:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Great! Thank you, Junio!

El mar., 29 oct. 2019 a las 4:03, Junio C Hamano (<gitster@pobox.com>) escr=
ibi=C3=B3:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > builtin/clone.c has a static function dir_exists() that
> > checks if a given path exists on the filesystem.  It returns
> > true (and it is correct for it to return true) when the
> > given path exists as a non-directory (e.g. a regular file).
> >
> > This is confusing.  What the caller wants to check, and what
> > this function wants to return, is if the path exists, so
> > rename it to path_exists().
> >
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
> >  builtin/clone.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> With a narrowed scope, the patch and its explanation are both
> perfect ;-)
>
> Now, with this localized change behind us, we may want to consider
> what to do with file_exists(path) that does not ensure the path is a
> file.  It would be a separate topic, and it is OK for the result
> after such consideration to be "let's not go further for now".  It
> also is OK for it to be "I am interested in digging further", too.
>
> Thanks.  Will queue.
