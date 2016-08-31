Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55261F859
	for <e@80x24.org>; Wed, 31 Aug 2016 17:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161301AbcHaR4i (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 13:56:38 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:57684 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965002AbcHaR4h (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Aug 2016 13:56:37 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 17E109EA12;
        Wed, 31 Aug 2016 17:56:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: earth86_1c67b2d9fdd12
X-Filterd-Recvd-Size: 1867
Received: from XPS-9350.home (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Aug 2016 17:56:35 +0000 (UTC)
Message-ID: <1472666194.4176.17.camel@perches.com>
Subject: Re: [PATCH] git-send-email: Add ability to cc: any "trailers" from
 commit message
From:   Joe Perches <joe@perches.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2016 10:56:34 -0700
In-Reply-To: <xmqqpooo259c.fsf@gitster.mtv.corp.google.com>
References: <b2aa91d59a6cdd468bcbe85b45807cc1b82b23ed.1472588158.git.joe@perches.com>
         <xmqqpooo259c.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-08-31 at 10:54 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > 
> > Many commits have various forms of trailers similar to
> >      "Acked-by: Name <address>" and "Reported-by: Name <address>"
> > 
> > Add the ability to cc these trailers when using git send-email.
> I thought you were asking what we call these "<token> followed by
> <colon>" at the end of the log message, and "footers or trailers"
> was the answer.
> 
> I do not have a strong objection against limiting to "-by:" lines;
> for one thing, it would automatically avoid having to worry about
> "Bug-ID:" and other trailers that won't have e-mail address at all.
> 
> But if you are _only_ picking up "-by:" lines, then calling this
> option "trailers" is way too wide and confusing.  I do not think
> there is any specific name for "-by:" lines, though.  Perhaps you
> would need to invent some name that has "-by" as a substring.
> 
> "any-by"?  or just "by"?  I dunno.

Signatures?

