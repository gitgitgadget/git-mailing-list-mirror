Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7191F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 00:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfADAnq (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 19:43:46 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:34320 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfADAnq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 19:43:46 -0500
Received: by mail-io1-f48.google.com with SMTP id b16so8757990ior.1
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 16:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SvMp1geOFdXcQoWIv5MPU/QOjZcGbaKREKBN2BIMepo=;
        b=mn1vfJ9Ppq8574MSUfw15VLmyIBT+KsBeq7Zzi+wMzqWFncgg8QqwgyZ8TaaBrnzPi
         XI8mY/440Khw72JuDQHK3/fpqum7ZCmWOjVtN0Vr0zBlhAhf1cKg1POXD56uq3CMKH9f
         /3eBE5N2Hgxqo6wRHms9MTqR02SgHnARlXuzfpE8WxGD0821MioCXyLiSU3X1r8j7Chn
         aV77I1wTDW/fz94YvIdrszvSliouZb/JiAy4slxQ4rjsmHNwHUhfMbtte63CPM8IEqQ6
         iKDyxrlMR6MDRD8G64RZAs6/vDWa7dVNoH5Nx/9BUO9rJWlrEMHIfO2WeolPqsyLI3LZ
         Rs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SvMp1geOFdXcQoWIv5MPU/QOjZcGbaKREKBN2BIMepo=;
        b=GvJJRQROTAwauprCcxvav404j//6uAKCMby8IU8FVPeZ4CTY9pAhG7tAntAPlaKgTO
         hJ9pWr6S2lHr7MvEW35uc/T5Xp1xvAZUPYJ+I6AP26JnTJqHHrTI2K701eJKk+VFJtps
         59dcPleKfdU2DzS04PB81UETb58s5zEp0ShAoUbjk0gvmnhia4xNHiJcvKxkHaMh1+3n
         NAZcsTwu6wYaLvjzXihPgxbAsZ+f9xTnaIGLV8PRR2A1jV2Pvv6T25qU50P1ABxenMcs
         tsc+c6qOF+sT5wi/Oc+/tBG9D3fiwhMlFsBeAhreSk2ciAdkgsLTzZb8OhlskQckRIEC
         JmvQ==
X-Gm-Message-State: AJcUukflGM3SbqccJGilrY8e9onUavGH0PIi4aayZHAO7MRiiSvzmJoq
        kckgAxFR6iVDwXG5N1MMFb/PXxuAfWgWmDQVGQ3Jc6QL
X-Google-Smtp-Source: ALg8bN4KgoTywktgrTDSrat/wcYVKitFx8n4rOS1SBUrQX1fNgWFHHWUzLVxxc28rGs2PrntC0hRxtXn7m6y8DJr33Q=
X-Received: by 2002:a6b:d101:: with SMTP id l1mr14429971iob.81.1546562624416;
 Thu, 03 Jan 2019 16:43:44 -0800 (PST)
MIME-Version: 1.0
From:   Charles Kerr <kerr262@gmail.com>
Date:   Thu, 3 Jan 2019 16:43:32 -0800
Message-ID: <CABMGpwQ5psB0DGJkWSbczAj+cTKXdsJ+cR6YbQhJpZMQZOHNrQ@mail.gmail.com>
Subject: git clone on page 44 of progit-en.1084.pdf (2nd try)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello-

I am an easily-derailed newbie reading chapter 2 of progit-en.1084.pdf

(1) On page 44 of my copy, where it first discusses git clone, there's
reference to a "linkable library".  How does this relate to
"repository".  I thought the aim here was to get a clone of a remote
repository....

(2) In each of the two example git-clone commands, the "libgit2" appears twice:

git clone https://github.com/libgit2/libgit2

What did make sense to me and worked:

$ git clone https://github.com/komwomak/shtoza SNOW

My  GitHub user name: komwomak
The name of the remote repository out on my GitHub stuff: shtoza
The name of the local repository on the PC: SNOW

I would appreciate knowing whether I have gotten the wrong end of some stick.

crk

-- 
Charles R Kerr

8508 N Pamela St
Spokane WA
99208-9656
