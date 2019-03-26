Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913E520248
	for <e@80x24.org>; Tue, 26 Mar 2019 15:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfCZPBi (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 11:01:38 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45196 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZPBi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 11:01:38 -0400
Received: by mail-vs1-f68.google.com with SMTP id n14so7781612vsp.12
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9TI1Uh5RJ7ppQdl/nsoyzebEvwprkXM0LWOfk1DBTLo=;
        b=HXpOzB0rORhzI7TgeZZ+V46vZL7Vv4JTlF8MoAJoL2JRCbpKPQA3TKr+SBeorjX+HT
         TfiJJhbFJgySRCiEq1dbBkVbEkHmEFol10YLibItuZ5Q9ZpuSutN7H3HtmSHL6qnpHpa
         vpcp1ErPTZvFPsskwAwQKLtDL0GEA3p7uh8C51ad9eat+0IGAYEBrDt3qSzPjjt6Aw7C
         V8wkuX4pycnaBvQv3lJnJv56cD5g7b4JBmATACEwsozb8dgyuncmLOIX4MOKFeh3IRHL
         0aTcAyJ01tM9rslFd85qDtURiMQ0cbaHPmlMU6j3LU3Dlo6OPIRcj7b1fgl65z7NGLIb
         PBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9TI1Uh5RJ7ppQdl/nsoyzebEvwprkXM0LWOfk1DBTLo=;
        b=hMlPPG1NJcCR9YitaZpIMqvx45CxBEq5vGQYCr9IIHtTGUYPV108aKTkqmMBzxXOwa
         RsX7IRNjw5Y3mlyOBxUnn50xjdo+Kq5Hu1i8xppU8GxMWtyY+Za99wYloqFuuk8fr8KY
         acO6AWx4MBljZ/RTEkdMj2hkOC3fai4lnDJiUUpTy+D1i7vv8Ffs/OgoeJ0fnFD0WRgg
         cbeAN7uJAAU2k/s+CsY9Lergkq+oeHRPML5bj3aTt0DUyWuwECoqNon2VwKJdzx7t95w
         p/ABmNJld1sSVp+VaDoR1gFgnzWbzqy3/SY2Q+AFBxjmSJqjCtExVLhoC38m7EEHvp/x
         etJg==
X-Gm-Message-State: APjAAAUWqZAnhevRNAwTHrEmhdxACwKb6jLwmi4s2OzMoObFZQrDsBLK
        JfrMYQi8heOZM53WeYZQBkzHCSwpAURA9DVOtYI=
X-Google-Smtp-Source: APXvYqxK0+wQouE/eudZ8mKyQ808Ce5EQ0R544R4QRGPUYgrgtnVf9ZjLT9DFWcc4jszGfSLhrSpPpbffhyImdgI4rg=
X-Received: by 2002:a67:ad0a:: with SMTP id t10mr19208072vsl.117.1553612496802;
 Tue, 26 Mar 2019 08:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
In-Reply-To: <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Mar 2019 08:01:24 -0700
Message-ID: <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 5:50 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> =
wrote:
> > On 08/03/2019 09:57, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > > "git checkout" doing too many things is a source of confusion for man=
y
> > > users (and it even bites old timers sometimes). To remedy that, the
> > > command will be split into two new ones: switch and
> > > something-to-checkout-paths.
> >
> > I think this is a good idea, thanks for working on it. I wonder if it
> > would be a good idea to have the new command refuse to checkout a new
> > branch if there is a cherry-pick/revert/merge/rebase in progress (with
> > an option to override the check) as switching branches in the middle of
> > one of those is likely to be confusing to users (if I do it it is
> > normally because I've forgotten that I've not run 'git whatever
> > --continue').
>
> Guys, I'm sorry for bringing this up again. Apparently I'm not quite
> done with 'git switch' yet (not sure if I will ever be).
>
> There is an interesting behavior in git-checkout (and of couse
> git-switch). When you do a successful switch, CHERRY_PICK_HEAD,
> REVERT_HEAD, MERGE_HEAD, MERGE_RR, MERGE_MSG, MERGE_MODE and
> SQUAHS_MSG, if exists, will be removed.
>
> This basically means that if you switch away, any cherry-pick, merge
> or revert in progress is destroyed (in the sense of "--quit" not
> "--abort" of course). All of this, I believe, involves merge conflicts
> so you can't easily switch away unless you allow to destroy unmerged
> entries. So it's still quite safe.
>
> However, it leaves me a funny feeling because some "work-in-progress"
> operations are destroyed, but some others (bisect, rebase) are not.
> This is git-checkout behavior and I will not change that. But do we
> want the same behavior in git-switch? Or do we want
> no-destroy-in-progress-whatsoever? Or
> destroy-all-commands-in-progress?

I thought we already decided that we'd abort the switch if there was
any operation-in-progress state?  Or are you asking what should we do
if the user explicitly overrides this error with e.g.
--ignore-in-progress?  In that case, I'd say that the reasonable thing
to do would be to leave all the state files alone.  If we make it
clear out the state, we're simply combining uncommon commands for the
user (<operation> --quit + git switch), which seems like a bad UI path
to go down.  Allowing them to switch to some other branch while
keeping all state files is something they can't do with any other
command, and while I hope people wouldn't want to do that much,
switching while keeping state files is something that can't be done
with combining other commands and thus at least makes sense as
something to consider providing.

> It may also be a good idea to attempt to describe the behavior we want
> in git-switch.txt. I think if the description gets too complicated,
> we're heading a wrong way. The current behavior so far could still be
> described as "work-in-progress operations related to merge conflicts
> are destroyed", or something along that line. But I'm not quite
> convinced it's easily understood.
>
> PS. git-reset shares the same behavior, but it's in a different boat,
> I think. Or maybe I should scrap/replace that one as well.

reset has traditionally been the home of
how-to-clear-in-progress-state.  e.g. aborting a merge or cherry-pick
or revert was 'reset --hard' (or later 'reset --merge'), skipping a
become-empty cherry-pick or rebase is still 'reset', etc.  So it's not
that surprising to me that it clears out state.  As to whether it
still should, we can address that along with...

> PPS. It may get trickier with cherry-pick which can pick a range of
> commits now, not just one. But I never used that feature much to know
> what I'm talking about.

Yeah, cherry-pick and revert and rebase all allow working on several
items.  It seems bad to me to abort/quit such operations without an
explicit '(cherry-pick|rebase|revert) --(abort|quit)'.  Back when
cherry-pick and revert only worked on a single commit, allowing 'reset
--hard' to clear state didn't seem that unreasonable even if it wasn't
the best UI.  So it all went there until people got used to 'rebase
--abort' and realized it was a better way and started spreading
--abort to other commands.  And you could kind of see us overlooking
that someone could cherry-pick --no-commit and then afterwards
checkout --force to put those changes somewhere else but I think it
was even dangerous/weird back then.  Once cherry-pick and revert
commands were extended to work with multiple commits like rebase does,
I just don't think it makes sense to allow reset to completely clear
out state files anymore.  Also, I don't want to check for one or
multiple commits and make them behave differently; I want git to
consistently require an explicit command-specific abort or quit (or
continue) to clear out the state associated with those
possibly-multi-step operations.  Maybe 'reset --hard' can continue
clearing out merge state just by force of habit, though I'd still
rather encourage 'merge --abort'.  But I don't think it makes sense to
let switch, reset, etc. remove multi-step progress state.
