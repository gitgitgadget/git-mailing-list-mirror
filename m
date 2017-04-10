Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42BB820970
	for <e@80x24.org>; Mon, 10 Apr 2017 10:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbdDJKVc (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:21:32 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34964 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdDJKVb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:21:31 -0400
Received: by mail-io0-f170.google.com with SMTP id r16so35490261ioi.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Mx4p/FttC6xCRUqrW97EiuaaIxvz5jwmfg4GhLOB1k=;
        b=NllmV4apvON40FnH2JuAnCXXj65MTnbthu3o3+GkiK3hD1DLD/ZivKZeiQJBjjVUSl
         kJVlnZUYhAhwXBLXcm1xh1J61ZZLy5g56VBb/QC4hBrFFwfhz911pMej7twuuK37YmDB
         Do2h5yZgzuI04L3pmT0el/y+eSxjwOoDcNRm/ZCHEETQb9hIBpDAtGwLIFMwoZLUrrEk
         xFAzxtI1gO9ck+2Ruxrc332IOE+CZ4SQSxrHXVYN/Duz5QtQ9M9AnDE36kp16/TiMEZF
         eeajp1do+Kze3KSuaKbjx4pXK1g1hh/w3jp4HpAMbpKZCAYA7OllD/Wx1ZdlNW22X5IX
         yHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Mx4p/FttC6xCRUqrW97EiuaaIxvz5jwmfg4GhLOB1k=;
        b=VmenxasTYkeZQxPhi2IYayXjfub3pLC0NQezMGGFBSioaBmcAWp5e8ySFOHio+LEd5
         hroFpv9GTRrdRGVvZcLkISp8mx5m5OHrxs8rNalMhO81VyejOSNZZqSs3ScuhqJbv9Sv
         HLmRBygRINPS5U5eEFJYG3FMdJZD8da2mbjehiDHWypakZ3BdE7mZr23Ng3+81Utf3Fk
         V5LrLeA8sbkE4nh2TulL+n19zR5a2l1jyWFICFECLckAnD1szCnS5xh8WrDUkOaWrUuR
         D7JS9AbT5PRAwVhhpVjPxcURswe+U5uFKr1A9API8D1TeejflbtrZx5i/y+Rr4c3OiVh
         qScA==
X-Gm-Message-State: AFeK/H2/ASj/9BVrxpdF94EbvVmFAOo9WH5CJDKydifohBw3X7AcbWJuDJmsvp5god2V4bfQusXimlKfBC8tqQ==
X-Received: by 10.107.150.201 with SMTP id y192mr56556663iod.33.1491819690786;
 Mon, 10 Apr 2017 03:21:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 10 Apr 2017 03:21:10 -0700 (PDT)
In-Reply-To: <3563ee7a-1175-2010-7176-0339cd3e60ee@update.uu.se>
References: <3563ee7a-1175-2010-7176-0339cd3e60ee@update.uu.se>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 10 Apr 2017 12:21:10 +0200
Message-ID: <CACBZZX5jD0AhqZ8ucdicW=6s3=HPfpPeyne6jSVbZKnQ+sRZkQ@mail.gmail.com>
Subject: Re: Git documentation on branching.
To:     =?UTF-8?Q?Samuel_=C3=85slund?= <samuel@update.uu.se>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 8:56 AM, Samuel =C3=85slund <samuel@update.uu.se> w=
rote:
> Hi all.
>
> I just started playing around with branching in git.
> I have been using it more or less as Subversion until now.
>
> One feature with "git branch xyz" and "git checkout xyz" that is rather
> obvious if you know them but bit me a little since I did not, is that
> uncommitted work in progress is not affected or saved when switching betw=
een
> branches. Thus I cleaned up the directory when working with the branch an=
d
> now I'm trying to find a stash where I hopefully have a copy of those fil=
es.
>
> Would it be possible to add something in the documentation to warn others
> that uncommitted work is not saved or affected by branching?

The main UI in git for switching branches is "git checkout", and it's
mentioned in the second paragraph of the documentation:

"[when switching branches] local modifications to the files in the
working tree are kept, so that they can be committed to the
<branch>.".

Did you read this and find it unclear, and if so can you elaborate on
what the confusion was, maybe we can fix the docs with that in mind?

Or did you read some entirely different docs (what docs?) where we're
perhaps not mentioning this as prominently?


> The first two hits on my google search was very informative about branchi=
ng
> but I did not see that specific nugget of information (I might have been
> careless reading, but if I did not see it others will probably also miss
> it).
>
> Git - git-branch Documentation
> https://git-scm.com/docs/git-branch
>
> Git - Branches in a Nutshell
> https://git-scm.com/book/.../Git-Branching-Branches-in-a-Nutsh...
>
> This is my first try to contribute to the Git community, I hope it will b=
e
> useful to somebody.
>
> Regards,
> //Samuel
