Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C0D1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 13:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeIZUAY (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 16:00:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46667 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZUAX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 16:00:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so13946191pga.13
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i0N8IQ75VczlJxSXZfOb3k3CyAciOaf95zKheOmsHJo=;
        b=RA3k5DPZ1Ioi/naWWg62mxrNFrznkUp97AOxN7TwQnh4q9r4bK5fJHbTi8G/31cy1j
         /6OxGtlI7/OfHs6gcEmKSH0gLv81t7ltGQrY2tF8LDTYnt4FcPL8yGl6eqbhYs3XlldF
         g/ogCwX/HZ5ZteLP4MSSRf+1kmIa7j6M9hlxGjFaIbz37Y1QxTrZSxMW+Al36kB4NG2b
         Eun2YikWBsXCXYV0ey5ecEdKpSE8SbHW+288H5Uj4SQTnRg2ipsTMGeInAQAf5xl4TXx
         txf2tKmQGelLJe9tEgRSDAaM4SQP6mJZVKrKsyP92n9NU01xj4Wwf4cQh/dgvgA8UxZS
         jFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i0N8IQ75VczlJxSXZfOb3k3CyAciOaf95zKheOmsHJo=;
        b=e3fvztQawrLKCWEcbfEz7DwDC5sU3BhHmTgqrq/fTVFBWGVXpft3hlKlJ922bu5Ymx
         PNtNWSn4Itt3nmEcoSoqjFYIhdjlS5BHbtxLQEwX0LA8Q6C06PienDcaUKjM5LQBAI2Y
         vn/xE/SMfRUcd8HlZy19/sbR/21DkMuoSFC4z12cfXN/T1cZORm5oU2wkumcVk5eah6g
         mrL2/1CY+T0MxTmU5+dh7czHPPi1jJsMuXWXQFOD1S3TehRSv7sPPSEsj0BMG5mQO9c3
         FFjK22/2ct5/tE4LbSARpbn2Em336Z5lc01OOeW1HQ/ANL3kIB6KJ8TPLDAjYp5WBS7E
         cDsw==
X-Gm-Message-State: ABuFfogVfXlLiPkcgx8Q5Ww4p4aO1oNWhGFF//LnRYaBeO35U6MRlMp6
        9uvsTDNhefz9Gc4cvcXX0/5Iew==
X-Google-Smtp-Source: ACcGV60XiW3jaaDfOOzRSFR5pRAe2BvaOgEZn7rEBFYCbvU1IlRPsm0qdESGY4AzlA3Zs97jqhqE/w==
X-Received: by 2002:a63:6c04:: with SMTP id h4-v6mr5894061pgc.290.1537969640294;
        Wed, 26 Sep 2018 06:47:20 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id v81-v6sm13466438pfj.25.2018.09.26.06.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 06:47:19 -0700 (PDT)
Date:   Wed, 26 Sep 2018 06:47:17 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git.txt: mention mailing list archive
Message-ID: <20180926134717.GC25697@syl>
References: <6319b34fc808ff6d8948e59f381cc5342b9ef17d.1537375332.git.martin.agren@gmail.com>
 <xmqqlg7wyol5.fsf@gitster-ct.c.googlers.com>
 <CAN0heSqA192U-eH8CZJJbKNcimPYxqn6yva6mstsEHnH1-DEGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqA192U-eH8CZJJbKNcimPYxqn6yva6mstsEHnH1-DEGA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 10:05:29AM +0200, Martin Ågren wrote:
> On Thu, 20 Sep 2018 at 21:07, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Martin Ågren <martin.agren@gmail.com> writes:
> >
> > > In the "Reporting Bugs" section of git(1), we refer to the mailing list,
> > > but we do not give any hint about where the archives might be found.
> >
> > And why is it a good idea to give that information in Reporting Bugs
> > section?  Are we asking the bug reporters to look for similar issues
> > in the archive before they send their message?  If so, I think that
>
> Your guess is correct, sorry for forcing you to make one.
>
> > we should be explicit about it, too.  Otherwise, the list archive
> > location would look like an irrelevant noise to those who wanted to
> > find the address to report bugs to.
> >
> > For example, we can say something like this:
> >
> > >  Report bugs to the Git mailing list <git@vger.kernel.org> where the
> > >  development and maintenance is primarily done.  You do not have to be
> > >  subscribed to the list to send a message there.
> >   +If you want to check to see if the issue has
> >   +been reported already, the list archive can be found at
> >   +<https://public-inbox.org/git/> and other places.
>
> I think that one reason I avoided spelling out why giving the archive
> location was a good thing to do, was that I didn't want to begin a huge
> list of "please do this and that", scaring away potential bug reporters.
> I think your "If you want to" solves that problem very nicely. I'll wrap
> this up later today.

Yeah. This is a tricky issue in my mind. On the one hand, getting a
deluge of duplicate bug reports is a burden for people who actively
read and respond to the list. On the other hand, imposing such a burden
on bug reporters is a detriment to Git users, who wouldn't benefit from
the fixes that would come with good bug reports.

But I think that the above is only a problem if bug reporters are
consistently ignoring this advice. I don't think they will, since the
barrier to entry is already quite high (e.g., sending email is more
foreign to some than opening a GitHub issue, say).

So, I think that the suggestion above is a good one, since I believe
we'd rather get some bad bug reports than no bug reports at all.

Thanks,
Taylor
