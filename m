Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D4F01F463
	for <e@80x24.org>; Mon, 16 Sep 2019 20:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391323AbfIPUWM (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 16:22:12 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53271 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfIPUWM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 16:22:12 -0400
Received: by mail-wm1-f46.google.com with SMTP id i16so726329wmd.3
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kbdvC0ThB2Cm9UvjNyMRE8+VHY8gdWGbcyVp4Vu8Gts=;
        b=R0uyL0a6poW2m4B1DqibqGknstD+agTmm2WQ2qbj5vo1ABN7GxWHQL+knfR4TD8dsy
         KTEZgGpdASnvtIhILhE7GAE6TCcbSalpZi5WteBHHeONxOHVRcnkfQxCKUCqlj0rc39v
         o5jm/FlMWSoo5bX01tGoS3ccl22JWE3gvPJj70Gcl45Sy/SwXd9AhiZkejmPiohuzdo7
         GNh6BpXujPBqIe1xlKpJ/iXqudBa2prjXvBeWyRaeUo5P8Qb6Yv6bGr/agq1sbO5cpuo
         PZOwYoFCuemCu+Ff/XxWWAmnm9/2IMimb0OvpXEr1yhBXwbnHedFfi8yBoievD+0I1WF
         gphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=kbdvC0ThB2Cm9UvjNyMRE8+VHY8gdWGbcyVp4Vu8Gts=;
        b=LEc202a1BQ3eCWD1VxcZBFTVWgbMtj2uAQwV45XTAK3OdCtbFSRZ0q0UJtLae6ftYV
         htV/sVRliwsMytWzeBWtZBzADMiLgHwTIDVf/TKd92hDOpgPxxigCWuiEaEUW71GfHNB
         spnDU/HPn5VcYuXNIeaI+TbWQTO4nC50HDU0opoZBjKgMiR4uNu+8O6w1+Ox8tPbYKg7
         ZpLbJktgsSwd+skKMyYV5CriY49NVTYmjrl28yab+VXcRYjkugnfnkAR/sEy4roOPQqb
         cCwD6fCYhP6tKSyFVUz5VaNweD2U6JpzXms89ASMzGppc/Jf6ENdUyM97N1u4WpstO/B
         B1pA==
X-Gm-Message-State: APjAAAVNsJ+zWQfwBmOow54g0cg4StS1DOJZ0iQts7k9+lJ14bdxo15y
        febE5VfnshsQNAGrVooLuMxlXI5jHVyPj9MxuWpRpQ==
X-Google-Smtp-Source: APXvYqyNvl+PVKaPVxFLsFlndZrSE+ykDOs0cMAW8kORfu773WE8T5REFyPMcIuDliLCuJyAqM1JpuvIaXo8G7FHVQQ=
X-Received: by 2002:a1c:f317:: with SMTP id q23mr601241wmq.33.1568665329006;
 Mon, 16 Sep 2019 13:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
 <CADMnYXDWwq2DN59qnkS_P31S+-NJZTzj2TMzps5KKQ7McxpO1Q@mail.gmail.com>
In-Reply-To: <CADMnYXDWwq2DN59qnkS_P31S+-NJZTzj2TMzps5KKQ7McxpO1Q@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Mon, 16 Sep 2019 22:21:55 +0200
Message-ID: <CADMnYXCRn-wcVeJ5z5W1CSwe0BKQxRrz4R8+=6UAAW_is3yEdA@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Many of you must be disappointed by the recent revelations.
However, we just figured "Gl=C3=BCck auf" ("Joy on top") makes "Ruhrpott" a
safe bet for unsafe sex.

Cheers,
The GCHQ

On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <klausem@gmail.com> wrote:
>
> Hello all,
>
> We know that this is for a technical-savvy audience, but as we are all
> people with a soul, here comes a combination of both, the logical and
> the emotional first waves of the GCHQ-propaganda-war.
>
> First waves of the GCHQ-propaganda-war:
>
> - Logic: This is the first wave of a propaganda-war, false from
> injust-people gets us extinct in the long run.
> - Emotions: We are precious, no pretentiousness, abuse, scare and
> disgust. Everything where it belongs.
>
> Cheers,
> The GCHQ
>
> On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <klausem@gmail.com> wrot=
e:
> >
> > Dear all,
> >
> > We texted a README.md on a new project hosted on GitHub, promoting but
> > not yet implementing a "friends-based search-engine", hosting the
> > complete WWW in the future, thereby reshaping GIT and HG also. Now we
> > figured we'd like to advertise the project to you directly.
> >
> > https://github.com/ksemb/Ethnics-Ess-Nix-friends-based-search-engine
> >
> > Please note that appropriateness is triple-solved to be necessity,
> > constrained to knowledge and feasibility, making this a perfectly-fine
> > email.
> >
> > This is the first wave of a propaganda-war, false from injust-people
> > gets us extinct in the long run.
> >
> > Cheers,
> > The GCHQ
