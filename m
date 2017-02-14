Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81AF1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdBNXLT (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 18:11:19 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36682 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBNXLT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 18:11:19 -0500
Received: by mail-it0-f67.google.com with SMTP id f200so7858954itf.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 15:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jKQYHZnJnaJLfke42NTPFH5sv37HIcdF+DtHK/5wO5A=;
        b=eo/ngO+xh7AnuCKNtGzzn0hiWq+WyQ1KlMm7hMlr15rW0oB1UZD4D86XJWehXsVWBn
         X2AT4vtXTclp2HZnP3kz5xNac41ZQFDGb7TI8HCpX9n35zGZ52iPttejoVNV9Oy5fP7e
         8ntt0pJCC+oyyzp6kefkHANna5avSDxp9+CecYegqUlXcyaF/L6/NsLSY564FwQJikk2
         T98pEGIyymFGNoDs8ReY36b0LxVroByVUHq2sWTcqxWYTlg/1WRpdjqpi8gMjO4j/ZJk
         GRJHXLUDgm8EI2LOR9c9D/A6qN0u4wvJeIe9jJO+HNeSPjo3gUWFh4cRyrGP4ZcxJgJq
         B78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jKQYHZnJnaJLfke42NTPFH5sv37HIcdF+DtHK/5wO5A=;
        b=IEysyHdPmDowJ8PGoQtHOARmHrbzjzfaJqXmBX6J6DXh7L5wDvUMWGL0PoEuuCt86Y
         Tq4e0RpqpwSLWJYlbojNs9gMY+PwgobetsbzPcKNh9B0PFaDK7MBC4+AVf/Ryvk6oBKc
         83Nh2nhdyjfwNP8sV89ATeiniBifdzayeR0BeWwvOe+QtXg6UQD5PLx2nIKw+IjKICn0
         A4CgPZNrpzvmsS3z/sJEHSh9ohaWVOl/cKg0TubaIxQXkpNdxHFYxLQfznDhC8Zr7Wyk
         GJ3ViglTPoOldiPeCEgd6DDk/s4uoV/Cpw1iEU4IFzt1ENMtw8rvt/TUP5pfZ/HSaFIN
         yeJw==
X-Gm-Message-State: AMke39ns90T1oB2tCgIPENPs1ePlY7oVe6QTQzhx2/BcJ8exXZBEnP6g14wfveYGtXp1Mw==
X-Received: by 10.84.178.7 with SMTP id y7mr39099383plb.60.1487113877934;
        Tue, 14 Feb 2017 15:11:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id r8sm3158685pfi.82.2017.02.14.15.11.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 15:11:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox>
        <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702142150220.3496@virtualbox>
        <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
Date:   Tue, 14 Feb 2017 15:11:16 -0800
In-Reply-To: <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
        (Christian Couder's message of "Wed, 15 Feb 2017 00:00:56 +0100")
Message-ID: <xmqq1sv074h7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> By the way it should not be very difficult as a patch to do this and
> more was proposed a long time ago:
>
> https://public-inbox.org/git/4D3CDDF9.6080405@intel.com/

Thanks for a link.  The one I found most interesting in the thread
is by Avery [*1*], where he explains why "first-parent" bisection
makes sense in "many people develop topics of their own, and they
are aggregated into an integration branch" environment:

    Basically, we push/fetch *all* the branches from *everybody* into a
    single repo, and build all of them as frequently as we can.  If you
    think about it, if you have all the branches that someone might have
    pulled/merged from, then you don't have to think of the git history
    as a whole complicated DAG; you can just think of it as a whole
    bunch of separate chunks of linear history.  Moreover, as long as
    people are careful to only pull from a branch when that branch is
    passing all tests - which you can easily see by looking at the
    gitbuilder console - then playing inside each of these chunks of
    linear history can help you figure out where particular bugs were
    introduced during "messy" branches.

    It also allows you a nice separation of concerns.  The owner of the
    mainline branch (the "integration manager" person) only really cares
    about which branch they merged that caused a problem, because that
    person doesn't want to fix bugs, he/she simply wants to know who
    owns the failing branch, so that person can fix *their* bug and
    their branch will merge without breaking things.

[Reference]

*1* https://public-inbox.org/git/AANLkTinwbm9gcZhGeQCbOEPov0_xV7uJyQvC7J13qO15@mail.gmail.com/
