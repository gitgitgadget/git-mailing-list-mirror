Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F366E1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfJYSgN (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 14:36:13 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56221 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfJYSgM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 14:36:12 -0400
X-Originating-IP: 1.186.12.52
Received: from localhost (unknown [1.186.12.52])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 03FA560004;
        Fri, 25 Oct 2019 18:36:07 +0000 (UTC)
Date:   Sat, 26 Oct 2019 00:06:05 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: RFC: Moving git-gui development to GitHub
Message-ID: <20191025183605.zk2g43z2townbigj@yadavpratyush.com>
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/10/19 12:46PM, Elijah Newren wrote:
> On Thu, Oct 24, 2019 at 2:45 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > Hi everyone,
> >
> > I recently had some discussions with Dscho about whether it is a better
> > idea to use GitHub for development instead of email [0]. His argument
> > was that GitHub makes it easier for newcomers to contribute, since more
> > people are familiar with GitHub compared to mailing lists. Also, it is
> > somewhat difficult to set up an email-based workflow.
> 
> Interesting; I had been pondering asking the opposite question for
> filter-repo: Even though filter-repo is tracked externally to git.git
> (since we seem to want to move to a batteries-not-included model),
> would it be okay to ask that filter-repo contributors send patches to
> the git mailing list (possibly specially marked somehow)?

Marking them some way (like we do with git-gui) would probably be a good 
idea since it allows people to just skip over those threads if they're 
not interested. It also allows using email filters on those topics.
 
> I'm debating between:
>   - Ask contributors to send filter-repo patches to the git mailing
> list (if okay).
>   - Try out GerritHub (GitHub + Gerrit; see gerrithub.io) and maybe use it
>   - Assume there won't be many contributions (wouldn't be surprising)
> and put up with GitHub PRs
> 
> GitHub is great for ease of creating new repos, learning about other
> developers, finding similar projects, creation of webhooks, etc.  But
> it's *awful* for code review.  Gerrit is a lot better at code reviews
> (though still has problems); so maybe dealing with both GitHub and
> Gerrit would be reasonable.  (Reviewable also exists, and is kinda
> decent, but I can't respect anything that doesn't offer reviewability
> of commit messages.  And it makes me feel bad by making me want to
> swat butterflies.)  Email is a horrible medium for sending/receiving
> changes, but at least it gets the overall code review model right
> (commit-messages-are-first-order-objects-that-can-be-reviewed,
> review-individual-commits, merge-per-topic, cover-letter included,
> range-diff for high-level comparison of different iterations,
> reversing-commit-order-display-based-on-author-timestamps-is-NOT-forgivable,
> Change-IDs-are-ugly, magic-refs-are-disgusting, etc.), something no
> GUI tool (yet) does to my knowledge.

Thanks for your perspective. I have never really used GitHub for 
anything more than one off contributions, and so never really ended up 
using their review and merge tools too much. In fact, most of the open 
source projects I have been interested in used mailing lists, which is 
why I questioned myself if I'm biased towards such a workflow.
 
> So...would anyone object if I asked filter-repo contributors to send
> contributions via email to the git mailing list?

-- 
Regards,
Pratyush Yadav
