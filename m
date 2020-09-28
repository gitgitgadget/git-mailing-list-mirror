Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C8C4741F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49612076B
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgI1Tm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:42:56 -0400
Received: from ikke.info ([178.21.113.177]:49976 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgI1Tm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 15:42:56 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 15:42:55 EDT
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id C8C6F44012C; Mon, 28 Sep 2020 21:33:32 +0200 (CEST)
Date:   Mon, 28 Sep 2020 21:33:32 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Evan Gates <evan.gates@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Doc: note minimum scissors line length for mailinfo
Message-ID: <20200928193332.GA2986883@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Evan Gates <evan.gates@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200928190029.GB2285677@google.com>
 <C5Z8UYJS02RM.2UD0R6DCK0KX5@emg-xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5Z8UYJS02RM.2UD0R6DCK0KX5@emg-xps>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 12:20:31PM -0700, Evan Gates wrote:
> On Mon Sep 28, 2020 at 12:00 PM PDT, Jonathan Nieder wrote:
> > Junio C Hamano wrote:
> >
> > > It certainly was fun to declare that users can use anything that
> > > look like perforation drawn on paper, and to pile more and more
> > > heuristics to detect such a line.  But I think, instead of
> > > describing all these details in the manual, telling the users to
> > > always write "-- >8 --" and nothing else would be a better approach.
> > >
> > > It would save them time.
> >
> > Agreed, I think this is a much better direction.
> >
> > Another advantage is that it makes us easier to change the heuristics,
> > confident that we are training users to aim for the simple and
> > reliable case instead of the edge cases that may need to be tweaked
> > over time.
> 
> Sounds good to me.  How about:
> 
> Remove everything in body before a scissors line ("-- >8 --"). The line
> represents scissors and perforation marks, and is used to request the
> reader to cut the message at that line.  If that line appears in the
> body of the message before the patch, everything before it (including
> the scissors line itself) is ignored when this option is used.
> 
> Etiquette question: Should a v2 patch be a new thread or reply to
> this one?

Typically you would reply to this thread, ie, to
20200925191659.31375-1-evan.gates@gmail.com

Kevin
