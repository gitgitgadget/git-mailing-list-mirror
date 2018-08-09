Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136C71F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeHIXy2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 19:54:28 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:40858 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeHIXy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 19:54:27 -0400
Received: by mail-yw1-f44.google.com with SMTP id z143-v6so6700756ywa.7
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESrmjj1m512xuczbxYl7XCldbdPQEz+sv63snlLueZ8=;
        b=fo4isbLLnmB+P1WMxtMqCuocgaMT6Iu/sawDzCggzuYVVcMBYSsUfed1qcSzUXaRFf
         ZlY3MmS9HO+BEQjGi8iX7ONRMkKI2cq8YDkWl3PpvW3d1VwZ+egx1JyJhbAjpHlIfmnk
         RRc01+rKTfsidUyD0RLJLruYvwrZZIkiCz7pO3md6PtBTo66GgpHDUzeuJbXeZPNsgOq
         q9M8bLh5VCSzvtWgJsNbPHczudlmgEaFV6csGOjJWvAC3b9QluTGZVwJFV2RoGcXX8sp
         GMDPFLHjtidiMYbzxB/bS273iuZDvrxVydX8Fwq8W3Ss3VmSDXx8bINlCdNAwsOLsZQd
         BMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESrmjj1m512xuczbxYl7XCldbdPQEz+sv63snlLueZ8=;
        b=XchjWWjwce83nfe13RZegzPYIsKLtzfeW0FnZFHgVmggCrrZuWOGi23vOsFB2gyi14
         vSuWy+OuPksdJhgm3fHWh9f3W/+dXRS1uFeRtyYfSnXG+SX05NkanTcwRyyFm/vmOYo8
         Mbu3h0j/jh+lCrvDGR9ERfsLAVat4Am2170c7vGm2Ly5j/Nr+zfrPtt6Sdz4qzmAMhwp
         pzDdcE7o+SJStOjHufDn3mq4NKOe0N7whsXbowTmhsAxd4lMMa5n3xj5vqQkRSgI0hvw
         37CseERgOfw3JxBgpdYYKJc5bOiXuPtikm6XqNlGL6OrWyLcf+EcGSRds8CrSwRch9++
         wxDQ==
X-Gm-Message-State: AOUpUlFHVy04bO/LK+KgGnU9gMWoWanyzJCMlzWQMIUCDGVxokKRNbOW
        TahWO6qKRoillFyFLGsety7/hjaMb+6ReO3cbxCDwtJM
X-Google-Smtp-Source: AA+uWPyEORb4a03sGTM+BVY4UXP8QSXep6Zc0rDHPZx2pjgnJfJ1dm+kTPLfSslc/wZr3RcQIlg2LkFlXQD96WlSY/Y=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr2582295uaf.199.1533850065968;
 Thu, 09 Aug 2018 14:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
 <20180806224547.8619-1-newren@gmail.com> <20180806224547.8619-2-newren@gmail.com>
 <xmqqbmabcuhf.fsf@gitster-ct.c.googlers.com> <CABPp-BH8oiJ17K6OHCikAxk8Jy9M7mSA=WCVX9KosTC+p4rE4w@mail.gmail.com>
 <xmqqk1ozb6qy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1ozb6qy.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Aug 2018 14:27:34 -0700
Message-ID: <CABPp-BG1t3hJsVWDKwy-dMM-CTY8voQfN=ebQ+BpJyJHSJ=gvg@mail.gmail.com>
Subject: Re: [RFC/WIP PATCH 1/1] merge-recursive: make file/directory
 conflicts easier to resolve
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 1:54 PM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> >> Of course, "git rm" and "git mv" must work sensibly, if we want this
> >> change to be truly helpful--but if not, they need to be fixed ;-)
> >
> > That actually brings up an interesting question.  Right now, if given
> > a path that appears in the index but at a stage greater than 0, git mv
> > will fail with "not under version control".  Obviously, that error
> > message is a lie in such a case, but what should it do?
> >
> > (Alternatively, if there is only one entry with stage greater than 0
> > and it has no other conflicts, one could envision git mv doing the
> > rename and dropping to stage 0 at the same time, but that sounds a bit
> > dangerous to me.)
>
> I do not particularly think it is "dangerous".  In fact, that sort
> of behaviour was what I had in mind when I said "work sensibly".
>
> When resolving a conflict that they added a new path at stage #3 to
> remove that path, I can say "git rm $that_path", which removes all
> stages of that path and make the index closer to the next commit.
> Or I may decide to keep that path by "git add $that_path", which
> adds that path at stage #0.  I think "git mv $that_path $over_there"
> that drops that path at stage #3 to stage #0 of another path would
> be in line with these two.

This argument makes sense to me *IF* there's no possibility for
internal textual conflicts.  But if there are textual conflicts, I
don't see how it works.  So either I'm misunderstanding part of what
you're suggesting or you may have overlooked that case.

Let's say we did want to drop to stage #0 when the user runs git mv.
I'm assuming you agree that'd be bad to do if there were still
conflict markers left in that file (which can happen when the file of
a D/F conflict came from a renamed file that had edits on both sides
of history, for example).  That suggests we have to open and parse the
file and look for conflict markers before dropping to stage #0 and
only proceeding when none are found.  That feels a bit magic; this
auto-resolving-upon-mv seems to risk surprising someone to me.  In
particular, I'm imagining a scenario where someone edits some file
enough to remove conflict markers but isn't satisfied that everything
is semantically resolved yet, then runs git mv on the file, then
starts working on other files, and then tries to come back to the
original file only to discover that they can't find it in the list of
unmerged files because we marked it as resolved for them.

Am I missing something here?
