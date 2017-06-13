Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0251FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 22:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753448AbdFMWTR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 18:19:17 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35678 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdFMWTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 18:19:16 -0400
Received: by mail-pg0-f50.google.com with SMTP id k71so66288226pgd.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=26XDycUj3TOmmLF/lJhP2WxDuRFFyyDzPh5RByS20sk=;
        b=ooSkMbwuOlkjA+chHsKHCOnYJKuMriRW6VcSkgQThb6OrlRsz6ey4LGnZiWxHF2w/S
         +sL7iLVjFaNPOO9QUXJpopqgTXQHhFY9XhtfC4jF+aU3gwMRUxueGJqPAowd6hvgwUyr
         LkOaBGX1nVH0rUeUMi41RaSly9w1QNMxDa562b6/NjuL9+y1rGKN5TdqvTzHNpSKkzx+
         VAmGHdXMhwR+bMgwFGhK04nhCymDh+QQW0n6ZbW0CMVVw8J8qhsDOfBaX/tUXR/STENa
         trE+EHIUthWa9EoFcsa7AVayxY48Woz946v0eGwdwicbyNERxzmLhzImLWqqz+NNM1Qc
         wIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=26XDycUj3TOmmLF/lJhP2WxDuRFFyyDzPh5RByS20sk=;
        b=k/5gwT6oo3qmj11iyIYs4jG5q8yNLQ/Bl/V5buFb3yJhd1yAqRLzjhdCN1wHPe2ydZ
         2Mh2oP6R+ekx+okx2SRNZ6um41daKQVBKj5RaAfmGpoL7EZjfxlpd3MzbxEgj3aEtnFP
         hEa78zO7Exwy8uyigY+v6qwyA9EVxQhtLY8asaDFbTYiHtgyXHtztjeVCka/z3iwFEMJ
         FI/TwPHl+DifGIrJeThPIJcc6k7S2pbW/6GCLi/yVE/0wXseOTKVCsvTsPJ/1GcQXXts
         hAcy0eRt4LSDNE0bK/yEFOx+bHJzTlQ2Fm1RKGw+7IBEGf5dnGfSO7E4KuNV45GlEL8o
         0taw==
X-Gm-Message-State: AKS2vOzoR3vbIOLaABcDAjyRg4/t0+hSEieG48ma8vzwhZb9PQuDhP8G
        sfp59fxRimkltfGm8B55GJmRtVRDXr82
X-Received: by 10.99.55.84 with SMTP id g20mr1213873pgn.243.1497392355760;
 Tue, 13 Jun 2017 15:19:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 15:19:15 -0700 (PDT)
In-Reply-To: <CA+P7+xpCWUBap757N45DrGjvh+v51dg=A9MNOgN8xfVDqZtvog@mail.gmail.com>
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com> <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
 <xmqq8tl5apkk.fsf@gitster.mtv.corp.google.com> <CA+P7+xpvZDHum-A4omMySTebgBLFzhkpD=DiL-_Mm_Qv-OkMaw@mail.gmail.com>
 <CA+P7+xpCWUBap757N45DrGjvh+v51dg=A9MNOgN8xfVDqZtvog@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 15:19:15 -0700
Message-ID: <CAGZ79kZU-QGYAiv+9tK9UoujuLVD8Ejar=zaHVm8YR2p4cbgOQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
To:     Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 10:41 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Jun 5, 2017 at 11:52 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>
>> I will try to find some time tomorrow to go over it in detail.
>>

https://public-inbox.org/git/20170613023151.9688-1-sbeller@google.com/
restarted the discussion on this feature, so I assembled a team of color experts
(my office mates), and we came to this conclusion more or less:

There are different ways to implement a move detection. Different
  people prefer different things, the main contenders are:

1)    "Zebra mode" (in the last patch known as "alternate" mode.

    This alternates between 2 colors for blocks of moved code.
    This may or may not reset to the first color, but the main features are:
    a) the whole block is in one color
    b) adjacent blocks have different colors.

For this implementation we need 4 new colors (2 colors for +, 2 for -)

2)    "Highlight bounds + dimming in between"

    A block is generally in a dim color. Depending on further configuration
    the boundaries are highlighted. There are different modes for that:
    a) all boundaries are highlighted
    b) bounds adjacent to other moved blocks of same sign are highlighted
    c) no bounds highlighted, moved code is only dimmed.
        (sucks for seeing blocks)
    d) [NEW] only the first (last) border line.
        This is consistent with the thread that started the discussion as
        this is done in the RFC for blame.

  The configured colors "oldMoved" and "oldMovedAlternative"
  are assumed that one is highlighting and the other is the dim color.

  Depending on the exact implementation we'd need up to 6 new
  colors (dim, highlight, highlight alternative for each + and -)
  The user may configure these to be the same though, e.g.
  both dims could be 'context'.

3) Combine 1) and 2)

    The algorithm would look like this:
    a) Find moved blocks
    b) Take one option from 2) to highlight the bounds. (all bounds
      or adjacent bounds are the only serious contenders IMHO)

  This needs 8 new colors configured:
  for each of (new, old):
    for each of (Zebra black, Zebra white):
      for each of (dim, highlight):
        define_color()

The color experts agreed that (3) might be the best solution
as this gives most flexibility:

    "I would be happy as I can configure the bounds highlighting
    to not exist, it would degenerate to a pure Zebra, which is
    very simple to understand. Junio seemed to like (2) a lot, so
    he would configure both dim colors to be 'context', but configure
    the highlight colors to be attention drawing. So everybody would
    be happy. It is also not too many colors, we are good at for loops."

I hope to have summarized this adequately.

Thanks,
Stefan
