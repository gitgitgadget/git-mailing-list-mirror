Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3EA1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 14:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732968AbeLUOt5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 09:49:57 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:50714 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732727AbeLUOt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 09:49:57 -0500
Received: by mail-it1-f173.google.com with SMTP id z7so7137409iti.0
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 06:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUgpUjNgPBP8uFGiwUsU2i2fkTmG17RnaYpD2GBBrO0=;
        b=Jh6bvPoQavTGyJhJ1xHUR2t787V2TkBjwEva9imftDDPs4979k4SmrJgIwZ0fimnly
         AjOTL11xTF2uUbKDku/+Yk7mx4tErgxWl+03P/XcWwSR9+l5n9m3fUHgGQxvFkDWIscx
         qF8rGRU6saCzc2wZla7KZkGsZU0xxCBxJfFbOi0oOeUPHBAKZuZMmMpW6itFzFh6AIGD
         mCSSmM/KIQqft7HMcnC1yYxZlfM2MWXSahSJDwAFpuRj2KXyq77qBvVLzquc3n8vDZ5i
         +iin3//1YZ4WKBkZObzpegAdf6UudeZTzgrOc3yehaNFKSoLO/+8Z5KKAUqP7/tTe11E
         k3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUgpUjNgPBP8uFGiwUsU2i2fkTmG17RnaYpD2GBBrO0=;
        b=bPL8xo24uJiS7Z5wKlyMjrsnWijD9LRiBc+5b+25m2MCCnIRBYgPfGCqYH1wObIr82
         7oXV99FEgZMhdEml2zckrlEYP6x7KY5bQTviFfQSZV3hDDVmd9yf5zxAcsF4DDCImrHr
         1P2d5LwGMK9Jr2GbYSpgmURv/eirukCmAsZcEPWDxEj0Y/779KCvnc4vxRGN/edwbg40
         5pu6NPdUvFKOVoiB9shv4EY3FMH36C8lbsEtDSyb7REN94JCHAseN4zigMzrJOBPt1/x
         Vp+oxaJQxUFAeNuDUG59FfEVi7XUEZw7h1T+8S2w4Nbo3thHaBwKOc8Gvcn60Mc8iOxh
         TDJA==
X-Gm-Message-State: AA+aEWayC3k54VO1YToJUz6Hnuc9Ap4n+m4/Xo8K9wtpFfTc7txDvpKi
        hR2tcMBdI0/k+9fvdChBRYlp6rZ+9ncBV6KPoGU=
X-Google-Smtp-Source: AFSGD/Xftw7Qj58L8pMOp6gYC4e2sdGbPf3jF2Ago4ZsXDWyyy402it2yqJWdp4BY7ds6so3ttJ2QVWqDwQQD6T+no0=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr2145223itk.70.1545403796668;
 Fri, 21 Dec 2018 06:49:56 -0800 (PST)
MIME-Version: 1.0
References: <CAEcaDLk_vid3Y2z-kX17d5_LWEQTF4CYiztqrUFmOpN-YW-3yQ@mail.gmail.com>
In-Reply-To: <CAEcaDLk_vid3Y2z-kX17d5_LWEQTF4CYiztqrUFmOpN-YW-3yQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Dec 2018 15:49:30 +0100
Message-ID: <CACsJy8AeTshh+JCqpL2E9Og_Su4AHH7kBU0HqiW12JnZiQeN6g@mail.gmail.com>
Subject: Re: "git show --usage" no "usage" displayed
To:     Nicholas Hsiang <xianghongai@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 21, 2018 at 9:40 AM Nicholas Hsiang <xianghongai@gmail.com> wrote:
>
> Dear git:
>
> When I type `git remote --usage`, The command panel will prompt
> 'error: unknown option `usage', Then there will be `git remote`
> related instructions.
> But I type `git show --usage`, just display 'fatal: unrecognized
> argument: --usage'.
>
> ![git-show-command-no-display-usage.png](https://i.loli.net/2018/12/21/5c1c4d34075c4.png)

This is a known issue because "git log" and friends do not use the
same option parser as the rest. I have something in the queue to fix
this, but it will take some time to get reviewed and merged because
it's a big big change.

> Sorry, the previou email forgot to write the title. The previou
> previou email did not remove the HTML format.
>
> Yours sincerely,
> Xiang HongAi.
> --
> Live Long and Prosper.



-- 
Duy
