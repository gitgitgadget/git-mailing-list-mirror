Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5D261F453
	for <e@80x24.org>; Mon, 28 Jan 2019 05:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfA1FF7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 00:05:59 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:43254 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfA1FF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 00:05:58 -0500
Received: by mail-io1-f42.google.com with SMTP id b23so12382083ios.10
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 21:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4f7KWwOgUR6v24AgFsmrcaOZ5AwRfeh3bH29uPFscQ=;
        b=GeOBRD7tVOPXhUSFm9Yx1gVv0TkjZ1eadH+L9J5oGsYCRWAN+ZfIGsM+unzn0Xpgf9
         m1JICcAGiY3PNlg/+sHnlbDjkJ3i9mu/0XYTyWAkb7kPTLsR928cgfGwaGkUr81vbwUD
         JRyZKD36vTcA6RRK36zvH3xn7Jh39tdwmnunZRr/WDRH6OfZD8Kqgu82EFmRnfFPFKgx
         b89JijEL4IDID1+QtjoWS60cFOMZGMBJ4bh32wn1eqhxowuYBFAiJ49bVptQ33fa6+On
         QCWe8/hwf32U97XV0/6IPhW/ehYGj639FivtGOr1w0FMKvpJ/ydncCc4mWKq5OUoIuIx
         aVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4f7KWwOgUR6v24AgFsmrcaOZ5AwRfeh3bH29uPFscQ=;
        b=d8rxRDf7EM83mq4qixjzI+DoI/w4HlyCF8PS7Ot8wDtIKhEyiSKQxeJ5ng/BXI+tMH
         hBagWvcqo4juVu0rvT//VzXfGkVuSmjjTDjlF0+3/33XvJHTrflZwuj/tO3gKIl1CbGC
         PsZB+MbXLK8hMs9Fggx3e2KIwYljsDW/Cp7gJ5V5IUMWD4DBRIbkhqBv712pxsZ5LwKT
         GKMxbgXSM0oYHlmwgvtN3q7Gxdl8qEU0ORPyE8BWASM9Kq9YBuS47l4Dfkyad61ROws1
         WlbwXoD/YisV1AsEt55ZoEUScR++RLEBj5D9GUGqdeRIPTLHVlfEl9xFJtPbmHSjJtY1
         hFyw==
X-Gm-Message-State: AHQUAuYrEKnfihgCHKYl5hBWitjwVo0oU2Kn4aLwoiDgPt1sjjKmobH0
        bRxlkNHRVaqsLlHhy/RluWyITBSu+x3P8ggrQK/j812o
X-Google-Smtp-Source: AHgI3IYOYMQiBrryvE/P9f8wC80tPkh8r34nxkaB3JIwPIhVEDzmEGAYn4pt+CkAVklhcLTmAsXpxs6dUxNXPGYQ3ZA=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr9974873ior.282.1548651957952;
 Sun, 27 Jan 2019 21:05:57 -0800 (PST)
MIME-Version: 1.0
References: <etPan.5c4e6be4.2ca84d68.4d5@zdharma.org>
In-Reply-To: <etPan.5c4e6be4.2ca84d68.4d5@zdharma.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 28 Jan 2019 12:05:31 +0700
Message-ID: <CACsJy8BMc9k3Q=P=2CaJ9yyXhc4C_BgGVO=S_J0_R8zDweahLQ@mail.gmail.com>
Subject: Re: There should be a `.gitbless; file, protecting files from git clean
To:     Sebastian Gniazdowski <psprint@zdharma.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 9:54 AM Sebastian Gniazdowski
<psprint@zdharma.org> wrote:
>
> Hello,
> Keepiing repo clean with `git clean -dxf' is a very pleasant experience. However, ability to use it ends when one gets untracked but *wanted* files in the repo, like an untracked TODO.
>
> Could a .gitbless file be a solution? I would list in it, e.g.:
>
> TODO
>
> and this way be able to use `git -dxf' again. What do you think?

There's a patch that adds "precious" git attribute [1]. I was going to
resend once the backup-log [2] got reviewed but I might just send it
separately to handle the "git clean" case alone.

[1] https://public-inbox.org/git/20181111095254.30473-1-pclouds@gmail.com/
[2] https://public-inbox.org/git/20181209104419.12639-1-pclouds@gmail.com/

>
> --
> Sebastian Gniazdowski
> News: https://twitter.com/ZdharmaI
> IRC: https://kiwiirc.com/client/chat.freenode.net:+6697/#zplugin
> Blog: http://zdharma.org
>


-- 
Duy
