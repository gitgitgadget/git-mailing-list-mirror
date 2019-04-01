Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B6EE20248
	for <e@80x24.org>; Mon,  1 Apr 2019 12:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfDAMCk (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 08:02:40 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33324 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDAMCj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 08:02:39 -0400
Received: by mail-it1-f194.google.com with SMTP id v8so17245474itf.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c4YC2cs2TAs9muQ6IpLI6TNLwGtCRDgk29nUle8xu+Y=;
        b=SP1KB/o/60ej/Cwa5SctTcPrtWfzypIAVstaFx8t8ooktYaHd7AEjUasR9a8aGY3KN
         piGC8SWm/2c+D3xMlXu0XUK1PM3FcBAVreujoHMgglvXzTCtTz+BiTN64pXvAxIcXsSJ
         xg7+PFkZ+ipdrKbDtoZRNdq4X6l9W6tTyrr1TbtixMa/VIoinL3/4LZcVNJnrrIkpyBA
         rbu1nHLVor5JV0IKNk/jQEbscfXSAmn8fS1fX1UMH/57aODpZ16gr8yuubCckqwqiBgb
         Bh6IjaUc3NpjkhW/r2MwKU0ix+qCeusUX0uAGp3/tSq45MKKG2ActUWfG5rfrdHXOW8E
         7utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c4YC2cs2TAs9muQ6IpLI6TNLwGtCRDgk29nUle8xu+Y=;
        b=sq0fogOPw/ACNalKzpFmVxNGvuLhhG4bn+d8U0FvVqeyBq1zYeF0q83cPLCMwTEw+o
         j48TPaTbrHxDO8taDXMQ5N7kpVHM7RcEiiA/2T0bCs/J2DtzCynHfpFQZ94wUV4UnNID
         zDSmXa1OuQmGiUICg54A1W2AtwSSx4Rl1rYrao1yqLYW3XTMO2YwOSEd3MN+m0/lnmIk
         DohxyqTuOCY8pvpkeHWFWhSDDkarSbszAwWCMKOnYCnmmjTjwXbradUTabrx/pegO0IS
         dG4NRWkChNjU+3OSqNlUbcP87V5bEtgEDQKRSSYzdwg/FVPGff8gnQiAHIZ3xVpeDgqV
         y6vg==
X-Gm-Message-State: APjAAAV6ITuVRQR1oKtp+hopSE6Le/aZjkdMqD0JEK9HTesj4+0p+GZi
        kYc3/4QxDJKKrIl0lApVXPqQLntyTJkxs3hDrkc=
X-Google-Smtp-Source: APXvYqzEqILDIiI0E0Kg4MAso+83rc8qM6PTulF5/7jjkbm3iWxkexC3VF4UWxaNtkCq4vBbbi5lIAn4fFMjLjjQuQo=
X-Received: by 2002:a24:4d8a:: with SMTP id l132mr6954779itb.70.1554120159017;
 Mon, 01 Apr 2019 05:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190326120939.31657-1-pclouds@gmail.com> <xmqqmulauhmv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmulauhmv.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 1 Apr 2019 19:02:12 +0700
Message-ID: <CACsJy8B1Bp6=H_pKTfaZtucxod-SK3X+gb6zMJfmxBy8ep0PPA@mail.gmail.com>
Subject: Re: [PATCH] read-tree.txt: clarify --reset and worktree changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 1, 2019 at 5:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
> > index 5c70bc2878..12a25bc954 100644
> > --- a/Documentation/git-read-tree.txt
> > +++ b/Documentation/git-read-tree.txt
> > @@ -38,8 +38,9 @@ OPTIONS
> >       started.
> >
> >  --reset::
> > -        Same as -m, except that unmerged entries are discarded
> > -        instead of failing.
> > +     Same as -m, except that unmerged entries are discarded
> > +     instead of failing. If `-u` is used, updates leading to loss
> > +     of local changes will not abort the operation.
>
> "git add $file" makes a local change to the index at path $file",
> and reverting that local change is what "read-tree --reset"
> primarily does.

That sounds more like "reset $file" than "read-tree --reset" actually,
which works on a full tree instead of a path.

> The difference cased by presence or lack of "-u" is only about the
> working tree files, so s/local/working tree/ perhaps?
>
> I'd also phrase s/If `-u` is used/When used with `-u`/ if I were
> writing this.

Updated. v2 coming.

>
> Thanks.
>
> >
> >  -u::
> >       After a successful merge, update the files in the work



--=20
Duy
