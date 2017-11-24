Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13E320954
	for <e@80x24.org>; Fri, 24 Nov 2017 09:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbdKXJMi (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 04:12:38 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:44424 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdKXJMf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 04:12:35 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:44724 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eIA2E-00088Y-DL; Fri, 24 Nov 2017 04:12:34 -0500
Date:   Fri, 24 Nov 2017 04:11:06 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: clarify that "git bisect" accepts one or more
 good commits
In-Reply-To: <xmqqh8tkp9nn.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1711240351170.30318@localhost.localdomain>
References: <alpine.LFD.2.21.1711220729230.13545@DESKTOP-1GPMCEJ> <xmqqh8tkp9nn.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Nov 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:

... snip ...

> > -to indicate that it was after.
> > +to indicate a single commit after that change.
>
> As to "identify", I would say it is better to consistently use
> "indicate" like the original of these two hunks at the end says,
> i.e. "indicate that it is bad/new (or they are good/old)".

  i'm going to ponder this, but let me explain why i am such an
annoying stickler for the choice of words at times, and you can read
all about it here:

  http://twain.lib.virginia.edu/projects/rissetto/offense.html

in particular, i draw your attention to twain's trashing of cooper
for, in many cases, using *almost* the right word, but not *quite* the
right word:

"Cooper's word-sense was singularly dull. When a person has a poor ear
for music he will flat and sharp right along without knowing it. He
keeps near the tune, but is not the tune. When a person has a poor ear
for words, the result is a literary flatting and sharping; you
perceive what he is intending to say, but you also perceive that he
does not say it. This is Cooper. He was not a word-musician. His ear
was satisfied with the approximate words. I will furnish some
circumstantial evidence in support of this charge. My instances are
gathered from half a dozen pages of the tale called "Deerslayer." He
uses "Verbal" for "oral"; "precision" for "facility"; "phenomena" for
"marvels"; "necessary" for "predetermined"; "unsophisticated" for
"primitive"; "preparation" for "expectancy"; "rebuked" for "subdued";
"dependent on" for "resulting from"; "fact" for "condition"; "fact"
for "conjecture"; "precaution" for "caution"; "explain" for
"determine"; "mortified" for "disappointed"; "meretricious" for
"factitious"; "materially" for "considerably"; "decreasing" for
"deepening"; "increasing" for "disappearing"; "embedded" for
"inclosed"; "treacherous" for "hostile"; "stood" for "stooped";
"softened" for "replaced"; "rejoined" for "remarked"; "situation" for
"condition"; "different" for "differing"; "insensible" for
"unsentient"; "brevity" for "celerity"; "distrusted" for "suspicious";
"mental imbecility" for "imbecility"; "eyes" for "sight";
"counteracting" for "opposing"; "funeral obsequies" for "obsequies."

  in this sense, i don't think "indicate" and "identify" are
completely interchangeable. in my mind, the word "identify" does
nothing more than, you know, point at something and say, "that one,
that's the one i'm talking about;" it goes no further than that.

  on the other hand, the word "indicate" (in my mind) implies that
you're about to provide some *property* or *quality* of something, and
you do exactly that in the earlier quote:

> As to "identify", I would say it is better to consistently use
> "indicate" like the original of these two hunks at the end says,
> i.e. "indicate that it is bad/new (or they are good/old)".

  as in, you "identify" a commit, but you "indicate" that it
represents a good or bad commit. i know this sounds picky, but it is
exactly this tendency of using *almost* the right word that makes a
lot of documentation potentially confusing. given this distinction,
depending on the word to be used, i would write one of:

1) "first, identify the bad commit and one or more good commits..."

2) "first, indicate which commit is the bad commit, and which commits
are the good commits ..."

  the eventual meaning *should* be the same, but the choice of words
can make the meaning clear, or can confuse the reader.

  thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
