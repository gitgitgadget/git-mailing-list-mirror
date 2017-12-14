Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED361F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbdLNV3C (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:29:02 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:38293 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbdLNV3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:29:01 -0500
Received: by mail-qt0-f173.google.com with SMTP id d4so9792481qtj.5
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 13:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bPIha0QRWv86llTnQmbjZOUMsmilQHamp5mS6KqFPn4=;
        b=mqYoFc9tAHpBCSBbJ9HzW615NU7zQOUVAkpBXxmU+61e3yHfjtEU+n7RsePOD4N6pa
         vgxF2xyB3c64HUj0PupIbLEz+mDl18ilGA/2G4c+DmE5XbX5xF7P3W6DJB/lH6OudAUy
         9PApQ09CMNcVls4Fo+KLpSH8bwVMZRtgz8AvYkN//UlumedrPLM5ERtZpnuk/3yLlp/A
         7xkAnG88JetSy6X5O7APTUNsxg2BONf6TUwdDihKfjcV4Z4rrTVjLTAUEumNAs1vdlcb
         8EpE1t6aatSxKsUdrdifzWBM0gfWl/mypOzP0BHKPIR1QkEh0/PnVaeUGkOwkog1FzsE
         Tb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bPIha0QRWv86llTnQmbjZOUMsmilQHamp5mS6KqFPn4=;
        b=dbINXPgSN/Tdq1brXkXU9r0s+oqZhZw7MbzbVPXve2aHU4+hp1r4ZrbUEOtIrsojml
         cPsLh6rEdJyaTTeHUiQsvUNJNfysdjDMn56bMOrCQ39S6XSrtkt80drhOQFzTBH7Zppv
         WYMoErbLFtJ7cAAgqm3lunGUKIai1uBNAl6Tn+bQ+aT2NOH83VaPrwUDrtyK9CDaA4YX
         ocgTRecHmzANRlx/SnGHdu69x3RLuEMeQy2YIpPaM3JhzZVXZkxW2zBmVXfJvhV6cK3+
         gCkAXRk9bE1jmDkba/XygS9Wca5t4N3pmEAj10d6wKlSpsyhEQ5KCwU/VgzbZeXnOICr
         ZHTQ==
X-Gm-Message-State: AKGB3mJr6qjLbukT0jw3x/PufqssxnKc/tr1Of/zMIfPG6BJeztSkcf8
        XEUaPdMwKWiqg7uWi8OJ5InTthcy12Xcp12ybRDang==
X-Google-Smtp-Source: ACJfBovAMTPtPJhriXSuk95CfkMVdKsYQdZtsjKw5txPgq9msCxdvogeEPEijgF/rD4LTppYlvvJyIRowlPyYwF+byc=
X-Received: by 10.237.42.22 with SMTP id c22mr17856573qtd.162.1513286940377;
 Thu, 14 Dec 2017 13:29:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 14 Dec 2017 13:28:59 -0800 (PST)
In-Reply-To: <E1ePark-0008P4-Qx@rmmprod07.runbox>
References: <xmqqfu8dt7wc.fsf@gitster.mtv.corp.google.com> <E1ePark-0008P4-Qx@rmmprod07.runbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Dec 2017 13:28:59 -0800
Message-ID: <CAGZ79kbgbLEOTY9ziWz7gkUFKfpNVsZp5-r-jzd15PQ7iJZsGQ@mail.gmail.com>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
To:     "David A. Wheeler" <dwheeler@dwheeler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 14, 2017 at 1:16 PM, David A. Wheeler <dwheeler@dwheeler.com> wrote:
> "David A. Wheeler" <dwheeler@dwheeler.com> writes:
>> > Why is "index" better? It is a confusing name, one that has many
>> > other unrelated meanings.  In particular, many projects managed by
>> > git also have an index, but few have a staging area.
>
> On Thu, 14 Dec 2017 11:40:51 -0800, Junio C Hamano <gitster@pobox.com> wrote:
>> That's an absurd argument.  A database product that wants to be used
>> in library systems are forbidden to have "index" because that may be
>> confused with library index cards?
>
> No, because most database systems aren't designed to be primarily used
> in library systems.  Even if they are, I haven't seen a "library index card"
> in decades (many people will not know what they are), so
> that is much less likely to be confusing.
>
> In contrast, git is widely used to manage source code (where "index" often
> means "array index", "hash index", and so on) and/or HTML
> (where "index.html" is pretty common).  Using the *same* term for something
> git often manages *is* confusing.
>
> Even if you don't buy that argument, I think most newer users find the term
> "staging area" simpler... and we are *all* new to something at one time.
>
> A Google of git "staging area" returns 67,000 results, and "staging area"
> is *much* newer terminology than "index" and has those hits in *spite* of
> "index" and "cache" being the historical terms.
>
> Is there a term you'd prefer over "index" or "cache"?
>

I would personally prefer to drop 'cache', as the mechanism involved
is not a cache from the users point of view. (A cache is not affecting
behavior except for performance. In Git this "index" does affect more
than just performance, it also allows a very specific workflow.)

Personally I am indifferent to whether we call it index or staging
area as long as it is consistent. Junio mentioned the 'X acts like Y'
is different from 'X is Y'", so maybe we can use both words, as in
"Use git-add to add files into the index, which is used as a staging
area for the next commit".

Note that this discussion seems to be quite old (way older than
my contribution record):

    $ git log --grep "staging area"
...
commit 11920d28da1ac1b65eb4041c1b7355924e5d1366
Author: Scott Chacon <schacon@gmail.com>
Date:   2008-12-01 22:14

    Add a built-in alias for 'stage' to the 'add' command

    This comes from conversation at the GitTogether where we thought it would
    be helpful to be able to teach people to 'stage' files because it tends
    to cause confusion when told that they have to keep 'add'ing them.

    This continues the movement to start referring to the index as a
    staging area (eg: the --staged alias to 'git diff'). Also adds a
    doc file for 'git stage' that basically points to the docs for
    'git add'.

    Signed-off-by: Scott Chacon <schacon@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
