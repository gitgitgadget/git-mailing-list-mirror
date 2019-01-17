Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB8E1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfAQU4r (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:56:47 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:37639 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQU4r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:56:47 -0500
Received: by mail-it1-f182.google.com with SMTP id b5so3055138iti.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AEhPDnV3zjTA4WwFCyIpmBeQNuIMja/n5Jcwyr0xw+k=;
        b=rMajeQ/SzA0BKO4MdwPP5HZPx7YY0xi7szbcigvOarFLSfhqxOIxKxpN60W9d6GqxF
         TIVSA8FtUOBmTZpMVCmr/FUBCzu1gtsAX23wiKa/JzaO5gMFBE9vL7d9BjMiVBjO+qW5
         GIIkiDMhAF0fvJMurTfZp92zEU73pJ1dxvLVzfBVEY7aQd+As4medTkdScpTt4IAzmLB
         zYjDflfDgAyNYLC7RyxW7wk82YXd5BM6Evg4BgKMEUbVJlnXiXrS+9rzVKFhFuUJXPaP
         Tfn1YousxNun1DaNRUXjneqbuf3BTBJWlpqwkuriOYVIgzOSBRWriGD7QLMprj7TrUcO
         gbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AEhPDnV3zjTA4WwFCyIpmBeQNuIMja/n5Jcwyr0xw+k=;
        b=oFCsQO3ZoZHu4d0XIlZQIRMSJ0G9dJCvMGGTTkGPvx5FOgHPlbPJ7xK+8wZ+YiSotP
         wkh4LnEwHWDSAtSUdFivj1Zg0AcjD9Q9msN+mvcjWB1Fo291pBDDcOFvPhZg1nn+K0gd
         eun7UaaQNAkhl5wvnVb4qmPfn5KPThvrDDjCFP5wKbVjKu0IW0uKb+j7hcnTwFbdsiW6
         U9ESTvTBElFtUxuOKcOANfrMXI+SC2U2Jdw6XpcZ2wNR7wi8uNMPdlc+RIGTNDSRxDXI
         ipPAJtQ7p3tGTpFG916ka2ecpEG79vilc1hNZmR/w1NNJRbkS/56MZumsLpEvMurFKGw
         q5ew==
X-Gm-Message-State: AJcUukcMB4FMbw7P4pO10+l/j1+44cv8Wx2gXwJ0IROsJfZygp+xJiYj
        436fzsdGUESY8pBjQ9T+bI9EFGIvFCDGKukm7D5F+qRj
X-Google-Smtp-Source: ALg8bN5Rccro4E+Tbbn07wvaevm4ovoQkv2tbfHemjvISwQ9fgmzU1boDvIB8CoO8w5I2POUK3wxkCwWwfeGP3jz1aw=
X-Received: by 2002:a24:70d2:: with SMTP id f201mr9159066itc.127.1547758606293;
 Thu, 17 Jan 2019 12:56:46 -0800 (PST)
MIME-Version: 1.0
References: <CAG2YSPxynGyj3kFxPbvHDETdievY0c_NGSohPSFURuNjhyaYWQ@mail.gmail.com>
In-Reply-To: <CAG2YSPxynGyj3kFxPbvHDETdievY0c_NGSohPSFURuNjhyaYWQ@mail.gmail.com>
From:   Mark Kharitonov <mark.kharitonov@gmail.com>
Date:   Thu, 17 Jan 2019 15:56:35 -0500
Message-ID: <CAG2YSPzFzpwKpDo4cCjUinpTDhFgd3ax0f_g--ZDd76=UJt35g@mail.gmail.com>
Subject: A seemingly wrong PR merge resolution.
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a very strange issue where a change has disappeared from the PR
merge commit.

I described it in great detail on SO here -
https://stackoverflow.com/questions/54244042/incorrect-pr-merge-in-vsts-the-new-change-disappeared-after-the-merge

(Sorry for the spaces, did not want it to be rejected)

The post contains quite a few images and it would be cumbersome to
replicate it faithfully in plain text.

-- 
Be well and prosper.
==============================
"There are two kinds of people.Those whose guns are loaded and those who dig."
   ("The good, the bad and the ugly")
So let us drink for our guns always be loaded.


-- 
Be well and prosper.
==============================
"There are two kinds of people.Those whose guns are loaded and those who dig."
   ("The good, the bad and the ugly")
So let us drink for our guns always be loaded.
