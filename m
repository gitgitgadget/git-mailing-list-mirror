Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9761F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbdAYWLR (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:11:17 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:35161 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdAYWLR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:11:17 -0500
Received: by mail-io0-f173.google.com with SMTP id j18so25187316ioe.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9/7EeFvnNEWUlRJzPfyhCc3GPrgoIzpZSTF/ut4ZPHg=;
        b=GD7ZHMGVvA0ugVzq8l9VXoYuwOnMHsv7Wh2c7bns1aBof2qnG13/Yb9BJqVwAzS5Zz
         u61SYQ0llBqcGLbUmhtsCrmEWYktgFAZusq9KZnAf+vJvCPto55i1K8R4YaBLCs9L+6X
         6yTBcgYrVD9EImvuHUeAtvhBvAwiNxI6q3L/v10kBTUtw08USHDa9K25NF1tuGYRwwbz
         6oxZX7JRKZ/Cuyh1td/Rz7APD2jJDDNwpUvaLgB+61CjC+vgAmY6stnK1BxK7ouLiWT8
         N5K8dE2iYN1q81mT+xKodcxmWCZ+5xjVSKQpfHAjt5rO4WZRGIWr3jQ5ZqTyA/oLz67t
         YDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9/7EeFvnNEWUlRJzPfyhCc3GPrgoIzpZSTF/ut4ZPHg=;
        b=gAQ900jgssgQPJwhXl+yKUIPszAj2NHmLie8meodao6wZPPN1F9VlTmIBb9+5sKuuF
         8GCTTV0vnIkVBaVoK2I4lLOXlJULAxQ0MVS+aEz99FkcU14EUFWAJem00jyBkepMW78V
         hYNPMAEULYE9r8zps+A2tjKK3Cf0kpme83m66FoMqoXGbMyOKgnmOucbJd5iOp0PWeSX
         9j0KL6jDEfTmrnvUtP8DJZlpj1dDMEyu8Yx/Qt/dYcCZmyCMqHEgSO2pPeGDW45u87Ho
         qtflq7Yk3D1jOF3ntHLqOsFqKLJQPvpN85hF5/ae/ZhlIuehYSwG9Q4u7MThJYDyF8wp
         zNmQ==
X-Gm-Message-State: AIkVDXKDNUdDMgaeyYIM0JqsR56vCTfjgNTWdj0/Hc0q3m5a2whWE2ibtzytj7gzT+IVnP2dHy85/BXQ0i85I8KP
X-Received: by 10.107.3.160 with SMTP id e32mr159216ioi.52.1485382276111; Wed,
 25 Jan 2017 14:11:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 25 Jan 2017 14:11:15 -0800 (PST)
In-Reply-To: <20170125220632.whjnpvrnhve2h6f6@sigill.intra.peff.net>
References: <20170125215931.26339-1-sbeller@google.com> <20170125220632.whjnpvrnhve2h6f6@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Jan 2017 14:11:15 -0800
Message-ID: <CAGZ79kb_g5Wq=Aeo1RH-iA5M-drU5Gm1LAJZuPZU7oe=xdHaOQ@mail.gmail.com>
Subject: Re: [PATCH] Add more proposals to SoC 2017 ideas page. (lots of
 submodule stuff)
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 2:06 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 25, 2017 at 01:59:31PM -0800, Stefan Beller wrote:
>
>>   This applies to the repo at https://github.com/git/git.github.io
>
> Thanks. I've applied and pushed, though I'll admit I didn't really read
> it carefully for content. A few of the ideas look like they would need
> to be aggregated to be big enough for a SoC project, but that can be
> fleshed out in future patches (i.e., I don't think we care enough about
> history to have people polish and re-roll what are essentially wiki
> edits).

Yeah, I wasn't sure if the ideas were meant to also contain microprojects
so I wrote down everything that came to mind, that I do not intend to work on
myself over the next couple month.

>
> If you (or anybody interested in working on this) would prefer direct
> push access to the git.github.io repo, I'm happy to set that up.

Yeah I wouldn't mind direct push access there, then I could fixup
what I just sent you, e.g. adding myself as a possible mentor or
re-shuffling these ideas. :)

>
>>   If you're looking for a co-admin/mentors, I can help out.
>
> I may take you up on the co-admin thing. I think it's good to have a
> backup, just in case.
>
> Anything you put on the Ideas page, you should probably be willing to
> mentor. We definitely _don't_ want Ideas that don't have a mentor.

agreed.

> I think in general that each idea should have the possible mentors
> listed below it.

ok, I can make a patch for that; but pushing seems (slightly) easier than
mailing a patch.

Thanks,
Stefan
