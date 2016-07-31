Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B81E1F858
	for <e@80x24.org>; Sun, 31 Jul 2016 14:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbcGaOKs (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 10:10:48 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:42489 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbcGaOKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 10:10:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 38B2D4627F7;
	Sun, 31 Jul 2016 15:09:55 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X+IhG9HJQ9HX; Sun, 31 Jul 2016 15:09:53 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id DBB11462868;
	Sun, 31 Jul 2016 15:09:52 +0100 (BST)
Date:	Sun, 31 Jul 2016 15:09:36 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Stefan Beller <sbeller@google.com>
Cc:	Josh Triplett <josh@joshtriplett.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	Dave Borowitz <dborowitz@google.com>
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160731140936.GA3959@salo>
References: <20160729064055.GB25331@x>
 <20160729101011.GA3469@salo>
 <20160729110426.GA2945@x>
 <20160729124443.GA3686@salo>
 <CAGZ79kbTViNYLq0aouQ--5d7m=HYi3QxUYqaaH8sTCS_YTDquQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbTViNYLq0aouQ--5d7m=HYi3QxUYqaaH8sTCS_YTDquQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 09:59:08AM -0700, Stefan Beller wrote:
> On Fri, Jul 29, 2016 at 5:44 AM, Richard Ipsum
> <richard.ipsum@codethink.co.uk> wrote:
> >>
> >> These definitely seem like a family of related problems.  I'd like to
> >> use git-series as a format for storing iterations on things like GitHub
> >> pull-requests or Gerrit patch versions (in the latter case, overcoming
> >> Gerrit's limitations on only handling one patch at a time).  Integrating
> >> reviews with that seems helpful.
> >
> > Worth noting here that Gerrit's one patch per change format isn't
> > intrinsic to Notedb, since we just need to track the sha we want
> > to merge and optionally the branch we intend to merge into.
> 
> Note that Gerrit started to lose the "one patch at a time" notion.
> It is possible to at least submit multiple changes coupled together
> (even across project boundaries) via the topic. Some sort of cover
> letter is missing though, that could be used e.g. for the merge commit.

Potentially my misuse of the format but git-candidate puts the cover
letter into the body of the commit message before the footers begin,
for each new patchset added to the change. This has the advantage
that you can track each version of the cover letter,
since there's one per patchset.
