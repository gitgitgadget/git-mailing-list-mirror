Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A14C1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 18:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJCB2A (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 21:28:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35971 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeJCB17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 21:27:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id f18-v6so372935pgv.3
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=YqLFuMmqpkAgRcg7sFB50vMsIoyHEJOvhkakLG6Uzvk=;
        b=O0k0LkGr8IuYmcrg///vk/ZsQrohliujKxX4Axh/Ft/lQr695zvktzq/CiO2j2ijhj
         kZ6dg9Z1kFkyKjDfL2wdBtmvXs/iMAvdzZu7JX7N1XxGfxSZCirCXItHfjljGWqDn7C1
         n9/BAjHPd3Jlo4w/kh3xVbUKo6WYN3lCy72d3zomXE+9mY09yPR9B9I48bQlE4fIxhMn
         19XY42vgVGkS9RTG7gWpboWauxd7YUn3s7D5ie4vWc2a4rusGsc4ik0jpjoQiMymwYYp
         bMH4By9mOyHt3ZKb0CKqpGAElgLkhRrZBbMYRthQTTpBtZFMnsawpxfs7xGpgSXt0/jB
         z8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=YqLFuMmqpkAgRcg7sFB50vMsIoyHEJOvhkakLG6Uzvk=;
        b=gKep+P0K77xrGz5zrLz+w7lTGLk/WBTHYaHVJcS+8BOUy+fgbZtRmuKrOiSYvM533E
         NTlKqw1SJV/LxQEvAKOUam/vMlb1kVTY4YeZlhixVHPS9i+OU227x0wP8RHykmUVDBw+
         nHLwayyHbe9qmLn4xZtYukuIAT/EBlsYqD0eriNVeAYUuuZgzQetnVlGa5frPXDWFYww
         S9f30fxcigiPz5/Fi9BtTZsOiAQfV47Uf+D9FBAgL5egBgoY7ltaJ6aktbwDz+hTvYI+
         W4WhMis1B6f++BboYMJpMfn4W3sua66tfmpaSJjLDpgl53wD/K1jVx0kC03VKBmWpHBg
         KXAQ==
X-Gm-Message-State: ABuFfoiCmb6Y6iBqVGBAPZq8Ql9+4r/RXeI3C/Dn+1Dd708/ZdKgxhZq
        JTFHQTq7D4N3kMpQVruN1XI=
X-Google-Smtp-Source: ACcGV62c+HCKwmye8Lr8gNf9QgD24i6QSiQ0ucORVrPO2Xiu5hqi12NrMgTIzJodbNqt0xmMqBAImw==
X-Received: by 2002:a63:7744:: with SMTP id s65-v6mr15626227pgc.197.1538505794390;
        Tue, 02 Oct 2018 11:43:14 -0700 (PDT)
Received: from unique-pc ([27.62.4.217])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm15528465pfo.135.2018.10.02.11.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 11:43:12 -0700 (PDT)
Message-ID: <d876e0af6a860621ae80fde71069c5e2e6a71878.camel@gmail.com>
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a
 worktree
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
In-Reply-To: <xmqqpnx0mbos.fsf@gitster-ct.c.googlers.com>
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
         <39F9931A-B297-4525-A131-736B900F37AF@gmail.com>
         <CACsJy8AScp1v+R62vXWuP-45LLLYwfSBNaZJfR02=d+2CzDqhg@mail.gmail.com>
         <20180926160938.GA15312@duynguyen.home>
         <xmqqpnx0mbos.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 03 Oct 2018 00:13:06 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the delay. Got a little busy over the weekend. I seem to have
found the reason behind the issue in the mean time :-)


On Wed, 2018-09-26 at 10:05 -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Wed, Sep 26, 2018 at 05:24:14PM +0200, Duy Nguyen wrote:
> > > On Wed, Sep 26, 2018 at 6:46 AM Kaartic Sivaraam
> > > <kaartic.sivaraam@gmail.com> wrote:
> > > > This is the most interesting part of the issue. I **did not** run
> > > > 'git fetch ...' in between those cat commands. I was surprised by
> > > > how the contents of FETCH_HEAD are changing without me spawning any
> > > > git processes that might change it. Am I missing something here? As
> > > > far as i could remember, there wasn't any IDE running that might
> > > > automatically spawn git commands especially in that work
> > > > tree. Weird.
> > 
> > Maybe something like this could help track down that rogue "git fetch"
> > process (it's definitely _some_ process writing to the wrong file; or
> > some file synchronization thingy is going on). You can log more of
> > course, but this is where FETCH_HEAD is updated.
> 

Thanks for the patch! It really helped me identify the issue.

The actual culprit here doesn't seem to be Git itself. It was the "git-
prompt" bash plug-in[1] I was using. It seems to be spawning "git
fetch" for every command I type on shell. That answers why the
FETCH_HEAD was being updated even though I wasn't explicitly running
it. The git bash plug-in seems to be fetching changes for *all* the
upstream branches. That answers why there FETCH_HEAD was populated with
info about all the branches when I explicitly requested for the next
branch. I've also verified that `git fetch origin next` works as
intended (FETCH_HEAD has info only about orgin/next) when I turn-off
the plug-in which confirms that it's the culprit. A cursory search
found me a related issue[2] but I'm not sure if it's the exact same
one.

I could identify the culprit only with the help of Duy's patch. Thanks
Duy! Sorry for not realising this earlier. I almost forgot I'm using it
as I've been accustomed to it a lot.


> Well, a background-ish thing could be some vendor-provided copy of
> Git that has nothing to do with what Kaartic would be compiling with
> this patch X-<.

Fortunately, it wasn't the case here as the plug-in was using my
manually-built version of Git :-)

Thanks for the help!

Tag-line: Sometimes tools become part of our workflow so much that we
really don't realise their presence. It's an indication of a good tool
but we should be aware of suspecting them when an issue arises!
Something which I should have done to realise the issue ealier x-<


References:
[1]: https://github.com/magicmonty/bash-git-prompt
[2]: https://github.com/magicmonty/bash-git-prompt/issues/125

Thanks,
Sivaraam

