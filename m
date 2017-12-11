Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1941F404
	for <e@80x24.org>; Mon, 11 Dec 2017 19:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbdLKT4A (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 14:56:00 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35527 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdLKTz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 14:55:59 -0500
Received: by mail-qt0-f179.google.com with SMTP id u10so41724126qtg.2
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 11:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XjU+yDXKNtEvrc6d4mPm2vIY50xv//x2NXDGZFeV6nc=;
        b=cfAv3FxOJuW9co/y4mTYAjYakZ1y2KCGD+rDJvoDygTubx3faT0ikOEGPHbPrqnZrf
         SCHcHUrytzf70vqo0OEijpOlnekHe7lHswcc1L3wW07laVIiTXI3vZykkGjnZmj7Hsyd
         1EvJCxHbOsXJZI6Wzt086qBz+cArp5Bz2ZPZtGbvLH0t2DEiVF0ydOkKYSiRPJLxnKE/
         xRikqmt84hzA5WBQca4y1dJMoyfSAySsREyhiXw+USeRPGS/Nu3M2uSsDHrDJRKSI/Os
         P/W9GqH6Gtffxc9MLwtlLRtNhetq+4CtcIlmB57g2SasGk6y/teeKKxF35ilPBMBAE4o
         Wv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XjU+yDXKNtEvrc6d4mPm2vIY50xv//x2NXDGZFeV6nc=;
        b=iyhJPoyUV5bFW2k3tSI3HBZSDHtNlwKDImK3cTTj+m6Lu4rdOG/m7KZ9DntueEprzf
         619AF1HHWezx/mXuW1qIMepTf0g3AdknfI1PDfe5/SaEDRoHZtVWn7n5ehk0v3g6Ro0H
         2B6Cs0FCs4912sSyadOP1cy8ncJ4cEaNyLutoHR+e1kxyPKS+3utPe7vUklvin1Tk+N9
         ZG1QMWsEsiELLjyCT3Kiu8OAAq1X+of24gD5cXGKCgW6WTCC9CG4nsOkqxQY5FGnwQMI
         ivCFub7pRAj33Ao5aHhfVijMNX/jTp+WuJs/wZbiN6mMTpPGyMAlkqnwwkWuFs3LJVzb
         ZG+g==
X-Gm-Message-State: AKGB3mIrVwc+2mBL7+daz3I2oAzrFLpkpaZ19UF/zXO/U7oAZU0vPxZw
        BG0MYpqdvH3aMjTZ8J5V+oyQm9yANNR+ehYajYw=
X-Google-Smtp-Source: ACJfBovDsdizjHoexqwHR2WhGcjFHg6YlKHD6DdI5vap1RjR+4Z6wEcXVyNT8UTlTkJPlaQ5SnA17I8+Vj8bwPolq0c=
X-Received: by 10.55.97.209 with SMTP id v200mr2247271qkb.71.1513022158526;
 Mon, 11 Dec 2017 11:55:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Mon, 11 Dec 2017 11:55:58 -0800 (PST)
In-Reply-To: <CAJ+F1CJB+fOJmYpDQtjn1kLa-wk=oUeQGjO7q=N2igYhVG0tiQ@mail.gmail.com>
References: <CAJ+F1CJB+fOJmYpDQtjn1kLa-wk=oUeQGjO7q=N2igYhVG0tiQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Dec 2017 14:55:58 -0500
X-Google-Sender-Auth: i2lwVBH_XjYc3OWXSgyzeSxF3UY
Message-ID: <CAPig+cSxOcSkANUx2+nuVdN9VHiuy_X0Xk7L64G6=07fLf9q+A@mail.gmail.com>
Subject: Re: Shared clone from worktree directory
To:     =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 12:02 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> For better, or worse, I encountered a script doing a git clone
> --shared from the working directory. However, if clone --shared is run
> from a worktree, it fails with cryptic errors.
>
> elmarco@boraha:/tmp/test/wt (wt)$ git worktree list
> /tmp/test     4ae16a0 [master]
> /tmp/test/wt  4ae16a0 [wt]
> elmarco@boraha:/tmp/test/wt (wt)$ git clone --shared  . clone-dir
> Cloning into 'clone-dir'...
> done.
> error: object directory /tmp/test/.git/worktrees/wt/objects does not
> exist; check .git/objects/info/alternates.
> fatal: update_ref failed for ref 'HEAD': cannot update ref
> 'refs/heads/wt': trying to write ref 'refs/heads/wt' with nonexistent
> object 4ae16a066ee088d40dbefeaaae7b5578d68b4b51
> fatal: The remote end hung up unexpectedly
>
> Is this a bug? If not, a nicer error message would be welcome, as well
> as man page note.

Looks like a simple oversight in the 'worktree' implementation. I
worked up a patch to fix it, which I'll try to send out later today.
