Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08350207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 20:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965363AbcIZUW0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 16:22:26 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:35152 "EHLO
        homiemail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933488AbcIZUWZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Sep 2016 16:22:25 -0400
Received: from homiemail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTP id CBC8B314C064;
        Mon, 26 Sep 2016 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=mnqz1
        w+8iV/ftfg5TVwQP8Rk/3E=; b=MuflQ9CG5xrhUJNBv5EUcOXbDYIXFF3FGLXT+
        bnpLR5U9IhFf6vQZC3/3xesmj0L0D7BqO20P4OXHeYHqaqTImkMSqNstAoAChGyv
        2bHB+H8ctKrNZu023K/Znr5BSw/lQ5fBeTsKM5Gl/xM9BCQzY1DxTSGdn1aihMv8
        m0aiTU=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTPSA id 41E81314C062;
        Mon, 26 Sep 2016 13:22:24 -0700 (PDT)
Message-ID: <1474921343.13374.1.camel@frank>
Subject: Re: [PATCH 0/2] tree-walk improvements
From:   David Turner <novalis@novalis.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu
Date:   Mon, 26 Sep 2016 16:22:23 -0400
In-Reply-To: <xmqqshsmqwfr.fsf@gitster.mtv.corp.google.com>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
         <xmqqshsmqwfr.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2016-09-26 at 12:43 -0700, Junio C Hamano wrote:
> David Turner <novalis@novalis.org> writes:
> 
> > The first patch is a re-roll of Peff's patch from 2014 -- here's
> > the archive message:
> >
> > http://git.661346.n2.nabble.com/PATCH-tree-walk-be-more-specific-about-corrupt-tree-errors-td7603558.html
> >
> > Not sure why this wasn't applied then, but I thought it looked pretty
> > good, so I added a few tests.
> 
> Thanks.  Adding tests is very much appreciated.  I however wonder
> why you needed to reword a perfectly readable "truncated" to
> something else, though?

Because truncated, to me, means "something that has been cut off". Here,
the recorded length is too short, so it's probably not the case that
something was cut off -- it was never right to begin with.


