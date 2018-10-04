Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B2A1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 07:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJDOeJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 10:34:09 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:44910 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJDOeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 10:34:09 -0400
Received: by mail-qk1-f180.google.com with SMTP id y8-v6so5120948qka.11
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpgdkWOeck0pJJWwInK/uUWhwuYgFd9SYKBtfJwiffg=;
        b=sE1QQQFub+LgddtTx4PKbl53nJjhPuYUdD4ZFoj+YuqIQLcbtiSq7kNesChmyimHBK
         9uL2TH9qE1mT8psiCOw2prsW+IwXKIl4VZI+hK/EhTFAVoQtPsHSbnSilSqNwT2pdy8M
         2rx4c+Gddn4rzlXuz7Ow6GKIrYUBkaejIpBy5pHbiMAcGvhRTqf6MurOdaCju9vSb84A
         k97iEVK2mcO3ySVPFQKT5TgA5Aa7VnVGNOEywxtXZ3JT+ZX857D2MWPNEmZwGlWcym1U
         g91NDOIaDckzQmlUFdegQT7Gjyu/dufTlEHvnlPcDY0lfUt8yHCYreKINGVa4D/oWo8X
         P2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpgdkWOeck0pJJWwInK/uUWhwuYgFd9SYKBtfJwiffg=;
        b=cgXg5YuAkTgQhcGhWpb2J4XfZ4ik37vGeNm7Dp3DMrVT7HUaujO1iZi890/1DTmxNe
         pVXTRRMu/y1Wsj1yGIxIT954z7QIsbbaBWfCwLfO25z4DS+7xP9qdtXK4X0cRhizq5L/
         a/PpKU3evp7OhgmtF9zEmRHONayGTUzzYJd6vNShzt6oPfVtBVtprNVKx7oO9BxbapuK
         b0O7U35HaXgcgelJxZUia/98FYvfq3zhebsB11fRK7LuQRMoEY8yCTHnEA4Ap+xJvaZa
         zdXj8vhAlqTuxIR0YLaN0LqvHOZzjtZT4+YNAR8jRsDUcTUzyFzC8wuJEQAnRPD01Pzj
         gwDQ==
X-Gm-Message-State: ABuFfogE4eq2GSxXe54xPcbxSCLsJc6+IjmA9MivRnRKNMzOovl4NoMr
        2f0+tIc0thoTvqf1XLQfUaan9OwRCJXMjn2/rJ0uyg==
X-Google-Smtp-Source: ACcGV60Veegx3ZUl+RpdgABMv/Y4PCqXb9gNOkLKO2HM29btUCJokGUdeSMRz0qVhqZbNKCzsbo1nSNzxtFom1lrJTU=
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr4041149qkb.326.1538638933990;
 Thu, 04 Oct 2018 00:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <CADWf5z4pAR20qeoT1RnYENBB7Q5fA2fVVTNqPzMzvOE5Dq02qA@mail.gmail.com>
 <CAGZ79kZ=FXEgTgZ7hO_7O2Qo-ze9ykQW0_Vgr=m7MFe8mc9+Mg@mail.gmail.com>
In-Reply-To: <CAGZ79kZ=FXEgTgZ7hO_7O2Qo-ze9ykQW0_Vgr=m7MFe8mc9+Mg@mail.gmail.com>
From:   Chris Jeschke <chrisjberlin@googlemail.com>
Date:   Thu, 4 Oct 2018 09:42:02 +0200
Message-ID: <CADWf5z4DNRj=+X5pUF-Pe4vTq01OmFLk7KMP-=_hWWOEmsJg4A@mail.gmail.com>
Subject: Re: inside the git folder
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

thanks for your answer.

The Goal after sending the files is to have a copy on the remote site.
This includes that the working directory is the same (what we already
guarantee with our tool) and that git is at the same 'state' (that
means that we have the same history and that we checkout at the same
branch/commit).
My idea:
Send the working directory with our  tool
Initialize a Git directory on the remote side
Send the 'objects','refs', 'HEAD' and the 'gitignore' with our tool

Is there anything else I should take care of?

Am Mi., 3. Okt. 2018 um 20:51 Uhr schrieb Stefan Beller <sbeller@google.com>:
>
> On Wed, Oct 3, 2018 at 5:26 AM Chris Jeschke
> <chrisjberlin@googlemail.com> wrote:
> >
> > Hey git-team,
> > I am working on a plug-in for a distributed pair programming tool. To
> > skip the details: I was thinking about sending parts of the git folder
> > as a zip folder with our own Bytestream instead of using the git API.
> > Is there a common sense about what should and what shouldn't be done
> > when working with the files inside the git folder?
>
> This contradicts the security model of git.
> Locally I can do things like:
>     git config alias.co "rm -rf ~"
>     echo "rm -rf ~" >.git/hooks/{...}
> and I would experience bad things, but that is ok,
> as I configured it locally (supposedly I know what
> I am doing); but if I have the ability to send these
> tricks to my beloved coworkers, hilarity might ensue.
>
> What stuff do you need to send around?
>
> objects? Fine, as the receive could check they are
> good using fsck.
>
> refs/ ? Sure. It may be confusing to users,
> but I am sure you'll figure UX out.
>
> local config, hooks ? I would not.
>
> Not sure what else you'd think of sending around.
>
> Cheers,
> Stefan
