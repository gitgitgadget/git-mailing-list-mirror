Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9651F463
	for <e@80x24.org>; Thu, 26 Sep 2019 07:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfIZHUs (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 03:20:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:60602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728240AbfIZHUs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 03:20:48 -0400
Received: (qmail 7773 invoked by uid 109); 26 Sep 2019 07:20:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Sep 2019 07:20:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25877 invoked by uid 111); 26 Sep 2019 07:23:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2019 03:23:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Sep 2019 03:20:46 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Denton Liu <liu.denton@gmail.com>, Git List <git@vger.kernel.org>,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: [PATCH] CODE_OF_CONDUCT: mention individual project-leader emails
Message-ID: <20190926072046.GB20653@sigill.intra.peff.net>
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
 <CAJoAoZkw08A_nkJNMwgTTFvGMCRUqR2UqEckOp65Vg_TW7K8bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJoAoZkw08A_nkJNMwgTTFvGMCRUqR2UqEckOp65Vg_TW7K8bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 04:52:56PM -0700, Emily Shaffer wrote:

> > > I've cc'd git@sfconservancy.org here, because I think it's important for
> > > all of the project committee members to endorse it (and because the
> > > document puts us on the hook for enforcing it!).
> >
> > I tried looking it up but I couldn't find who the project committee
> > members are. Is this list published anywhere? More on that later...
> 
> To be honest, I'm a little worried about it too. What if I have a
> problem with someone on the project committee? What if I have a
> problem with someone I don't know is on the project committee?

I think those are very good points. See the patch below.

> I helped my other FOSS project to adopt a Code of Conduct earlier in
> the year (https://github.com/openbmc/docs/blob/master/code-of-conduct.md)
> and we got around this by asking for volunteers from the technical
> steering committee to agree to have their contact info listed on the
> escalation path; at the end of the escalation path we also listed
> someone external to the project (which we were able to do because we
> had been adopted by the Linux Foundation, and they have someone for
> that).

Yeah, I think this is sort of the same thing except that I
pre-volunteered the whole project committee. ;)

We could have a separate list of contacts for the code of conduct, but
it seems simplest to just use the existing group that we already have,
unless there's a compelling reason not to.

> A possible con of being on this escalation path is having your name
> and contact info outed to trolls as a supporter of something
> controversial like a code of conduct. However, I'd argue that the
> growing list of ACKs on this thread expose us in a similar way. On the
> other side, the benefit of having a transparent escalation path like
> this is that you can bypass a problematic individual who may be in a
> position of power. It also provides an opportunity for increased
> discretion in delicate situations like the example Peff gave
> downthread.

Yep, agreed with all of this.

So here's a patch that I think improves the situation.

-- >8 --
Subject: [PATCH] CODE_OF_CONDUCT: mention individual project-leader emails

It's possible that somebody on the project committee is the subject of a
complaint. In that case, it may be useful to be able to contact the
other members individually, so let's make it clear that's an option.

This also serves to enumerate the set of people on the committee. That
lets you easily _know_ if you're in the situation mentioned above. And
it's just convenient to list who's involved in the process, since the
project committee list is not anywhere else in the repository.

Signed-off-by: Jeff King <peff@peff.net>
---
 CODE_OF_CONDUCT.md | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
index b94f72b0b8..fc4645d5c0 100644
--- a/CODE_OF_CONDUCT.md
+++ b/CODE_OF_CONDUCT.md
@@ -74,6 +74,14 @@ Project maintainers who do not follow or enforce the Code of Conduct in good
 faith may face temporary or permanent repercussions as determined by other
 members of the project's leadership.
 
+The project leadership team can be contacted by email as a whole at
+git@sfconservancy.org, or individually:
+
+  - Ævar Arnfjörð Bjarmason <avarab@gmail.com>
+  - Christian Couder <christian.couder@gmail.com>
+  - Jeff King <peff@peff.net>
+  - Junio C Hamano <gitster@pobox.com>
+
 ## Attribution
 
 This Code of Conduct is adapted from the [Contributor Covenant][homepage],
-- 
2.23.0.765.g1fc3e247e7

