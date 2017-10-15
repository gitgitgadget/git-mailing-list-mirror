Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495C220372
	for <e@80x24.org>; Sun, 15 Oct 2017 16:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbdJOQFr (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 12:05:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:57342 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdJOQFq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 12:05:46 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M24Vr-1dEHMY05FL-00tzxM; Sun, 15
 Oct 2017 18:05:37 +0200
Date:   Sun, 15 Oct 2017 18:05:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote
 ref name
In-Reply-To: <xmqqinfiv5u2.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710151804060.40514@virtualbox>
References: <cover.1506952571.git.johannes.schindelin@gmx.de> <cover.1507205895.git.johannes.schindelin@gmx.de> <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de> <20171013163923.GA5598@alpha.vpn.ikke.info>
 <xmqqinfiv5u2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sHUHt4xBxc71Tphpp6QMs6rIBqaZa+sP1XbE65aXQns1jsiDI7A
 rYvJmVnlVgCFOSeLNA7RWh9yXivypieLXphbOtupL5qodUvMgl2oQkXET9nvl0Qvsvbchzi
 fjx5jafC3aAboN2nw4SQ8I16jgv7P2+52YKqwGQOTO+0G2Ka0o90ASF8/W/vvFgqyUqy+S5
 LJ8SdWgtcefqk9Dv6c2kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KkTwDe3kvJ4=:2UyV+uU+Q5O6oeAa+yuG0E
 MlxIlt/J+OjsW9YfXYjRRzY+Wev04lRZ0lglZSb/4zE8gFUZss7Mqo6wicoW0KqdCGh9c0AHf
 l9P+nU9den0P9/zzuOnK0n7CG65O7+QzdPJgsRhOdHiCDnv4AfkAtsXY8qEBtVygYM4H6tTs8
 fn2LQ1156BugVmty0e9hrR+V/YqG90JOxwEO+qny2cG+Rs9If9MU7r5Sj0owrlrtbD8isfLWw
 2EHwxOr4HR9VdaTtKCcRXiMkzyfy5P6fGjs0RqBQQlFHGNF43jqs5ukxflVpuzvQ+UC+nemgb
 R6Yh3GXvaaIxQ1ifkO36FMz00kW9XCpq/lpvVtW24sFB1sxf+gsQGR9kKaAKaFK+SWNyLCrqr
 QfCqpSYhBrm+0hxgUzNMuYbE3nbyw/oyEXHBVlyER9oku4+kHBh9uY35VOK3N+XyYWFpv4d/p
 9/Y99/uELwvC7ow17Hbj2+ovkwuMUj4gPO0g5CyK9SNMsWmm3DVXJWVvMQeLyB/qbgBhKFx6k
 Kgnr6Rzk7EnifBmVLNWwT7vaKAtWH0eoQMI95z5nNlHBH8o5UlFdt/nMunJQGxromGyBTct+Y
 GzBRg3W2Tj/hOCNciKJo3LQ1Xd+XaXjrX6/+m47eRg8OiWXo0reuEycOoH2K68QckknJK+1v4
 uA68PKMuMlXcE9t4f+MM2O4KdUlUHLNLFw5GwbjchRtnbNE1QjsI39JAVcT8SWxi2e7clnWNH
 CxENEG7nuHVVYL7HSKpfeImZ7jyhAMBfryHT/cZdZyyva2rczRd+2Nko3DDHnIJtYz7ZS8Xhd
 5mCpgmaj8C9LdQLoIYkoGTa1ePmXKrK0hm8xYrvgeN/c8kSGhU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 14 Oct 2017, Junio C Hamano wrote:

> Kevin Daudt <me@ikke.info> writes:
> 
> > On Thu, Oct 05, 2017 at 02:19:15PM +0200, Johannes Schindelin wrote:
> >> From: J Wyman <jwyman@microsoft.com>
> >> [..] 
> >> 
> >> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> >> index 39f50bd53eb..22767025850 100644
> >> --- a/Documentation/git-for-each-ref.txt
> >> +++ b/Documentation/git-for-each-ref.txt
> >> @@ -142,8 +142,9 @@ upstream::
> >>  	encountered. Append `:track,nobracket` to show tracking
> >>  	information without brackets (i.e "ahead N, behind M").
> >>  +
> >> -Also respects `:remotename` to state the name of the *remote* instead of
> >> -the ref.
> >> +Also respects `:remotename` to state the name of the *remote* instead
> >> +of the ref, and `:remoteref` to state the name of the *reference* as
> >> +locally known by the remote.
> >
> > What does "locally known by the remote" mean in this sentence?
> 
> Good question.  I cannot offhand offer a better and concise
> phrasing, but I think can explain what it wants to describe ;-).

Yep, described it well.

Maybe "and `:remoteref` to state the name by which the remote knows the
*reference*"?

Ciao,
Dscho
