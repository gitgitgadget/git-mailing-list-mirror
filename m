Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176771F51C
	for <e@80x24.org>; Sun, 20 May 2018 15:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbeETPR6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 11:17:58 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:44591 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbeETPR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 11:17:56 -0400
Received: by mail-oi0-f50.google.com with SMTP id e80-v6so10981482oig.11
        for <git@vger.kernel.org>; Sun, 20 May 2018 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WjOSQdBuDpmXYjYMiyoibwnYyAiU6g7iqwWixUIojA4=;
        b=suw6Bt3yjT3A7Gjp5w3NpMa5iETm8ylGvKLLqn4CqjVqs7GTMIZh839wKWGITWOuG0
         VBxPpSUpp8lp6fvBPtoULyvlumSr5IY6Zli+p80yGycm9QDToeVTXEqdMqY22gVDMt8/
         /LMuer1T26wDek02n5L+M2bPT6uwAnIzCFt8wTVdWugW3GXvltRIWDRjwanhuHiACl0Z
         Svs1SAduVW3Otn0MfyaxEPNsQukkJfHoC/wUv1+xAUHEmY+bxbWG3zK0OTquc5HVExNZ
         0sIvncdGY8YRze1LVs1zI9+Lk6uqiUDmMn8otXfFjOQtgDjOSsQ6QkXNxF3/drqOPcNn
         hLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WjOSQdBuDpmXYjYMiyoibwnYyAiU6g7iqwWixUIojA4=;
        b=bjZ2UfuEj7owss3hVptomSf3HNajYHSeZHiOOp+jTIlRtInKEE5ed5FXeML/yKdpwY
         Vxpy3GBbDwzQ6yL/7/44VRnuVXyJmQ0AU1EoiDN5ua5d+GU5txNcUbgbZQtMzXOFnT6h
         xYXoZWfI7rztPRXcJffyfxksHMJJ4DYWJIfAQOshAbwdeeIyJF4X7IjeOQEVpxGC4Icc
         kHjOHw4c41ymyuR5MViNVslfgHFvDUrNq1ZxjcRt2fZjXN4m/4ifT/od67ZXjRnNCh7M
         QvZR7sK0ZgBGXtb1LTsIegYhYYpoBoKfbYWU7MtQJcFvBoDD9VN32/3FMV074Wrs3nta
         I9dw==
X-Gm-Message-State: ALKqPwdpaheKBzg6vmNpkfSeHNOflOYYraEDTKzu2nk/rKuWFxHOJ/tv
        ERpFlSKKFcUEJ1rXklt4w3JyP9n4pJtpaehOlVvPvw==
X-Google-Smtp-Source: AB8JxZqIN3uf8178bCcvdK5w4tDagtgMuBlOht4XV0MVC2RgWyBPZHXEhrxRtu1OsE2Lvwxuily0Ia8cNMovSH7z+Vw=
X-Received: by 2002:aca:5a09:: with SMTP id o9-v6mr10100744oib.127.1526829475413;
 Sun, 20 May 2018 08:17:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:d50:0:0:0:0:0 with HTTP; Sun, 20 May 2018 08:17:54 -0700 (PDT)
From:   Chris <jesdisciple@gmail.com>
Date:   Sun, 20 May 2018 10:17:54 -0500
Message-ID: <CAN_7rfcZHkbfaVO5A989Dza-zu7eRSPTKag9pcyB4v9=HWbKKQ@mail.gmail.com>
Subject: git push => git: 'credential-winstore' is not a git command.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Windows 10
git version 2.17.0.windows.1

I'm having a problem very similar to this one:
https://stackoverflow.com/questions/11693074/git-credential-cache-is-not-a-git-command
One of the comments on the question suggests this command:

git config --global --unset credential.helper


This did help me, because previously Git was trying to authenticate me
with the Microsoft account I use to log into my Windows, which is
unrelated to the account I need to use to push code. And it removed
one of the two "git: 'credential-winstore' is not a git command."
messages I was receiving.

But I still get one of them, so I tried reinstalling Git for Windows
with the credential helper disabled, but that didn't help. Then I ran
this command:

git config -e


And couldn't find any mention of [credential].

What can I do to get rid of this annoying message (and, for all I
know, potential symptom of a larger problem)?

Thanks,
Chris
