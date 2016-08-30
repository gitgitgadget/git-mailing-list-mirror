Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7115C1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbcH3RlY (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:41:24 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:43679 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932463AbcH3RlX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Aug 2016 13:41:23 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B7590351FA6;
        Tue, 30 Aug 2016 17:41:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: group25_80334ec38f715
X-Filterd-Recvd-Size: 2013
Received: from XPS-9350.home (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Aug 2016 17:41:20 +0000 (UTC)
Message-ID: <1472578879.5512.111.camel@perches.com>
Subject: Re: git am and duplicate signatures
From:   Joe Perches <joe@perches.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Date:   Tue, 30 Aug 2016 10:41:19 -0700
In-Reply-To: <xmqq8tve5fet.fsf@gitster.mtv.corp.google.com>
References: <1472573556.5512.93.camel@perches.com>
         <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
         <1472577999.5512.107.camel@perches.com>
         <xmqq8tve5fet.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-08-30 at 10:34 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> > On Tue, 2016-08-30 at 09:54 -0700, Junio C Hamano wrote:
> > > 
> > > Support for more generic footers was supposed to come when the
> > > "interpret-trailers" topic started, but the author of the topic
> > > seems to have lost interest before the mechanism has become ready to
> > > be integrated in the workflow commands like "am", "commit", "rebase"
> > > etc., which is unfortunate.
> > I think adding at least an option to git send-email
> > allowing auto-cc's for all
> > 	"<foo>-by: [name] <address>"
> > lines in the commit log would be useful.
> > 
> > Today, only "Signed-off-by" and "CC" lines are
> > added to cc's.
> > 
> > I've always called these lines "-by:" lines
> > "signatures", but perhaps there's a better name.
> I think we casually call them footers (as they are counter-part to
> "headers"), or trailers.

I think they are neither footers, which would relate
more to the email headers, nor trailers.

Maybe something like traces or chains.

btw: I submitted this awhile ago

http://www.spinics.net/lists/git/msg162269.html

