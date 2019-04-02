Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F045820248
	for <e@80x24.org>; Tue,  2 Apr 2019 23:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDBXfW (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 19:35:22 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37644 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBXfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 19:35:22 -0400
Received: by mail-vs1-f68.google.com with SMTP id w13so7836857vsc.4
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eS7KrWwFPs9bq9XqGmKgWYFUukDl3IvkiXy3Cw60SvA=;
        b=OD5C/YcWbADr28HthAAXBjuVkxeEPpWiGOT/vTLURANqef8yGIlvMcuupclAEM+3HN
         fBeU2Bu4lEnwuW822rXaGDOSBP96qOBewbQ/N9BE7bG1jBEibwPFFAolnNAwSAENEoHz
         PLvxNdL8Y/3+1FKGddVlRmStjspQkuWZafE7kGaNjxhcQ9o7wJdxEkj3Obg0mESWTkJu
         MAVp+HjQ2rEfehRlSlCrBaLTUB+/oGfS6/I8FBmoO5WqpFoF11YbHqqlz7Lr6gLC/T1t
         NFEKorncibdsTy7yIT0VUceF9g21Dh6WqecR+aO9aB6+RDyxNCieoY3g00py1d+ub6Ij
         T09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eS7KrWwFPs9bq9XqGmKgWYFUukDl3IvkiXy3Cw60SvA=;
        b=qnkfHNEOajU70qglBB9AjtsRGZ9BHr8J9Peetr6pzLnzCROxHuO/PklKv3adpsOryh
         o8YDOxw7OaXbEZgX4vng5tiLgUbWj3sfkuxNA8xca0BA+NzWX3dcj1krNI7SK4a8Mk9T
         QOmWp75iCs8JYVwn+m0vRSFSg5lTZDz5G6J/mBFaQEmsvHACXdZKVmPiMGgXRmY1jRWS
         mo+iWe1SlsXDanDyiYd+PA8DgaI61EzUOBnto9DLU+PkYRVTL3LOpy9QAhcRjK5XktBX
         kmSQ1N8Yfo2bT2ndZYt8zk89oiytHMm8icMKSYMlPK8HmmuCiixmmPXcwrCkRv1wY1u1
         xFBQ==
X-Gm-Message-State: APjAAAXerFjC9FCiBJ1iciKFHyZbcC6AL3c+dBD/QSymYEk6/Zv6YOou
        7MNCMT+0JhPmW/TAr+XZlgfoDb4eVgCGoam2VHs=
X-Google-Smtp-Source: APXvYqwVKXlwge3oRbvNGKinLpRdrqKU5xYruAfKVcHaboivpCpk1qVKPy2s4kgJU8lNQbB45jvtlnN4/nFDoUTHWLY=
X-Received: by 2002:a67:dd0f:: with SMTP id y15mr31574244vsj.195.1554248121679;
 Tue, 02 Apr 2019 16:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0rSSeLReFKci_p3kjJwxD65R21syDTHoKcqWJ0wbF8jZQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1904012244520.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1904012244520.41@tvgsbejvaqbjf.bet>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Wed, 3 Apr 2019 01:35:10 +0200
Message-ID: <CAODFU0q9-02k_OtHh8+fo-rm8AxpmaE_fqiEhoS2cmfrxrim=A@mail.gmail.com>
Subject: Re: git-gui: executed hooks are different from command-line git if
 hooksPath is set
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 1 Apr 2019 at 22:46, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Could you give `master` of https://github.com/git-for-windows/git a try?
> (Despite the name, we aim to keep it functional on the same platforms as
> Git itself.)
>
> I am fairly certain that I fixed it there, and contributed a PR to the Git
> GUI project, but it seems that that project is in a kind of hibernating
> state right now.

Hello Johannes

You are right. git-gui.sh in `master` of
https://github.com/git-for-windows/git is respecting the hooksPath
specified in ~/.gitconfig.

Executing "git-for-windows/git rev-parse --git-path hooks/post-commit"
as part of the process works fine but it seems a bit inefficient.

Sincerely
Jan
