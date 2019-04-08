Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D302620248
	for <e@80x24.org>; Mon,  8 Apr 2019 13:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDHNTM (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 09:19:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53357 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHNTM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 09:19:12 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so20559131itf.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=94qYuubtbeNkWAWJWY2KOG3m6CP4hydorwNNsR9R9Vs=;
        b=p0Q1uf8rngfPWOuMvrP2E0k5IqtiJlpg3BP6AGxdRoa1Gtzk91pqBK7n4aOjXgtEYm
         th3XoHGs+auzxdmEs2MHtQxZDGoLFUCazZmEEbtPbWD0sIOA382b4L/kk21wgapOzhZP
         LLAFp5AHkG+p8nxO0CZU7i2KKQsRo14rqZ/m243LbgXIbEQ5Y6XyNDJAFQriRjzKu9rZ
         LZN86/YjLWuwqfXAdsGJoTgy3nR9+WDKMHAPFrarZ4RiX+FNgx+04GheL9EHk1HxbjoQ
         b+DILdoxbCavDW/Bpq4dI8JHAHCpWB8Yw+cmXqDsE6/zQjAM9ysvoISQQ9C758WIpuUZ
         0OMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=94qYuubtbeNkWAWJWY2KOG3m6CP4hydorwNNsR9R9Vs=;
        b=oLdFBrRtkdKH+xl5KHtZFFyZ0GjDVwC1CmcSBEOXrJTGW7iCEHkU6I4zLT8Q462hkF
         6tDES8UmlHUu1guOruLiTL1fR6HnjbOTO7DN4GdGg8KuifxqiD8hnj/ppAMvZ0ugX7HE
         Gc3nxoivmVxzE9knE14YyEV3jy62Hba+clh+RSv5gXja4VdKvXyZCvOYRaAPS3y77XZy
         Jqx57/EG1f276bjfZvCrWb26qlcdkDWu5ESnpWzzOaQ31NtqC/9qygrD3DOxKTjLjNia
         rhsg+9+n6Zkk8XN/RmxuTT0X5ZtsAS0I/fDbOrToX8Cx6Sk7/heKhe5Zl9iC8iuWPqaD
         VfKw==
X-Gm-Message-State: APjAAAX5cim4mO/yIAp5QCVe0dLVIp/nAdzrikF2VQqnkQ4W32aMOJd2
        Kup9NZdSVPbumwcv7fZcwD0hJMBKVZvGIQud9kw=
X-Google-Smtp-Source: APXvYqwehaDwcSCw4sw9jVgGaTr8MXvwywgUo/sLMaiJTD+Fwk0M7Gv6CdA+/h0Qtu01tuMPXqgHPCiLtKw8novIGB8=
X-Received: by 2002:a02:711f:: with SMTP id n31mr20186409jac.126.1554729551490;
 Mon, 08 Apr 2019 06:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190406131200.xcd7gtf7dlc567uh@doriath> <xmqq4l79cmb4.fsf@gitster-ct.c.googlers.com>
 <CACsJy8B_-r-=LxzvdnY44H7Bnydijqu4+GvWOy3r+hP723uezA@mail.gmail.com> <877ec4acdo.fsf@evledraar.gmail.com>
In-Reply-To: <877ec4acdo.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 8 Apr 2019 20:18:45 +0700
Message-ID: <CACsJy8BtZrP4T31cwPvoUfhpUfNGgXb624uQaZMFB8wOpKjFxQ@mail.gmail.com>
Subject: Re: Pull without fetch
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 7:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Mon, Apr 08 2019, Duy Nguyen wrote:
>
> > On Mon, Apr 8, 2019 at 8:34 AM Junio C Hamano <gitster@pobox.com> wrote=
:
> >>
> >> Damien Robert <damien.olivier.robert@gmail.com> writes:
> >>
> >> > is there a way to do a git pull without it running git fetch?
> >> > Looking at the source in builtin/pull.c does not seem to indicate so=
.
> >>
> >> The reason behind that is because it does not make any sense for
> >> "pull", which is meant as a quick short-cut to say "fetch && merge",
> >> not to run fetch, especially back then when 'git pull' was designed,
> >> the world was much simpler.  There was no "fetch && rebase", our
> >> branches did not know what their @{upstream}s were.  In that simpler
> >> world, what you are trying to do would have been:
> >>
> >>         git fetch
> >>         # did I get anything worth integrating?
> >>         git merge FETCH_HEAD
> >>
> >> That obviously would not work for those with "pull.rebase", and I do
> >> not think it makes much sense to teach "git rebase" the same trick
> >> to read FETCH_HEAD as "git merge" does in the above sequence.
> >>
> >> Others may have a better idea, but I do not immediately see any
> >> solution better than inventing a new option to "git pull".
> >>
> >> Another and better option that may be harder to arrange is to make
> >> sure that a no-op "git fetch" incurs very low cost.  If you did so,
> >
> > Not exactly related. But I often wish to see the list of branch
> > updates since the last fetch. There's no easy way (that I know) to do
> > this unless you copy the last fetch's output somewhere. If this "fetch
> > at low cost" could simply read FETCH_HEAD and summarizes it like a
> > normal fetch, that would be great. And it should also be very low cost
> > because we only replay the last part (making summary) of normal fetch.
>
> The ability to have this is something reftables will provide (from my
> memory of a comment by Stefan Beller), which Christian Couder is working
> on implementing these days.

I don't think we even need reftables to implement it. The list of new
SHA-1 is available in FETCH_HEAD (at least until the next fetch), and
from reflog we know the old SHA-1 (or a new branch/tag, I think we
know too).
--=20
Duy
