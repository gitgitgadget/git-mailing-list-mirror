Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 161B120248
	for <e@80x24.org>; Thu, 11 Apr 2019 12:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfDKM5Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 08:57:24 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33270 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKM5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 08:57:24 -0400
Received: by mail-it1-f193.google.com with SMTP id v8so2210536itf.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaSjCyJK23cFanDXIiYhBTPxFxzqKbStQNumqWk1olg=;
        b=cmQm6NM63lOF4PB0gJyPIfGoxZuJ+3nzh4a4OZhGyQULwIK04cyGQNhybfzUvFs6eK
         D7vIh53uL/DryHz0+R+y0H3mJKIxn5/mkXXCKdt1mi8xZPQRPGJy89Um9YQ5fkdHVUel
         g7ayB+DpChaTuKO9czNbMOBDHXBOV0z0vMa0nMQDKqVjr7Nch1Pumq7/3UiShW+XYFHx
         tIOFA0V1BjqdP6jIWxpPoSfZFN7Ck7YQn0MEnc5LuMGDbhedJMc3kvSLDFvxBmA3tTsI
         ZUKldDnscb78QgE9GMaNWCpkarRFdP3qCI4fvcFwTgo8awE41XA23FCGDhcAWHey2lNV
         fyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaSjCyJK23cFanDXIiYhBTPxFxzqKbStQNumqWk1olg=;
        b=fuKuo7Px7XPPWxzyefIpZnmeFlnH5Z3pxkE0BoY7hWOP+hjXLv80Xw5fTsYFatASUX
         Hiixk29tvO2DpI1NnasFlTea4uuIJtPjXWP54mdojHAZOyo5fOXBrPBFKGspR8pP7J9S
         1CnoopvoJrH3LrUZP7gs5GTjImXe5noI3x8l+j4bgeUnqOFsvpreUjWkjQJB3ZCdxubj
         leEf+0CSwFfpkPuVlx6NaO9QBZM8tehflmggaNEV7J4yNOdRz3jf/FCcryb8TWt7R4sh
         fiVQqjoIpFAXQ7aJY5O9SX4oCaWRjs948RUaMiVSNr5zH+FPNSspsneEblFaAWPPksVM
         l5EA==
X-Gm-Message-State: APjAAAUmWE72wR6k2HuwBrssI/0wMFnMxl2jqlszAaeQwGjFPqh/jT6c
        KPskfwM/ptZky+67bvdRpKyiBUsANPbDMETIMTw=
X-Google-Smtp-Source: APXvYqzAw3ThCGpCsGRZig02apJUO99XC+KSTI1oKUmwHyQK8X7OCd86p4Skvak8uM4DFgaq/qXd3BtLYzP/DxgUVCY=
X-Received: by 2002:a02:711f:: with SMTP id n31mr33785700jac.126.1554987443176;
 Thu, 11 Apr 2019 05:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABgj7us=Rk3EUvd2EVVqsYKDUGS7VfAX09SpW04fB26cgntw5g@mail.gmail.com>
In-Reply-To: <CABgj7us=Rk3EUvd2EVVqsYKDUGS7VfAX09SpW04fB26cgntw5g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 11 Apr 2019 19:56:55 +0700
Message-ID: <CACsJy8B0dmonaCuAmT6wNJae8iX0JxUOvU-P=zvjVUrQnoHoUw@mail.gmail.com>
Subject: Re: Bug(feature?) on git-diff-files
To:     NoName Req <nonamereq29@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 7:49 PM NoName Req <nonamereq29@gmail.com> wrote:
>
> Summary
>    `git -C (folder path) diff-files --name-only` output is not correct
>
> Steps to Reproduce
> 1. Apply change to a clean git repository. Go to another folder (not
> within this repository) and apply the command
>    `git -C repo-path diff-files --name-only`
> The above command lists dirty files in that repository.
> 2. Now undo your changes on the repository
> 3. Issue the same command. It still lists the file.
>
> More Information
>
> `git -C repo-path diff`  command doesn't seem to have this problem.

I haven't tried to reproduce. But my first impression is diff-files,
as a low-level plumbing sometimes requires you to refresh the index
first. Sometimes without that, you'll get wrong output.

"git diff" is a more high-level command that always refreshes the
index internally.

>
> System Information
>
> Arch Linux 5.0.7-arch1-1-ARCH
> git version 2.21.0



-- 
Duy
