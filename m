Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959021FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 22:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbcLTWR0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 17:17:26 -0500
Received: from ozlabs.org ([103.22.144.67]:47405 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752020AbcLTWRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 17:17:24 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3tjsbR2qVJz9t1F; Wed, 21 Dec 2016 09:17:23 +1100 (AEDT)
Date:   Wed, 21 Dec 2016 09:17:19 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
Message-ID: <20161220221719.GB22566@fergus.ozlabs.ibm.com>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
 <97d97bc6-54f1-2ef2-fe04-7e7f144d7e51@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d97bc6-54f1-2ef2-fe04-7e7f144d7e51@xiplink.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 10:01:15AM -0500, Marc Branchaud wrote:
> On 2016-12-19 11:44 AM, Michael Haggerty wrote:
> >This patch series changes a bunch of details about how remote-tracking
> >references are rendered in the commit list of gitk:
> 
> Thanks for this!  I like the new, compact look very much!
> 
> That said, I remember when I was a new git user and I leaned heavily on gitk
> to understand how references worked.  It was particularly illuminating to
> see the remote references distinctly labeled, and the fact that they were
> "remotes/origin/foo" gave me an Aha! moment where I came to understand that
> the refs hierarchy is more flexible than just the conventions coded into git
> itself.  I eventually felt free to create my own, private ref hierarchies.
> 
> I am in no way opposed to this series.  I just wanted to point out that
> there was some utility in those labels.  It makes me think that it might be
> worthwhile for gitk to have a "raw-refs" mode, that shows the full
> "refs/foo/bar/baz" paths of all the heads, tags, and whatever else.  It
> could be a useful teaching tool for git.

Do you think we should have a checkbox in the preferences dialog to
select whether to display the long form or the short form?

Paul.
