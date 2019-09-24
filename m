Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF98A1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 20:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442019AbfIXUqP (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 16:46:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:58816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2442011AbfIXUqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 16:46:14 -0400
Received: (qmail 10930 invoked by uid 109); 24 Sep 2019 20:46:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 20:46:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12417 invoked by uid 111); 24 Sep 2019 20:48:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 16:48:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 16:46:13 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, git@sfconservancy.org,
        Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
Message-ID: <20190924204613.GA20858@sigill.intra.peff.net>
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 10:12:14AM -0700, Denton Liu wrote:

> > I've cc'd git@sfconservancy.org here, because I think it's important for
> > all of the project committee members to endorse it (and because the
> > document puts us on the hook for enforcing it!).
> 
> I tried looking it up but I couldn't find who the project committee
> members are. Is this list published anywhere? More on that later...

See:

  https://public-inbox.org/git/20180925215112.GA29627@sigill.intra.peff.net/

The current committee is:

  Junio C Hamano <gitster@pobox.com>
  Jeff King <peff@peff.net>
  Christian Couder <christian.couder@gmail.com>
  Ævar Arnfjörð Bjarmason <avarab@gmail.com>

There's a link there that goes into more detail on how the selection
process works.

> > +* Publishing others' private information, such as a physical or electronic
> > +  address, without explicit permission
> 
> Since this is a mailing list-based project, we should explicitly state
> that email addresses and names don't count as private information since
> it's vital for discourse.

I'd argue that participating in the mailing list means you've given
permission for your address to be public. Ditto including it in a git
commit that gets pushed.

> On that note, I like the idea of having a CoC-interpretations document,
> much like the one in the Linux kernel[1]. In my opinion, having one
> would remove a lot of the vagueness (such as the emails issue) in the
> CoC and close us off from people loophole lawyering over the language
> used.

Yeah, I like the kernel one, as well. I'd rather have an interpretation
document than try to hack up the CoC. It's nice to be able to say "we
use Contributor Covenent 1.4" and have that be a standard across
projects.

> > +Project maintainers have the right and responsibility to remove, edit, or
> > +reject comments, commits, code, wiki edits, issues, and other contributions
> 
> Since we use patches here, we should probably explicitly state that too.

I'd just call that "commits", but I think "other contributions" is a
fine catch-all. Again, I don't mind a clarification document but I'd
prefer not to hack up this CoC for little things like this.

> > +Instances of abusive, harassing, or otherwise unacceptable behavior may be
> > +reported by contacting the project team at git@sfconservancy.org. All
> > +complaints will be reviewed and investigated and will result in a response
> > +that is deemed necessary and appropriate to the circumstances. The project
> > +team is obligated to maintain confidentiality with regard to the reporter of
> > +an incident. Further details of specific enforcement policies may be posted
> > +separately.
> 
> I feel uncomfortable with this being left so wide open. First of all, I
> know that the power *probably* won't be abused but I don't think
> probably is good enough.
> 
> As I said above, I couldn't find a public list of the people who were on
> the project committee. Perhaps that's because my Googling skills are bad
> but I feel uncomfortable knowing that *anyone* will be given judge, jury
> and executioner power, let alone people whom I don't know anything
> about.
> 
> I'm okay with leaving it open for now but I think I would be a lot more
> comfortable if we had the interpretations document to close up the
> vagueness later.

In general the project committee tries to involve the larger community
on the list where possible. So I think if there were, say, a discussion
about list behavior, I'd expect it to happen on the list. But I think we
do need a semi-private reporting mechanism:

  - some issues may involve details that the reporter wishes to keep
    public (e.g,. a harasser follows somebody to a non-mailing-list
    venue like Twitter, but the harassed person doesn't want to publicly
    announce their Twitter handle; you can imagine even more extreme
    cases of details somebody doesn't want to make public).

  - people may want to report problems pseudo-anonymously because they
    fear retaliation. I think this gets into a grey area of facing your
    accuser, but it seems like there needs to be a private mechanism to
    at least make initial contact (e.g., not to deliver one-sided
    evidence, but to draw the committee's attention to a particular
    already-public thread).

-Peff
