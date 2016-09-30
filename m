Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C81207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 16:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbcI3QYY (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 12:24:24 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:57953 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933749AbcI3QYW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 12:24:22 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Sep 2016 12:24:22 EDT
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id u8UGEDa4022370
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 19:14:15 +0300
Date:   Fri, 30 Sep 2016 19:14:13 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     git@vger.kernel.org
Subject: "Purposes, Concepts,Misfits, and a Redesign of Git" (a research
 paper)
Message-Id: <20160930191413.002049b94b3908b15881b77f@domain007.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "It Will Never Work in Theory" blog has just posted a summary of a
study which tried to identify shortcomings in the design of Git.

In the hope it might be interesting, I post this summary here.
URL: http://neverworkintheory.org/2016/09/30/rethinking-git.html

The except from that resource written by Greg Wilson, the blog author:
---------------->8----------------
Santiago Perez De Rosso and Daniel Jackson: "[Purposes, Concepts,
Misfits, and a Redesign of Git]
(http://people.csail.mit.edu/sperezde/pre-print-oopsla16.pdf)", _SPLASH
2016_. 

> Git is a widely used version control system that is powerful but
> complicated. Its complexity may not be an inevitable consequence of
> its power but rather evidence of flaws in its design. To explore this
> hypothesis, we analyzed the design of Git using a theory that
> identifies concepts, purposes, and misfits. Some well-known
> difficulties with Git are described, and explained as misfits in
> which underlying concepts fail to meet their intended purpose. Based
> on this analysis, we designed a reworking of Git (called Gitless)
> that attempts to remedy these flaws. 
> 
> To correlate misfits with issues reported by users, we conducted a
> study of Stack Overflow questions. And to determine whether users
> experienced fewer complications using Gitless in place of Git, we
> conducted a small user study. Results suggest our approach can be
> profitable in identifying, analyzing, and fixing design problems. 

This paper presents a detailed, well-founded critique of one of the
most powerful, but frustrating, tools in widespread use today. A
follow-up to earlier work published in 2013, it is distinguished from
most other discussion of software design by three things: 

  1. It clearly describes its design paradigm, which comprises
_concepts_ (the major elements of the user's mental model of the
system), _purposes_ (which motivate the concepts), and _misfits_ (which
are instances where concepts do not satisfy purposes, or contradict one
another). 

  2. It lays out Git's concepts and purposes, analyzes its main
features in terms of them, and uses that analysis to identify
mis-matches. 

  3. Crucially, it then analyzes independent discussion of Git (on
Stack Overflow) to see if users are stumbling over the misfits
identified in step 2. 

That would count as a major contribution on its own, but the authors go
further. They have designed a tool called Gitless that directly
addresses the shortcomings they have identified, and the penultimate
section of this paper presents a usability study that compares it to
standard Git. Overall, subjects found Gitles more satisfying and less
frustrating than Git, even though there was no big difference in
efficiency, difficulty, or confusion. Quoting the paper, "This apparent
contradiction might be due to the fact that all of the participants had
used Git before but were encountering Gitless for the first time
without any substantive training. Some participants (2 regular, 1
expert) commented that indeed their problems with Gitless were mostly
due to their lack of practice using it." 

This paper is one of the best examples I have ever seen of how software
designs ought to be critiqued. It combines an explicit, coherent
conceptual base, detailed analysis of a specific system, design
grounded in that analysis, and an empirical check of that design.
Sadly, nothing shows the actual state of our profession more clearly
than the way this work has been greeted: 

> In some respects, this project has been a fool's errand. We picked a
> product that was popular and widely used so as not to be investing
> effort in analyzing a strawman design; we thought that its popularity
> would mean that a larger audience would be interested in our
> experiment. In sharing our research with colleagues, however, we have
> discovered a significant polarization. Experts, who are deeply
> familiar with the product, have learned its many intricacies,
> developed complex, customized workflows, and regularly exploit its
> most elaborate features, are often defensive and resistant to the
> suggestion that the design has flaws. In contrast, less intensive
> users, who have given up on understanding the product, and rely on
> only a handful of memorized commands, are so frustrated by their
> experience that an analysis like ours seems to them belaboring the
> obvious.
---------------->8----------------
(This text is Copyright © Never Work in Theory, under the CC license.)
