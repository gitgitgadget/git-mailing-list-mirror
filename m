Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95908C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62764207FD
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBSUuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:50:23 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40490 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUuX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 15:50:23 -0500
Received: by mail-wm1-f52.google.com with SMTP id t14so2162759wmi.5
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 12:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zpnp5rQkCOmncodc5FPeRR853M9yZpWIC6V0Q0nC2BY=;
        b=mX/WVJ5iw5z1JYWeKcIL/0Z71Ct5JAeQO7WWlllA6RHNwK/76VABp5JHdYNpxJi+5D
         pTzEXCB+Ayeutp1cjf8Sd+kMlhllpBn3x2qTvvDXE+ElbM5S9qIyCL56NRO4qXfUE6ef
         c2is5kFi8FeaOltEz6AsfHrd6m3ujoSYyfxtslLssz38UO4Vr98w1QfBmK1RmcRvY8ad
         N706DBTA/fVUvB8BtB8/sMckDUE4C8WyUcgxSv2C9k3sgsUX0XEYnYr+3pHrndWKDQ4q
         KiXAxRBflqZS25oIDfQOtNahwHsYUptJrC18oNketAYwwEbR1mEjEQj1KKm5FaEsE+yE
         oESQ==
X-Gm-Message-State: APjAAAWFw4GsQ4eoRBeBEmFMk3qDXzf9kbQOZoXdiwD+4cE7SgJNnSVG
        lKZJuJmIEcqOSItNBC6/hqwyJ7yb604T2N69ddw=
X-Google-Smtp-Source: APXvYqyESii/DGucnWxnJQttsNfvYDkpbpGIUcTEd68rdiRzYeXCFAbF/N/UqTajOFg+KqtpWbFf83IF5d13a1UelCU=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr12134099wmi.107.1582145421784;
 Wed, 19 Feb 2020 12:50:21 -0800 (PST)
MIME-Version: 1.0
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com> <20200219195822.GA5101@syl.local>
In-Reply-To: <20200219195822.GA5101@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Feb 2020 15:50:10 -0500
Message-ID: <CAPig+cQQdLaD58y+OLPELOWP_91ypHep68HMjwBBHYkZE_=6XA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #04; Mon, 17)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 2:58 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Mon, Feb 17, 2020 at 02:08:38PM -0800, Junio C Hamano wrote:
> > * tb/commit-graph-split-merge (2020-02-12) 3 commits
> >
> >  Waiting for the discussion to settle.
> >  cf. <20200212205028.GE4364@syl.local>
>
> I wanted to get feedback from my response to Eric Sunshine before saying
> that we have consensus, but otherwise I think this is moving along.

Erm, I don't think Eric Sunshine participated in the discussion about
that series (or did I overlook something?).
