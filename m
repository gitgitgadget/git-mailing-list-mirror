Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DC31F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 19:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeK1GYE (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 01:24:04 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45003 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeK1GYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 01:24:04 -0500
Received: by mail-ed1-f52.google.com with SMTP id y56so19983962edd.11
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 11:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8IowKUkxlEWlXkhwYrJxq2gj8Niiskwn1jpSwz+IRMA=;
        b=Nd0xo7hmmL/RH9SL2W5zYdOZPHN2+J1eDBynLWWzVctaXVjsLzeLn6WcLrzFjEkwAz
         fCqbWi0BQjCvgKRLqvTdx+8gBN1Yie41whuWaFNdz/zvS30tjVPcI0O0E5An/LossLYO
         E3wQiaeJJVTc8pvourW+bZt+TmVQYo6Ws/YYpdDn01hQnighmZLS9AXe4LIuE8uQ36FG
         LiLymzCgr85+AEPlLVxgYnolTvZpjifV6/vZegi5wqOs3EIoW2Ajtu6GdJXvH6pAhz2a
         ej9VWmFUD0pgPD6FbHFmi6qWz2rxRjt2S+j/f9itVb5q0rfdfVcyBYVaEqeMVGh9+Ve/
         g8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8IowKUkxlEWlXkhwYrJxq2gj8Niiskwn1jpSwz+IRMA=;
        b=tRzmjFmgkjKigsLc6PIBwzSQlIxJpaw7i0uHyV7leCkutdHfXIYM0JmpxIyCS0XbFN
         /qrBsgdtwpMODRRZiNx9OqzmGN25nCyXLsQg1srGf/RcsiOmbbOGXo4/rEMtUeZxr48V
         t5tIyOa24ztx+Xe9cXmRemwynfnzphyAAKJ/odw7/odlaKUEYDWkS4Cqg3iM7jko/srQ
         /OjgRfJr0GHaDUu/wTRnEuMbclCWsBdWsRCqS+9YoxGEaLzEcspSjlozEmCkVkLWO7/w
         vCD7RiCxx4p4+0KpYHEfBvXiVwBdUXVKQrNsV7Ak/1zwELl8fHrBg8vpVT5EbmzGritp
         WnDQ==
X-Gm-Message-State: AA+aEWYNbkaWmfjJma2Y7fHQoHJwGDy8JMgteowMCs+ZtBOXJRYFT1TS
        yqxyi3EiEs+ax2c9xkJA2A1CUO7+3XqyxZWC3cACJw==
X-Google-Smtp-Source: AFSGD/VbJ+cq3Qn4It4wHul9Ia4Hr3Hv+SO5EP+9ZeDBZurMnntZo8fMA7/MKVAPbaPel5AHLV+qX9baQQZMCTq9KQY=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr27427491edc.76.1543346707446;
 Tue, 27 Nov 2018 11:25:07 -0800 (PST)
MIME-Version: 1.0
References: <758FA299-0842-4462-8CF6-D7210D26A6C7@gmail.com>
In-Reply-To: <758FA299-0842-4462-8CF6-D7210D26A6C7@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Nov 2018 11:24:56 -0800
Message-ID: <CAGZ79kbDHyzFF-HtDcD=rOLZB+RFRnVqZgXb9uwm=9_m-6E0QA@mail.gmail.com>
Subject: Re: Git pull confusing output
To:     william.duclot@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 8:52 AM Will <william.duclot@gmail.com> wrote:

> And even them, do they need this info every time they push?

I agree that we should make the output a bit more user friendly,
which means we'd only want to output relevant data for the user.

The different phases taking each one line takes up precious
screen real estate, so another approach would be delete the line
after one phase is finished, such that you'd only see the currently
active phase (that can be useful for debugging as in "The phase of
'Writing objects' takes very long" -> slow network connection).

> I feel like a less intimidating output would help, while showing info
> about objects and deltas with the verbose flag:

I agree that most information in pushing is not very useful
and could be omitted. This helps in multiple ways:
* it keeps the focus on the actually important information,
   see bf1a11f0a1 (sideband: highlight keywords in remote
   sideband output, 2018-08-07)
* less space in a terminal wasted, such that you can scroll over
   it better

> > Compressing=E2=80=A6 done

After the push succeeded this information would not be useful
any more, it is only useful during the compression phase
(Does it progress quickly enough? or does it error out?)

Slightly related (but applies mostly to fetch, for which this
discussion can also be had):
When fetching, these informations are generated on the
remote side (as the server needs to create the packfile
according to your local state that you negotiated with the
server), which takes some time. Sending over this
information also keeps the connection alive. This is only
relevant in corner cases depending on the setup of the
hosting provider/repository, but it led to commits such as
https://eclipse.googlesource.com/jgit/jgit/+/a38531b21c7e2b0dc956e0ed1bfc95=
13f604273c
in the java implementation of Git.

> > Pushing to github.com:williamdclt/some-repo.git=E2=80=A6 done
> > 1ca9aaa..4320d30  master -> master
>
>
> I=E2=80=99d be more than happy to work on this (`git push` is an example
> amongst so many other), but want the mailing list=E2=80=99s opinion on it=
. Am
> I wrong in thinking that this output is not something users want, am I
> fighting windmills or maybe just being ignorant?

I think this would be a useful patch, but it could get complicated
quickly: push uses other low level git commands to prepare the
packfile to be sent to the server, currently it only needs to pipe
through the output of the low level command (or even have the
low level command directly write to the terminal).

The output of those low level commands should not be changed
when run on their own, I would assume.

So maybe the best way to dive into understanding what happens
under the hood in git-push is to run

  GIT_TRACE=3D1 git push ...

and see what child processes are invoked (e.g.
run_command: git pack-objects --all-progress-implied)
and then we'd need to change the output of iff the
specific progress flag is given.

Stefan
