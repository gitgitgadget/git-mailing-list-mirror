Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70A8208B4
	for <e@80x24.org>; Tue,  8 Aug 2017 02:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbdHHCmk (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 22:42:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57032 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbdHHCmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 22:42:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 662DF2047F;
        Tue,  8 Aug 2017 02:42:39 +0000 (UTC)
Date:   Tue, 8 Aug 2017 02:42:39 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Urs Thuermann <urs@isnogud.escape.de>
Subject: Re: [PATCH] git svn fetch: Create correct commit timestamp when
 using --localtime
Message-ID: <20170808024239.GA2915@starla>
References: <ygf8tiyx480.fsf@tehran.isnogud.escape.de>
 <xmqqlgmvni8x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgmvni8x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Urs Thuermann <urs@isnogud.escape.de> writes:
> 
> > In parse_svn_date() prepend the correct UTC offset to the timestamp
> > returned.  This is the offset in effect at the commit time instead of
> > the offset in effect at calling time.
> >
> > Signed-off-by: Urs Thuermann <urs@isnogud.escape.de>
> > ---
> >  perl/Git/SVN.pm | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks; sounds sensible.  
> 
> Eric?

Yep, seems alright.  Can you apply directly?
Been a bit preoccupied as of late.  Thanks.
