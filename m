Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5591F463
	for <e@80x24.org>; Tue, 24 Sep 2019 21:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbfIXVJT (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 17:09:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:58892 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728597AbfIXVJT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 17:09:19 -0400
Received: (qmail 11205 invoked by uid 109); 24 Sep 2019 21:09:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 21:09:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12646 invoked by uid 111); 24 Sep 2019 21:11:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 17:11:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 17:09:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, git@sfconservancy.org,
        Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
Message-ID: <20190924210918.GC20858@sigill.intra.peff.net>
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <89c6f5b7-aeab-740c-06b6-e50232266fd4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89c6f5b7-aeab-740c-06b6-e50232266fd4@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 10:14:55PM +0200, René Scharfe wrote:

> > +* Trolling, insulting/derogatory comments, and personal or political attacks
> 
> Hmm.  Trolling can be helpful, if done right.  I consider this to be a
> good example: https://git-man-page-generator.lokaltog.net/.  Wrote some
> texts that look like that..

I suppose one man's joke is another man's troll. Is the manpage
generator too mean? I don't think so (I think it's quite funny). I guess
somebody could. But at some point all of these terms are open to
interpretation, and we're going to have to rely on discussion and
precedent.

I don't think step 1 would ever be "report the manpage generator to the
committee, and get it banned!". For one thing, we have no control over
their domain, and it really exists outside of our development community.
So at most we say "yeah, we don't like that; please don't". But more
importantly, I think step 1 is somebody saying "hey, this kind of seems
in poor taste", and then we all have a discussion about it.

> "Personal and political attacks" sound really scary and don't seem to
> match trolling and insulting in severity.  Perhaps I don't understand
> the intended meaning.  In any case, I also wouldn't want anyone to be
> beaten up or swatted, get a lower social credit score or be forced out
> of public office over participation in our project.

I take political attacks to be things like "Everyone from Country X is a
moron", or "People who support political party X are jerks". You might
even have a legitimate complaint about somebody's politics, but if
they're not bringing their politics into the project, it seems wrong to
attack them over it.

I do think there's some grey area there, though, because there _is_ some
intersection of politics (e.g., a discussion about licensing could
easily get into discussion of laws and IP). But if people are talking
constructively about it, and not attacks like "the party you support has
a dumb interpretation of the GPL", that seems fine to me.

Again, I really think the point here is not to enumerate all
possibilities. It's to set some general expectations, and to make it
clear that we value the idea of having a genial atmosphere for
communication that we have a document and a reporting mechanism.

> > +* Other conduct which could reasonably be considered inappropriate in a
> > +  professional setting
> 
> This is very vague.  It could match eating at your desk, tipping, not
> tipping, not wearing a tie, or talking back to a senior developer.

Here I'd go back to "discussion and precedent" from above. Community
norms are a moving target to some degree. Wearing a tie was
unprofessional at one point, and now that is very much not the case, at
least in the programming profession. I think we have to stay somewhat
vague and rely on the social interactions of the community to resolve
things (and again, this is more or less what the status quo is; the
document is mostly a commitment from project leadership to take
seriously discussion and complains about behavior within the project).

-Peff
