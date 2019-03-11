Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456F820248
	for <e@80x24.org>; Mon, 11 Mar 2019 18:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfCKSTH (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 14:19:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:46112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727050AbfCKSTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 14:19:06 -0400
Received: (qmail 13740 invoked by uid 109); 11 Mar 2019 18:19:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Mar 2019 18:19:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25543 invoked by uid 111); 11 Mar 2019 18:19:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Mar 2019 14:19:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Mar 2019 14:19:04 -0400
Date:   Mon, 11 Mar 2019 14:19:04 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test
 on Fedora 29
Message-ID: <20190311181904.GA16865@sigill.intra.peff.net>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
 <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
 <20190311033755.GB7087@sigill.intra.peff.net>
 <CAH8yC8=9HOAmDE93aXd300kOJSOa0sA8Qv2cNn2M-EO-gqiktw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8=9HOAmDE93aXd300kOJSOa0sA8Qv2cNn2M-EO-gqiktw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 06:40:21AM -0400, Jeffrey Walton wrote:

> > So anyway, I think this needs a patch to the upstream sha1dc project.
> 
> https://github.com/cr-marcstevens/sha1collisiondetection/issues/47

Thanks, it looks like the turnaround on that may be pretty quick. Once
it's merged there, we'll need a local patch to bump the gitlink sha1 and
tweak the Makefile.

-Peff
