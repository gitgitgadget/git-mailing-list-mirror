Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251621F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965490AbeBMSZh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:25:37 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:39764 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965217AbeBMSZe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:25:34 -0500
Received: by mail-yw0-f178.google.com with SMTP id v196so12959730ywc.6
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QkYYCWoLCsJh5FOV6jDT47LhTvbmwsKZlllO2ZyF5jQ=;
        b=HrRdFo8TXDzEN68cp1p2FPQK9SZbIIdMxB0bSUExIqCdD6Nfr6wonlApbGJZMcixRz
         JM9/bR6MRtWpCaIQOSEhZ5J6NUdYC839BZ4cf4rp9kD1xeQPglnV91b1dP8T3pJFAMAA
         /5MF1ELdSKSu38cxvBc73Vqa0E+vxIHAYARDEPrRpoHFtbs89IAFRO2YIgUyZEjWYADm
         ZtXy4phHf6i2tN76Es0YotHzONnEONl0oOBbmDHJhvaPSfsbqgkuwhXiudZMPkb+uLEc
         4SvTSEYdxyHBDVGf8cFqKJvpCvc4BXWQyiGVY9FEdAaZZykaOZDAJJXQAgI3dNpzCav7
         I1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QkYYCWoLCsJh5FOV6jDT47LhTvbmwsKZlllO2ZyF5jQ=;
        b=ILN91izbd6W2wOnQhONDiqDfGymkQjCrpJcHHNes3ZeLcVRRLAxECZXw3ss2kWVH6W
         M6InWLW6V68cyuOF86Tgv1uDMeBurC6EQWnekidfGRr0Nv1wBeFZ7rf2iqdrLIQNDI4l
         NgzRXtGvOi+E5ReBG5Ufo7OgSsU5yWGpZAyNL2I5YWz+Ea3yI20m2crVXjzJXFch71WQ
         wlpArNgfg4DWpQ0BjMW2BgCJL3hqspO/YJ4wDLb4Q7L3/KySOsj1EH/s3Z49Zi+7sG9x
         v5S+vRIOndMzoGxQwmqWRriWeZ41GrEoKJJCKzmBN620EQK/CNeVif8ZRuo6vlOJjKSs
         gLZg==
X-Gm-Message-State: APf1xPCmtB3SRvPMHntMkfb3OsVDolgIHIPBbcPRg7pftm//Dm9/WSh0
        u1xir/+P5jcow6JwMiuCsthlcQkeFG3K7JfM+M0rLGkN+IQ=
X-Google-Smtp-Source: AH8x226mjXoSscfG2x0UfQXp+vMErDAvKx6hzXm+UVptr4Oa/aIB2e77Y8Ph5bMjz2aByZ6vO1gJdtqxXzTnBYQ4zFI=
X-Received: by 10.129.57.134 with SMTP id g128mr1393003ywa.373.1518546332872;
 Tue, 13 Feb 2018 10:25:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Tue, 13 Feb 2018 10:25:32 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1802130746360.16738@localhost.localdomain>
References: <alpine.LFD.2.21.1802130746360.16738@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Feb 2018 10:25:32 -0800
Message-ID: <CAGZ79kYubKmmpg_aka=P0FMjQSqrYQaerq3=awwGRfW_H8H+Vg@mail.gmail.com>
Subject: Re: "git submodule" vs "git subtree" vs "repo" vs "git subdir" ... ?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 5:06 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   looking for general opinions ... i am (frighteningly :-) teaching a
> git course later this week, and one of the topics on the list is git
> submodules, which was specifically requested by the client as their
> idea of how to start incorporating child repos in new projects.
>
>   however, given the number of articles written about the drawbacks
> with submodules, i wanted to throw in a section about "git subtree" as
> well, even though (as discussed earlier) there is some minor dispute
> as to whether "git subtree" is part of "core" git, but i'm not going
> to let that stop me.
>
>   going even beyond that, there is also google's "repo" command, which
> i seem to see more and more often, like here for automotive grade
> linux:
>
>   https://wiki.automotivelinux.org/agl-distro/source-code
>
> and it would be a shame to at least not mention that as yet another
> possibility.

Please note that Google would prefer to get rid of the repo tool.
(It was made as a stop gap solution until submodules are good enough,
i.e. have comparable UX compared to repo. But as you know stop gap
solutions hold up for quite a long time reliably. :) repo has issues by itself,
fundamental issues such as the data model, as well as minor things like
complete lack of tests)

>   and then there are unofficial, hand-rolled solutions, like
> "git-subdir":
>
>   https://github.com/andreyvit/git-subdir
>
> given that the client does not appear to be wedded to any particular
> solution yet, i'm open to recommendations or pointers to online
> comparisons that i'll collect and post on a single wiki page, and they
> can peruse the comparisons at their leisure.

There are a couple of these. I came across these recently
http://gitslave.sourceforge.net/
https://github.com/ingydotnet/git-subrepo

>   so ... thoughts? no need to be verbose, just links to decent online
> discussions/comparisons would be massively useful.
>
> rday
>
> p.s. oh, pointers to well-designed usage of any of the above would be
> handy as well. as i mentioned, for "repo", there's AGL. for
> submodules, i might use boost:

If your copy of Git is recent, look at the man pages for submodules
such as d48034551a (submodules: overhaul documentation, 2017-06-22)
or 4f73a7f124 (Doc/gitsubmodules: make some changes to improve
readability and syntax, 2018-01-14)

>   https://github.com/boostorg/boost/wiki/Getting-Started
>
> and so on. thank you kindly.

Stefan
