Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099811F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeCUTSM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:18:12 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46941 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbeCUTSM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:18:12 -0400
Received: by mail-lf0-f65.google.com with SMTP id j68-v6so9513685lfg.13
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wLGlXTdEds58eb/k18kULOr7r8suv+5QiMYNNCyxy2k=;
        b=QxiG22xldA8m/n0CBkjL9gs6jM/FgPBMureZVJBHRXSAWLFQj2KdCkVHyfgg0941Lx
         bdpvOql/AbF5BYUDqjzqEA1tZY6M/1iGOtZQg3uhLcuGKEoWB4sg9eQB/nSYFAojsFc8
         js/N9TcrINDbWC/NbDWNb8rd3wDJx0e1ZN0xPz1UEcliPjk14lQWYXs+VAc+yd+bBi24
         zJOTGVF1URveEdFlOkM+dbwzJxiuRMYZWPrIPiOwHRP2tURS+DWlaynP4Ngxbr3IOoNL
         pfHDS/YBcwIe3/EIjnlfbBo0NwvTwqhqch2h5pNEXQFYoWVNiWm5+P88b7/WlEwhz3Ck
         Fazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wLGlXTdEds58eb/k18kULOr7r8suv+5QiMYNNCyxy2k=;
        b=Chr8Hd62cCVRgM2QFzgx2xAELwYZxCBOy0QrfWDXAnG7Xlp5B7nQWLly9VYfBZPXFu
         PY+9TKVxp1Ttv7B/jF8Vah6Jf6mz9G/fKXikK6MBjDPyJKgO+IEbgI5aAYlXU6G4Ahbg
         u4RzSrFuDIQZMJ83QvPPx63TKKwTTkkAv0Ls9q7PDIfAxUEoHHWBHXtAN+HyHk1RGvyl
         DswfLh3KlAsFkZweHq5Z5lIiZcBjs4+7gaQhBxLDT8/lzXwFURzIA28llxYGV/tv/urq
         OKXyNVQvwt4B5DfFk81wKPkYu0sBwY7TJLdmLQkFC56g5qb5/legmVm1v9G2KLf9Eb4D
         va4w==
X-Gm-Message-State: AElRT7GiFIARMLU921eOu6Lg9rUSybUaxKp+WGHQVugUMhtLfTfQgvcR
        JTuHZlUugtAMO4+EOSk1KFt1qRPNWbOxi0DhD8nRlg==
X-Google-Smtp-Source: AG47ELvd4CRXgOhEdiL+olopAqnWNmOLOGKItOyyqg7I7KSAlRuvahQ3gbdZ+DCfsL6jpQ7zxiUyyRYnW+4dcVZqYnU=
X-Received: by 10.46.49.10 with SMTP id x10mr7456767ljx.5.1521659890285; Wed,
 21 Mar 2018 12:18:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d591:0:0:0:0:0 with HTTP; Wed, 21 Mar 2018 12:17:49
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803211242190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CADzBBBb0KDVJiX2WSNW=vC6b6paWoK=5XrnZNAY+pwpcu-t9JA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803211242190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Wink Saville <wink@saville.com>
Date:   Wed, 21 Mar 2018 12:17:49 -0700
Message-ID: <CAKk8isrOMMm0zyJ1JtH3aDm=tF5hwokZ0Wzn=D1BQ1R-qEPicw@mail.gmail.com>
Subject: Re: [GSoC] Regarding "Convert scripts to builtins"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 5:32 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Paul,
>

> Note! There is one exception, and it is not even a full script. As
> everybody knows who follows my patch series on this here mailing list, I
> consider --preserve-merges one of my stupidest design mistakes ever. To
> undo this (or at least to alleviate the damage I caused), I already
> submitted a patch series to introduce a superseding option:
> --recreate-merges. This patch series is on hold due to the -rc phase of
> v2.17 and will be kicked back into action after v2.17.0 final is out. As
> it is my hope that --preserve-merges can be deprecated in favor of
> --recreate-merges (and eventually even phased out of Git), I would be
> totally cool with git-rebase--preserve-merges.sh being factored out of
> git-rebase--interactive.sh before converting the latter to pure C, and
> leaving the --preserve-merges script alone until the time when it is put
> to rest.
>
> (While I was sleeping, leaving this mail unfinished, to be completed and
> sent today, a patch series was sent to the mailing list that seems to
> perform this refactoring of --preserve-merges into its own script.)

I plead guilty to being the preson refactoring --preserve-merges. But after
reading this and seeing that --recreate-merges is coming and possibly
git-rebase--* moving to C I'm worried I'd be messing things up.

Also, Eric Sunshine felt my v1 changes causes the blame information to
be obscured. So I created a v2 change which keeps everything in the
git-rebase--interactive.sh.

Please see "[RFC PATCH 0/3] rebase-interactive" and
"[RFC PATCH v2 0/1] rebase-interactive: ...". I'm looking for
advice on how to proceed.
